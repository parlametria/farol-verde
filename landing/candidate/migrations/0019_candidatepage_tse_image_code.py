# Generated by Django 3.2.12 on 2022-08-12 22:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("candidate", "0018_add_gender_and_chargechanged"),
    ]

    operations = [
        migrations.AddField(
            model_name="candidatepage",
            name="tse_image_code",
            field=models.CharField(blank=True, max_length=60, null=True),
        ),
    ]
