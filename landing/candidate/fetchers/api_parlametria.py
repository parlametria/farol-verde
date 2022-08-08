import requests
import json

LEGGO_API = "https://api.parlametria.org.br"
PERFIL_API = "https://perfil.parlametria.org.br/api"
SERENATA_API = "https://api-perfilpolitico.serenata.ai/api"


def fetch_autores():
    """
    {LEGGO_API}/atores/agregados json format
    [
        {
            "id_autor": int,
            "id_autor_parlametria": int,
            "nome_autor": str,
            "partido": str,
            "uf": str,
            "casa_autor": str,
            "bancada":str,
            "total_documentos": int,
            "peso_documentos": float
        }
    ]
    """
    response = requests.get(f"{LEGGO_API}/atores/agregados")
    return response.json()


def fetch_actor_data(id_autor_parlametria: int):
    response = requests.get(f"{PERFIL_API}/parlamentares/{id_autor_parlametria}/info")
    return response.json()


def main():
    data = fetch_autores()
    print(json.dumps(data[:3], indent=2))

    print("*"*80)

    for autor in data[:3]:
        extra = fetch_actor_data(autor["id_autor_parlametria"])
        print(json.dumps(extra, indent=2))


if __name__ == "__main__":
    main()
