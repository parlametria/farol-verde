import csv

from os.path import abspath
from typing import Optional

from django.core.management.base import BaseCommand, OutputWrapper
from django.core.management.color import Style

from candidate.util import CandidatoTSE, csv_row_iterator
from candidate.models import CandidatePage, GenderChoices


class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            "--process",
            action="store_true",
            help="Process TSE csv",
        )

    def handle(self, *args, **options):
        if options["process"]:
            votacoes_fetcher = TseProcessor(self.stdout, self.style)
            votacoes_fetcher.process()


class TseProcessor:
    def __init__(self, stdout: OutputWrapper, style: Style):
        self.stdout = stdout
        self.style = style

    def process(self):
        self._unpublish_all_candidates()
        self._publish_reelection_candidates()
        self._publish_no_reelection_candidates()

    def _unpublish_all_candidates(self):
        return CandidatePage.objects.filter(live=True).update(live=False)

    def _publish_reelection_candidates(self):
        return self._publish_candidates(reelection=True)

    def _publish_no_reelection_candidates(self):
        return self._publish_candidates(reelection=False)

    def _publish_candidates(self, reelection=False):
        for candidato in self._tse_csv_iterator():
            is_deputado_or_senador = candidato.is_deputado or candidato.is_senador
            if not is_deputado_or_senador:
                continue

            if candidato.has_dados_invalidos:
                continue

            found = self._find_candidate(candidato)

            if found is None:  # candidate not in database, skip
                continue

            if reelection is True:
                # canditado sem id_autor foi criado pela enquete e não foi encontrado no parlametria
                # nesse case não deve ser publicado(live=True) automaticamente
                if found.id_autor is None:
                    continue
            else:
                # candidato sem id_autor deve ser publicado caso a flag reelection indique a
                # publicação de candidatos semser reeleição
                if found.id_autor is not None:
                    continue

            gender = GenderChoices.NOT_DISCLOSURE.value
            if candidato.genero == GenderChoices.MASCULINE.label:
                gender = GenderChoices.MASCULINE.value
            elif candidato.genero == GenderChoices.FEMININE.value:
                gender = GenderChoices.FEMININE.value

            found.gender = gender
            found.party = candidato.partido_sigla
            found.cpf = candidato.cpf  # set CPF for senadores
            found.tse_image_code = candidato.codigo_imagem
            found.tse_urn_code = candidato.codigo_urna

            if (found.is_deputado and candidato.is_senador) or (
                found.is_senador and candidato.is_deputado
            ):
                self.stdout.write(
                    self.style.WARNING(
                        f"\tCandidate:"
                        f"\n\t- CPF={candidato.cpf}, id_autor={found.id_autor}, slug={found.slug}"
                        f"\n\t- Changed charge from {found.charge} to {candidato.cargo}"
                    )
                )
                found.charge_changed = True
                found.charge = self._charge_change(found, candidato)

            found.live = True
            found.save()

            self.stdout.write(
                f"Found candidate with CPF={candidato.cpf}, id_autor={found.id_autor} and published"
            )

    def _tse_csv_iterator(self):
        for row in csv_row_iterator("candidatos_tse_2022"):
            yield CandidatoTSE.from_list(row)

    def _find_candidate(self, candidate: CandidatoTSE) -> Optional[CandidatePage]:
        found = CandidatePage.objects.filter(cpf=candidate.cpf).first()
        if found is not None:
            return found

        candidate_pages = CandidatePage.objects.filter(
            birth_date=candidate.data_nascimento
        )

        for page in candidate_pages:
            name = page.title.upper()
            campaign_name = page.campaign_name.upper()

            if campaign_name == candidate.nome_urna or name == candidate.nome:
                return page

        return None

    def _charge_change(self, farol: CandidatePage, tse: CandidatoTSE) -> str:
        if farol.is_deputado and tse.is_senador:
            return CandidatePage.SENADOR_CHARGE_TEXT
        else:
            return CandidatePage.DEPUTADO_CHARGE_TEXT
