import csv
from os.path import abspath
from typing import Generator

from django.core.management.base import BaseCommand
from django.core.management.base import OutputWrapper
from django.core.management.color import Style
from django.db import connection

from candidate.models import (
    CandidatePage,
    Proposicao,
    VotacaoProsicao,
    VotacaoParlamentar,
)

from candidate.adhesion import get_adhesion_strategy


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--all-candidates-adhesion-csv",
            action="store_true",
            help="process all candidates adhesion and saves it in a csv file",
        )

        parser.add_argument(
            "--candidates-votos-to-csv",
            action="store_true",
            help="Saves all candidates votes in a csv file",
        )

    def handle(self, *args, **options):
        if options["all_candidates_adhesion_csv"]:
            adhesion_csv = AdhesionCSV(self.stdout, self.style)
            adhesion_csv.adhesion_to_csv()

        if options["candidates_votos_to_csv"]:
            adhesion_csv = AdhesionCSV(self.stdout, self.style)
            adhesion_csv.votes_to_csv()


class AdhesionCSV:
    def __init__(self, stdout: OutputWrapper, style: Style):
        self.stdout = stdout
        self.style = style
        self._filepath_adhesion = "".join(
            [abspath(""), "/candidate/csv/", "candidates_adhesion_csv.csv"]
        )
        self._filepath_votes = "".join(
            [abspath(""), "/candidate/csv/", "candidates_votes_csv.csv"]
        )

    def adhesion_to_csv(self):
        csvfile = open(self._filepath_adhesion, "w")
        writer = csv.writer(csvfile, delimiter=";")

        writer.writerow(["id", "candidato", "partigo", "estado", "indice"])

        candidates = (
            CandidatePage.objects.filter(live=True).exclude(id_autor=None).all()
        )
        for candidate in candidates:
            self.stdout.write(f"Calculando adesão candidato: {candidate}")
            strategy = get_adhesion_strategy(candidate)
            propositions_adhesion = strategy.adhesion_calculation()
            total = 0.0
            calculated = 0
            adhesion_mean = 0.0

            for prop in propositions_adhesion:
                if prop["total_com_votos"] > 0:
                    total += prop["adhesion"]
                    calculated += 1

            if calculated > 0:
                adhesion_mean = total / calculated

            writer.writerow(
                [
                    candidate.id_autor,
                    candidate.title,
                    candidate.party,
                    candidate.election_state,
                    adhesion_mean,
                ]
            )

        csvfile.close()

    def votes_to_csv(self):
        # candidato / projeto / id votacao / desc votacao / voto
        candidates = CandidatePage.objects.exclude(id_autor=None).all()

        csvfile = open(self._filepath_adhesion, "w")
        writer = csv.writer(csvfile, delimiter=";")

        writer.writerow(
            [
                "candidato",
                "candidato_id",
                "projeto",
                "proposicao_id",
                "votacao_id",
                "tipo_voto",
            ]
        )

        for candidate in candidates:
            self.stdout.write(
                f"Writing votes of candidate: {candidate.id_autor} {candidate.campaign_name}"
            )
            candidate_votes = self._get_candidate_votes(candidate)

            for vote_data in candidate_votes:
                projeto = f"{vote_data[3]} {vote_data[4]}/{vote_data[5]}"
                writer.writerow(
                    [
                        candidate.campaign_name,
                        candidate.id_autor,
                        projeto,
                        vote_data[0],
                        vote_data[1],
                        vote_data[2],
                    ]
                )

        csvfile.close()

    def _get_candidate_votes(self, candidate: CandidatePage):
        query = f"""
        SELECT
            cp.id_externo as proposicao_id,
            cv.id_votacao as votacao_id,
            vp.tipo_voto,
            cp.sigla_tipo,
            cp.numero,
            cp.ano
        FROM
            public.candidate_votacaoparlamentar vp
        INNER JOIN public.candidate_votacaoprosicao cv
            ON cv.id_votacao=votacao_proposicao_id
        INNER JOIN public.candidate_proposicao cp
            ON cp.id_externo=cv.proposicao_id
        WHERE
            id_parlamentar={candidate.id_autor}
        ORDER BY proposicao_id ASC
        """
        cursor = connection.cursor()
        cursor.execute(query)
        return cursor
