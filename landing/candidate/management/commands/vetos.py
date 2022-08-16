import csv
import requests
import urllib.parse

from os.path import abspath
from typing import Generator, Optional, List

from django.core.management.base import BaseCommand
from django.core.management.base import OutputWrapper
from django.core.management.color import Style

from candidate.models import Proposicao, SessaoVeto, VotacaoDispositivo, CasaChoices

# https://docs.google.com/spreadsheets/d/17v7I99WH0GcgrqpzP6Zk7E7mG_Mbr2rQx719Dmufigo
SHEET_ID = "17v7I99WH0GcgrqpzP6Zk7E7mG_Mbr2rQx719Dmufigo"
VETO_SHEET_TABS = [
    "946475:PL 5028/2019",
    "946475:PL 5028/2019 - Veto 05/2021 015",
    "946475:PL 5028/2019 - Veto 05/2021 017...",
    "2224662:PL 5466/2019 - Veto n. 28/2022",
    "2199215:PL 2510/2019 Veto n. 72/2021",
    "2213200:PL 4162/2019",
]

VOTOS_CAMARA_SHEET_TABS = [
    "2270639:PL 528/2021 - REQ 2271/2021",  # Não é veto
    "2236765:PL 191/2020 - REQ 227/2022",  # Não é veto
]


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--import",
            action="store_true",
            help="Import Votos from google sheet",
        )

    def handle(self, *args, **options):
        if options["import"]:
            vetos_sheet = VetosSheet(self.stdout, self.style)
            vetos_sheet.import_data()


class VetosSheet:
    def __init__(self, stdout: OutputWrapper, style: Style):
        self.stdout = stdout
        self.style = style

    def import_data(self):
        for vetotab in VETO_SHEET_TABS:
            self.stdout.write(f"Processing tab {vetotab}")
            self._process_sheet_tab(vetotab)

    def _process_sheet_tab(self, tab: str):
        proposition = self._find_proposition(tab)

        if proposition is None:
            raise Exception(f"Proposition not found from tab: {tab}")

        sheet_csv_url = self.get_google_sheet_csv_url(SHEET_ID, tab)
        csv_iterator = self.url_csv_iterator(sheet_csv_url)
        reader = csv.reader(csv_iterator, delimiter=",")
        dispositivos = next(reader)[1:]
        sessoes: List[SessaoVeto] = []

        for i, dispositivo in enumerate(dispositivos):
            if dispositivo is None or len(dispositivo.strip()) == 0:
                self.stdout.write(self.style.WARNING(f"dispositivo is None or empty, skipping"))
                continue

            sessoes.append(self._get_or_create_sessao_veto(proposition, dispositivo.strip()))

        casa = str(CasaChoices.CAMARA)
        for votacoes_parlamentar in reader:
            nome_parlamentar = votacoes_parlamentar[0].strip()
            votos = votacoes_parlamentar[1:]

            if nome_parlamentar == "-":
                casa = str(CasaChoices.SENADO)

            self._process_votacoes_dispositivo(nome_parlamentar, sessoes, votos, casa)

    def get_google_sheet_csv_url(self, sheet_id: str, sheet_name: str) -> str:
        sheet_name_url = urllib.parse.quote_plus(sheet_name)
        return f"https://docs.google.com/spreadsheets/d/{sheet_id}/gviz/tq?tqx=out:csv&sheet={sheet_name_url}"

    def url_csv_iterator(self, url: str) -> Generator[str, None, None]:
        headers = {"Content-type": "text/csv"}
        response = requests.get(url, headers=headers)
        return (it.decode("utf-8") for it in response.iter_lines())

    def _find_proposition(self, tab: str) -> Optional[Proposicao]:
        _id = tab.split(":")[0]
        return Proposicao.objects.filter(id_externo=_id).first()

    def _find_sessao_veto(
        self, proposition: Proposicao, dispositivo: str
    ) -> Optional[SessaoVeto]:
        return (
            SessaoVeto.objects.filter(proposicao=proposition)
            .filter(dispositivo=dispositivo)
            .first()
        )

    def _get_or_create_sessao_veto(
        self, proposition: Proposicao, dispositivo: str
    ) -> SessaoVeto:
        sessao = self._find_sessao_veto(proposition, dispositivo)

        if sessao is None:
            sessao = SessaoVeto.objects.create(
                proposicao=proposition, dispositivo=dispositivo
            )

        return sessao

    def _process_votacoes_dispositivo(
        self,
        nome_parlamentar: str,
        sessoes: List[SessaoVeto],
        votos: List[str],
        casa: str,
    ):
        for i, sessao in enumerate(sessoes):
            tipo_voto = votos[i].strip()
            voto_dipositivo = self._get_or_instance_votacao_dispositivo(
                nome_parlamentar, sessao, casa
            )
            voto_dipositivo.tipo_voto = tipo_voto
            voto_dipositivo.save()

    def _get_or_instance_votacao_dispositivo(
        self, nome_parlamentar: str, sessao_veto: SessaoVeto, casa: str
    ) -> VotacaoDispositivo:
        voto_dipositivo = (
            VotacaoDispositivo.objects.filter(nome_parlamentar=nome_parlamentar)
            .filter(sessao_veto=sessao_veto)
            .first()
        )

        if voto_dipositivo is None:
            voto_dipositivo = VotacaoDispositivo()
            voto_dipositivo.nome_parlamentar = nome_parlamentar
            voto_dipositivo.sessao_veto = sessao_veto
            voto_dipositivo.casa = casa

        return voto_dipositivo
