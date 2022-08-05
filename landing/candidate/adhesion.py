from datetime import datetime, date
from django.db.models.query import QuerySet

from candidate.models import Proposicao, VotacaoParlamentar, CasaChoices

IDS_LIDERES_CAMARA = {
    "antes-02-02-2022": 204530,  # Dep. Rodrigo Agostinho
    "apos-02-02-2022": 160511,  # Dep. Alessandro Molon
}

IDS_LIDERES_SENADO = {
    "antes-02-02-2022": 5953,  # Sen. Fabiano Contarato
    "apos-02-02-2022": 5718,  # Sen. Eliziane Gama
}


def _get_ids_lideres_casa(casa: str):
    if casa == str(CasaChoices.CAMARA):
        return IDS_LIDERES_CAMARA
    else:
        return IDS_LIDERES_SENADO


def _get_votacoes_lider(
    votacao_queryset: QuerySet, votacao_date: date, casa: str
) -> QuerySet:
    date_check = datetime.strptime("2022-02-02", "%Y-%m-%d").date()
    ids_lideres = _get_ids_lideres_casa(casa)

    if votacao_date < date_check:
        return votacao_queryset.filter(data__lt="2022-02-02").filter(
            id_parlamentar=ids_lideres["antes-02-02-2022"]
        )
    else:
        return votacao_queryset.filter(data__gte="2022-02-02").filter(
            id_parlamentar=ids_lideres["apos-02-02-2022"]
        )


def _compare_votes(parlamentar: VotacaoParlamentar, lider: VotacaoParlamentar):
    if parlamentar == None and lider != None:
        return "different"

    if lider == None and parlamentar != None:
        return "different"

    return "same" if parlamentar.tipo_voto == lider.tipo_voto else "different"


def calcula_adesao_parlamentar_em_proposicao(
    id_parlamentar: int, proposicao: Proposicao
):
    total_votacoes = proposicao.votacoes.count()

    adesao = {
        "casa": proposicao.casa,
        "id_externo": proposicao.id_externo,
        "summary": proposicao.ementa,
        "about": proposicao.sobre,
        "same": 0,
        "different": 0,
        "total_votacoes": total_votacoes,
    }

    if total_votacoes == 0:
        adesao["adhesion"] = 0
        return adesao

    total_calculadas = 0
    for votacao in proposicao.votacoes.all():
        if votacao.votacoes_parlamentares.count() == 0:
            continue

        votos_lider = _get_votacoes_lider(
            votacao.votacoes_parlamentares, votacao.data, proposicao.casa
        ).first()

        votos_parlamentar = votacao.votacoes_parlamentares.filter(
            id_parlamentar=id_parlamentar
        ).first()

        if votos_lider == None and votos_parlamentar == None:
            continue

        voto = _compare_votes(votos_parlamentar, votos_lider)

        adesao[voto] += 1
        total_calculadas += 1

    adesao["total_com_votos"] = total_calculadas

    # quanto menos o parlamentar divergir do lider, maior é a sua adesão
    adesao["adhesion"] = (
        (total_calculadas - adesao["different"]) / total_calculadas
        if total_calculadas > 0
        else 0
    )

    return adesao


def calcula_adesao_parlamentar_todas_proposicoes(id_parlamentar: int, casa: str):
    voted = []

    proposicoes = (
        Proposicao.proposicoes_camara()
        if casa == str(CasaChoices.CAMARA)
        else Proposicao.proposicoes_senado()
    )

    for prop in proposicoes:
        voted.append(calcula_adesao_parlamentar_em_proposicao(id_parlamentar, prop))

    return voted
