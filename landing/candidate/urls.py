from django.urls import path

from candidate.views.perfil_parlamentar import votacoes_perfil_parlamentar_view
from candidate.views.parlamentar import votacoes_parlamentar_view

urlpatterns = [
    path("votacoes/perfil-parlamentar/<int:id_candidate>", votacoes_perfil_parlamentar_view),
    path("votacoes/parlamentar/<int:id_candidate>", votacoes_parlamentar_view),
]
