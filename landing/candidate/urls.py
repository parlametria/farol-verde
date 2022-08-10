from django.urls import path

from candidate.views.perfil_parlamentar import votacoes_perfil_parlamentar_view
from candidate.views.parlamentar import adesao_parlamentar_view, proposicoes_onde_parlamentar_e_autor_view

urlpatterns = [
    path("votacoes/perfil-parlamentar/<int:id_candidate>", votacoes_perfil_parlamentar_view),
    path("adesao/parlamentar/<int:id_candidate>", adesao_parlamentar_view),
    path("autoria/parlamentar/<int:id_candidate>", proposicoes_onde_parlamentar_e_autor_view),
]
