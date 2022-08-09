from django.http import HttpRequest
from django.http import JsonResponse
from candidate.models import CandidatePage

from candidate.adhesion import get_adhesion_strategy

from candidate.models import CandidatePage


def adesao_parlamentar_view(request: HttpRequest, slug: str):
    id_candidate = CandidatePage.objects.filter(slug=slug).first().id_parlametria
    response = { "adhesion": 0.0, "propositions": [] }

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
