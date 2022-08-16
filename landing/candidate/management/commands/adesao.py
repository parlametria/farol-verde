import csv
from os.path import abspath
from typing import Generator

from django.core.management.base import BaseCommand
from django.core.management.base import OutputWrapper
from django.core.management.color import Style

from candidate.models import CandidatePage

from candidate.adhesion import get_adhesion_strategy
class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--import",
            action="store_true",
            help="Import data from parlametria api",
        )

        parser.add_argument(
            "--update-date",
            action="store_true",
            help="Update the date of registered propositions",
        )

        parser.add_argument(
            "--all-candidates-adhesion-csv",
            action="store_true",
            help="Update the date of registered propositions",
        )

    def handle(self, *args, **options):
        if options["all_candidates_adhesion_csv"]:
            adhesion_csv = AdhesionCSV(self.stdout, self.style)
            adhesion_csv.adhesion_to_csv()



class AdhesionCSV:
    def __init__(self, stdout: OutputWrapper, style: Style):
        self.stdout = stdout
        self.style = style
        self._filepath = "".join(
            [abspath(""), "/candidate/csv/", "candidates_adhesion_csv.csv"]
        )

    def adhesion_to_csv(self):
        csvfile = open(self._filepath, "w")
        writer = csv.writer(csvfile, delimiter=";")

        writer.writerow(["id", "candidato", "partigo", "estado", "indice"])

        candidates = CandidatePage.objects.filter(live=True).exclude(id_autor=None).all()
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

            writer.writerow([candidate.id_autor, candidate.title, candidate.party, candidate.election_state, adhesion_mean])

        csvfile.close()
