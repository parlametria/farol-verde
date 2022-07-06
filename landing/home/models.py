from django.db.models import CharField, ImageField, EmailField, URLField
from wagtail.core.models import Page

from wagtail.core.fields import RichTextField, StreamField
from wagtail.admin.edit_handlers import StreamFieldPanel, FieldPanel
from wagtailstreamforms.blocks import WagtailFormBlock
from wagtail.core.blocks import StructBlock, ChoiceBlock, URLBlock


class LandingPage(Page):
    is_creatable = False

    heading = RichTextField(
        null=False,
        blank=False,
        default="Tenetur nesciunt quae aspernatur, incidunt suscipit beatae totam qui ut, nam possimus adipisci cum quaerat? Odio maxime sint, officiis excepturi veritatis quod accusantium quidem corporis sapiente delectus ut, ullam cum a praesentium ea nam soluta molestiae, blanditiis assumenda quia beatae. In veritatis quod nisi incidunt suscipit nesciunt iure. Rerum deserunt ad ipsum repudiandae magni exercitationem laboriosam amet saepe labore illo? Maxime modi temporibus suscipit impedit, libero alias nostrum ipsa consequuntur dignissimos, eveniet alias qui aperiam ex ipsam ipsa quod ea. Similique eligendi est delectus ipsa ullam quisquam quis inventore voluptas corrupti, mollitia dolorum ab veniam voluptatibus ex alias debitis ratione. Quae fugit expedita, veniam id tenetur veritatis, voluptatum corrupti nam ipsam sed quidem quam iste modi soluta, omnis magnam similique corporis voluptates rerum quidem est sed? Corporis distinctio non sunt alias, necessitatibus inventore asperiores, ea dolore dolor autem, atque sunt eius soluta minima nostrum aspernatur facere doloremque? In dolores fugit nihil iusto officia, fugit atque impedit porro totam magnam, qui ea repudiandae corporis repellat aspernatur, et dolorem voluptatem explicabo eligendi quibusdam? Et odio harum sed non voluptatum suscipit asperiores, facilis voluptate dolore nihil aliquam ab qui non dolor quisquam? Quam a provident, non vitae facere dolorem recusandae, id quis beatae cum sapiente, voluptate vero corporis soluta culpa recusandae officiis delectus, maiores beatae excepturi quam hic accusantium. Voluptatem ex quisquam inventore dolor ea minus libero nam, distinctio hic deleniti reiciendis nobis accusamus magnam atque, earum doloribus culpa ullam eveniet quae qui aliquam sapiente nisi explicabo, ratione eius aperiam pariatur sit maxime hic laudantium, quisquam animi deserunt in itaque harum veniam velit culpa provident dolor veritatis. Placeat ullam nesciunt expedita atque? Ab recusandae animi illum beatae nihil perferendis qui id provident, facere tempora similique.",
    )

    content_panels = Page.content_panels + [
        FieldPanel("heading"),
    ]

    def get_context(self, request):
        context = super(LandingPage, self).get_context(request)
        survey_url = SurveysPage.objects.get(title="Enquete").slug
        contact_url = SurveysPage.objects.get(title="Contato").slug
        candidates_url = CandidatesPage.objects.first().slug
        context["survey_url"] = survey_url
        context["contact_url"] = contact_url
        context["candidates_url"] = candidates_url
        return context


class SurveysPage(Page):
    surveys = StreamField(
        [
            ("form", WagtailFormBlock()),
        ],
        blank=True,
        null=True,
    )

    content_panels = Page.content_panels + [
        StreamFieldPanel("surveys"),
    ]

class CandidateProfilePage(Page):
    parent_page_types = [
        "home.CandidatesPage",
    ]

    campaign_name = CharField(null=True, max_length=255)
    cpf = CharField(max_length=14, null=True)
    email = EmailField(null=True)
    picture = ImageField(null=True, blank=True)
    party = CharField(null=True, max_length=255, default="PSOL")
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
    manager_site = URLField(null=True)

    election_state = CharField(null=True, max_length=255)
    election_city = CharField(null=True, max_length=255)

    opinions = StreamField([
        ('opinions', StructBlock([
            ("clima", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável à inclusão da \"segurança climática\" em nossa Constituição Federal, como direito fundamental (no art. 5º), como princípio da Ordem Econômica e Financeira Nacional (no art. 170) e como núcleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econômico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudança Climática no Brasil.\""
            )),
            ("agua", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável à inclusão do “acesso à água potável e ao esgotamento sanitário” no artigo 5° da Constituição Federal, para entrarem formalmente no rol de direitos humanos fundamentais.\""
            )),
            ("desmatamento", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável à política de “desmatamento zero” em todos os biomas brasileiros, porque acredito ser possível manter, e até aumentar, a produção agropecuária atual sem novos desmatamentos, por meio da conversão de pastagens degradadas ou subaproveitadas.\""
            )),
            ("terras_indigenas", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável à retomada dos processos demarcatórios de Terras Indígenas no Brasil, pois sei que ainda há mais de 200 processos pendentes, e concordo que os povos e as culturas indígenas contribuem para o enfrentamento da mudança climática, para a conservação dessas Áreas Protegidas e da sociobiodiversidade brasileira.\""
            )),
            ("reforma_tributaria", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável a uma reforma e a uma política tributária socioambiental progressiva e promotora de saúde, que reduza tributos sobre atividades econômicas com baixas emissões de Gases de Efeito Estufa (GEE) e com baixo nível de poluição, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas à saúde.\""
            )),
            ("saude_consumo", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável à redução do consumo de produtos nocivos à saúde e ao meio ambiente, tais como álcool e tabaco, alimentos ultraprocessados, agrotóxicos e combustíveis fósseis, e concordo com a adoção de medidas regulatórias para esses produtos, como tributação progressiva, restrição da publicidade, garantia de ambientes protegidos de seus efeitos e informação adequada para seu consumo.\""
            )),
            ("agropecuaria", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou contra a flexibilização das leis de Defesa Agropecuária, pois os programas de autocontrole geridos pelas empresas do setor não devem substituir o poder público na fiscalização da qualidade de rebanhos, de lavouras e de seus produtos, assim como não concordo com a flexibilização das regras para registro e utilização de agrotóxicos e pesticidas no Brasil.\""
            )),
            ("unidades_conservacao", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável às parcerias entre o setor público e o setor privado para a implementação e gestão sustentável de Parques Nacionais, Parques Estaduais e outras Unidades de Conservação onde seja permitido o uso público.\""
            )),
            ("caca_animais_silvestres", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou contra a liberação da caça de animais silvestres no Brasil, excetuadas as situações já previstas na Lei Federal nº 5.197/1967, como o controle de espécies invasoras e de animais silvestres considerados nocivos à agricultura ou à saúde pública.\""
            )),
            ("mata_atlantica", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável ao Fundo de Restauração do Bioma Mata Atlântica e me comprometo a apoiar sua implantação, conforme a Lei Federal nº 11.428/2006, visando à conservação de remanescentes de vegetação nativa, à pesquisa científica ou à restauração, pois sei que apenas 7% da cobertura original da Mata Atlântica ainda está de pé.\""
            )),
            ("pantanal", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou contra o plantio de soja nas planícies inundáveis do bioma Pantanal brasileiro, que é considerado Patrimônio Nacional pela Constituição Federal (§ 4º do art. 225) e Reserva da Biosfera pelas Nações Unidas.\""
            )),
            ("amazonia_cerrado", ChoiceBlock(
                [
                    ('Sim', 'Sim'),
                    ('Não', 'Não'),
                    ('Prefiro não responder / Não sei', 'Prefiro não responder / Não sei'),
                ], label="Opinião do candidato em relação à frase \"Sou favorável à destinação dos 60 milhões de hectares de florestas públicas não destinadas na Amazônia e no Cerrado para o uso sustentável, a conservação ambiental e a proteção dos povos indígenas, quilombolas, pequenos produtores extrativistas e Unidades de Conservação, pois sei que esta medida é imprescindível para a economia das regiões citadas e o equilíbrio climático de todo o planeta.\""
            )),
        ]))
    ], null=True)

    content_panels = Page.content_panels + [
        FieldPanel('campaign_name'),
        FieldPanel('cpf'),
        FieldPanel('email'),
        FieldPanel('picture'),
        FieldPanel('party'),
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

    def get_context(self, request):
        context = super(CandidateProfilePage, self).get_context(request)
        context['opinions_data'] = {
            "clima": "Sou favorável à inclusão da \"segurança climática\" em nossa Constituição Federal, como direito fundamental (no art. 5º), como princípio da Ordem Econômica e Financeira Nacional (no art. 170) e como núcleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econômico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudança Climática no Brasil.",
            "agua": "Sou favorável à inclusão do “acesso à água potável e ao esgotamento sanitário” no artigo 5° da Constituição Federal, para entrarem formalmente no rol de direitos humanos fundamentais.",
            "desmatamento": "Sou favorável à política de “desmatamento zero” em todos os biomas brasileiros, porque acredito ser possível manter, e até aumentar, a produção agropecuária atual sem novos desmatamentos, por meio da conversão de pastagens degradadas ou subaproveitadas.",
            "terras_indigenas": "Sou favorável à retomada dos processos demarcatórios de Terras Indígenas no Brasil, pois sei que ainda há mais de 200 processos pendentes, e concordo que os povos e as culturas indígenas contribuem para o enfrentamento da mudança climática, para a conservação dessas Áreas Protegidas e da sociobiodiversidade brasileira.",
            "reforma_tributaria": "Sou favorável a uma reforma e a uma política tributária socioambiental progressiva e promotora de saúde, que reduza tributos sobre atividades econômicas com baixas emissões de Gases de Efeito Estufa (GEE) e com baixo nível de poluição, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas à saúde.",
            "saude_consumo": "Sou favorável à redução do consumo de produtos nocivos à saúde e ao meio ambiente, tais como álcool e tabaco, alimentos ultraprocessados, agrotóxicos e combustíveis fósseis, e concordo com a adoção de medidas regulatórias para esses produtos, como tributação progressiva, restrição da publicidade, garantia de ambientes protegidos de seus efeitos e informação adequada para seu consumo.",
            "agropecuaria": "Sou contra a flexibilização das leis de Defesa Agropecuária, pois os programas de autocontrole geridos pelas empresas do setor não devem substituir o poder público na fiscalização da qualidade de rebanhos, de lavouras e de seus produtos, assim como não concordo com a flexibilização das regras para registro e utilização de agrotóxicos e pesticidas no Brasil.",
            "unidades_conservacao": "Sou favorável às parcerias entre o setor público e o setor privado para a implementação e gestão sustentável de Parques Nacionais, Parques Estaduais e outras Unidades de Conservação onde seja permitido o uso público.",
            "caca_animais_silvestres": "Sou contra a liberação da caça de animais silvestres no Brasil, excetuadas as situações já previstas na Lei Federal nº 5.197/1967, como o controle de espécies invasoras e de animais silvestres considerados nocivos à agricultura ou à saúde pública.",
            "mata_atlantica": "Sou favorável ao Fundo de Restauração do Bioma Mata Atlântica e me comprometo a apoiar sua implantação, conforme a Lei Federal nº 11.428/2006, visando à conservação de remanescentes de vegetação nativa, à pesquisa científica ou à restauração, pois sei que apenas 7% da cobertura original da Mata Atlântica ainda está de pé.",
            "pantanal": "Sou contra o plantio de soja nas planícies inundáveis do bioma Pantanal brasileiro, que é considerado Patrimônio Nacional pela Constituição Federal (§ 4º do art. 225) e Reserva da Biosfera pelas Nações Unidas.",
            "amazonia_cerrado": "Sou favorável à destinação dos 60 milhões de hectares de florestas públicas não destinadas na Amazônia e no Cerrado para o uso sustentável, a conservação ambiental e a proteção dos povos indígenas, quilombolas, pequenos produtores extrativistas e Unidades de Conservação, pois sei que esta medida é imprescindível para a economia das regiões citadas e o equilíbrio climático de todo o planeta.",
        }
        return context

class CandidatesPage(Page):
    is_creatable = False
    ajax_template = "candidates/candidates_ajax.html"

    candidates_list = CandidateProfilePage.objects.all()

    def get_context(self, request):
        context = super(CandidatesPage, self).get_context(request)
        context['candidates_list'] = CandidatesPage.candidates_list
        return context