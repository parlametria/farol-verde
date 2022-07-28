from django.http import HttpRequest
from django.http import JsonResponse

from candidate.camara.adhesion import calcula_adesao_parlamentar_todas_proposicoes


def adesao_parlamentar_view(request: HttpRequest, id_candidate: int):
    response = { "adhesion": 0.0, "propositions": [] }

    total = 0.0
    response["propositions"] = calcula_adesao_parlamentar_todas_proposicoes(id_candidate)

    for prop in response["propositions"]:
        total += prop["adhesion"]

    response["adhesion"] = total/len(response["propositions"])

    return JsonResponse(response)
