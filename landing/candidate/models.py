from django.db import models
from django.db.models.signals import post_save
from django.core.paginator import EmptyPage, PageNotAnInteger, Paginator
from django.dispatch import receiver
from django.template.defaultfilters import slugify

from wagtail.core.models import Page
from wagtail.search import index
from wagtail.admin.edit_handlers import FieldPanel, StreamFieldPanel
from wagtail.core.fields import StreamField
from wagtailstreamforms.models import FormSubmission

from wagtail.core.blocks import StructBlock, ChoiceBlock, URLBlock
from django.db.models import CharField, ImageField, EmailField, URLField

from candidate.util import check_deputado, Deputado, uf_list, subjects_list, subject_dict, subject_descriptions

class CandidatePage(Page):
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
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável à inclusão da \"segurança climática\" em nossa Constituição Federal, como direito fundamental (no art. 5º), como princípio da Ordem Econômica e Financeira Nacional (no art. 170) e como núcleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econômico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudança Climática no Brasil.\""
            )),
            ("agua", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável à inclusão do “acesso à água potável e ao esgotamento sanitário” no artigo 5° da Constituição Federal, para entrarem formalmente no rol de direitos humanos fundamentais.\""
            )),
            ("desmatamento", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável à política de “desmatamento zero” em todos os biomas brasileiros, porque acredito ser possível manter, e até aumentar, a produção agropecuária atual sem novos desmatamentos, por meio da conversão de pastagens degradadas ou subaproveitadas.\""
            )),
            ("terras_indigenas", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável à retomada dos processos demarcatórios de Terras Indígenas no Brasil, pois sei que ainda há mais de 200 processos pendentes, e concordo que os povos e as culturas indígenas contribuem para o enfrentamento da mudança climática, para a conservação dessas Áreas Protegidas e da sociobiodiversidade brasileira.\""
            )),
            ("reforma_tributaria", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável a uma reforma e a uma política tributária socioambiental progressiva e promotora de saúde, que reduza tributos sobre atividades econômicas com baixas emissões de Gases de Efeito Estufa (GEE) e com baixo nível de poluição, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas à saúde.\""
            )),
            ("saude_consumo", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável à redução do consumo de produtos nocivos à saúde e ao meio ambiente, tais como álcool e tabaco, alimentos ultraprocessados, agrotóxicos e combustíveis fósseis, e concordo com a adoção de medidas regulatórias para esses produtos, como tributação progressiva, restrição da publicidade, garantia de ambientes protegidos de seus efeitos e informação adequada para seu consumo.\""
            )),
            ("agropecuaria", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou contra a flexibilização das leis de Defesa Agropecuária, pois os programas de autocontrole geridos pelas empresas do setor não devem substituir o poder público na fiscalização da qualidade de rebanhos, de lavouras e de seus produtos, assim como não concordo com a flexibilização das regras para registro e utilização de agrotóxicos e pesticidas no Brasil.\""
            )),
            ("unidades_conservacao", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável às parcerias entre o setor público e o setor privado para a implementação e gestão sustentável de Parques Nacionais, Parques Estaduais e outras Unidades de Conservação onde seja permitido o uso público.\""
            )),
            ("caca_animais_silvestres", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou contra a liberação da caça de animais silvestres no Brasil, excetuadas as situações já previstas na Lei Federal nº 5.197/1967, como o controle de espécies invasoras e de animais silvestres considerados nocivos à agricultura ou à saúde pública.\""
            )),
            ("mata_atlantica", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável ao Fundo de Restauração do Bioma Mata Atlântica e me comprometo a apoiar sua implantação, conforme a Lei Federal nº 11.428/2006, visando à conservação de remanescentes de vegetação nativa, à pesquisa científica ou à restauração, pois sei que apenas 7% da cobertura original da Mata Atlântica ainda está de pé.\""
            )),
            ("pantanal", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou contra o plantio de soja nas planícies inundáveis do bioma Pantanal brasileiro, que é considerado Patrimônio Nacional pela Constituição Federal (§ 4º do art. 225) e Reserva da Biosfera pelas Nações Unidas.\""
            )),
            ("amazonia_cerrado", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], defult="Sim", label="Opinião do candidato em relação à frase \"Sou favorável à destinação dos 60 milhões de hectares de florestas públicas não destinadas na Amazônia e no Cerrado para o uso sustentável, a conservação ambiental e a proteção dos povos indígenas, quilombolas, pequenos produtores extrativistas e Unidades de Conservação, pois sei que esta medida é imprescindível para a economia das regiões citadas e o equilíbrio climático de todo o planeta.\""
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


class CandidateIndexPage(Page):
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
            if param in ['senators', 'deputies']:
                charges.append(charges_dict[param])
            if param != 'uf[]':
                value = value[0]
            if value and param in params_functions:
                queryset = params_functions[param](queryset, value)

        return queryset.filter(charge__in=charges)


    def get_context(self, request):
        context = super(CandidateIndexPage, self).get_context(request)

        search_results = self.search_results(request)
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

    if form[role_column] == "Deputado(a) Federal":
        cpf = int(form["cpf"])
        found = check_deputado(cpf)

        if found:
            return check_candidate_and_add_new(found, instance)

    add_blank_candidate_page(instance)


def make_candidate(form, id_autor, id_parlametria, slug):
    candidates_index = CandidateIndexPage.objects.all().first()

    candidate = CandidatePage(
        title=form['nome-completo'],
        slug=slug,
        id_autor=id_autor,
        id_parlametria=id_parlametria,
        campaign_name=form['nome-de-campanha'],
        cpf=form['cpf'],
        email=form['e-mail'],
        charge=form['e-candidatoa-a-qual-vaga-no-pleito-de-2022'],
        social_media=[('twitter', form['twitter']), ('facebook', form['facebook']), ('instagram', form['instagram']), ('youtube', form['youtube'])],
        manager_name=form['nome-completo-do-contato'],
        manager_email=form['e-mail-do-contato'],
        manager_phone=form['telefone-do-contato'],
        manager_site=form['link-para-o-site-da-campanha'],
        election_state=form['uf'],
        election_city=form['municipio'],
        picture="",
        opinions=[
            ('opinions', {
                "clima": form['sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais'],
                "agua": form['sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas'],
                "desmatamento": form['sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira'],
                "terras_indigenas": form['sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude'],
                "reforma_tributaria": form['sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo'],
                "saude_consumo": form['sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil'],
                "agropecuaria": form['sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico'],
                "unidades_conservacao": form['sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico'],
                "caca_animais_silvestres": form['sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica'],
                "mata_atlantica": form['sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe'],
                "pantanal": form['sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas'],
                "amazonia_cerrado": form['sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta']
            })
        ]
    )

    candidates_index.add_child(instance=candidate)
    candidates_index.save()

    return candidate


def check_candidate_and_add_new(dep: Deputado, form: FormSubmission):
    alread_added = CandidatePage.objects.filter(id_autor=dep.id_autor).first()
    form = form.get_data()

    if alread_added:
        return alread_added

    slug = slugify(f"{dep.nome_autor} {dep.id_autor}")

    make_candidate(
        form,
        dep.id_autor,
        dep.id_autor_parlametria,
        slug,
    )


def add_blank_candidate_page(instance: FormSubmission):
    form = instance.get_data()

    slug = slugify(f"{form['nome-de-campanha']} {instance.id}")
    make_candidate(form, None, None, slug)
