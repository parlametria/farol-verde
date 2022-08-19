import requests

CAMARA_API = "https://dadosabertos.camara.leg.br/api/v2"

# (numero/ano)
FETCH_LIST = [
    ("MPV", 867, 2018, "Anistias no Código Florestal (MP 867/18)"),
    ("MPV", 910, 2019, "MP da Grilagem (MP 910/19)"),
    ("PL", 3729, 2004, "Licenciamento ambiental"),
    ("PL", 6299, 2002, "PL do Veneno (PL 6299/02)"),
    ("PL", 2633, 2020, "PL da Grilagem (PL 2633/20)"),
    ("PL", 5028, 2019, "Pagamento por Serviços Ambientais (derrubada de vetos PL 5028/19)"),
    ("PL", 191, 2020, "Mineração em Terras Indígenas (req. urgência PL 191/20)"),
    ("PL", 528, 2021, "Mercado Brasileiro de Redução de Emissões (req. urgência PL 528/21)"),
    ("PL", 2510, 2019, "APP urbana"),
    ("PL", 5466, 2019, "Dia dos Povos Indígenas"),
    ("PL", 4162, 2019, "Marco legal do saneamento básico"),
    # ("PL", 4476, 2020, "Gás natural"),
]


def get_ids_membros_frente_parlamentar_ambientalista():
    url = f"{CAMARA_API}/frentes/54012/membros"
    response = requests.get(url)
    dados = response.json()["dados"]
    # remove rows with id None
    return list(filter(lambda row: row["id"] is not None, dados))


def get_proposicoes(
    ano: int,
    numero: int,
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
                yield row, prop


def get_all_proposicoes_ids():
    proposicoes_ids = []

    for prop in get_proposicoes_iterator():
        proposicoes_ids.append(prop[0]["id"])

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


def fetch_deputado_data(id_depudado: int):
    """
    {
    "dados": {
        "id": 204431,
        "uri": "https://dadosabertos.camara.leg.br/api/v2/deputados/204431",
        "nomeCivil": "MARCOS AURÉLIO  PÁDUA RIBEIRO GONÇALVES DE SAMPAIO",
        "ultimoStatus": {
            "id": 204431,
            "uri": "https://dadosabertos.camara.leg.br/api/v2/deputados/204431",
            "nome": "Marcos Aurélio Sampaio",
            "siglaPartido": "PSD",
            "uriPartido": "https://dadosabertos.camara.leg.br/api/v2/partidos/36834",
            "siglaUf": "PI",
            "idLegislatura": 56,
            "urlFoto": "https://www.camara.leg.br/internet/deputado/bandep/204431.jpg",
            "email": "dep.marcosaureliosampaio@camara.leg.br",
            "data": "2019-02-01T11:45",
            "nomeEleitoral": "Marcos Aurélio Sampaio",
            "gabinete": {
                "nome": "771",
                "predio": "3",
                "sala": "771",
                "andar": null,
                "telefone": "3215-5771",
                "email": "dep.marcosaureliosampaio@camara.leg.br"
            },
        "situacao": "Exercício",
        "condicaoEleitoral": "Titular",
        "descricaoStatus": null
        },
        "cpf": "01742564348",
        "sexo": "M",
        "urlWebsite": null,
        "redeSocial": [],
        "dataNascimento": "1991-09-19",
        "dataFalecimento": null,
        "ufNascimento": "PI",
        "municipioNascimento": "Teresina",
        "escolaridade": "Superior"
    },
    "links": [
        {
        "rel": "self",
        "href": "https://dadosabertos.camara.leg.br/api/v2/deputados/204431"
        }
    ]
    }
    """
    url = f"{CAMARA_API}/deputados/{id_depudado}"
    response = requests.get(url)
    return response.json()


def fetch_autores(id_proposicao: int):
    """
    {
        "dados": [
            {
                "uri": "https://dadosabertos.camara.leg.br/api/v2/deputados/204554",
                "nome": "Abílio Santana",
                "codTipo": 10000,
                "tipo": "Deputado",
                "ordemAssinatura": 1,
                "proponente": 1
            }
        ],
        "links": [
            {
                "rel": "self",
                "href": "https://dadosabertos.camara.leg.br/api/v2/proposicoes/2287916/autores"
            }
        ]
    }
    """
    url = f"{CAMARA_API}/proposicoes/{id_proposicao}/autores"
    headers = {"Content-type": "application/json"}
    response = requests.get(url, headers=headers)
    return response.json()


def fetch_dados_proposicao(id_proposicao: int):
    """
    {
        "dados": {
            "id": 2287916,
            "uri": "https://dadosabertos.camara.leg.br/api/v2/proposicoes/2287916",
            "siglaTipo": "PL",
            "codTipo": 139,
            "numero": 2284,
            "ano": 2021,
            "ementa": "Proíbe a exposição, lançamento ou destinação, de material orgânico ou não, líquidos ou sólidos, matéria viva ou não, objetos sólidos ou rejeitos, que afetem, atentem ou poluam o meio ambiente, obstruam a livre circulação de pessoas e veículos, em todo Território Nacional.",
            "dataApresentacao": "2021-06-22T16:17",
            "uriOrgaoNumerador": null,
            "statusProposicao": {
                "dataHora": "2021-07-07T00:00",
                "sequencia": 14,
                "siglaOrgao": "CCP",
                "uriOrgao": "https://dadosabertos.camara.leg.br/api/v2/orgaos/186",
                "uriUltimoRelator": null,
                "regime": "Prioridade (Art. 151, II, RICD)",
                "descricaoTramitacao": "Publicação de Proposição",
                "codTipoTramitacao": "604",
                "descricaoSituacao": "Tramitando em Conjunto",
                "codSituacao": 925,
                "despacho": "Encaminhada à publicação. Publicação Inicial em avulso e no DCD de 08/07/21 PAG 440",
                "url": "http://www.camara.gov.br/proposicoesWeb/prop_mostrarintegra?codteor=2057229",
                "ambito": "Regimental"
            },
            "uriAutores": "https://dadosabertos.camara.leg.br/api/v2/proposicoes/2287916/autores",
            "descricaoTipo": "Projeto de Lei",
            "ementaDetalhada": "",
            "keywords": "Proibição, lançamento, destinação, Resíduo orgânico, Resíduo inorgânico, praia, Corpo de água, via pública, local público, descumprimento, multa.",
            "uriPropPrincipal": "https://dadosabertos.camara.leg.br/api/v2/proposicoes/2196952",
            "uriPropAnterior": null,
            "uriPropPosterior": null,
            "urlInteiroTeor": "http://www.camara.gov.br/proposicoesWeb/prop_mostrarintegra?codteor=2032187",
            "urnFinal": null,
            "texto": null,
            "justificativa": null
        },
        "links": [
            {
            "rel": "self",
            "href": "https://dadosabertos.camara.leg.br/api/v2/proposicoes/2287916"
            }
        ]
        }
    """
    url = f"{CAMARA_API}/proposicoes/{id_proposicao}"
    headers = {"Content-type": "application/json"}
    response = requests.get(url, headers=headers)
    return response.json()


def fetch_deputados():
    """
    {
        "dados": [
            {
                "id": 204521,
                "uri": "https://dadosabertos.camara.leg.br/api/v2/deputados/204521",
                "nome": "Abou Anni",
                "siglaPartido": "UNIÃO",
                "uriPartido": "https://dadosabertos.camara.leg.br/api/v2/partidos/38009",
                "siglaUf": "SP",
                "idLegislatura": 56,
                "urlFoto": "https://www.camara.leg.br/internet/deputado/bandep/204521.jpg",
                "email": "dep.abouanni@camara.leg.br"
            },
            ...
        ],
        "links": [
            {
                "rel": "self",
                "href": "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome"
            },
            {
                "rel": "first",
                "href": "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome&pagina=1&itens=1000"
            },
            {
                "rel": "last",
                "href": "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome&pagina=1&itens=1000"
            }
        ]
    }
    """
    url = f"{CAMARA_API}/deputados?ordem=ASC&ordenarPor=nome"
    headers = {"Content-type": "application/json"}
    response = requests.get(url, headers=headers)
    return response.json()
