from django.http import HttpRequest
from django.http import JsonResponse
from candidate.models import CandidatePage

from candidate.adhesion import get_adhesion_strategy

from candidate.models import CandidatePage


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
