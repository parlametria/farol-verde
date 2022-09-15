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

        parser.add_argument(
            "--change-adhesion",
            action="store_true",
            help="Change Adhesion status of some propositions",
        )

    def handle(self, *args, **options):
        if options["import"]:
            parla_fetcher = ProposicoesFetcher(self.stdout, self.style)
            parla_fetcher.start_fetch()

        if options["update_date"]:
            parla_fetcher = ProposicoesFetcher(self.stdout, self.style)
            parla_fetcher.update_proposition_date()

        if options["change_adhesion"]:
            parla_fetcher = ProposicoesFetcher(self.stdout, self.style)
            parla_fetcher.change_adhesion()

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

    def change_adhesion(self):
        self._fix_pagamento_por_servicos_ambientais()
        self._rename_propositions()
        self._remove_from_adhesion()

    def _fix_pagamento_por_servicos_ambientais(self):
        proposicao = Proposicao.objects.filter(id_externo=138725).first()
        proposicao.casa = str(CasaChoices.SENADO)
        proposicao.ano = 2019
        proposicao.numero = 5028
        proposicao.sigla_tipo = "PL"
        proposicao.data = "2019-09-05"
        proposicao.save()

    def _rename_propositions(self):
        rename_propositions = [
            [140256, "Linhas de Transmissão em Terras indígenas", "PLP 275/2019"],
            [140554, "PL regularização fundiária em Terras da União", "PL 4348/2019"],
            [132208, "Acesso Água Potável como Diraito Fundamental", "PEC 04/2018"],
            [138725, "Pagamento por Serviços Ambientais", "derrubada de vetos PL 5028/19"],
            [152937, "Dia dos povos indigenas", "PL 5466/2019"],
        ]

        for row in rename_propositions:
            proposicao = Proposicao.objects.filter(id_externo=row[0]).first()

            if proposicao is None:
                print("*" * 80)
                print(f"Proposicao {row[0]} not found")
                continue

            proposicao.sobre = "".join([row[1], " (", row[2], ")"])
            proposicao.save()

    def _remove_from_adhesion(self):
        remove_from_adhesion_calculate = [148658, 140534, 144582]

        for id_prop in remove_from_adhesion_calculate:
            proposicao = self._find_or_create_proposicao(id_prop)
            proposicao.calculate_adhesion = False
            proposicao.save()

        add_to_adhesion_calculate = [138725, 152937]

        for id_prop in add_to_adhesion_calculate:
            proposicao = self._find_or_create_proposicao(id_prop)
            proposicao.calculate_adhesion = True
            proposicao.save()

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

    def _find_or_create_proposicao(self, id_proposicao: int, calculate_adhesion=False) -> Proposicao:
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
                calculate_adhesion=calculate_adhesion,
                data=dados_json["dataApresentacao"].split("T")[0],
            )

        return proposicao
