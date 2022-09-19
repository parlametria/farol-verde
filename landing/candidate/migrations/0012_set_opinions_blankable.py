# Generated by Django 3.2.12 on 2022-08-09 22:43

from django.db import migrations
import wagtail.core.blocks
import wagtail.core.fields


class Migration(migrations.Migration):

    dependencies = [
        ("candidate", "0011_set_social_question_class"),
    ]

    operations = [
        migrations.AlterField(
            model_name="candidatepage",
            name="opinions",
            field=wagtail.core.fields.StreamField(
                [
                    (
                        "opinions",
                        wagtail.core.blocks.StructBlock(
                            [
                                (
                                    "clima",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável à inclusão da "segurança climática" em nossa Constituição Federal, como direito fundamental (no art. 5º), como princípio da Ordem Econômica e Financeira Nacional (no art. 170) e como núcleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econômico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudança Climática no Brasil."',
                                    ),
                                ),
                                (
                                    "agua",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável à inclusão do “acesso à água potável e ao esgotamento sanitário” no artigo 5° da Constituição Federal, para entrarem formalmente no rol de direitos humanos fundamentais."',
                                    ),
                                ),
                                (
                                    "desmatamento",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável à política de “desmatamento zero” em todos os biomas brasileiros, porque acredito ser possível manter, e até aumentar, a produção agropecuária atual sem novos desmatamentos, por meio da conversão de pastagens degradadas ou subaproveitadas."',
                                    ),
                                ),
                                (
                                    "terras_indigenas",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável à retomada dos processos demarcatórios de Terras Indígenas no Brasil, pois sei que ainda há mais de 200 processos pendentes, e concordo que os povos e as culturas indígenas contribuem para o enfrentamento da mudança climática, para a conservação dessas Áreas Protegidas e da sociobiodiversidade brasileira."',
                                    ),
                                ),
                                (
                                    "reforma_tributaria",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável a uma reforma e a uma política tributária socioambiental progressiva e promotora de saúde, que reduza tributos sobre atividades econômicas com baixas emissões de Gases de Efeito Estufa (GEE) e com baixo nível de poluição, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas à saúde."',
                                    ),
                                ),
                                (
                                    "saude_consumo",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável à redução do consumo de produtos nocivos à saúde e ao meio ambiente, tais como álcool e tabaco, alimentos ultraprocessados, agrotóxicos e combustíveis fósseis, e concordo com a adoção de medidas regulatórias para esses produtos, como tributação progressiva, restrição da publicidade, garantia de ambientes protegidos de seus efeitos e informação adequada para seu consumo."',
                                    ),
                                ),
                                (
                                    "agropecuaria",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou contra a flexibilização das leis de Defesa Agropecuária, pois os programas de autocontrole geridos pelas empresas do setor não devem substituir o poder público na fiscalização da qualidade de rebanhos, de lavouras e de seus produtos, assim como não concordo com a flexibilização das regras para registro e utilização de agrotóxicos e pesticidas no Brasil."',
                                    ),
                                ),
                                (
                                    "unidades_conservacao",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável às parcerias entre o setor público e o setor privado para a implementação e gestão sustentável de Parques Nacionais, Parques Estaduais e outras Unidades de Conservação onde seja permitido o uso público."',
                                    ),
                                ),
                                (
                                    "caca_animais_silvestres",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou contra a liberação da caça de animais silvestres no Brasil, excetuadas as situações já previstas na Lei Federal nº 5.197/1967, como o controle de espécies invasoras e de animais silvestres considerados nocivos à agricultura ou à saúde pública."',
                                    ),
                                ),
                                (
                                    "mata_atlantica",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável ao Fundo de Restauração do Bioma Mata Atlântica e me comprometo a apoiar sua implantação, conforme a Lei Federal nº 11.428/2006, visando à conservação de remanescentes de vegetação nativa, à pesquisa científica ou à restauração, pois sei que apenas 7% da cobertura original da Mata Atlântica ainda está de pé."',
                                    ),
                                ),
                                (
                                    "pantanal",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou contra o plantio de soja nas planícies inundáveis do bioma Pantanal brasileiro, que é considerado Patrimônio Nacional pela Constituição Federal (§ 4º do art. 225) e Reserva da Biosfera pelas Nações Unidas."',
                                    ),
                                ),
                                (
                                    "amazonia_cerrado",
                                    wagtail.core.blocks.ChoiceBlock(
                                        choices=[
                                            ("Sim", "Sim"),
                                            ("Não", "Não"),
                                            (
                                                "Prefiro não responder / Não sei",
                                                "Prefiro não responder / Não sei",
                                            ),
                                        ],
                                        defult=True,
                                        label='Opinião do candidato em relação à frase "Sou favorável à destinação dos 60 milhões de hectares de terras públicas não destinadas na Amazônia e no Cerrado para o uso sustentável, a conservação ambiental e a proteção dos povos indígenas, quilombolas, pequenos produtores extrativistas e Unidades de Conservação, pois sei que esta medida é imprescindível para a economia das regiões citadas e o equilíbrio climático de todo o planeta."',
                                    ),
                                ),
                            ]
                        ),
                    )
                ],
                blank=True,
                null=True,
            ),
        ),
    ]
