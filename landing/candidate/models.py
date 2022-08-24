from django.db import models
from django.db.models.signals import post_save
from django.core.paginator import EmptyPage, PageNotAnInteger, Paginator
from django.dispatch import receiver
from django.template.defaultfilters import slugify

from wagtailmetadata.models import MetadataPageMixin
from wagtail.core.models import Page
from wagtail.search import index
from wagtail.admin.edit_handlers import FieldPanel, StreamFieldPanel
from wagtail.core.fields import StreamField
from wagtailstreamforms.models import FormSubmission

from wagtail.core.blocks import StructBlock, ChoiceBlock, URLBlock
from django.db.models import CharField, ImageField, EmailField, URLField, DateField, BooleanField
from django.db.models.signals import post_save
from django.dispatch import receiver

from candidate.util import uf_list, subjects_list, subject_dict, subject_descriptions, keywords
from candidate.factories import SurveyCandidateFactory

class GenderChoices(models.TextChoices):
    MASCULINE = "M", "MASCULINO"
    FEMININE = "F", "FEMININO"
    NOT_DISCLOSURE = "N", "NÃO DIVULGÁVEL"


class CandidatePage(MetadataPageMixin, Page):
    DEPUTADO_CHARGE_TEXT = "Deputado(a) Federal"
    SENADOR_CHARGE_TEXT = "Senador(a)"

    id_autor = models.IntegerField(blank=True, null=True, unique=True)
    id_parlametria = models.IntegerField(blank=True, null=True, unique=True)
    id_serenata = models.IntegerField(blank=True, null=True, unique=True)

    parent_page_types = [
        "candidate.CandidateIndexPage",
    ]

    search_fields = Page.search_fields + [
        index.SearchField("id_autor"),
        index.FilterField("title"),
    ]

    campaign_name = CharField(null=True, max_length=255)
    party = CharField(null=True, blank=True, max_length=255)
    cpf = CharField(max_length=14, null=True)
    birth_date = DateField(blank=True, null=True)
    email = EmailField(null=True)
    picture = ImageField(null=True, blank=True, default=None)
    charge = CharField(null=True, max_length=255)
    charge_changed = BooleanField(
        default=False,
        help_text="Charge changed from parlametria api to TSE 2022 csv data"
    )
    social_media = StreamField([
        ('twitter', URLBlock(max_length=255)),
        ('facebook', URLBlock(max_length=255)),
        ('instagram', URLBlock(max_length=255)),
        ('youtube', URLBlock(max_length=255)),
    ], null=True, blank=True)

    manager_name = CharField(null=True, max_length=255)
    manager_email = EmailField(null=True)
    manager_phone = CharField(max_length=50, null=True)
    manager_site = URLField(null=True, blank=True)

    election_state = CharField(null=True, max_length=255)
    election_city = CharField(null=True, max_length=255)

    gender = models.CharField(
        blank=True,
        null=True,
        max_length=1,
        choices=GenderChoices.choices,
    )
    tse_image_code = CharField(null=True, blank=True, max_length=60)

    global make_block

    def make_block(subject):
        _, phrase, key = subject.values()
        choices = [
            ("Sim", "Sim"),
            ("Não", "Não"),
            ("Prefiro não responder / Não sei", "Prefiro não responder / Não sei"),
        ]

        return (
            key,
            ChoiceBlock(
                choices=choices,
                defult=True,
                label=f'Opinião do candidato em relação à frase "{phrase}."',
            ),
        )

    opinions = StreamField(
        [
            (
                "opinions",
                StructBlock(
                    [make_block(subject) for subject in subjects_list],
                ),
            )
        ],
        null=True, blank=True,
    )

    @property
    def opinions_answers(self):
        answers = list(subjects_list)
        answer_dict = {
            "Sim": "sim",
            "Não": "nao",
            "Prefiro não responder / Não sei": "nao_sei",
        }
        if len(self.opinions) == 0:
            return None
        opinions = self.opinions[0].value
        for key, answer in enumerate(answers):
            answer_key = opinions[answer["key"]]
            answers[key]["phrase"] = answers[key]["phrase"]
            answers[key]["answer"] = answer_dict[answer_key]
        return answers

    @property
    def get_picture(self):
        if self.picture:
            return self.picture.url

        if self.id_autor:
            return self._get_external_picture_link()

        if self.tse_image_code:
            return f"https://farolverde.org.br/static/tse/F{self.election_state}{self.tse_image_code}_div.jpg"

        return ""


    def _get_external_picture_link(self):
        senador_picture_url = "https://www.senado.leg.br/senadores/img/fotos-oficiais/senador"
        deputado_picture_url = "https://www.camara.leg.br/internet/deputado/bandep/"

        if self.charge == self.SENADOR_CHARGE_TEXT:
            return f"{senador_picture_url}{self.id_autor}.jpg" if not self.charge_changed else f"{deputado_picture_url}{self.id_autor}.jpg"
        return f"{deputado_picture_url}{self.id_autor}.jpg" if not self.charge_changed else f"{senador_picture_url}{self.id_autor}.jpg"


    @property
    def is_deputado(self) -> bool:
        return self.charge == self.DEPUTADO_CHARGE_TEXT

    @property
    def is_senador(self) -> bool:
        return not self.is_deputado

    @property
    def keywords(self):
        return keywords

    content_panels = Page.content_panels + [
        FieldPanel("id_autor", classname="full"),
        FieldPanel("id_parlametria", classname="full"),
        FieldPanel("id_serenata", classname="full"),
        FieldPanel('campaign_name'),
        FieldPanel('party'),
        FieldPanel('cpf'),
        FieldPanel('birth_date'),
        FieldPanel('email'),
        FieldPanel('picture'),
        FieldPanel('charge'),
        FieldPanel('gender'),
        FieldPanel('tse_image_code'),
        StreamFieldPanel('social_media'),
        FieldPanel('manager_name'),
        FieldPanel('manager_email'),
        FieldPanel('manager_phone'),
        FieldPanel('manager_site'),
        FieldPanel('election_state'),
        FieldPanel('election_city'),
        StreamFieldPanel('opinions'),
    ]

    def __str__(self):
        return f"{self.id_autor}: {self.title}"


class CandidateIndexPage(MetadataPageMixin, Page):
    ajax_template = 'candidate/candidate_index_ajax.html'

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

    def search_results(self, request):
        queryset = CandidatePage.objects.order_by('title')

        charges_dict = {'senators': 'Senador(a)', 'deputies': 'Deputado(a) Federal'}
        charges = []
        gender_dict = {'men': 'M', 'women': 'F'}
        genders = []
        election_dict = {'reelection': False, 'no_reelection': True }
        reelections = []

        params_functions = {
            'name': lambda queryset, value: queryset.filter(title__icontains=value),
            'uf[]': lambda queryset, values: queryset.filter(election_state__in=values),
            'party[]': lambda queryset, values: queryset.filter(party__in=values),
            'sortby': lambda queryset, value: queryset.order_by('-title') if value == 'descending' else queryset,
            'id_autor': lambda queryset, value: queryset.filter(id_autor__isnull=value),
        }

        request_items = dict(request.GET)
        for param, value in list(request_items.items()):
            if param in charges_dict.keys():
                charges.append(charges_dict[param])
            if param in gender_dict.keys():
                genders.append(gender_dict[param])
            if param in election_dict.keys():
                reelections.append(election_dict[param])
            if param not in ['uf[]', 'party[]']:
                value = value[0]
            if value and param in params_functions:
                pass
                queryset = params_functions[param](queryset, value)

        if len(reelections) == 1:
            queryset = params_functions['id_autor'](queryset, reelections[0])

        return queryset.filter(charge__in=charges, gender__in=genders)


    def get_context(self, request):
        context = super(CandidateIndexPage, self).get_context(request)

        search_results = self.search_results(request)
        search_results = search_results.filter(live=True) # do not display draft pages
        subject = request.GET.get('subject', None)
        print(subject)
        candidates_opinions = [''] * len(search_results)

        if subject:
            search_results = [candidate for candidate in search_results if len(candidate.opinions)]
            candidates_opinions = [
                candidate.opinions[0].value.get(subject_dict[subject])
                for candidate in search_results
            ]
            context["subject_description"] = (
                subject_descriptions[subject] + "?"
            )
            context["subject"] = subject
        search_results = zip(search_results, candidates_opinions)
        search_results = [{'opinion': opinion, 'candidate': candidate} for candidate, opinion in search_results]

        party_list = [candidate.party for candidate in CandidatePage.objects.live()
            if candidate.party is not None]
        party_list = list(set(party_list))
        party_list.sort()

        paginator = Paginator(search_results, 20)
        page = request.GET.get('page', 1)
        try:
            candidates_list = paginator.page(page)
        except EmptyPage:
            candidates_list = paginator.page(paginator.num_pages)

        page = int(page)

        context["candidates_list"] = candidates_list
        context["pagination_range"] = [x for x in range(page-2, page+3) if x > 0 and x <= paginator.num_pages]
        context["subjects"] = list(subject_dict.keys())
        context["uf_list"] = uf_list
        context["party_list"] = party_list

        return context

@receiver(
    post_save, sender=FormSubmission, dispatch_uid="form_submission_link_candidate"
)
def form_submission_link_candidate(sender, instance: FormSubmission, **kwargs):
    form = instance.get_data()
    role_column = "e-candidatoa-a-qual-vaga-no-pleito-de-2022"

    if role_column not in form:
        return  # not a SurveysPage form

    builder = SurveyCandidateFactory(instance.id, form, role_column)
    builder.create_candidate()


class CasaChoices(models.TextChoices):
    SENADO = "senado", "senado"
    CAMARA = "camara", "camara"


class Proposicao(models.Model):
    id_externo = models.IntegerField(blank=False, null=False, primary_key=True)
    sigla_tipo = models.CharField(blank=False, null=False, max_length=6)
    numero = models.IntegerField(blank=False, null=False)
    ano = models.IntegerField(blank=False, null=False)
    ementa = models.TextField(blank=True, null=True)
    sobre = models.CharField(blank=False, null=False, max_length=90)
    casa = models.CharField(
        blank=False,
        null=False,
        max_length=6,
        choices=CasaChoices.choices,
    )
    calculate_adhesion = BooleanField(default=True)
    data = models.DateField(default="1900-01-01")

    def __str__(self) -> str:
        # MPV 867/2018
        return f"{self.sigla_tipo} {self.numero}/{self.ano}"

    @staticmethod
    def proposicoes_senado():
        return Proposicao.objects.filter(casa=str(CasaChoices.SENADO))

    @staticmethod
    def proposicoes_camara():
        return Proposicao.objects.filter(casa=str(CasaChoices.CAMARA))


class VotacaoProsicao(models.Model):
    proposicao = models.ForeignKey(
        Proposicao,
        on_delete=models.CASCADE,
        related_name="votacoes",
    )
    id_votacao = models.CharField(
        primary_key=True,
        blank=False,
        null=False,
        max_length=30,
    )
    data = models.DateField()
    data_hora_registro = models.CharField(blank=True, null=True, max_length=30)


class VotacaoParlamentar(models.Model):
    TIPOS_VOTO = {
        "camara": {
            "sim": "Sim",
            "nao": "Não",
            "obstrucao": "Obstrução",
            "abstencao": "Abstenção",
            "artigo_17": "Artigo 17",
        },
        "senado": {
            "sim": "Sim",
            "nao": "Não",
            "p_nrv": "P-NRV",
            "ap": "AP",
            "lp": "LP",
            "mis": "MIS",
            "abstencao": "Abstenção",
            "presidente_art_51": "Presidente (art. 51 RISF)",
        },
    }

    class Meta:
        indexes = [
            models.Index(
                fields=["id_parlamentar", "votacao_proposicao"],
                name="votacao_prop_deputado_idx",
            ),
        ]
        unique_together = (("id_parlamentar", "votacao_proposicao"),)

    votacao_proposicao = models.ForeignKey(
        VotacaoProsicao,
        on_delete=models.CASCADE,
        related_name="votacoes_parlamentares",
    )
    tipo_voto = models.CharField(blank=False, null=False, max_length=26)
    data = models.DateField()
    data_registro_voto = models.CharField(blank=False, null=False, max_length=30)
    id_parlamentar = models.IntegerField(blank=False, null=False)
    casa = models.CharField(
        blank=False,
        null=False,
        max_length=7,
        choices=CasaChoices.choices,
    )

class AutorProposicao(models.Model):
    id_parlamentar = models.IntegerField(blank=False, null=False, primary_key=True)
    nome = CharField(max_length=120, blank=True, null=True)
    proposicoes = models.ManyToManyField(Proposicao, related_name="autores")


#https://www.congressonacional.leg.br/materias/vetos/-/veto/detalhe/13965
#https://www.congressonacional.leg.br/materias/vetos/-/veto/detalhe/13965/1
class SessaoVeto(models.Model):
    proposicao = models.ForeignKey(
        Proposicao,
        on_delete=models.CASCADE,
        related_name="sessoes_vetos",
    )
    dispositivo = models.CharField(blank=False, null=False, max_length=12)
    class Meta:
        indexes = [
            models.Index(
                fields=["dispositivo", "proposicao"],
                name="sessaoveto_disp_prop_idx",
            ),
        ]
        unique_together = (("dispositivo", "proposicao"),)

    def __str__(self):
        return f"({self.proposicao}, {self.dispositivo})"


class VotacaoDispositivo(models.Model):
    nome_parlamentar = models.CharField(blank=False, null=False, max_length=120)
    tipo_voto = models.CharField(blank=False, null=False, max_length=26)
    sessao_veto = models.ForeignKey(
        SessaoVeto,
        on_delete=models.CASCADE,
        related_name="votacoes",
    )
    casa = models.CharField(
        blank=False,
        null=False,
        max_length=7,
        choices=CasaChoices.choices,
    )
    class Meta:
        indexes = [
            models.Index(
                fields=["nome_parlamentar", "sessao_veto"],
                name="votacaodispositivo_nomsess_idx",
            ),
        ]
        unique_together = (("nome_parlamentar", "sessao_veto"),)

    def __str__(self):
        return f"{self.sessao_veto} -- {self.nome_parlamentar} -- {self.tipo_voto}"
