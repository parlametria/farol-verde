from django.http import HttpRequest
from django.http import JsonResponse

from candidate.adhesion import calcula_adesao_parlamentar_todas_proposicoes

from candidate.models import CandidatePage, CasaChoices


def adesao_parlamentar_view(request: HttpRequest, id_candidate: int):
    response = {"adhesion": 0.0, "propositions": []}

    candidate = CandidatePage.objects.filter(id_autor=id_candidate).first()

    if candidate is None:
        return JsonResponse(
            status=404,
            data={
                "message": "Candidate not found",
            },
        )

    casa = str(CasaChoices.CAMARA) if candidate.is_deputado else str(CasaChoices.SENADO)
    response["propositions"] = calcula_adesao_parlamentar_todas_proposicoes(
        id_candidate,
        casa,
    )

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
