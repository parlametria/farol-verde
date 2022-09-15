import csv

from typing import Optional, Tuple, List

from django.core.management.base import BaseCommand
from django.core.management.base import OutputWrapper
from django.core.management.color import Style

from candidate.models import (
    Proposicao,
    SessaoVeto,
    VotacaoDispositivo,
    CasaChoices,
    VotacaoParlamentar,
)
from candidate.util import get_google_sheet_csv_url, url_to_row_iterator

# https://docs.google.com/spreadsheets/d/1AtqBCT5IwOF6QwiDEWUJjuDBICRBQ4cHV4pw2DWW5JE
SHEET_ID = "1AtqBCT5IwOF6QwiDEWUJjuDBICRBQ4cHV4pw2DWW5JE"

PROPOSICOES_TABS = [
    ("PEC 04/2018", 132208),
    ("PL 4348/2019", 140554),
    ("PLP 275/2019", 140256),
]

VETOS_TABS = [
    ("PL 5028/2019 - VETO N. 5/2021 (001 ao 014)", 138725),
    ("PL 5028/2019 - VETO N. 5/2021 (015 ao 016)", 138725),
    ("PL 5466/2019 - VETO N. 28/2022", 152937),
]

SENADORES = {
    "Acir Gurgacz": 4981,
    "Alessandro Vieira": 5982,
    "Alvaro Dias": 945,
    "Angelo Coronel": 5967,
    "Antonio Anastasia": 5529,
    "Alexandre Silveira": 4610,
    "Carlos Fávaro": 6295,  # suplente
    "Carlos Portinho": 5936,
    "Carlos Viana": 5990,
    "Chico Rodrigues": 470,
    "Cid Gomes": 5973,
    "Ciro Nogueira": 739,
    "Confúcio Moura": 475,
    "Daniella Ribeiro": 5998,
    "Davi Alcolumbre": 3830,
    "Dário Berger": 5537,
    "Eduardo Braga": 4994,
    "Eduardo Girão": 5976,
    "Eduardo Gomes": 3777,
    "Eliane Nogueira": 5898,
    "Eliziane Gama": 5718,
    "Elmano Férrer": 5531,
    "Esperidião Amin": 22,
    "Fabiano Contarato": 5953,
    "Fabio Garcia": 5740,
    "Fernando Bezerra Coelho": 5540,
    "Fernando Collor": 4525,
    "Flávio Arns": 345,
    "Flávio Bolsonaro": 5894,
    "Giordano": 6008,
    "Humberto Costa": 5008,
    "Irajá": 5385,
    "Izalci Lucas": 4770,
    "Jader Barbalho": 35,
    "Jaques Wagner": 581,
    "Jarbas Vasconcelos": 4545,
    "Jayme Campos": 4531,
    "Jean Paul Prates": 5627,
    "Jorge Kajuru": 5895,
    "Jorginho Mello": 5350,
    "José Serra": 90,
    "Kátia Abreu": 1249,
    "Lasier Martins": 5533,
    "Leila Barros": 5979,
    "Lucas Barreto": 5926,
    "Luis Carlos Heinze": 1186,
    "Luiz Carlos do Carmo": 5585,
    "Mailza Gomes": 5557,
    "Mara Gabrilli": 5376,
    "Marcelo Castro": 742,
    "Marcio Bittar": 285,
    "Marcos Rogério": 5422,
    "Marcos do Val": 5942,
    "Maria do Carmo Alves": 1023,
    "Mecias de Jesus": 6027,
    "Nelsinho Trad": 5985,
    "Nilda Gondim": 5281,
    "Omar Aziz": 5525,
    "Oriovisto Guimarães": 5924,
    "Otto Alencar": 5523,
    "Paulo Paim": 825,
    "Paulo Rocha": 374,
    "Plínio Valério": 5502,
    "Randolfe Rodrigues": 5012,
    "Reguffe": 5236,
    "Renan Calheiros": 70,
    "Roberto Rocha": 677,
    "Rodrigo Cunha": 5905,
    "Rodrigo Pacheco": 5732,
    "Rogério Carvalho": 5352,
    "Romário": 5322,
    "Rose de Freitas": 2331,
    "Simone Tebet": 5527,
    "Soraya Thronicke": 5988,
    "Styvenson Valentim": 5959,
    "Sérgio Petecão": 4560,
    "Tasso Jereissati": 3396,
    "Telmário Mota": 5535,
    "Vanderlan Cardoso": 5899,
    "Veneziano Vital do Rêgo": 5748,
    "Wellington Fagundes": 1173,
    "Weverton Rocha": 5411,
    "Zenaide Maia": 5783,
    "Zequinha Marinho": 3806,
}


def remap_tipo_voto(voto: str) -> str:
    tipos_voto = VotacaoParlamentar.TIPOS_VOTO["senado"]

    voto_planilha = {
        "Sim": tipos_voto["sim"],
        "Não": tipos_voto["nao"],
        "Não registrou voto": tipos_voto["p_nrv"],
        "art. 43, I - Licença saúde": tipos_voto["ls"],
        "art. 13, caput - Atividade parlamentar": tipos_voto["ap"],
        "PRESIDENTE": tipos_voto["presidente_art_51"],
        "Não Compareceu": tipos_voto["NCom"],
        "Abstenção": tipos_voto["abstencao"],
        "Presente (art. 40 - em Missão)": tipos_voto["mis"],
        "art. 43, II - Licença particular": tipos_voto["lp"],
    }

    return voto_planilha[voto]


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--votos-senadores-proposicoes-interesse",
            action="store_true",
            help="Import Votos from google sheet",
        )

    def handle(self, *args, **options):
        if options["votos_senadores_proposicoes_interesse"]:
            vetos_senatores = VetosSenatoresSheet(self.stdout, self.style)
            vetos_senatores.process_votos()
            vetos_senatores.process_vetos()


class VetosSenatoresSheet:
    def __init__(self, stdout: OutputWrapper, style: Style):
        self.stdout = stdout
        self.style = style

    def process_votos(self):
        global PROPOSICOES_TABS

        for tab in PROPOSICOES_TABS:
            self._process_voto_sheet_tab(tab)

    def _get_or_create_sessao_vetos(self, proposicao: Proposicao, dispositivo: str):
        sessao = (
            SessaoVeto.objects.filter(proposicao=proposicao)
            .filter(dispositivo=dispositivo)
            .first()
        )

        if sessao is None:
            sessao = SessaoVeto.objects.create(
                proposicao=proposicao, dispositivo=dispositivo
            )

        return sessao

    def process_vetos(self):
        global VETOS_TABS

        for tab in VETOS_TABS:
            self._process_veto_sheet_tab(tab)

    def _process_voto_sheet_tab(self, tab: Tuple[str, int]):
        global SHEET_ID
        proposition = self._get_proposition_from_tab(tab)

        self.stdout.write(
            self.style.WARNING(f"FOUND {proposition.id_externo}:{proposition}")
        )

        if proposition is None:
            self.stdout.write(
                self.style.ERROR(f"Proposition {tab[0]}={tab[1]} not found in databse")
            )
            return

        votacoes = proposition.votacoes.all()

        self.stdout.write(f"Fetching votos sheet tab {tab[0]}")

        sheet_csv_url = get_google_sheet_csv_url(SHEET_ID, tab[0])
        csv_iterator = url_to_row_iterator(sheet_csv_url)
        reader = csv.reader(csv_iterator, delimiter=",")

        next(reader)  # skip header

        for row in reader:
            [name, *votes] = row
            senador_id = self._get_senador_id(name)

            if senador_id is None:
                self.stdout.write(
                    self.style.WARNING(f"Senador {row[0]} id not found, skipping")
                )
                continue

            for (column_index, vote) in enumerate(votes):
                votacao = votacoes[column_index]
                already_voted = votacao.votacoes_parlamentares.filter(
                    id_parlamentar=senador_id
                ).first()
                tipo_voto = remap_tipo_voto(vote)

                if already_voted is not None:
                    if already_voted.tipo_voto != tipo_voto:
                        self.stdout.write(
                            self.style.WARNING(
                                f"Senador {senador_id}: voto mudou {already_voted.tipo_voto} --> {tipo_voto}. updating"
                            )
                        )
                        already_voted.tipo_voto = tipo_voto
                        already_voted.save()
                else:
                    self.stdout.write(
                        self.style.ERROR(f"Senador {senador_id} did not vote")
                    )

    def _process_veto_sheet_tab(self, tab: str):
        global SHEET_ID
        proposition = self._get_proposition_from_tab(tab)

        if proposition is None:
            self.stdout.write(
                self.style.ERROR(f"Proposition {tab[0]}={tab[1]} not found in databse")
            )
            return

        self.stdout.write(f"Fetching votos sheet tab {tab[0]}")

        sheet_csv_url = get_google_sheet_csv_url(SHEET_ID, tab[0])
        csv_iterator = url_to_row_iterator(sheet_csv_url)
        reader = csv.reader(csv_iterator, delimiter=",")

        [_, *sessoes_vetos] = next(reader)

        for row in reader:
            [nome, *votos] = row

            for (idx, dispositivo) in enumerate(sessoes_vetos):
                sv = self._get_or_create_sessao_vetos(proposition, dispositivo)

                if sv is None:
                    self.stdout.write(
                        self.style.ERROR(
                            f"SessaoVeto with proposition={proposition.id_externo}:{proposition} and dispositivo={dispositivo} not found"
                        )
                    )
                    continue

                tipo_voto = remap_tipo_voto(votos[idx])

                voto = (
                    VotacaoDispositivo.objects.filter(nome_parlamentar=nome.strip())
                    .filter(sessao_veto_id=sv.id)
                    .first()
                )

                if voto is None:
                    self.stdout.write(
                        self.style.WARNING(
                            f"Senador {nome} did not vote in veto: dispositivo={dispositivo}, creating it"
                        )
                    )
                    self._create_votacao_dispositivo(sv, nome.strip(), tipo_voto)
                    continue

                if voto.tipo_voto != tipo_voto:
                    self.stdout.write(
                        self.style.WARNING(
                            f"Senador {nome}: voto mudou {voto.tipo_voto} --> {tipo_voto}. updating"
                        )
                    )
                    voto.tipo_voto = tipo_voto
                    voto.save()

    def _create_votacao_dispositivo(
        self, sessao_veto: SessaoVeto, nome_parlamentar: str, tipo_voto: str
    ) -> VotacaoDispositivo:
        return VotacaoDispositivo.objects.create(
            nome_parlamentar=nome_parlamentar,
            tipo_voto=tipo_voto,
            sessao_veto=sessao_veto,
            casa=CasaChoices.SENADO,
        )

    def _get_senador_id(self, name: str):
        global SENADORES
        return SENADORES.get(name.strip())

    def _get_proposition_from_tab(self, tab: Tuple[str, int]) -> Optional[Proposicao]:
        id_externo = tab[1]
        # tabname = tab[0]
        # codes = tabname.split(" ")[1]
        # [numero, ano] = codes.split("/")
        # return Proposicao.objects.filter(numero=numero, ano=ano).first()
        return Proposicao.objects.filter(id_externo=id_externo).first()

    def _rename_proposition(self, proposition: Proposicao):
        # "make proposicoes-change-adhesion" does it
        pass
        # rename proposition, ex:
        # Linhas de transmissão em terras indígenas --> Linhas de transmissão em terras indígenas (PLP 275/2019)
        # if str(proposition) not in proposition.sobre:
        #    proposition.sobre = "".join([proposition.sobre, " (", str(proposition), ")"])
        #    proposition.save()
