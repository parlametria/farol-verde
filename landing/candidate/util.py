import csv
import requests
import time


from functools import lru_cache, partial, update_wrapper
from os.path import abspath
from dataclasses import dataclass
from typing import Optional, List

from django.utils.functional import lazy


@dataclass
class Deputado:
    id_autor: int
    id_autor_parlametria: int
    nome_autor: str
    cpf: int


@dataclass
class Senador:
    id_autor: int
    id_autor_parlametria: int
    nome_autor: str
    nome_completo: str
    uf: str


# https://stackoverflow.com/questions/31771286/python-in-memory-cache-with-time-to-live
def lru_cache_time(seconds, maxsize=None):
    """
    Adds time aware caching to lru_cache
    """

    def wrapper(func):
        # Lazy function that makes sure the lru_cache() invalidate after X secs
        ttl_hash = lazy(lambda: round(time.time() / seconds), int)()

        @lru_cache(maxsize)
        def time_aware(__ttl, *args, **kwargs):
            """
            Main wrapper, note that the first argument ttl is not passed down.
            This is because no function should bother to know this that
            this is here.
            """

            def wrapping(*args, **kwargs):
                return func(*args, **kwargs)

            return wrapping(*args, **kwargs)

        return update_wrapper(partial(time_aware, ttl_hash), func)

    return wrapper


def apidata_to_senador(data) -> Senador:
    identificacao = data["IdentificacaoParlamentar"]
    mandato = data["Mandatos"]["Mandato"]

    uf = (
        mandato["UfParlamentar"]
        if type(mandato) != list
        else mandato[0]["UfParlamentar"]
    )

    return Senador(
        id_autor=int(identificacao["CodigoParlamentar"]),
        id_autor_parlametria=int("2" + identificacao["CodigoParlamentar"]),
        nome_autor=identificacao["NomeParlamentar"].strip(),
        nome_completo=identificacao["NomeCompletoParlamentar"].strip(),
        uf=uf.strip(),
    )


def get_senadores_data(legislatura: int = 56):
    """
    Get senadores from the given legislatura
    """
    url = (
        "https://legis.senado.leg.br/dadosabertos"
        f"/senador/lista/legislatura/{legislatura}/{legislatura}.json"
    )
    response = requests.get(url)
    return response.json()


# cache api senadores from api for 10min(60s * 10)
@lru_cache_time(seconds=600, maxsize=1)
def get_senadores() -> List[Senador]:
    json = get_senadores_data()

    senadores = []
    for row in json["ListaParlamentarLegislatura"]["Parlamentares"]["Parlamentar"]:
        senadores.append(apidata_to_senador(row))

    return senadores


def get_deputados() -> List[Deputado]:
    filepath = "".join([abspath(""), "/candidate/csv/", "depudados.csv"])
    csvfile = open(filepath, "r")
    reader = csv.reader(csvfile, delimiter=",")

    # skip header
    next(reader)

    depurados = [
        Deputado(
            id_autor=int(row[0]),
            id_autor_parlametria=int(row[1]),
            nome_autor=row[2],
            cpf=int(row[3]),
        )
        for row in reader
    ]

    csvfile.close()

    return depurados


def check_deputado(cpf: int) -> Optional[Deputado]:
    found: Optional[Deputado] = None

    for dep in get_deputados():
        if dep.cpf == cpf:
            found = dep
            break

    return found


def check_senador(nome: str, nome_completo: str, uf: str) -> Optional[Senador]:
    # Filter senadores from the same UF
    senadores = filter(lambda s: s.uf == uf, get_senadores())
    found: Optional[Senador] = None

    for senador in senadores:
        if senador.nome_autor == nome or senador.nome_completo == nome_completo:
            found = senador
            break

    return found


uf_list = [
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO",
]

subjects_list = [
    "clima",
    "??gua",
    "desmatamento",
    "terras ind??genas",
    "ref. tribut.",
    "sa??de",
    "agro",
    "unid. conserva????o",
    "ca??a",
    "mata atl??ntica",
    "pantanal",
    "amazonia e cerrado",
]

subject_dict = {
    "clima": "clima",
    "??gua": "agua",
    "desmatamento": "desmatamento",
    "terras ind??genas": "terras_indigenas",
    "ref. tribut.": "reforma_tributaria",
    "sa??de": "saude_consumo",
    "agro": "agropecuaria",
    "unid. conserva????o": "unidades_conservacao",
    "ca??a": "caca_animais_silvestres",
    "mata atl??ntica": "mata_atlantica",
    "pantanal": "pantanal",
    "amazonia e cerrado": "amazonia_cerrado",
}

subject_descriptions = {
    "clima": 'Sou favor??vel ?? inclus??o da "seguran??a clim??tica" em nossa Constitui????o Federal, como direito fundamental (no art. 5??), como princ??pio da Ordem Econ??mica e Financeira Nacional (no art. 170) e como n??cleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econ??mico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudan??a Clim??tica no Brasil.',
    "??gua": "Sou favor??vel ?? inclus??o do ???acesso ?? ??gua pot??vel e ao esgotamento sanit??rio??? no artigo 5?? da Constitui????o Federal, para entrarem formalmente no rol de direitos humanos fundamentais.",
    "desmatamento": "Sou favor??vel ?? pol??tica de ???desmatamento zero??? em todos os biomas brasileiros, porque acredito ser poss??vel manter, e at?? aumentar, a produ????o agropecu??ria atual sem novos desmatamentos, por meio da convers??o de pastagens degradadas ou subaproveitadas.",
    "terras ind??genas": "Sou favor??vel ?? retomada dos processos demarcat??rios de Terras Ind??genas no Brasil, pois sei que ainda h?? mais de 200 processos pendentes, e concordo que os povos e as culturas ind??genas contribuem para o enfrentamento da mudan??a clim??tica, para a conserva????o dessas ??reas Protegidas e da sociobiodiversidade brasileira.",
    "ref. tribut.": "Sou favor??vel a uma reforma e a uma pol??tica tribut??ria socioambiental progressiva e promotora de sa??de, que reduza tributos sobre atividades econ??micas com baixas emiss??es de Gases de Efeito Estufa (GEE) e com baixo n??vel de polui????o, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas ?? sa??de.",
    "sa??de": "Sou favor??vel ?? redu????o do consumo de produtos nocivos ?? sa??de e ao meio ambiente, tais como ??lcool e tabaco, alimentos ultraprocessados, agrot??xicos e combust??veis f??sseis, e concordo com a ado????o de medidas regulat??rias para esses produtos, como tributa????o progressiva, restri????o da publicidade, garantia de ambientes protegidos de seus efeitos e informa????o adequada para seu consumo.",
    "agro": "Sou contra a flexibiliza????o das leis de Defesa Agropecu??ria, pois os programas de autocontrole geridos pelas empresas do setor n??o devem substituir o poder p??blico na fiscaliza????o da qualidade de rebanhos, de lavouras e de seus produtos, assim como n??o concordo com a flexibiliza????o das regras para registro e utiliza????o de agrot??xicos e pesticidas no Brasil.",
    "unid. conserva????o": "Sou favor??vel ??s parcerias entre o setor p??blico e o setor privado para a implementa????o e gest??o sustent??vel de Parques Nacionais, Parques Estaduais e outras Unidades de Conserva????o onde seja permitido o uso p??blico.",
    "ca??a": "Sou contra a libera????o da ca??a de animais silvestres no Brasil, excetuadas as situa????es j?? previstas na Lei Federal n?? 5.197/1967, como o controle de esp??cies invasoras e de animais silvestres considerados nocivos ?? agricultura ou ?? sa??de p??blica.",
    "mata atl??ntica": "Sou favor??vel ao Fundo de Restaura????o do Bioma Mata Atl??ntica e me comprometo a apoiar sua implanta????o, conforme a Lei Federal n?? 11.428/2006, visando ?? conserva????o de remanescentes de vegeta????o nativa, ?? pesquisa cient??fica ou ?? restaura????o, pois sei que apenas 7% da cobertura original da Mata Atl??ntica ainda est?? de p??.",
    "pantanal": "Sou contra o plantio de soja nas plan??cies inund??veis do bioma Pantanal brasileiro, que ?? considerado Patrim??nio Nacional pela Constitui????o Federal (?? 4?? do art. 225) e Reserva da Biosfera pelas Na????es Unidas.",
    "amazonia e cerrado": "Sou favor??vel ?? destina????o dos 60 milh??es de hectares de terras p??blicas n??o destinadas na Amaz??nia e no Cerrado para o uso sustent??vel, a conserva????o ambiental e a prote????o dos povos ind??genas, quilombolas, pequenos produtores extrativistas e Unidades de Conserva????o, pois sei que esta medida ?? imprescind??vel para a economia das regi??es citadas e o equil??brio clim??tico de todo o planeta.",
}
