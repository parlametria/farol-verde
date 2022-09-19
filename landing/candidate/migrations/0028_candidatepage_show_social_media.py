from candidate.models import CandidatePage
from django.db import migrations, models

def set_social_media(apps, schema_editor):
    candidates = CandidatePage.objects.live()
    candidates = candidates.filter(id_autor__iexact=None)
    for candidate in candidates:
        candidate.show_social_media = False
        candidate.save()

def unset_social_media(apps, scheme_editor):
    candidates = CandidatePage.objects.live()
    for candidate in candidates:
        candidate.show_social_media = True
        candidate.save()

class Migration(migrations.Migration):

    dependencies = [
        ('candidate', '0027_set_url_fields'),
    ]

    operations = [
        migrations.AddField(
            model_name='candidatepage',
            name='show_social_media',
            field=models.BooleanField(default=True),
        ),
        migrations.RunPython(set_social_media, unset_social_media)
    ]
