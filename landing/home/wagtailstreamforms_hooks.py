import json, uuid

from django.template.defaultfilters import pluralize

from wagtailstreamforms.hooks import register
from wagtailstreamforms.models import FormSubmissionFile
from wagtailstreamforms.serializers import FormSubmissionSerializer
from home.models import CandidateProfilePage, CandidatesPage

@register('process_form_submission')
def save_form_submission_data(instance, form):
    submission_data = form.cleaned_data.copy()

    candidates_page = CandidatesPage.objects.first().specific
    candidate_id = uuid.uuid1()

    candidate = CandidateProfilePage(
        title=submission_data['nome-completo'],
        slug=candidate_id,
        campaign_name=submission_data['nome-de-campanha'],
        cpf=submission_data['cpf'],
        email=submission_data['e-mail'],
        charge=submission_data['e-candidatoa-a-qual-vaga-no-pleito-de-2022'],
        social_media=[('twitter', submission_data['twitter']), ('facebook', submission_data['facebook']), ('instagram', submission_data['instagram']), ('youtube', submission_data['youtube'])],
        manager_name=submission_data['nome-completo-do-contato'],
        manager_email=submission_data['e-mail-do-contato'],
        manager_phone=submission_data['telefone-do-contato'],
        manager_site=submission_data['link-para-o-site-da-campanha'],
        election_state=submission_data['uf'],
        election_city=submission_data['municipio'],
        picture="media/lula.jpg",
        opinions=[
            ('opinions', {
                "clima": submission_data['sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais'],
                "agua": submission_data['sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas'],
                "desmatamento": submission_data['sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira'],
                "terras_indigenas": submission_data['sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude'],
                "reforma_tributaria": submission_data['sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo'],
                "saude_consumo": submission_data['sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil'],
                "agropecuaria": submission_data['sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico'],
                "unidades_conservacao": submission_data['sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico'],
                "caca_animais_silvestres": submission_data['sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica'],
                "mata_atlantica": submission_data['sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe'],
                "pantanal": submission_data['sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas'],
                "amazonia_cerrado": submission_data['sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta']
            })
        ]
    )

    candidates_page.add_child(instance=candidate)
    candidates_page.save()

    # change the submission data to a count of the files
    for field in form.files.keys():
        count = len(form.files.getlist(field))
        submission_data[field] = '{} file{}'.format(count, pluralize(count))

    # save the submission data
    submission = instance.get_submission_class().objects.create(
        form_data=json.dumps(submission_data, cls=FormSubmissionSerializer),
        form=instance
    )

    # save the form files
    for field in form.files:
        for file in form.files.getlist(field):
            FormSubmissionFile.objects.create(
                submission=submission,
                field=field,
                file=file
            )