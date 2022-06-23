import requests
from time import sleep

from django.core.management.base import BaseCommand, CommandError, OutputWrapper
from django.core.management.color import Style

from django.template.defaultfilters import slugify
from wagtail.core.models import Page

from blog.models import Candidate, CandidateIndexPage

LEGGO_API = "https://api.parlametria.org.br"
PERFIL_API = "https://perfil.parlametria.org.br/api"
SERENATA_API = "https://api-perfilpolitico.serenata.ai/api"


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--import",
            action="store_true",
            help="Import data from parlametria api",
        )

    def handle(self, *args, **options):
        if options["import"]:
            parla_fetcher = ParlametriaFetcher(self.stdout, self.style)
            parla_fetcher.start_fetch()


class ParlametriaFetcher:
    SLEEP = True  # for dev
    SLEEP_TIME = 2
    candidate_index: CandidateIndexPage = None

    def __init__(self, stdout: OutputWrapper, style: Style):
        self.stdout = stdout
        self.style = style

    def start_fetch(self):
        self.candidate_index = self._get_or_create_candidates_index()
        self._import_candidates()

    def _get_or_create_candidates_index(self) -> CandidateIndexPage:
        root: Page = Page.objects.filter(slug="root").first()
        candidate_index = CandidateIndexPage.objects.filter(slug="candidatos").first()

        if not candidate_index:
            candidate_index = CandidateIndexPage(title="Candidatos", slug="candidatos")
            root.add_child(instance=candidate_index)
            root.save()

        return candidate_index

    def _import_candidates(self):
        self.stdout.write(f"Fetching all actors from {LEGGO_API}")
        base_autores = requests.get(f"{LEGGO_API}/autores/")

        if base_autores.status_code != 200:
            raise CommandError(f"Could not get candidates data from {LEGGO_API}")

        for row in base_autores.json():
            self._get_actors(row["id_leggo"])

    def _get_actors(self, id_leggo: str):
        url = f"{LEGGO_API}/atores/{id_leggo}"
        self.stdout.write(f"Fetching actors data from {url}")
        actors = requests.get(url)

        if actors.status_code != 200:
            # raise CommandError(f"Could not get actors data from {url}")
            self.stdout.write(self.style.ERROR(f"\tCould not get actors data from {url}"))
            return

        for row in actors.json():
            self._get_actor_data(
                row["id_autor"],
                row["id_autor_parlametria"],
                row["nome_autor"],
            )

            if self.SLEEP:
                sleep(self.SLEEP_TIME)

    def _get_actor_data(
        self,
        id_autor: int,
        id_autor_parlametria: int,
        nome_autor: str,
    ):
        url = f"{PERFIL_API}/parlamentares/{id_autor_parlametria}/info"
        self.stdout.write(f"\tFetching actor data from {url}")
        perfil_data = requests.get(url)

        if perfil_data.status_code != 200:
            self.stdout.write(
                self.style.ERROR(
                    f"\tCould not get perfil data from {url}\n"
                    f"\tName: {nome_autor}\n"
                    f"\tId Autor: {id_autor}\n"
                    f"\tId Parlametria {id_autor_parlametria}\n"
                )
            )
            return

        data = perfil_data.json()
        self._make_candidate(
            id_autor=id_autor,
            id_parlametria=id_autor_parlametria,
            id_serenata=data["id_perfil_politico"],
            nome_autor=nome_autor,
        )

    def _make_candidate(
        self, id_autor: int, id_parlametria: int, id_serenata: int, nome_autor: str
    ):
        found = Candidate.objects.filter(id_actor=id_autor).first()

        if found is not None:
            self.stdout.write(
                self.style.WARNING(
                    f"\t\tCandidate id_autor={id_autor} already saved in database, skipping."
                )
            )
            return

        try:
            slug = slugify(f"{nome_autor} {id_autor}")

            candidate = Candidate(
                id_actor=id_autor,
                id_parlametria=id_parlametria,
                id_serenata=id_serenata,
                name=nome_autor,
                title=nome_autor,
                slug=slug,
            )

            self.candidate_index.add_child(instance=candidate)
            self.candidate_index.save()
        except Exception as ex:
            self.stdout.write(
                self.style.ERROR(
                    f"\t\tCould not create candidate with data:\n"
                    f"\t\t\tnome_autor={nome_autor}\n"
                    f"\t\t\tid_autor={id_autor}\n"
                    f"\t\t\tid_parlametria{id_parlametria}\n"
                    f"\t\t\tid_serenata{id_serenata}\n"
                )
            )
            self.stdout.write(self.style.ERROR("\t\t" + str(ex)))
