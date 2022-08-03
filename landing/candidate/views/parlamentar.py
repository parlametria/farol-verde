from django.http import HttpRequest
from django.http import JsonResponse

from candidate.camara.adhesion import calcula_adesao_parlamentar_todas_proposicoes


def adesao_parlamentar_view(request: HttpRequest, id_candidate: int):
    response = { "adhesion": 0.0, "propositions": [] }

    total = 0.0
    response["propositions"] = calcula_adesao_parlamentar_todas_proposicoes(id_candidate)

    calculated = 0
    for prop in response["propositions"]:
        if prop["total_com_votos"] > 0:
            total += prop["adhesion"]
            calculated += 1

    # prevent division by zero
    if calculated > 0:
        response["adhesion"] = total/calculated
    else:
        response["adhesion"] = 0

    return JsonResponse(response)
