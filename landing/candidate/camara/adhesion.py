from datetime import datetime, date
from django.db.models.query import QuerySet

from candidate.models import Proposicao, VotacaoParlamentar

IDS_LIDERES = {
    "rodrigo_agostinho": 204530,  # Dep. Rodrigo Agostinho antes de 02-02-2022
    "alessandro_molon": 160511,  # Dep. Alessandro Molon apos 02-02-2022
}


def _get_votacoes_lider(votacao_queryset: QuerySet, votacao_date: date) -> QuerySet:
    date_check = datetime.strptime("2022-02-02", "%Y-%m-%d").date()

    # Dep. Rodrigo Agostinho antes de 02-02-2022
    if votacao_date < date_check:
        return votacao_queryset.filter(data__lt="2022-02-02").filter(
            id_deputado=IDS_LIDERES["rodrigo_agostinho"]
        )
    else:  # Dep. Alessandro Molon apos 02-02-2022
        return votacao_queryset.filter(data__gte="2022-02-02").filter(
            id_deputado=IDS_LIDERES["alessandro_molon"]
        )


def _compare_votes(parlamentar: VotacaoParlamentar, lider: VotacaoParlamentar):
    if parlamentar == None and lider != None:
        return "different"

    if lider == None and parlamentar != None:
        return "different"

    return "same" if parlamentar.tipo_voto == lider.tipo_voto else "different"


def calcula_adesao_parlamentar_em_proposicao(id_deputado: int, proposicao: Proposicao):
    total_votacoes = proposicao.votacoes.count()

    adesao = {
        "id_camara": proposicao.id_camara,
        "proposition_number": str(proposicao),
        "summary": proposicao.ementa,
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
            votacao.votacoes_parlamentares, votacao.data
        ).first()

        votos_parlamentar = votacao.votacoes_parlamentares.filter(
            id_deputado=id_deputado
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


def calcula_adesao_parlamentar_todas_proposicoes(id_deputado: int):
    voted = []

    for prop in Proposicao.objects.all():
        voted.append(calcula_adesao_parlamentar_em_proposicao(id_deputado, prop))

    return voted
