import requests

SENADO_API = "https://legis.senado.leg.br/dadosabertos"

FETCH_LIST = [
    ("PLP", 275, 2019, "Linhas de transmissão em terras indígenas"),
    ("PL", 4348, 2019, "Regularização de assentamentos"),
    ("PEC", "004", 2018, "PEC da água potável"),  # 132208
    (
        "PL",
        5028,
        2019,
        "Pagamento por Serviços Ambientais (derrubada de vetos PL 5028/19)",
    ),  # senado:138725
    (
        "PL",
        5466,
        2019,
        "Dia dos povos indigenas (PL 5466/2019)",
    )  # senado:152937 camara:2224662
    # ("PL", 2015, 2021, "Financiamento de energia solar residencial"),
    # ("PL", 4476, 2020, "Marco legal do gás"),
    # ("PL", 4162, 2019, "Marco legal do saneamento básico"),
]


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
        data = materia_json["DetalheMateria"]["Materia"]["DadosBasicosMateria"][
            "DataApresentacao"
        ]

        row = {
            "id_externo": codigo,
            "sigla_tipo": prop[0],
            "numero": prop[1],
            "ano": prop[2],
            "ementa": ementa,
            "sobre": prop[3],
            "data": data,
        }

        yield row, prop


def get_votacoes_materia_iterator(codigo_materia: int):
    votacoes_data = fetch_votacoes_materia(codigo_materia)

    if "Votacoes" not in votacoes_data["VotacaoMateria"]["Materia"]:
        return

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
            "votacao_parmanentares": votacoes["Votos"]["VotoParlamentar"],
        }


def fetch_senador_data(id_senador: int):
    """
    {
        "DetalheParlamentar": {
            "@xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
            "@xsi:noNamespaceSchemaLocation": "https://legis.senado.leg.br/dadosabertos/dados/DetalheParlamentarv6.xsd",
            "Metadados": {
                "Versao": "08/08/2022 15:30:51",
                "VersaoServico": "6",
                "DataVersaoServico": "2021-09-09",
                "DescricaoDataSet": "Informações sobre o parlamentar."
            },
            "Parlamentar": {
                "IdentificacaoParlamentar": {
                    "CodigoParlamentar": "5905",
                    "NomeParlamentar": "Rodrigo Cunha",
                    "NomeCompletoParlamentar": "Rodrigo Santos Cunha",
                    "SexoParlamentar": "Masculino",
                    "UrlFotoParlamentar": "http://www.senado.leg.br/senadores/img/fotos-oficiais/senador5905.jpg",
                    "UrlPaginaParlamentar": "http://www25.senado.leg.br/web/senadores/senador/-/perfil/5905",
                    "EmailParlamentar": "sen.rodrigocunha@senado.leg.br",
                    "SiglaPartidoParlamentar": "UNIÃO"
                },
                "DadosBasicosParlamentar": {
                    "DataNascimento": "1981-05-11",
                    "Naturalidade": "Arapiraca",
                    "UfNaturalidade": "AL",
                    "EnderecoParlamentar": "Senado Federal Anexo 2   Ala Afonso Arinos Gabinete 07"
                },
                "OutrasInformacoes": {
                    "Servico": [...]
                }
            }
        }
    }
    """
    url = f"{SENADO_API}/senador/{id_senador}.json"
    response = requests.get(url)
    return response.json()


def fetch_dados_materia(id_materia: int):
    # https://legis.senado.leg.br/dadosabertos/materia/140256.json
    url = f"{SENADO_API}/materia/{id_materia}.json"
    headers = {"Content-type": "application/json"}
    response = requests.get(url, headers=headers)
    return response.json()


def fetch_senadores():
    # https://legis.senado.leg.br/dadosabertos/senador/lista/atual.json
    url = f"{SENADO_API}/senador/lista/atual.json"
    headers = {"Content-type": "application/json"}
    response = requests.get(url, headers=headers)
    return response.json()
