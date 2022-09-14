from django.core.management.base import BaseCommand, OutputWrapper
from django.core.management.color import Style

from typing import List

from candidate.management.commands import ApiFetcher
from candidate.fetchers.api_senado import (
    SENADO_API,
    get_all_materia_iterator,
    get_votacoes_materia_iterator,
)

from candidate.models import (
    Proposicao,
    VotacaoProsicao,
    VotacaoParlamentar,
    CasaChoices,
)


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--import",
            action="store_true",
            help="Import data from senado api",
        )

    def handle(self, *args, **options):
        if options["import"]:
            votacoes_fetcher = SenadoVotacoesFetcher(self.stdout, self.style)
            votacoes_fetcher.start_fetch()


class SenadoVotacoesFetcher(ApiFetcher):

    def start_fetch(self):
        self._fetch_proposicoes()
        self._fetch_votacoes_proposicoes()
        # self._fetch_votacoes_parlamentares()

    def _fetch_proposicoes(self):
        self.stdout.write(f"\nFetching proposicoes from: {SENADO_API}")

        for prop_json, prop_data in get_all_materia_iterator():
            found = Proposicao.objects.filter(
                id_externo=prop_json["id_externo"]
            ).first()

            if found is not None:
                self.stdout.write(
                    self.style.WARNING(
                        f"\t{found}: {found.id_externo} already saved, skipping"
                    )
                )

                if found.casa == str(CasaChoices.CAMARA):
                    found.casa = str(CasaChoices.SENADO)
                    found.save()

                continue

            created = Proposicao.objects.create(
                id_externo=prop_json["id_externo"],
                sigla_tipo=prop_json["sigla_tipo"],
                numero=prop_json["numero"],
                ano=prop_json["ano"],
                ementa=prop_json["ementa"],
                sobre=prop_json["sobre"],
                data=prop_json["data"],
                casa=str(CasaChoices.SENADO),
                calculate_adhesion=True,
            )
            self.stdout.write(f"\tProposicao {created} created")

    def _fetch_votacoes_proposicoes(self):
        self.stdout.write(f"\nFetching votacoes from all Proposicao")

        proposicoes_senado = (
            Proposicao.objects
            .filter(casa=str(CasaChoices.SENADO))
            .filter(calculate_adhesion=True)
        )
        for prop in proposicoes_senado:
            for votacao_json in get_votacoes_materia_iterator(prop.id_externo):
                votacao_prosicao = VotacaoProsicao.objects.filter(
                    id_votacao=votacao_json["id_votacao"]
                ).first()

                if votacao_prosicao is None:
                    votacao_prosicao = VotacaoProsicao.objects.create(
                        id_votacao=votacao_json["id_votacao"],
                        proposicao=prop,
                        data=votacao_json["data"],
                        data_hora_registro="".join(
                            [votacao_json["data"], "T", votacao_json["hora"]]
                        ),
                    )
                    self.stdout.write(
                        f"\tVotacaoProsicao {votacao_prosicao.id_votacao} created"
                    )
                else:
                    self.stdout.write(
                        self.style.WARNING(
                            f"\tVotacaoProsicao {votacao_prosicao.id_votacao} already saved, skipping creation"
                        )
                    )

                self._create_votacoes_parlamentares(
                    votacao_prosicao, votacao_json["votacao_parmanentares"]
                )

    def _create_votacoes_parlamentares(
        self, votacao_proposicao: VotacaoProsicao, votacao_parlamentares: List
    ):
        for voto in votacao_parlamentares:
            id_parlamentar = voto["IdentificacaoParlamentar"]["CodigoParlamentar"]
            found = (
                VotacaoParlamentar.objects
                .filter(id_parlamentar=id_parlamentar)
                .filter(votacao_proposicao=votacao_proposicao)
                .first()
            )

            if found is not None:
                self.stdout.write(
                    self.style.WARNING(
                        f"\VotacaoParlamentar with id_parlamentar={found.id_parlamentar}"
                        f" and votacao_proposicao={votacao_proposicao.id_votacao}"
                        " already saved, skipping"
                    )
                )
                return

            created = VotacaoParlamentar.objects.create(
                votacao_proposicao=votacao_proposicao,
                id_parlamentar=id_parlamentar,
                tipo_voto=voto["SiglaVoto"],
                data=votacao_proposicao.data,
                data_registro_voto=votacao_proposicao.data_hora_registro,
                casa=str(CasaChoices.SENADO),
            )
            self.stdout.write(f"\tVotacaoParlamentar {created.id_parlamentar} created")
