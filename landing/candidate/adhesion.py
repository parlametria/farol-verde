from abc import ABC, abstractmethod
from datetime import datetime, date
from typing import Dict, List, Union

from django.db.models.query import QuerySet

from candidate.models import Proposicao, VotacaoParlamentar, CandidatePage, CasaChoices


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

    @abstractmethod
    def _get_ids_lideres(self) -> Dict[str, int]:
        pass

    def __init__(self, candidate: CandidatePage):
        self.id_parlamentar = candidate.id_autor
        self.candidate = candidate

    def _get_leader_votes(
        self, votacao_queryset: QuerySet, votacao_date: date, casa: str
    ):
        date_check = datetime.strptime("2022-02-02", "%Y-%m-%d").date()
        ids_lideres = self._get_ids_lideres()

        if votacao_date < date_check:
            return (
                votacao_queryset
                .filter(data__lt="2022-02-02")
                .filter(id_parlamentar=ids_lideres["antes-02-02-2022"])
            )
        else:
            return (
                votacao_queryset
                .filter(data__gte="2022-02-02")
                .filter(id_parlamentar=ids_lideres["apos-02-02-2022"])
            )

    def _compare_votes(
        self, parlamentar: VotacaoParlamentar, lider: VotacaoParlamentar
    ):
        if parlamentar == None and lider != None:
            return self.VOTE_DIFFERENT

        if lider == None and parlamentar != None:
            return self.VOTE_DIFFERENT

        return (
            self.VOTE_SAME
            if parlamentar.tipo_voto == lider.tipo_voto
            else self.VOTE_DIFFERENT
        )

    def _adhesion_calculation_on_proposition(
        self, id_parlamentar: int, proposicao: Proposicao
    ):
        total_votacoes = proposicao.votacoes.count()

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
        }

        if total_votacoes == 0:
            adesao["adhesion"] = 0
            adesao["total_com_votos"] = 0
            return adesao

        total_calculadas = 0
        for votacao in proposicao.votacoes.all():
            if votacao.votacoes_parlamentares.count() == 0:
                continue

            votos_lider = self._get_leader_votes(
                votacao.votacoes_parlamentares, votacao.data, proposicao.casa
            ).first()

            votos_parlamentar = votacao.votacoes_parlamentares.filter(
                id_parlamentar=id_parlamentar
            ).first()

            if votos_lider == None and votos_parlamentar == None:
                continue

            voto = self._compare_votes(votos_parlamentar, votos_lider)

            adesao[voto] += 1
            total_calculadas += 1

        adesao["total_com_votos"] = total_calculadas

        if adesao["total_com_votos"] == 0:
            return None

        # quanto menos o parlamentar divergir do lider, maior é a sua adesão
        adesao["adhesion"] = (
            (total_calculadas - adesao["different"]) / total_calculadas
            if total_calculadas > 0
            else 0
        )

        return adesao

    def _get_propositions(self) -> QuerySet[Proposicao]:
        check = _check_camara_or_senado(self.candidate)

        if check == str(CasaChoices.CAMARA):
            return Proposicao.proposicoes_camara().filter(calculate_adhesion=True)
        else:
            Proposicao.proposicoes_senado().filter(calculate_adhesion=True)

    def adhesion_calculation(self) -> List[Dict[str, Union[int, str]]]:
        voted = []

        for prop in self._get_propositions():
            adhesion = self._adhesion_calculation_on_proposition(self.id_parlamentar, prop)

            if adhesion is not None:
                voted.append(adhesion)

        return voted

class CandidateAdhesionCamara(CandidateAdhesion):

    IDS_LIDERES_CAMARA = {
        "antes-02-02-2022": 204530,  # Dep. Rodrigo Agostinho
        "apos-02-02-2022": 160511,  # Dep. Alessandro Molon
    }

    def _get_ids_lideres(self):
        return self.IDS_LIDERES_CAMARA

class CandidateAdhesionSenado(CandidateAdhesion):

    IDS_LIDERES_SENADO = {
        "antes-02-02-2022": 5953,  # Sen. Fabiano Contarato
        "apos-02-02-2022": 5718,  # Sen. Eliziane Gama
    }

    def _get_ids_lideres(self):
        return self.IDS_LIDERES_SENADO


def get_adhesion_strategy(candidate: CandidatePage):
    check = _check_camara_or_senado(candidate)

    if check == str(CasaChoices.CAMARA):
        return CandidateAdhesionCamara(candidate)
    else:
        return CandidateAdhesionSenado(candidate)
