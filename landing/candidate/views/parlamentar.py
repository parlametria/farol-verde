from django.http import HttpRequest
from django.http import JsonResponse
from candidate.models import CandidatePage

from candidate.adhesion import get_adhesion_strategy

from candidate.models import CandidatePage, AutorProposicao


def adesao_parlamentar_view(request: HttpRequest, slug: str):
    candidate = CandidatePage.objects.filter(slug=slug).first()

    response = {"adhesion": 0.0, "propositions": []}
    
    if candidate is None:
        return JsonResponse(
            status=404,
            data={
                "message": "Candidate not found",
            },
        )

    strategy = get_adhesion_strategy(candidate)
    response["propositions"] = strategy.adhesion_calculation()

    total = 0.0
    calculated = 0
    for prop in response["propositions"]:
        if prop["total_com_votos"] > 0:
            total += prop["adhesion"]
            calculated += 1

    # prevent division by zero
    if calculated > 0:
        response["adhesion"] = total / calculated
    else:
        response["adhesion"] = 0

    return JsonResponse(response)


def proposicoes_onde_parlamentar_e_autor_view(request: HttpRequest, id_candidate: int):
    autor = AutorProposicao.objects.filter(id_parlamentar=id_candidate).first()

    if autor is None:
        return JsonResponse(
            status=404,
            data={
                "message": "Autor not found",
            },
        )

    proposicoes = []
    for proposicao in autor.proposicoes.all():
        proposicoes.append(
            {
                "id": proposicao.id_externo,
                "title": str(proposicao),
                "summary": proposicao.ementa,
            }
        )

    return JsonResponse({"propositions": proposicoes})
