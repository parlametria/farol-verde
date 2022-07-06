import csv

from os.path import abspath
from dataclasses import dataclass
from typing import Optional


@dataclass
class Deputado:
    id_autor: int
    id_autor_parlametria: int
    nome_autor: str
    cpf: int


def get_deputados():
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
    found = None

    for dep in get_deputados():
        if dep.cpf == cpf:
            found = dep
            break

    return found
