# Generated by Django 3.2.12 on 2022-09-23 17:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('candidate', '0029_alter_proposition_about_value'),
    ]

    operations = [
        migrations.AddField(
            model_name='candidatepage',
            name='adhesion_mean',
            field=models.FloatField(default=0.0),
        ),
    ]