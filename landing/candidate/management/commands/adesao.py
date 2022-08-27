import csv
from os.path import abspath
from typing import Iterator

from django.core.management.base import BaseCommand
from django.core.management.base import OutputWrapper
from django.core.management.color import Style

from candidate.models import CandidatePage
from candidate.adhesion import get_adhesion_strategy
from candidate.util import CandidatoTSE, csv_row_iterator


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--all-candidates-adhesion-csv",
            action="store_true",
            help="Generate a CSV file with all candidates adhesion",
        )

        parser.add_argument(
            "--re-election-adhesion-csv",
            action="store_true",
            help="Generate a CSV file with adhesion of only candidate for re-election",
        )

    def handle(self, *args, **options):
        if options["all_candidates_adhesion_csv"]:
            adhesion_csv = AdhesionCSV(self.stdout, self.style)
            adhesion_csv.all_candidates_adhesion_to_csv()

        if options["re_election_adhesion_csv"]:
            adhesion_csv = AdhesionCSV(self.stdout, self.style)
            adhesion_csv.re_election_candidates_adhesion_to_csv()


class AdhesionCSV:
    TSE_CSV_FILENAME = "candidatos_tse_2022"
    ALL_CANDIDATES_ADHESION_FILENAME = "candidates_adhesion"
    RE_ELECTION_CANDIDATES_ADHESION_FILENAME = "re_election_candidates_adhesion"

    def __init__(self, stdout: OutputWrapper, style: Style):
        self.stdout = stdout
        self.style = style

    def all_candidates_adhesion_to_csv(self):
        candidates = (
            CandidatePage.objects.filter(live=True).exclude(id_autor=None).all()
        )
        self._write_adhesion_in_csv(self.ALL_CANDIDATES_ADHESION_FILENAME, candidates)

    def re_election_candidates_adhesion_to_csv(self):
        self._write_adhesion_in_csv(
            self.RE_ELECTION_CANDIDATES_ADHESION_FILENAME,
            self._re_election_candidates_generator(),
        )

    def _write_adhesion_in_csv(
        self, csvfilename: str, candidates: Iterator[CandidatePage]
    ):
        filepath = "".join([abspath(""), "/candidate/csv/", csvfilename, ".csv"])
        csvfile = open(filepath, "w")
        writer = csv.writer(csvfile, delimiter=";")

        self.stdout.write(self.style.WARNING(f"Writing csv on file {csvfilename}"))
        writer.writerow(["id", "candidato", "partigo", "estado", "indice"])

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

        self.stdout.write(
            self.style.WARNING(f"FINISHED writing on csv file {csvfilename}")
        )
        csvfile.close()

    def _re_election_candidates_generator(self):
        self.stdout.write("Reading TSE csv data")
        for tse_row in csv_row_iterator(self.TSE_CSV_FILENAME):
            candidato = CandidatoTSE.from_list(tse_row)
            found: CandidatePage = CandidatePage.objects.filter(cpf=candidato.cpf).first()

            if found is not None and found.id_autor is not None and found.live:
                yield found
