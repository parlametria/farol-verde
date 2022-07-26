from dataclasses import dataclass

@dataclass
class Deputado:
    id_autor: int
    id_autor_parlametria: int
    nome_autor: str
    cpf: int


@dataclass
class Senador:
    id_autor: int
    id_autor_parlametria: int
    nome_autor: str
    nome_completo: str
    uf: str
