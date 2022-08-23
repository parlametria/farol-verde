from typing import List, Dict, Any
from unidecode import unidecode

from django.core.management.base import BaseCommand, OutputWrapper
from django.core.management.color import Style

from django.template.defaultfilters import slugify

from candidate.management.commands import ApiFetcher
from candidate.fetchers.api_camara import fetch_deputado_data, fetch_deputados
from candidate.fetchers.api_senado import fetch_senadores
from candidate.util import CandidatoTSE, csv_row_iterator

from candidate.models import CandidatePage, CandidateIndexPage, GenderChoices


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--import",
            action="store_true",
            help="Import data from parlametria api",
        )

    def handle(self, *args, **options):
        if options["import"]:
            parla_fetcher = CandidateFetcher(self.stdout, self.style)
            parla_fetcher.start_fetch()


class CandidateFetcher(ApiFetcher):
    TSE_CSV_FILENAME = "candidatos_tse_2022"
    DEFAULT_EMPTY = {
        "email": "email.nao@informado.com",
        "manager_name": "Não informado",
        "manager_email": "email.nao@informado.com",
        "manager_phone": "Não informado",
        "cpf": "00000000000",
        "manager_site": "https://farolverde.org.br",
        "election_city": "Não informado",
        "election_state": "Não informado",
    }

    def __init__(self, stdout: OutputWrapper, style: Style):
        super().__init__(stdout, style)
        self.candidates_index = CandidateIndexPage.objects.all().first()

    def start_fetch(self):
        self._get_autors()

    def _as_key(self, nome_urna: str):
        return unidecode(nome_urna.upper())

    def _get_autors(self):
        self.stdout.write("Fetching all deputados")
        deputados = self._remap_deputados_by_nome_urna(fetch_deputados())
        self.stdout.write("Fetching all senadores")
        senadores = self._remap_seadores_by_nome_urna(fetch_senadores())

        self.stdout.write("Processing TSE csv data")
        for tse_row in csv_row_iterator(self.TSE_CSV_FILENAME):
            candidato = CandidatoTSE.from_list(tse_row)

            if not candidato.is_senador and not candidato.is_deputado:
                # skip candidates that are neither senador or deputado
                continue

            if (
                candidato.is_deputado
                and deputados.get(self._as_key(candidato.nome_urna)) is not None
            ):
                self._process_deputado_candidate(
                    candidato, deputados[self._as_key(candidato.nome_urna)]
                )

            if (
                candidato.is_senador
                and senadores.get(self._as_key(candidato.nome_urna)) is not None
            ):
                self._process_senador_candidate(
                    candidato, senadores[self._as_key(candidato.nome_urna)]
                )

    def _process_deputado_candidate(self, candidato: CandidatoTSE, deputado_json: List):
        # candidates can have the same nome_urna
        deputado = (
            self._find_unique_deputado(candidato.cpf, deputado_json)
            if len(deputado_json) > 1
            else deputado_json[0]
        )
        if deputado is None:
            self.stdout.write(f"[DEPUTADO] CPF={candidato.cpf} no found")
            return

        found = CandidatePage.objects.filter(id_autor=deputado["id"]).first()
        if found is not None:
            self.stdout.write(
                self.style.WARNING(
                    f"\t[CAMARA] Candidate {found.id_autor} already saved, skipping"
                )
            )
            return

        data = self._prepare_data(
            candidato, id_autor=deputado["id"], id_parlametria="1" + str(deputado["id"])
        )
        self._make_candidate(data)

    def _process_senador_candidate(
        self, candidato: CandidatoTSE, senador_json: List[Any]
    ):
        senador = (
            self._find_unique_senador(candidato, senador_json)
            if len(senador_json) > 1
            else senador_json[0]
        )
        if senador is None:
            self.stdout.write(f"[SENADOR] CPF={candidato.cpf} no found")
            return

        _id = senador["IdentificacaoParlamentar"]["CodigoParlamentar"]
        found = CandidatePage.objects.filter(id_autor=_id).first()
        if found is not None:
            self.stdout.write(
                self.style.WARNING(
                    f"\t[SENADO] Candidate {found.id_autor} already saved, skipping"
                )
            )
            return

        data = self._prepare_data(
            candidato, id_autor=_id, id_parlametria="2" + str(_id)
        )
        self._make_candidate(data)

    def _remap_deputados_by_nome_urna(self, deputados_json) -> Dict[str, List[Any]]:
        remap = dict()
        for deputado in deputados_json["dados"]:
            nome_key = self._as_key(deputado["nome"])

            if remap.get(nome_key) is None:
                remap[nome_key] = []

            remap[nome_key].append(deputado)

        return remap

    def _remap_seadores_by_nome_urna(self, senadores_json) -> Dict[str, List[Any]]:
        remap = dict()
        parlamentares = senadores_json["ListaParlamentarEmExercicio"]["Parlamentares"]
        for senador in parlamentares["Parlamentar"]:
            nome = senador["IdentificacaoParlamentar"]["NomeParlamentar"]
            nome_key = self._as_key(nome)

            if remap.get(nome_key) is None:
                remap[nome_key] = []

            remap[nome_key].append(senador)

        return remap

    def _find_unique_deputado(self, cpf, deputados: List):
        for dep in deputados:
            json = fetch_deputado_data(dep["id"])

            if cpf == json["dados"]["cpf"]:
                return dep

        return None

    def _find_unique_senador(self, candidato: CandidatoTSE, senadores: List):
        for sen in senadores:
            nome_urna = self._as_key(sen["IdentificacaoParlamentar"]["NomeParlamentar"])
            nome_completo = self._as_key(
                sen["IdentificacaoParlamentar"]["NomeCompletoParlamentar"]
            )

            if (
                self._as_key(candidato.nome_urna) == nome_urna
                and self._as_key(candidato.nome) == nome_completo
            ):
                return sen

        return None

    def _prepare_data(
        self, candidato: CandidatoTSE, id_autor: int, id_parlametria: str
    ):
        slug = slugify(" ".join([candidato.nome_urna, str(id_autor)]))

        gender = (
            GenderChoices.MASCULINE.value
            if candidato.genero == GenderChoices.MASCULINE.label
            else GenderChoices.FEMININE.value
        )

        return {
            "id_autor": id_autor,
            "id_parlametria": id_parlametria,
            "id_serenata": None,
            "name": candidato.nome.title(),
            "title": candidato.nome_urna.title(),
            "party": candidato.partido_sigla,
            "slug": slug,
            "charge": self._get_charge(candidato),
            "social_media": None,
            # "opinions": [("opinions", self._get_default_options())],
            "opinions": [],
            "picture": None,
            "campaign_name": candidato.nome_urna,
            "cpf": candidato.cpf,
            "birth_date": candidato.data_nascimento,
            "email": candidato.email,
            "manager_name": self.DEFAULT_EMPTY["manager_name"],
            "manager_email": self.DEFAULT_EMPTY["manager_email"],
            "manager_phone": self.DEFAULT_EMPTY["manager_phone"],
            "manager_site": self.DEFAULT_EMPTY["manager_site"],
            "election_state": candidato.estado_nome.title(),
            "election_city": candidato.estado_sigla,
            "gender": gender,
            "tse_image_code": candidato.codigo_imagem,
        }

    def _get_charge(self, candidato: CandidatoTSE):
        if candidato.is_senador:
            return CandidatePage.SENADOR_CHARGE_TEXT

        return CandidatePage.DEPUTADO_CHARGE_TEXT

    def _get_default_options(self):
        default_text = "Prefiro não responder / Não sei"

        return {
            "clima": default_text,
            "agua": default_text,
            "desmatamento": default_text,
            "terras_indigenas": default_text,
            "reforma_tributaria": default_text,
            "saude_consumo": default_text,
            "agropecuaria": default_text,
            "unidades_conservacao": default_text,
            "caca_animais_silvestres": default_text,
            "mata_atlantica": default_text,
            "pantanal": default_text,
            "amazonia_cerrado": default_text,
        }

    def _make_candidate(self, data: dict):
        self.stdout.write(f"\tCreating candidate {data['slug']}")

        candidate = CandidatePage(
            live=True,
            title=data["title"],
            slug=data["slug"],
            id_autor=data["id_autor"],
            id_parlametria=data["id_parlametria"],
            campaign_name=data["campaign_name"],
            cpf=data["cpf"],
            birth_date=data["birth_date"],
            email=data["email"],
            charge=data["charge"],
            party=data["party"],
            social_media=data["social_media"],
            manager_name=data["manager_name"],
            manager_email=data["manager_email"],
            manager_phone=data["manager_phone"],
            manager_site=data["manager_site"],
            election_state=data["election_state"],
            election_city=data["election_city"],
            picture=data["picture"],
            opinions=data["opinions"],
        )

        self.candidates_index.add_child(instance=candidate)
        self.candidates_index.save()

        return candidate
