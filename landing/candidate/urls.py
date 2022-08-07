from django.urls import path

from candidate.views.perfil_parlamentar import votacoes_perfil_parlamentar_view, social_media_view, keywords_view
from candidate.views.parlamentar import adesao_parlamentar_view

urlpatterns = [
    path("<slug:slug>/api/votacoes", votacoes_perfil_parlamentar_view),
    path("<slug:slug>/api/adesao", adesao_parlamentar_view),
    path("<slug:slug>/api/social-media", social_media_view),
    path("<slug:slug>/api/keywords", keywords_view),
]
