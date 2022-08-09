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

def social_media_view(request: HttpRequest, slug: str):
    candidate = CandidatePage.objects.filter(slug=slug).first()
    url = os.environ.get("ELASTIC_URL")
    login = os.environ.get("ELASTIC_USER")
    password = os.environ.get("ELASTIC_PASSWORD")
    query = json.dumps({ 
        "query": { 
            "wildcard": { 
                "social-data.tipo": { "value": f"{candidate.campaign_name}", "case_insensitive": True }
            }
        },
        "fields": [ "_source.social-data.*" ]
    })
    response = requests.get(url, auth=HTTPBasicAuth(login, password), headers={'Content-Type': 'application/json'}, data=query)
    return JsonResponse(response.json())

def keywords_view(request: HttpRequest, slug:str, letter:str, search=''):
    new_keywords = dict(keywords)
    keys = list(new_keywords.keys())
    words_limit = 34
    while(keys[0] != letter):
        del(new_keywords[keys[0]])
        del(keys[0])
    for key in keys:
        if len(search) > 0:
            new_keywords[key] = [keyword for keyword in new_keywords[key] if search in keyword]
        if words_limit <= 0 or len(new_keywords[key]) == 0:
            del(new_keywords[key])
            continue
        new_keywords[key] = new_keywords[key][:words_limit]
        words_limit -= len(new_keywords[key]) + 2
        large_words = [keyword for keyword in new_keywords[key] if len(keyword) > 30]
        words_limit -= len(large_words)
        next_letter = key
    new_keywords['next'] = next_letter
    
    return JsonResponse(new_keywords)
