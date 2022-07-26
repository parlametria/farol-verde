from django.urls import path

from candidate.views.parlamentar import votacoes_parlamentar_view

urlpatterns = [
    path("votacoes/parlamentar/<int:id_candidate>", votacoes_parlamentar_view)
]
