from django.template.defaultfilters import slugify
from django.apps import apps
from wagtail.core.models import Page

from typing import Optional, Union
from typing_extensions import Literal

from candidate.util import Deputado, Senador, check_deputado, check_senador


def get_candidate_page_model() -> Page:
    """
    return CandidatePage from candidate.models\n
    Why ? Because of cyclic import between builders.py and models.py
    """
    return apps.get_model("candidate.CandidatePage")


def get_candidate_index_page_model() -> Page:
    """
    return CandidateIndexPage from candidate.models\n
    Why ? Because of cyclic import between builders.py and models.py
    """
    return apps.get_model("candidate.CandidateIndexPage")


class SurveyCandidateBuilder:
    def __init__(self, form_id, form, role_column):
        self.form_id = form_id
        self.form = form
        self.role_column = role_column

    def create_candidate(self):
        found = (
            self._find_deputado()
            if self._check_role() == "deputado"
            else self._find_senador()
        )

        if found:
            return self._check_candidate_and_add_new(found)

        return self._add_candidate_page_without_parlametria()

    def _check_role(self) -> Literal["deputado", "senador"]:
        deputado_value = "Deputado(a) Federal"

        if self.form[self.role_column] == deputado_value:
            return "deputado"
        else:
            return "senador"

    def _find_deputado(self) -> Optional[Deputado]:
        cpf = int(self.form["cpf"])
        return check_deputado(cpf)

    def _find_senador(self) -> Optional[Senador]:
        nome = self.form["nome-de-campanha"].strip()
        nome_completo = self.form["nome-completo"].strip()
        uf = self.form["uf"].strip()

        return check_senador(nome, nome_completo, uf)

    def _check_candidate_and_add_new(self, parlamentar: Union[Deputado, Senador]):
        CandidatePage = get_candidate_page_model()

        alread_added: Optional[CandidatePage] = CandidatePage.objects.filter(
            id_autor=parlamentar.id_autor
        ).first()

        if alread_added:
            return alread_added

        slug = slugify(f"{parlamentar.nome_autor} {parlamentar.id_autor}")

        return self._make_candidate(
            slug,
            parlamentar.id_autor,
            parlamentar.id_autor_parlametria,
        )

    def _add_candidate_page_without_parlametria(self):
        nome = self.form["nome-de-campanha"]

        slug = slugify(f"{nome} {self.form_id}")
        return self._make_candidate(slug, None, None)

    def _make_candidate(
        self,
        slug: str,
        id_autor: Optional[int] = None,
        id_parlametria: Optional[int] = None,
    ):
        CandidateIndexPage = get_candidate_index_page_model()
        CandidatePage = get_candidate_page_model()

        candidates_index = CandidateIndexPage.objects.all().first()

        candidate = CandidatePage(
            title=self.form["nome-completo"],
            slug=slug,
            id_autor=id_autor,
            id_parlametria=id_parlametria,
            campaign_name=self.form["nome-de-campanha"],
            cpf=self.form["cpf"],
            email=self.form["e-mail"],
            charge=self.form["e-candidatoa-a-qual-vaga-no-pleito-de-2022"],
            social_media=[
                ("twitter", self.form["twitter"]),
                ("facebook", self.form["facebook"]),
                ("instagram", self.form["instagram"]),
                ("youtube", self.form["youtube"]),
            ],
            manager_name=self.form["nome-completo-do-contato"],
            manager_email=self.form["e-mail-do-contato"],
            manager_phone=self.form["telefone-do-contato"],
            manager_site=(
                self.form["link-para-o-site-da-campanha"]
                if "link-para-o-site-da-campanha" in self.form
                else None
            ),
            election_state=self.form["uf"],
            election_city=self.form["municipio"],
            picture="",
            opinions=[
                (
                    "opinions",
                    {
                        "clima": self.form[
                            "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais"
                        ],
                        "agua": self.form[
                            "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas"
                        ],
                        "desmatamento": self.form[
                            "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira"
                        ],
                        "terras_indigenas": self.form[
                            "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude"
                        ],
                        "reforma_tributaria": self.form[
                            "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo"
                        ],
                        "saude_consumo": self.form[
                            "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil"
                        ],
                        "agropecuaria": self.form[
                            "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico"
                        ],
                        "unidades_conservacao": self.form[
                            "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico"
                        ],
                        "caca_animais_silvestres": self.form[
                            "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica"
                        ],
                        "mata_atlantica": self.form[
                            "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe"
                        ],
                        "pantanal": self.form[
                            "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas"
                        ],
                        "amazonia_cerrado": self.form[
                            "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta"
                        ],
                    },
                )
            ],
        )

        candidates_index.add_child(instance=candidate)
        candidates_index.save()

        return candidate
