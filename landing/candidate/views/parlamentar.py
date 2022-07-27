from django.http import HttpRequest
from django.http import JsonResponse


def votacoes_parlamentar_view(request: HttpRequest, id_candidate: int):
    return JsonResponse({"test": "xim"})
