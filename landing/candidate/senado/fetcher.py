import requests
import json

SENADO_API = "https://legis.senado.leg.br/dadosabertos"

FETCH_LIST = [
    ("PLP", 275, 2019, "Linhas de transmissão em terras indígenas"),
    ("PL", 2015, 2021, "Financiamento de energia solar residencial"),
    ("PL", 4348, 2019, "Regularização de assentamentos"),
    ("PEC", "004", 2018, "PEC da água potável"),
    ("PL", 4476, 2020, "Marco legal do gás"),
    ("PL", 4162, 2019, "Marco legal do saneamento básico"),
]

# https://legis.senado.leg.br/dadosabertos/materia/135060
# {
#    "CodigoClasse": "33809634",
#    "DescricaoClasse": "Meio Ambiente",
#    "DescricaoClasseHierarquica": "Meio Ambiente"
# },

# proposições na api do senado são matérias
def fetch_materias(
    ano=int,
    numero=int,
    url=f"{SENADO_API}/materia/pesquisa/lista?ano=%s&numero=%s",
):
    """
    https://legis.senado.leg.br/dadosabertos/materia/pesquisa/lista?ano=2018&numero=867
    {
        "PesquisaBasicaMateria": {
            "@xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
            "@xsi:noNamespaceSchemaLocation": "http://legis.senado.leg.br/dadosabertos/dados/PesquisaBasicaMateriav7.xsd",
            "Metadados": {
            "Versao": "29/07/2022 15:40:06",
            "VersaoServico": "7",
            "DataVersaoServico": "2021-08-18",
            "DescricaoDataSet": "Retorna as matérias que satisfazem aos parâmetros informados. Atenção:  1) Se não informar o ano (da matéria ou da norma) nem o período de apresentação, será considerado o ano atual. \n\t 2) Para a pesquisa por período de apresentação, o limite é de 1 ano."
            },
            "Materias": {
                "Materia": [
                    {
                    "Codigo": "135060",
                    "IdentificacaoProcesso": "7708718",
                    "DescricaoIdentificacao": "MPV 867/2018",
                    "Sigla": "MPV",
                    "Numero": "00867",
                    "Ano": "2018",
                    "Ementa": "Altera a Lei nº 12.651, de 25 de maio de 2012, para dispor sobre a extensão do prazo para adesão ao Programa de Regularização Ambiental.",
                    "Autor": "Presidência da República",
                    "Data": "2018-12-27",
                    "UrlDetalheMateria": "http://legis.senado.leg.br/dadosabertos/materia/135060?v=7"
                    }
                ]
            }
        }
    }
    """
    response = requests.get(url % (numero, ano))
    return response.json()


def fetch_materia(sigla: str, numero: int, ano: int):
    # https://legis.senado.leg.br/dadosabertos/materia/PL/2510/2019.json
    url = f"{SENADO_API}/materia/{sigla}/{numero}/{ano}.json"
    response = requests.get(url)
    return response.json()


def get_codigo_materia(materia_json):
    """
    https://legis.senado.leg.br/dadosabertos/materia/PL/2015/2021.json
    DetalheMateria
        Materia
            IdentificacaoMateria
                CodigoMateria
    """
    if not "Materia" in materia_json["DetalheMateria"]:
        return None

    return materia_json["DetalheMateria"]["Materia"]["IdentificacaoMateria"][
        "CodigoMateria"
    ]


def get_ementa_materia(materia_json):
    """
    https://legis.senado.leg.br/dadosabertos/materia/PL/2015/2021.json
    DetalheMateria
        Materia
            DadosBasicosMateria
                EmentaMateria
    """
    if not "Materia" in materia_json["DetalheMateria"]:
        return None

    return materia_json["DetalheMateria"]["Materia"]["DadosBasicosMateria"][
        "EmentaMateria"
    ]


def fetch_votacoes_materia(codigo: int):
    """
    https://legis.senado.leg.br/dadosabertos/materia/votacoes/149648.json
    VotacaoMateria
        Materia
            Votacoes
                Votacao[0]:
                    - CodigoSessaoVotacao
                    SessaoPlenaria
                        - DataSessao
                        - HoraInicioSessao
                    Votos
                        VotoParlamentar[0]:
                            IdentificacaoParlamentar
                                - CodigoParlamentar
                            - SiglaVoto
    """
    url = f"{SENADO_API}/materia/votacoes/{codigo}.json"
    response = requests.get(url)
    return response.json()


def get_all_materia_iterator():
    for prop in FETCH_LIST:
        materia_json = fetch_materia(prop[0], prop[1], prop[2])
        codigo = get_codigo_materia(materia_json)
        ementa = get_ementa_materia(materia_json)

        row = {
            "id_externo": codigo,
            "sigla_tipo": prop[0],
            "numero": prop[1],
            "ano": prop[2],
            "ementa": ementa,
            "sobre": prop[3],
        }

        yield row, prop


def get_votacoes_materia_iterator(codigo_materia: int):
    votacoes_data = fetch_votacoes_materia(codigo_materia)
    votacoes_data = votacoes_data["VotacaoMateria"]["Materia"]["Votacoes"]["Votacao"]

    for votacoes in votacoes_data:
        id_proposicao = codigo_materia
        id_votacao = votacoes["CodigoSessaoVotacao"]
        data = votacoes["SessaoPlenaria"]["DataSessao"]
        hora = votacoes["SessaoPlenaria"]["HoraInicioSessao"]

        yield {
            "id_proposicao": id_proposicao,
            "id_votacao": id_votacao,
            "data": data,
            "hora": hora,
            "votacao_parmanentares": votacoes["Votos"]["VotoParlamentar"]
        }


def get_all_votacoes():
    a = get_all_materia_iterator()
    mat, _ = next(get_all_materia_iterator())

    for votacao in get_votacoes_materia_iterator(mat["id_externo"]):
        print(json.dumps(votacao["votacao_parmanentares"][0], indent=2))
        print("+"*80)


if __name__ == "__main__":
    get_all_votacoes()
