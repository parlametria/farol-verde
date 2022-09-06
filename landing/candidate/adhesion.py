from abc import ABC, abstractmethod
from datetime import datetime, date
from typing import Dict, List, Union, Optional

from django.db.models import Q
from django.db.models.query import QuerySet

from candidate.models import (
    Proposicao,
    VotacaoParlamentar,
    CandidatePage,
    CasaChoices,
    SessaoVeto,
    VotacaoDispositivo,
)


def _check_camara_or_senado(candidate: CandidatePage):
    """
    Retorna a casa da legislação 56 do candidato.
    Se na proxima eleição ele mudou de cargo(dep -> sen or sen -> dep)
    retorna a casa anterior, senao retorna a casa atual
    """
    if (
        candidate.is_deputado and not candidate.charge_changed
    ):  # é deputado, nao mudou
        return str(CasaChoices.CAMARA)
    elif (
        candidate.is_deputado and candidate.charge_changed
    ):  # é deputado, mas era senador
        return str(CasaChoices.SENADO)
    elif (
        candidate.is_senador and not candidate.charge_changed
    ):  # é senador, nao mudou
        return str(CasaChoices.SENADO)
    else:  # candidate.is_senador and candidate.charge_changed. # é senador, mas era deputado
        return str(CasaChoices.CAMARA)

class CandidateAdhesion(ABC):
    VOTE_SAME = "same"
    VOTE_DIFFERENT = "different"
    IGNORE_VOTE = "ignore"

    @abstractmethod
    def _get_ids_lideres(self) -> Dict[str, List[int]]:
        pass

    def __init__(self, candidate: CandidatePage, use_vetos=True):
        self.id_parlamentar = candidate.id_autor
        self.candidate = candidate
        self.use_vetos = use_vetos
        self.skip_session_cases = {
            VotacaoParlamentar.TIPOS_VOTO["camara"]["artigo_17"],
            VotacaoParlamentar.TIPOS_VOTO["senado"]["presidente_art_51"],
            VotacaoParlamentar.TIPOS_VOTO["senado"]["ap"],
            VotacaoParlamentar.TIPOS_VOTO["senado"]["mis"],
            VotacaoParlamentar.TIPOS_VOTO["senado"]["lp"],
            VotacaoParlamentar.TIPOS_VOTO["senado"]["ls"],
        }

    def _get_leader_votes(
        self, votacao_queryset: QuerySet,
        votacao_date: date,
        specific_leader=None
    ) -> Optional[QuerySet]:
        date_check = datetime.strptime("2022-02-02", "%Y-%m-%d").date()
        ids_lideres: List[int] = []
        date_filter: QuerySet = None

        if specific_leader is not None:
            ids_lideres = [specific_leader]
        else:
            if votacao_date < date_check:
                ids_lideres = self._get_ids_lideres()["antes-02-02-2022"]
            else:
                ids_lideres = self._get_ids_lideres()["apos-02-02-2022"]

        if votacao_date < date_check:
            date_filter = votacao_queryset.filter(data__lt="2022-02-02")
        else:
            date_filter = votacao_queryset.filter(data__gte="2022-02-02")

        for id_lider in ids_lideres:
            votes = date_filter.filter(id_parlamentar=id_lider).first()
            if votes is not None:
                return votes

        return None

    def _compare_votes(
        self, parlamentar: VotacaoParlamentar, lider: VotacaoParlamentar
    ):
        if parlamentar == None:
            return self.VOTE_DIFFERENT

        if parlamentar.casa == str(CasaChoices.CAMARA):
            obstrucao_vote = VotacaoParlamentar.TIPOS_VOTO["camara"]["obstrucao"]

            if parlamentar.tipo_voto == obstrucao_vote:
                # Todo voto obstrução, deve ser convergente
                return self.VOTE_SAME

        return (
            self.VOTE_SAME
            if parlamentar.tipo_voto == lider.tipo_voto
            else self.VOTE_DIFFERENT
        )

    def _adhesion_calculation_on_proposition(
        self, id_parlamentar: int, proposicao: Proposicao
    ):
        # desconsiderar votações anteriores a 01/01/2019
        # Issue 147 usa PEC 04/2018, logo vai ter que usar 2018 agora
        votacoes = proposicao.votacoes.filter(data__gte="2018-01-01")
        total_votacoes = votacoes.count()

        if total_votacoes == 0:
            return None

        adesao = {
            "casa": proposicao.casa,
            "id_externo": proposicao.id_externo,
            "title": str(proposicao),
            "summary": proposicao.ementa,
            "about": proposicao.sobre,
            "same": 0,
            "different": 0,
            "total_votacoes": total_votacoes,
            "total_vetos": 0.0
        }

        if total_votacoes == 0:
            adesao["adhesion"] = 0
            adesao["total_com_votos"] = 0
            return adesao

        # https://github.com/parlametria/farol-verde/issues/147
        specific_leader = self._get_specific_leader_for_proposition(proposicao)

        total_calculadas = 0
        for votacao in votacoes.all():
            if votacao.votacoes_parlamentares.count() == 0:
                continue

            votos_lider = self._get_leader_votes(
                votacao.votacoes_parlamentares, votacao.data, specific_leader
            )

            votos_parlamentar = votacao.votacoes_parlamentares.filter(
                id_parlamentar=id_parlamentar
            ).first()

            # ignora votacao quando lider não votou
            if votos_lider == None:
                continue

            # Voto artigo 17 deve-se descartar a votação do candidato
            if votos_parlamentar is not None and votos_parlamentar.tipo_voto in self.skip_session_cases:
                continue

            voto = self._compare_votes(votos_parlamentar, votos_lider)

            adesao[voto] += 1
            total_calculadas += 1


        if self.use_vetos:
            total_vetos = 0
            sessao_vetos = self._get_sessao_vetos_proposition(proposicao)
            candidate = CandidatePage.objects.filter(id_autor=id_parlamentar).first()

            for sessao in sessao_vetos:
                voto_veto = self._compare_votes_veto(sessao, candidate.title, candidate.campaign_name)
                if voto_veto == self.IGNORE_VOTE:
                    continue

                adesao[voto_veto] += 1
                total_calculadas += 1
                total_vetos += 1

        adesao["total_com_votos"] = total_calculadas
        adesao["total_vetos"] = total_vetos

        if adesao["total_com_votos"] == 0:
            return None

        # quanto menos o parlamentar divergir do lider, maior é a sua adesão
        adesao["adhesion"] = (
            (total_calculadas - adesao["different"]) / total_calculadas
            if total_calculadas > 0
            else 0
        )

        return adesao

    def _get_specific_leader_for_proposition(self, proposition: Proposicao):
        if proposition.casa == str(CasaChoices.CAMARA):
            return None

        propstr = str(proposition)

        if propstr == "PLP 275/2019":
            return CandidateAdhesionSenado.ELIZIANE

        if propstr == "PL 4348/2019" or propstr == "PEC 4/2018":
            return CandidateAdhesionSenado.FABIANO

        return None

    def _get_propositions(self) -> QuerySet[Proposicao]:
        check = _check_camara_or_senado(self.candidate)

        if check == str(CasaChoices.CAMARA):
            return Proposicao.proposicoes_camara().filter(calculate_adhesion=True)
        else:
            return Proposicao.proposicoes_senado().filter(calculate_adhesion=True)

    def _get_sessao_vetos_proposition(self, proposition: Proposicao):
        return SessaoVeto.objects.filter(proposicao=proposition).all()

    def adhesion_calculation(self) -> List[Dict[str, Union[int, str]]]:
        voted = []

        for prop in self._get_propositions():
            adhesion = self._adhesion_calculation_on_proposition(self.id_parlamentar, prop)

            if adhesion is not None:
                voted.append(adhesion)

        return voted

    def _compare_votes_veto(self, sessao: SessaoVeto, candidate_name: str, campaign_name: str):
        votacao_parlamentar = self._get_votacao_veto_parlamentar(sessao, candidate_name, campaign_name)

        if votacao_parlamentar is None:
            return self.VOTE_DIFFERENT

        if votacao_parlamentar.tipo_voto in self.skip_session_cases:
            return self.IGNORE_VOTE

        votacao_lider = self._get_votacao_dispositivo_lider(sessao)

        if votacao_lider is None:
            return self.IGNORE_VOTE

        return (
            self.VOTE_SAME
            if votacao_parlamentar.tipo_voto == votacao_lider.tipo_voto
            else self.VOTE_DIFFERENT
        )

    def _get_votacao_veto_parlamentar(self, sessao: SessaoVeto, candidate_name: str, campaign_name: str):
        return (
            VotacaoDispositivo.objects
            .filter(Q(nome_parlamentar__icontains=candidate_name) | Q(nome_parlamentar__icontains=campaign_name))
            .filter(sessao_veto=sessao)
            .first()
        )

    def _get_votacao_dispositivo_lider(
        self, sessao: SessaoVeto
    ) -> Optional[VotacaoDispositivo]:
        antes = self._get_ids_lideres()["antes-02-02-2022"]

        for _id in antes:
            lider = CandidatePage.objects.filter(id_autor=_id).first()

            if lider is None:
                continue

            votacao_lider = (
                VotacaoDispositivo.objects
                .filter(Q(nome_parlamentar__icontains=lider.title) | Q(nome_parlamentar__icontains=lider.campaign_name))
                .filter(sessao_veto=sessao)
                .first()
            )

            if votacao_lider is not None:
                return votacao_lider

        return None


class CandidateAdhesionCamara(CandidateAdhesion):
    RODRIGO = 204530
    ALESSANDRO = 160511
    NILTO = 178986

    IDS_LIDERES_CAMARA = {
        # 1.º: Dep. Rodrigo Agostinho, 2º: Dep. Alessandro Molon, 3º: Dep. Nilto Tatto
        "antes-02-02-2022": [RODRIGO, ALESSANDRO, ALESSANDRO],
        # 1.º: Dep. Alessandro Molon, 2º: Dep. Rodrigo Agostinho , 3º: Dep. Nilto Tatto
        "apos-02-02-2022": [ALESSANDRO, RODRIGO, ALESSANDRO],  # Dep. Alessandro Molon
    }

    def _get_ids_lideres(self):
        return self.IDS_LIDERES_CAMARA

class CandidateAdhesionSenado(CandidateAdhesion):
    FABIANO = 5953
    ELIZIANE = 5718
    RANDOLFE = 5012

    IDS_LIDERES_SENADO = {
        # 1º: Sen. Fabiano Contarato, 2º: Sen. Eliziane Gama, 3º: Sen. Randolfe Rodrigues
        "antes-02-02-2022": [FABIANO, ELIZIANE, RANDOLFE],  # Sen. Fabiano Contarato
        # 1º: Sen. Eliziane Gama, 2º: Sen. Fabiano Contarato, 3º: Sen. Randolfe Rodrigues
        "apos-02-02-2022": [ELIZIANE, FABIANO, RANDOLFE],  # Sen. Eliziane Gama
    }

    def _get_ids_lideres(self):
        return self.IDS_LIDERES_SENADO


def get_adhesion_strategy(candidate: CandidatePage):
    check = _check_camara_or_senado(candidate)

    if check == str(CasaChoices.CAMARA):
        return CandidateAdhesionCamara(candidate)
    else:
        return CandidateAdhesionSenado(candidate)
