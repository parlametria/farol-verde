from django.urls import path

from candidate.views.perfil_parlamentar import votacoes_perfil_parlamentar_view, social_media_view, keywords_view, keywords_sections_view
from candidate.views.parlamentar import adesao_parlamentar_view

urlpatterns = [
    path("<slug:slug>/api/votacoes", votacoes_perfil_parlamentar_view),
    path("<slug:slug>/api/adesao", adesao_parlamentar_view),
    path("<slug:slug>/api/social-media", social_media_view),
    path("<slug:slug>/api/social-media/<slug:keyword>", social_media_view),
    path("<slug:slug>/api/keywords/<int:page>", keywords_view),
    path("<slug:slug>/api/keywords/<int:page>/<slug:search>", keywords_view),
    path("<slug:slug>/api/keywords-sections", keywords_sections_view),
    path("<slug:slug>/api/keywords-sections/<slug:search>", keywords_sections_view),
]
