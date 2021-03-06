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
from django.db.models import CharField, ImageField, EmailField, URLField
from django.db.models.signals import post_save
from django.dispatch import receiver


from candidate.util import uf_list, subjects_list, subject_dict, subject_descriptions
from candidate.factories import SurveyCandidateFactory

class CandidatePage(MetadataPageMixin, Page):
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
    cpf = CharField(max_length=14, null=True)
    email = EmailField(null=True)
    picture = ImageField(null=True, blank=True, default=None)
    charge = CharField(null=True, max_length=255)
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

    opinions = StreamField([
        ('opinions', StructBlock([
            ("clima", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel ?? inclus??o da \"seguran??a clim??tica\" em nossa Constitui????o Federal, como direito fundamental (no art. 5??), como princ??pio da Ordem Econ??mica e Financeira Nacional (no art. 170) e como n??cleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econ??mico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudan??a Clim??tica no Brasil.\""
            )),
            ("agua", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel ?? inclus??o do ???acesso ?? ??gua pot??vel e ao esgotamento sanit??rio??? no artigo 5?? da Constitui????o Federal, para entrarem formalmente no rol de direitos humanos fundamentais.\""
            )),
            ("desmatamento", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel ?? pol??tica de ???desmatamento zero??? em todos os biomas brasileiros, porque acredito ser poss??vel manter, e at?? aumentar, a produ????o agropecu??ria atual sem novos desmatamentos, por meio da convers??o de pastagens degradadas ou subaproveitadas.\""
            )),
            ("terras_indigenas", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel ?? retomada dos processos demarcat??rios de Terras Ind??genas no Brasil, pois sei que ainda h?? mais de 200 processos pendentes, e concordo que os povos e as culturas ind??genas contribuem para o enfrentamento da mudan??a clim??tica, para a conserva????o dessas ??reas Protegidas e da sociobiodiversidade brasileira.\""
            )),
            ("reforma_tributaria", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel a uma reforma e a uma pol??tica tribut??ria socioambiental progressiva e promotora de sa??de, que reduza tributos sobre atividades econ??micas com baixas emiss??es de Gases de Efeito Estufa (GEE) e com baixo n??vel de polui????o, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas ?? sa??de.\""
            )),
            ("saude_consumo", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel ?? redu????o do consumo de produtos nocivos ?? sa??de e ao meio ambiente, tais como ??lcool e tabaco, alimentos ultraprocessados, agrot??xicos e combust??veis f??sseis, e concordo com a ado????o de medidas regulat??rias para esses produtos, como tributa????o progressiva, restri????o da publicidade, garantia de ambientes protegidos de seus efeitos e informa????o adequada para seu consumo.\""
            )),
            ("agropecuaria", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou contra a flexibiliza????o das leis de Defesa Agropecu??ria, pois os programas de autocontrole geridos pelas empresas do setor n??o devem substituir o poder p??blico na fiscaliza????o da qualidade de rebanhos, de lavouras e de seus produtos, assim como n??o concordo com a flexibiliza????o das regras para registro e utiliza????o de agrot??xicos e pesticidas no Brasil.\""
            )),
            ("unidades_conservacao", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel ??s parcerias entre o setor p??blico e o setor privado para a implementa????o e gest??o sustent??vel de Parques Nacionais, Parques Estaduais e outras Unidades de Conserva????o onde seja permitido o uso p??blico.\""
            )),
            ("caca_animais_silvestres", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou contra a libera????o da ca??a de animais silvestres no Brasil, excetuadas as situa????es j?? previstas na Lei Federal n?? 5.197/1967, como o controle de esp??cies invasoras e de animais silvestres considerados nocivos ?? agricultura ou ?? sa??de p??blica.\""
            )),
            ("mata_atlantica", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel ao Fundo de Restaura????o do Bioma Mata Atl??ntica e me comprometo a apoiar sua implanta????o, conforme a Lei Federal n?? 11.428/2006, visando ?? conserva????o de remanescentes de vegeta????o nativa, ?? pesquisa cient??fica ou ?? restaura????o, pois sei que apenas 7% da cobertura original da Mata Atl??ntica ainda est?? de p??.\""
            )),
            ("pantanal", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou contra o plantio de soja nas plan??cies inund??veis do bioma Pantanal brasileiro, que ?? considerado Patrim??nio Nacional pela Constitui????o Federal (?? 4?? do art. 225) e Reserva da Biosfera pelas Na????es Unidas.\""
            )),
            ("amazonia_cerrado", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('N??o', 'N??o'),
                    ('Prefiro n??o responder / N??o sei', 'Prefiro n??o responder / N??o sei'),
                ], defult="Sim", label="Opini??o do candidato em rela????o ?? frase \"Sou favor??vel ?? destina????o dos 60 milh??es de hectares de terras p??blicas n??o destinadas na Amaz??nia e no Cerrado para o uso sustent??vel, a conserva????o ambiental e a prote????o dos povos ind??genas, quilombolas, pequenos produtores extrativistas e Unidades de Conserva????o, pois sei que esta medida ?? imprescind??vel para a economia das regi??es citadas e o equil??brio clim??tico de todo o planeta.\""
            )),
        ]))
    ], null=True)

    @property
    def get_picture(self):
        if self.id_autor is None:
            return ''
        if self.picture:
            return self.picture.url
        return f"https://www.camara.leg.br/internet/deputado/bandep/{self.id_autor}.jpg"

    content_panels = Page.content_panels + [
        FieldPanel("id_autor", classname="full"),
        FieldPanel("id_parlametria", classname="full"),
        FieldPanel("id_serenata", classname="full"),
        FieldPanel('campaign_name'),
        FieldPanel('cpf'),
        FieldPanel('email'),
        FieldPanel('picture'),
        FieldPanel('charge'),
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

        params_functions = {
            'name': lambda queryset, value: queryset.filter(title__icontains=value),
            'uf[]': lambda queryset, values: queryset.filter(election_state__in=values),
            'sortby': lambda queryset, value: queryset.order_by('-title') if value == 'descending' else queryset,
        }

        request_items = dict(request.GET)
        for param, value in list(request_items.items()):
            if param in charges_dict.keys():
                charges.append(charges_dict[param])
            if param != 'uf[]':
                value = value[0]
            if value and param in params_functions:
                queryset = params_functions[param](queryset, value)

        return queryset.filter(charge__in=charges)


    def get_context(self, request):
        context = super(CandidateIndexPage, self).get_context(request)

        search_results = self.search_results(request)
        search_results = search_results.filter(live=True) # do not display draft pages
        subject = request.GET.get('subject', None)
        candidates_opinions = [''] * len(search_results)

        if subject:
            candidates_opinions = [candidate.opinions[0].value.get(subject_dict[subject]) for candidate in search_results]
            context['subject_description'] = subject_descriptions[subject]
            context['subject'] = subject
        search_results = zip(search_results, candidates_opinions)
        search_results = [{'opinion': opinion, 'candidate': candidate} for candidate, opinion in search_results]

        paginator = Paginator(search_results, 20)
        page = request.GET.get('page', 1)
        try:
            candidates_list = paginator.page(page)
        except EmptyPage:
            candidates_list = paginator.page(paginator.num_pages)

        context['candidates_list'] = candidates_list
        context['subjects'] = subjects_list
        context['uf_list'] = uf_list

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
