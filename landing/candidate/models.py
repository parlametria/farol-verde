from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.template.defaultfilters import slugify

from wagtail.core.models import Page
from wagtail.search import index
from wagtail.admin.edit_handlers import FieldPanel
from wagtailstreamforms.models import FormSubmission

from candidate.util import check_deputado, Deputado


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
    id_autor = models.IntegerField(blank=True, null=True, unique=True)
    id_parlametria = models.IntegerField(blank=True, null=True, unique=True)
    # id_serenata=id_perfil_politico on perfil.parlametria.org.br api
    id_serenata = models.IntegerField(blank=True, null=True, unique=True)
    name = models.CharField(max_length=255)

    survey_form = models.OneToOneField(
        FormSubmission,
        blank=True,
        null=True,
        on_delete=models.CASCADE,
        primary_key=False,
        related_name="candidate",
    )

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


def get_or_create_candidates_index() -> CandidateIndexPage:
    candidate_index = CandidateIndexPage.objects.filter(slug="candidatos").first()

    if not candidate_index:
        # https://stackoverflow.com/questions/24976561/wagtail-pages-giving-none-url-with-live-status
        home: Page = Page.objects.filter(slug="home-2").first()
        candidate_index = CandidateIndexPage(
            title="Candidatos",
            slug="candidatos",
            description="Lista de candidatos",
        )
        home.add_child(instance=candidate_index)
        home.save()
        candidate_index.save()

    return candidate_index


@receiver(
    post_save, sender=FormSubmission, dispatch_uid="form_submission_link_candidate"
)
def form_submission_link_candidate(sender, instance: FormSubmission, **kwargs):
    data = instance.get_data()

    role_column = "e-candidatoa-a-qual-vaga-no-pleito-de-2022"

    if role_column not in data:
        return  # not a SurveysPage form

    if data[role_column] == "Deputado(a) Federal":
        cpf = int(data["cpf"])
        found = check_deputado(cpf)

        if found:
            return check_candidate_and_add_new(found, instance)

    add_blank_candidate_page(instance)


def make_candidate(id_autor, id_parlametria, name, title, slug):
    candidates_index = get_or_create_candidates_index()

    candidate = CandidatePage(
        id_autor=id_autor,
        id_parlametria=id_parlametria,
        id_serenata=None,
        name=name,
        title=title,
        slug=slug,
    )

    candidates_index.add_child(instance=candidate)
    candidates_index.save()
    candidate.save()


def check_candidate_and_add_new(dep: Deputado, form: FormSubmission):
    alread_added = CandidatePage.objects.filter(id_autor=dep.id_autor).first()

    if alread_added:
        alread_added.survey_form = form
        alread_added.save()
        return

    slug = slugify(f"{dep.nome_autor} {dep.id_autor}")

    make_candidate(
        dep.id_autor,
        dep.id_autor_parlametria,
        dep.nome_autor,
        dep.nome_autor,
        slug,
    )


def add_blank_candidate_page(instance: FormSubmission):
    data = instance.get_data()

    slug = slugify(f"{data['nome-de-campanha']} {instance.id}")
    make_candidate(None, None, data["nome-de-campanha"], data["nome-de-campanha"], slug)
