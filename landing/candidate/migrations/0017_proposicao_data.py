# Generated by Django 3.2.12 on 2022-08-11 14:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('candidate', '0016_set_phone_fields_class'),
    ]

    operations = [
        migrations.AddField(
            model_name='proposicao',
            name='data',
            field=models.DateField(default='1900-01-01'),
        ),
    ]