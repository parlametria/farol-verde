from ast import keyword
from os import remove
from django.db import migrations, models
from candidate.models import Keyword

keywords_list = ['acordo de paris', 'agenda 2030', 'agenda277', 'agricultores familiares', 'agricultura familiar', 'agrodefensivos', 'agrotoxicos', 'alimentacao saudavel', 'amazonia', 'ambiental ', 'animais', 'aquecimento global', 'aquifero', 'area verde', 'areas protegidas', 'areas verdes', 'asg', 'aterro sanitario', 'berco das aguas', 'biodiversidade', 'bioeconomia', 'bioma', 'biomas', 'biosfera', 'caatinga', 'caca', 'carbono zero', 'cerrado', 'clima', 'climatico', 'climaticos', 'comunidades tradicionais', 'consumo consciente', 'consumo e producao responsaveis', 'consumo responsavel', 'crise climatica', 'desastres naturais', 'desenvolvimento sustentavel', 'desmatamento ', 'desmatamentos', 'direito ambiental', 'direitos indigenas', 'direitos socioambientais ', 'economia circular', 'economia verde', 'educacao ambiental', 'efeito estufa', 'eficiencia energetica', 'emergencia climatica', 'energia limpa', 'energia renovavel', 'energia solar',
                'esg', 'fauna', 'favela', 'flora', 'florestas', 'funai', 'grilagem', 'grileiro', 'grileiros', 'ibama', 'icmbio', 'incendios', 'indigena', 'jovem', 'jovens', 'justica climatica', 'juventude', 'juventudes', 'lixo', 'lixoes', 'madeiras', 'madeireira', 'madeireiro', 'madeireiros', 'mata atlantica', 'mudanca climatica', 'mudancas climaticas', 'objetivos de desenvolvimento sustentavel', 'ods', 'organicos', 'pantanal', 'pantaneiro', 'parques nacionais', 'participacao cidada', 'pnrs', 'poluicao', 'populacoes tradicionais', 'povo indigena', 'povos das florestas', 'povos indigenas', 'povos tradicionais', 'queimadas', 'quilombolas', 'racismo ambiental', 'reciclado', 'reciclados', 'reciclagem', 'rejeitos', 'residuo', 'residuos solidos', 'rios', 'savana', 'seguranca alimentar', 'seguranca climatica', 'sociobiodiversidade', 'sustentabilidade', 'sustentavel', 'terra indigena', 'territorios indigenas', 'unidade de conservacao', 'unidades de conservacao']

def insert_keywords(apps, schema_editor):
    for item in keywords_list:
        new_keyword = Keyword.objects.create(keyword=item)
        new_keyword.save()

def remove_keywords(apps, schema_editor):
    pass

class Migration(migrations.Migration):
    dependencies = [
        ('candidate', '0028_candidatepage_show_social_media'),
    ]

    operations = [
        migrations.CreateModel(
            name='Keyword',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('keyword', models.CharField(max_length=255)),
            ],
            options={
                'verbose_name_plural': 'Social Media Keyword',
            },
        ),
        migrations.RunPython(insert_keywords, remove_keywords)
    ]
