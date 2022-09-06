from django.test import TestCase
from wagtailstreamforms.models import FormSubmission, Form
from candidate.models import CandidatePage

import json
from uuid import uuid1

SAMPLE_FORM_DATA = {
    "informacoes-do-candidatoa": "",
    "nome-completo": "Fabio Paulino Garcia",
    "nome-na-urna": "Fabio Garcia",
    "cpf": "01234567891",
    "e-mail": "teste@email.br",
    "confirmacao-de-e-mail": "teste@email.br",
    "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Senador(a)",
    "redes-sociais": "",
    "twitter": "testeTT",
    "facebook": "testeFb",
    "instagram": "testeIG",
    "youtube": "testeYT",
    "contato-de-gabinetecampanha": "",
    "nome-completo-do-contato": "",
    "e-mail-do-contato": "contato@gmail.br",
    "telefone-do-contato": "65464646464656",
    "domicilio-eleitoral": "",
    "uf": "MG",
    "municipio": "Algum",
    "perguntas": "",
    "1-clima": "",
    "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim",
    "2-agua": "",
    "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Prefiro não responder / Não sei",
    "3-desmatamento": "",
    "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Prefiro não responder / Não sei",
    "4-terras-indigenas-e-quilombolas": "",
    "sou-favoravel-a-retomada-dos-processos-de-demarcacao-de-terras-indigenas-e-de-titulacao-de-territorios-quilombolas-no-brasil-pois-concordo-que-os-povos-e-comunidades-tradicionais-indigenas-e-quilombolas-e-suas-culturas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Prefiro não responder / Não sei",
    "5-reforma-tributaria": "",
    "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Prefiro não responder / Não sei",
    "6-saude-e-consumo": "",
    "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Prefiro não responder / Não sei",
    "7-defesa-agropecuaria-e-agrotoxicos": "",
    "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Prefiro não responder / Não sei",
    "8-unidades-de-conservacao": "",
    "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Prefiro não responder / Não sei",
    "9-caca-de-animais-silvestres": "",
    "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Prefiro não responder / Não sei",
    "10-mata-atlantica": "",
    "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Prefiro não responder / Não sei",
    "11-pantanal": "",
    "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Prefiro não responder / Não sei",
    "12-amazonia-e-cerrado": "",
    "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-terras-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Prefiro não responder / Não sei",
}


def make_enquete_form():
    form_fields = []
    for key in SAMPLE_FORM_DATA:
        form_fields.append(
            {
                "type": "singleline",
                "value": {"label": key, "required": False},
                "id": str(uuid1()),
            }
        )

    f = Form.objects.create(
        title="Enquete",
        template_name="streamforms/form_block.html",
        slug="enquete",
        fields=json.dumps(form_fields),
    )

    return f


class SurveyCandidateFactoryTest(TestCase):
    def test_created_a_candidate_page_on_form_submission(self):
        old_count = CandidatePage.objects.count()

        base_form = make_enquete_form()
        filled_form = FormSubmission(
            form=base_form, form_data=json.dumps(SAMPLE_FORM_DATA)
        )
        filled_form.save()

        new_count = CandidatePage.objects.count()

        self.assertEqual(new_count, old_count + 1)
