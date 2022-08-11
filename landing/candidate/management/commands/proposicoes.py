import csv
from os.path import abspath
from typing import Generator

from django.core.management.base import BaseCommand

from candidate.management.commands import ApiFetcher
from candidate.fetchers.api_camara import fetch_autores, fetch_dados_proposicao
from candidate.fetchers.api_senado import fetch_dados_materia
from candidate.models import Proposicao, AutorProposicao, CasaChoices


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--import",
            action="store_true",
            help="Import data from parlametria api",
        )

        parser.add_argument(
            "--update-date",
            action="store_true",
            help="Update the date of registered propositions",
        )

    def handle(self, *args, **options):
        if options["import"]:
            parla_fetcher = ProposicoesFetcher(self.stdout, self.style)
            parla_fetcher.start_fetch()

        if options["update_date"]:
            parla_fetcher = ProposicoesFetcher(self.stdout, self.style)
            parla_fetcher.update_proposition_date()


class ProposicoesFetcher(ApiFetcher):
    def start_fetch(self):
        self._fetch_autors()

    def update_proposition_date(self):
        self.stdout.write("Updating all stored proposition date with API data")

        for prop in Proposicao.objects.all():
            data = None

            if prop.casa == str(CasaChoices.CAMARA):
                self.stdout.write(f"Fetching date of {prop.id_externo} from {CasaChoices.CAMARA} API")
                dados_json = fetch_dados_proposicao(prop.id_externo)["dados"]
                data = dados_json["dataApresentacao"].split("T")[0]
            else:
                self.stdout.write(f"Fetching date of {prop.id_externo} from {CasaChoices.SENADO} API")
                dados_json = fetch_dados_materia(prop.id_externo)["DetalheMateria"]["Materia"]
                data = dados_json["DadosBasicosMateria"]["DataApresentacao"]

            prop.data = data
            prop.save()


    def _proposicoes_iterator(self) -> Generator[int, None, None]:
        filepath = "".join(
            [abspath(""), "/candidate/csv/", "proposicoes_com_tematica_ambiental.csv"]
        )
        csvfile = open(filepath, "r")
        reader = csv.reader(csvfile, delimiter=",")

        # skip header
        next(reader)

        for row in reader:
            yield int(row[0])

        csvfile.close()

    def _fetch_autors(self):
        for id_proposicao in self._proposicoes_iterator():
            self.stdout.write(f"Fetching data from proposition: {id_proposicao}")

            proposicao = self._find_or_create_proposicao(id_proposicao)
            autores_json = fetch_autores(id_proposicao)

            for autor in autores_json["dados"]:
                id_autor = int(autor["uri"].split("/")[-1])

                autor_proposicao = AutorProposicao.objects.filter(
                    id_parlamentar=id_autor
                ).first()

                if autor_proposicao is None:
                    autor_proposicao = AutorProposicao.objects.create(
                        id_parlamentar=id_autor, nome=autor["nome"]
                    )

                autor_proposicao.proposicoes.add(proposicao)

    def _find_or_create_proposicao(self, id_proposicao: int) -> Proposicao:
        proposicao = Proposicao.objects.filter(id_externo=id_proposicao).first()

        if proposicao is None:
            dados_json = fetch_dados_proposicao(id_proposicao)["dados"]
            proposicao = Proposicao.objects.create(
                id_externo=id_proposicao,
                sigla_tipo=dados_json["siglaTipo"],
                numero=dados_json["numero"],
                ano=dados_json["ano"],
                ementa=dados_json["ementa"],
                sobre="...",
                casa=str(CasaChoices.CAMARA),
                calculate_adhesion=False,
                data=dados_json["dataApresentacao"].split("T")[0],
            )

        return proposicao
