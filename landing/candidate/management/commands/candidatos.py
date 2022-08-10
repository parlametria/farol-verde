from django.core.management.base import BaseCommand, CommandError, OutputWrapper
from django.core.management.color import Style

from django.template.defaultfilters import slugify

from candidate.management.commands import ApiFetcher
from candidate.fetchers.api_parlametria import fetch_autores
from candidate.fetchers.api_camara import fetch_deputado_data
from candidate.fetchers.api_senado import fetch_senador_data

from candidate.models import (
    CandidatePage,
    CandidateIndexPage,
)


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
    DEFAULT_EMPTY = {
        "email": "email.nao@informado.com",
        "manager_name": "Não informado",
        "manager_email": "email.nao@informado.com",
        "manager_phone": "Não informado",
        "cpf": "00000000000",
        "manager_site": "https://farolverde.org.br",
        "election_city": "Não informado",
        "election_state": "Não informado",  # API senado não informa e no parlametria está "nan"
    }

    def __init__(self, stdout: OutputWrapper, style: Style):
        super().__init__(stdout, style)
        self.candidates_index = CandidateIndexPage.objects.all().first()

    def start_fetch(self):
        self._get_autors()

    def _get_autors(self):
        self.stdout.write(f"Fetching all actors from PARLAMETRIA")
        for autor in fetch_autores():
            found = CandidatePage.objects.filter(id_autor=autor["id_autor"]).first()

            if found is not None:
                self.stdout.write(
                    self.style.WARNING(
                        f"\tCandidate {found.id_autor} already saved, skipping"
                    )
                )
                continue

            slug = slugify(" ".join([autor["nome_autor"], str(autor["id_autor"])]))

            base_data = {
                "id_autor": autor["id_autor"],
                "id_parlametria": autor["id_autor_parlametria"],
                "id_serenata": None,
                "name": autor["nome_autor"],
                "title": autor["nome_autor"],
                "party": autor["partido"],
                "slug": slug,
                "charge": self._get_charge(autor["casa_autor"]),
                "social_media": None,
                # "opinions": [("opinions", self._get_default_options())],
                "opinions": [],
                "picture": None,
            }

            extra_data = dict()
            if autor["casa_autor"] == "camara":
                extra_data = self._get_candidate_data_camara(autor["id_autor"])
            else:
                extra_data = self._get_candidate_data_senado(autor["id_autor"])

            self._make_candidate({**base_data, **extra_data})

    def _get_candidate_data_camara(self, id_deputado):
        self.stdout.write(
            f"\tCandidate {id_deputado} from CAMARA, fetch data from CAMARA api"
        )
        data = fetch_deputado_data(id_deputado)

        ultimo_status = data["dados"]["ultimoStatus"]

        email = self.DEFAULT_EMPTY["email"]
        manager_email = self.DEFAULT_EMPTY["manager_email"]
        manager_phone = self.DEFAULT_EMPTY["manager_phone"]

        if (
            "email" in ultimo_status
            and ultimo_status["email"] is not None
            and len(ultimo_status["email"]) > 0
        ):
            email = ultimo_status["email"]

        if "gabinete" in ultimo_status:
            if (
                "email" in ultimo_status["gabinete"]
                and ultimo_status["gabinete"]["email"] is not None
                and len(str(ultimo_status["gabinete"]["email"])) > 0
            ):
                manager_email = ultimo_status["gabinete"]["email"]

            if (
                "telefone" in ultimo_status["gabinete"]
                and ultimo_status["gabinete"]["telefone"] is not None
                and len(str(ultimo_status["gabinete"]["telefone"])) > 0
            ):
                manager_phone = ultimo_status["gabinete"]["telefone"]

        data = {
            "campaign_name": ultimo_status["nomeEleitoral"],
            "cpf": data["dados"]["cpf"],
            "birth_date": data["dados"]["dataNascimento"],
            "email": email,
            "manager_name": ultimo_status["nomeEleitoral"],
            "manager_email": manager_email,
            "manager_phone": manager_phone,
            "manager_site": self.DEFAULT_EMPTY["manager_site"],
            "election_state": ultimo_status["siglaUf"],
            "election_city": self.DEFAULT_EMPTY["election_city"],
        }

        if (
            "siglaPartido" in ultimo_status
            and ultimo_status["siglaPartido"] is not None
            and len(ultimo_status["siglaPartido"]) > 0
        ):
            data["party"] = ultimo_status["siglaPartido"]

        return data

    def _get_candidate_data_senado(self, id_senador: int):
        self.stdout.write(
            f"\tCandidate {id_senador} from SENADO, fetch data from SENADO api"
        )
        data = fetch_senador_data(id_senador)

        parlamentar = data["DetalheParlamentar"]["Parlamentar"]

        email = self.DEFAULT_EMPTY["email"]
        if (
            "EmailParlamentar" in parlamentar["IdentificacaoParlamentar"]
            and parlamentar["IdentificacaoParlamentar"]["EmailParlamentar"] is not None
            and len(parlamentar["IdentificacaoParlamentar"]["EmailParlamentar"]) > 0
        ):
            email = parlamentar["IdentificacaoParlamentar"]["EmailParlamentar"]

        data = {
            "campaign_name": parlamentar["IdentificacaoParlamentar"]["NomeParlamentar"],
            "cpf": self.DEFAULT_EMPTY["cpf"],
            "birth_date": parlamentar["DadosBasicosParlamentar"]["DataNascimento"],
            "email": email,
            "manager_name": parlamentar["IdentificacaoParlamentar"]["NomeParlamentar"],
            "manager_email": self.DEFAULT_EMPTY["manager_email"],
            "manager_phone": self.DEFAULT_EMPTY["manager_phone"],
            "manager_site": self.DEFAULT_EMPTY["manager_site"],
            "election_city": self.DEFAULT_EMPTY["election_city"],
            "election_state": self.DEFAULT_EMPTY["election_state"],
        }

        if (
            "SiglaPartidoParlamentar" in parlamentar["IdentificacaoParlamentar"]
            and parlamentar["IdentificacaoParlamentar"]["SiglaPartidoParlamentar"]
            is not None
            and len(parlamentar["IdentificacaoParlamentar"]["SiglaPartidoParlamentar"])
            > 0
        ):
            data["party"] = parlamentar["IdentificacaoParlamentar"][
                "SiglaPartidoParlamentar"
            ]

        return data

    def _get_charge(self, casa: str):
        return (
            CandidatePage.DEPUTADO_CHARGE_TEXT
            if casa == "camara"
            else CandidatePage.SENADOR_CHARGE_TEXT
        )

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
            live=False,
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
