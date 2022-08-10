from django.core.management.base import BaseCommand, CommandError, OutputWrapper
from django.core.management.color import Style

from candidate.management.commands import ApiFetcher
from candidate.models import Proposicao, VotacaoProsicao, VotacaoParlamentar, CasaChoices
from candidate.fetchers.api_camara import (
    CAMARA_API,
    get_proposicoes_iterator,
    get_votacoes_proposicao,
    get_dados_votacao,
)


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--import",
            action="store_true",
            help="Import data from parlametria api",
        )

    def handle(self, *args, **options):
        if options["import"]:
            votacoes_fetcher = CamaraVotacoesFetcher(self.stdout, self.style)
            votacoes_fetcher.start_fetch()


class CamaraVotacoesFetcher(ApiFetcher):

    def start_fetch(self):
        self._fetch_proposicoes()
        self._fetch_votacoes_proposicoes()
        self._fetch_votacoes_parlamentares()

    def _fetch_proposicoes(self):
        self.stdout.write(f"\nFetching proposicoes from: {CAMARA_API}")

        for prop_json, prop_data in get_proposicoes_iterator():
            found = Proposicao.objects.filter(id_externo=prop_json["id"]).first()

            if found is not None:
                if found.calculate_adhesion == False:
                    found.calculate_adhesion = True
                    found.save()

                self.stdout.write(
                    self.style.WARNING(
                        f"\t{found}: {found.id_externo} already saved, skipping"
                    )
                )
                continue

            created = Proposicao.objects.create(
                id_externo=prop_json["id"],
                sigla_tipo=prop_json["siglaTipo"],
                numero=prop_json["numero"],
                ano=prop_json["ano"],
                ementa=prop_json["ementa"],
                sobre=prop_data[3],
                casa=str(CasaChoices.CAMARA),
                calculate_adhesion=True,
            )
            self.stdout.write(f"\tProposicao {created} created")

    def _fetch_votacoes_proposicoes(self):
        self.stdout.write(f"\nFetching votacoes from all Proposicao")

        proposicoes_camara = (
            Proposicao.objects
            .filter(casa=str(CasaChoices.CAMARA))
            .filter(calculate_adhesion=True)
        )
        for prop in proposicoes_camara:
            votacoes = get_votacoes_proposicao(prop.id_externo)["dados"]

            if len(votacoes) == 0:
                self.stdout.write(
                    self.style.WARNING(
                        f"\tProposicao {prop}: {prop.id_externo} has no votacoes in {CAMARA_API}, skipping"
                    )
                )
                continue

            for votacao in votacoes:
                self._check_and_create_votacao_proposicao(prop, votacao)

    def _check_and_create_votacao_proposicao(
        self, proposicao: Proposicao, votacao_json
    ):
        """
        votacao_json format:
        {
            'id': '2190237-119',
            'uri': 'https://dadosabertos.camara.leg.br/api/v2/votacoes/2190237-119',
            'data': '2019-05-29',
            'dataHoraRegistro': '2019-05-29T19:25:44',
            'siglaOrgao': 'PLEN',
            'uriOrgao': 'https://dadosabertos.camara.leg.br/api/v2/orgaos/180',
            'uriEvento': 'https://dadosabertos.camara.leg.br/api/v2/eventos/55820',
            'proposicaoObjeto': None,
            'uriProposicaoObjeto': None,
            'descricao': 'Aprovada a Redação Final assinada pelo Dep. Sergio Souza (MDB-PR), Relator-Revisor da Comissão Mista.',
            'aprovacao': 1
        },
        """
        found = VotacaoProsicao.objects.filter(id_votacao=votacao_json["id"]).first()

        if found is not None:
            self.stdout.write(
                self.style.WARNING(
                    f"\tVotacao {votacao_json['id']} already saved, skipping"
                )
            )
            return

        created = VotacaoProsicao.objects.create(
            id_votacao=votacao_json["id"],
            proposicao=proposicao,
            data=votacao_json["data"],
            data_hora_registro=votacao_json["dataHoraRegistro"],
        )
        self.stdout.write(f"\tVotacaoProsicao {created.id_votacao} created")

    def _fetch_votacoes_parlamentares(self):
        self.stdout.write(f"\nFetching votos from parlamentares from all VotacaoProsicao")

        proposicoes_camara = [p.id_externo for p in Proposicao.proposicoes_camara()]
        votacoes_proposicoes = VotacaoProsicao.objects.filter(proposicao_id__in=proposicoes_camara)

        for votacao_prop in votacoes_proposicoes:
            dados_votacoes = get_dados_votacao(votacao_prop.id_votacao)["dados"]

            if len(dados_votacoes) == 0:
                self.stdout.write(
                    self.style.WARNING(
                        f"\tVotacaoProsicao {votacao_prop.id_votacao} has no votacoes VotacaoParlamentar, skipping"
                    )
                )
                continue

            for dados_votacao in dados_votacoes:
                self._check_and_create_votacao_parlamentar(votacao_prop, dados_votacao)

    def _check_and_create_votacao_parlamentar(
        self, votacao_proposicao: VotacaoProsicao, dados_votacao
    ):
        """
        dados_votacao format:
        {
         "dataRegistroVoto" : "2019-05-29T19:16:24",
         "deputado_" : {
            "email" : "dep.juliocesarribeiro@camara.leg.br",
            "id" : 204372,
            "idLegislatura" : 56,
            "nome" : "Julio Cesar Ribeiro",
            "siglaPartido" : "PRB",
            "siglaUf" : "DF",
            "uri" : "https://dadosabertos.camara.leg.br/api/v2/deputados/204372",
            "uriPartido" : "https://dadosabertos.camara.leg.br/api/v2/partidos/36815",
            "urlFoto" : "https://www.camara.leg.br/internet/deputado/bandep/204372.jpg"
         },
         "tipoVoto" : "Sim"
        },
        """
        found = (
            VotacaoParlamentar.objects
            .filter(id_parlamentar=dados_votacao["deputado_"]["id"])
            .filter(votacao_proposicao=votacao_proposicao)
            .first()
        )

        if found is not None:
            self.stdout.write(
                self.style.WARNING(
                    f"\VotacaoParlamentar with id_deputado={found.id_parlamentar}"
                    f" and votacao_proposicao={votacao_proposicao.id_votacao}"
                    " already saved, skipping"
                )
            )
            return

        data = dados_votacao["dataRegistroVoto"].split("T")[0]

        created = VotacaoParlamentar.objects.create(
            votacao_proposicao=votacao_proposicao,
            id_parlamentar=dados_votacao["deputado_"]["id"],
            tipo_voto=dados_votacao["tipoVoto"],
            data=data,
            data_registro_voto=dados_votacao["dataRegistroVoto"],
            casa=str(CasaChoices.CAMARA),
        )
        self.stdout.write(f"\tVotacaoParlamentar {created.id_parlamentar} created")
