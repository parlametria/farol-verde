import requests

CAMARA_API = "https://dadosabertos.camara.leg.br/api/v2"

# (numero/ano)
FETCH_LIST = [
    ("MPV", 867, 2018),
    ("MPV", 910, 2019),
    ("PL", 3729, 2004),
    ("PL", 6299, 2002),
    ("PL", 2633, 2020),
    ("PL", 5028, 2019),
    ("PL", 191, 2020),
    ("PL", 528, 2021),
    ("PL", 2510, 2019),
    ("PL", 5466, 2019),
]


def get_ids_membros_frente_parlamentar_ambientalista():
    url = f"{CAMARA_API}/frentes/54012/membros"
    response = requests.get(url)
    dados = response.json()["dados"]
    # remove rows with id None
    return list(filter(lambda row: row["id"] is not None, dados))


def get_proposicoes(
    ano=2018,
    numero=867,
    url=f"{CAMARA_API}/proposicoes?numero=%d&ano=%d&ordem=ASC&ordenarPor=id&itens=100",
):
    # https://dadosabertos.camara.leg.br/api/v2/proposicoes?numero=867&ano=2018&ordem=ASC&ordenarPor=id&itens=100
    response = requests.get(url % (numero, ano))
    return response.json()


def get_proposicoes_iterator():
    for prop in FETCH_LIST:
        proposicoes = get_proposicoes(numero=prop[1], ano=prop[2])

        for row in proposicoes["dados"]:
            if row["siglaTipo"] == prop[0]:
                yield row


def get_all_proposicoes_ids():
    proposicoes_ids = []

    for prop in get_proposicoes_iterator():
        proposicoes_ids.append(prop["id"])

    return proposicoes_ids


def get_votacoes_proposicao(idprop: int):
    url = f"{CAMARA_API}/proposicoes/{idprop}/votacoes?ordem=DESC&ordenarPor=dataHoraRegistro"
    response = requests.get(url)
    return response.json()


def get_all_votacoes_ids_prosicao(prosicao_json):
    return list(map(lambda row: row["id"], prosicao_json["dados"]))


def get_dados_votacao(idvota: str):
    # https://dadosabertos.camara.leg.br/api/v2/votacoes/2190237-114/votos
    url = f"{CAMARA_API}/votacoes/{idvota}/votos"
    response = requests.get(url)
    return response.json()
