from django.db import models

from wagtail.core.models import Page
from wagtail.search import index
from wagtail.admin.edit_handlers import FieldPanel


class CandidateIndexPage(Page):
    is_creatable = False

    parent_page_types = [
        "home.LandingPage",
    ]

    subpage_types = [
        "candidate.CandidatePage",
    ]

    description = models.CharField(
        max_length=255,
        blank=True,
    )

    content_panels = Page.content_panels + [
        FieldPanel("description", classname="full"),
    ]


class CandidatePage(Page):
    id_autor = models.IntegerField(blank=False, unique=True)
    id_parlametria = models.IntegerField(blank=False, unique=True)
    # id_serenata=id_perfil_politico on perfil.parlametria.org.br api
    id_serenata = models.IntegerField(blank=False, unique=True)
    name = models.CharField(max_length=255)

    parent_page_types = [
        "candidate.CandidateIndexPage",
    ]

    search_fields = Page.search_fields + [
        index.SearchField("id_autor"),
        index.FilterField("name"),
    ]

    content_panels = Page.content_panels + [
        FieldPanel("id_autor", classname="full"),
        FieldPanel("id_parlametria", classname="full"),
        FieldPanel("id_serenata", classname="full"),
        FieldPanel("name", classname="full"),
    ]

    def __str__(self):
        return f"{self.id_autor}: {self.name}"
