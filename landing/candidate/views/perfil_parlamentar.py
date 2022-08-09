import requests, os, json
from requests.auth import HTTPBasicAuth

from django.http import HttpRequest
from django.http import JsonResponse
from django.core.paginator import EmptyPage, PageNotAnInteger, Paginator

from candidate.models import CandidatePage
from candidate.util import lru_cache_time, keywords

API_PERFIIL = "https://perfil.parlametria.org.br/api"

# cache proposicoes for 1h = 60s*60m = 3600s
@lru_cache_time(seconds=3600, maxsize=2)
def fetch_proposicoes(casa: str):
    """
    https://perfil.parlametria.org.br/api/orientacoes/proposicoes?casa=camara

    [
        {
            projetoLei: "PL 10431/2018"
            idProposicao: 12179189
            proposicaoVotacoes: [
                {idVotacao: 1167271611},
                {idVotacao:	1167271717},
            ]
        },
    ]
    """
    url = f"{API_PERFIIL}/orientacoes/proposicoes?casa={casa}"
    response = requests.get(url)
    return response.json()


def get_proposicoes(candidate: CandidatePage):
    if candidate.is_senador:
        return fetch_proposicoes("senado")
    else:
        return fetch_proposicoes("camara")


def get_votos_candidate(candidate: CandidatePage):
    """
    https://perfil.parlametria.org.br/api/parlamentares/1204530/votos

    {
        idParlamentarVoz: "1204530"
        votos: [
            {"1167271611": 0},
            {"1167271717": 1},
            {"1167281821": 1},
            {"1167341652": -1},
        ]
    }
    """
    url = f"{API_PERFIIL}/parlamentares/{candidate.id_parlametria}/votos"
    response = requests.get(url)
    return response.json()


def check_candidate_vote(
    votes_store,
    prop_id_votacao,
    prop_id_proposicao,
    projeto_lei,
    candidate_votes,
):
    if prop_id_votacao in candidate_votes.keys():  # if cancidate voted in proposition
        if prop_id_proposicao in votes_store:
            votes_store[prop_id_proposicao]["votos"][prop_id_votacao] = candidate_votes[
                prop_id_votacao
            ]
        else:
            votes_store[prop_id_proposicao] = {
                "projeto_lei": projeto_lei,
                "votos": {prop_id_votacao: candidate_votes[prop_id_votacao]},
            }


def process_candidate_votes(candidate_json):
    proposicoes = fetch_proposicoes("camara")

    proposicoes_com_votos_do_candidato = dict()

    for prop in proposicoes:
        for prop_votacoes in prop["proposicaoVotacoes"]:
            check_candidate_vote(
                votes_store=proposicoes_com_votos_do_candidato,
                prop_id_votacao=str(prop_votacoes["idVotacao"]),
                prop_id_proposicao=prop["idProposicao"],
                projeto_lei=prop["projetoLei"],
                candidate_votes=candidate_json["votos"],
            )

    return proposicoes_com_votos_do_candidato


def votacoes_perfil_parlamentar_view(request: HttpRequest, slug: str):
    candidate = CandidatePage.objects.filter(slug=slug).first()

    if not candidate:
        return JsonResponse(
            data={"status_code": 404, "error": "Candidato não encontrado"},
            status=404,
        )

    if candidate.id_parlametria is None:
        return JsonResponse(
            data={"status_code": 404, "error": "Candidato sem id do parlametria"},
            status=404,
        )

    votacoes_candidato = get_votos_candidate(candidate)
    votos_por_proposicao = process_candidate_votes(votacoes_candidato)

    candidate_votes = {
        "codigos": {
            "nao": -1,
            "faltou": 0,
            "sim": 1,
            "obstrucao": 2,
            "abstencao": 3,
            "liberou": 5,
        },
        "votos_por_proposicao": votos_por_proposicao,
    }

    return JsonResponse(candidate_votes)

def social_media_view(request: HttpRequest, slug: str, keyword: str = None):
    candidate = CandidatePage.objects.filter(slug=slug).first()
    url = os.environ.get("ELASTIC_URL")
    login = os.environ.get("ELASTIC_USER")
    password = os.environ.get("ELASTIC_PASSWORD")
    query = { 
        "query": {
            "bool":{
                "must": [
                {
                    "wildcard": { 
                        "social-data.tipo": { "value": f"{candidate.campaign_name}*", "case_insensitive": True },
                    }
                }
            ]
            }
        },
        "fields": [ "_source.social-data.*" ]
    }
    if keyword:
        value = {"wildcard": { "social-data.tags": { "value": f"*{keyword}*", "case_insensitive": True },}}
        query["query"]["bool"]["must"].append(value)
    response = requests.get(url, auth=HTTPBasicAuth(login, password), headers={'Content-Type': 'application/json'}, data=json.dumps(query))
    return JsonResponse(response.json())

def keywords_sections_view(request: HttpRequest, slug: str, search: str=''):
    keywords_list = list(keywords)
    sections = []
    if len(search) > 0:
        keywords_list = [keyword for keyword in keywords_list if search in keyword]
    for i in range(0, len(keywords_list), 36):
        sections.append(keywords_list[i:i+36])
    sections = [f"{section[0][0]} - {section[-1][0]}".upper() for section in sections]
    response = {"sections": sections, "total": len(keywords_list) - 1}
    return JsonResponse(response)

def keywords_view(request: HttpRequest, slug:str, page:int, search=''):
    page = 36 * page
    if len(search) > 0:
        keywords_list = [keyword for keyword in keywords if search in keyword[0]]
    keywords_list = keywords[page:page+36]
    return JsonResponse(keywords_list, safe=False)
