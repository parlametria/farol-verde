import csv
import requests
import time
import urllib.parse


from functools import lru_cache, partial, update_wrapper
from os.path import abspath
from dataclasses import dataclass
from typing import Optional, List, Generator

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


@dataclass
class CandidatoTSE:
    cpf: str
    estado_sigla: str
    estado_nome: str
    nome: str
    nome_urna: str
    email: str
    partido_sigla: str
    data_nascimento: str
    genero: str
    cargo: str
    codigo_imagem: str
    codigo_urna: str

    @staticmethod
    def from_list(data: List[str]):
        split = data[7].split("/")
        # YYYY-MM-DD
        data_nascimento = (
            "-".join([split[2], split[1], split[0]]
                     ) if data[7] != "nan" else ""
        )

        return CandidatoTSE(
            # some CPFs have less than 11 chars, left pad with '0' until 11 chars
            cpf=str(data[0]).zfill(11),
            estado_sigla=data[1],
            estado_nome=data[2],
            nome=data[3].title(),
            nome_urna=data[4].title(),
            email=data[5],
            partido_sigla=data[6],
            data_nascimento=data_nascimento,
            genero=data[8],
            cargo=data[9],
            codigo_imagem=data[10],
            codigo_urna=data[11],
        )

    @property
    def is_deputado(self):
        return self.cargo in [
            "DEPUTADO ESTADUAL",
            "DEPUTADO FEDERAL",
            "DEPUTADO DISTRITAL",
        ]

    @property
    def is_senador(self):
        return self.cargo == "SENADOR"

    @property
    def has_dados_invalidos(self):
        if self.data_nascimento == "":
            return True

        if int(self.cpf) < 0:
            return True

        return False


def csv_row_iterator(csv_filename: str):
    filepath = "".join([abspath(""), "/candidate/csv/", csv_filename, ".csv"])
    csvfile = open(filepath, "r")
    reader = csv.reader(csvfile, delimiter=";")

    # skip header
    next(reader)
    yield from reader
    csvfile.close()

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


def get_google_sheet_csv_url(sheet_id: str, sheet_name: str) -> str:
    sheet_name_url = urllib.parse.quote_plus(sheet_name)
    return f"https://docs.google.com/spreadsheets/d/{sheet_id}/gviz/tq?tqx=out:csv&sheet={sheet_name_url}"


def url_to_row_iterator(url: str) -> Generator[str, None, None]:
    headers = {"Content-type": "text/csv"}
    response = requests.get(url, headers=headers)
    return (it.decode("utf-8") for it in response.iter_lines())


uf_list = [
    "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO",
    "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI",
    "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO",
]

subject_dict = {
    "clima": "clima",
    "água": "agua",
    "desmatamento": "desmatamento",
    "terras indígenas e quilombolas": "terras_indigenas",
    "ref. tribut.": "reforma_tributaria",
    "saúde": "saude_consumo",
    "agrotóxico": "agropecuaria",
    "unid. conservação": "unidades_conservacao",
    "caça": "caca_animais_silvestres",
    "mata atlântica": "mata_atlantica",
    "pantanal": "pantanal",
    "amazonia e cerrado": "amazonia_cerrado",
}

subject_descriptions = {
    "clima": 'Sou favorável à inclusão da "segurança climática" em nossa Constituição Federal, como direito fundamental (no art. 5º), como princípio da Ordem Econômica e Financeira Nacional (no art. 170) e como núcleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econômico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudança Climática no Brasil',
    "água": "Sou favorável à inclusão do “acesso à água potável e ao esgotamento sanitário” no artigo 5° da Constituição Federal, para entrarem formalmente no rol de direitos humanos fundamentais",
    "desmatamento": "Sou favorável à política de “desmatamento zero” em todos os biomas brasileiros, porque acredito ser possível manter, e até aumentar, a produção agropecuária atual sem novos desmatamentos, por meio da conversão de pastagens degradadas ou subaproveitadas",
    "terras indígenas e quilombolas": "Sou favorável à retomada dos processos demarcatórios de Terras Indígenas no Brasil, pois sei que ainda há mais de 200 processos pendentes, e concordo que os povos e as culturas indígenas contribuem para o enfrentamento da mudança climática, para a conservação dessas Áreas Protegidas e da sociobiodiversidade brasileira.",
    "ref. tribut.": "Sou favorável a uma reforma e a uma política tributária socioambiental progressiva e promotora de saúde, que reduza tributos sobre atividades econômicas com baixas emissões de Gases de Efeito Estufa (GEE) e com baixo nível de poluição, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas à saúde",
    "saúde": "Sou favorável à redução do consumo de produtos nocivos à saúde e ao meio ambiente, tais como álcool e tabaco, alimentos ultraprocessados, agrotóxicos e combustíveis fósseis, e concordo com a adoção de medidas regulatórias para esses produtos, como tributação progressiva, restrição da publicidade, garantia de ambientes protegidos de seus efeitos e informação adequada para seu consumo",
    "agrotóxico": "Sou contra a flexibilização das leis de Defesa Agropecuária, pois os programas de autocontrole geridos pelas empresas do setor não devem substituir o poder público na fiscalização da qualidade de rebanhos, de lavouras e de seus produtos, assim como não concordo com a flexibilização das regras para registro e utilização de agrotóxicos e pesticidas no Brasil",
    "unid. conservação": "Sou favorável às parcerias entre o setor público e o setor privado para a implementação e gestão sustentável de Parques Nacionais, Parques Estaduais e outras Unidades de Conservação onde seja permitido o uso público",
    "caça": "Sou contra a liberação da caça de animais silvestres no Brasil, excetuadas as situações já previstas na Lei Federal nº 5.197/1967, como o controle de espécies invasoras e de animais silvestres considerados nocivos à agricultura ou à saúde pública",
    "mata atlântica": "Sou favorável ao Fundo de Restauração do Bioma Mata Atlântica e me comprometo a apoiar sua implantação, conforme a Lei Federal nº 11.428/2006, visando à conservação de remanescentes de vegetação nativa, à pesquisa científica ou à restauração, pois sei que apenas 7% da cobertura original da Mata Atlântica ainda está de pé",
    "pantanal": "Sou contra o plantio de soja nas planícies inundáveis do bioma Pantanal brasileiro, que é considerado Patrimônio Nacional pela Constituição Federal (§ 4º do art. 225) e Reserva da Biosfera pelas Nações Unidas",
    "amazonia e cerrado": "Sou favorável à destinação dos 60 milhões de hectares de terras públicas não destinadas na Amazônia e no Cerrado para o uso sustentável, a conservação ambiental e a proteção dos povos indígenas, quilombolas, pequenos produtores extrativistas e Unidades de Conservação, pois sei que esta medida é imprescindível para a economia das regiões citadas e o equilíbrio climático de todo o planeta",
}

subjects_list = [
    {"label": key, "phrase": value, "key": subject_dict[key]}
    for key, value in subject_descriptions.items()
]

keywords_list = ['acordo de paris', 'agenda 2030', 'agenda277', 'agricultores familiares', 'agricultura familiar', 'agrodefensivos', 'agrotoxicos', 'alimentacao saudavel', 'amazonia', 'ambiental ', 'animais', 'aquecimento global', 'aquifero', 'area verde', 'areas protegidas', 'areas verdes', 'asg', 'aterro sanitario', 'berco das aguas', 'biodiversidade', 'bioeconomia', 'bioma', 'biomas', 'biosfera', 'caatinga', 'caca', 'carbono zero', 'cerrado', 'clima', 'climatico', 'climaticos', 'comunidades tradicionais', 'consumo consciente', 'consumo e producao responsaveis', 'consumo responsavel', 'crise climatica', 'desastres naturais', 'desenvolvimento sustentavel', 'desmatamento ', 'desmatamentos', 'direito ambiental', 'direitos indigenas', 'direitos socioambientais ', 'economia circular', 'economia verde', 'educacao ambiental', 'efeito estufa', 'eficiencia energetica', 'emergencia climatica', 'energia limpa', 'energia renovavel', 'energia solar',
                'esg', 'fauna', 'favela', 'flora', 'florestas', 'funai', 'grilagem', 'grileiro', 'grileiros', 'ibama', 'icmbio', 'incendios', 'indigena', 'jovem', 'jovens', 'justica climatica', 'juventude', 'juventudes', 'lixo', 'lixoes', 'madeiras', 'madeireira', 'madeireiro', 'madeireiros', 'mata atlantica', 'mudanca climatica', 'mudancas climaticas', 'objetivos de desenvolvimento sustentavel', 'ods', 'organicos', 'pantanal', 'pantaneiro', 'parques nacionais', 'participacao cidada', 'pnrs', 'poluicao', 'populacoes tradicionais', 'povo indigena', 'povos das florestas', 'povos indigenas', 'povos tradicionais', 'queimadas', 'quilombolas', 'racismo ambiental', 'reciclado', 'reciclados', 'reciclagem', 'rejeitos', 'residuo', 'residuos solidos', 'rios', 'savana', 'seguranca alimentar', 'seguranca climatica', 'sociobiodiversidade', 'sustentabilidade', 'sustentavel', 'terra indigena', 'territorios indigenas', 'unidade de conservacao', 'unidades de conservacao']

keywords = []
key = ''
for k in keywords_list:
    if k[0] != key:
        key = k[0]
        keywords.append(key)
    keywords.append(k)


hide_convergency = [90, 878, 4610, 90842, 105534, 123756, 141401, 141480, 141552,
                    160517, 204433, 207309, 214865, 219585, 219592, None]
