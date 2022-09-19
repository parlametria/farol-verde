from candidate.models import CandidatePage
from wagtailstreamforms.models import FormSubmission
from django.db import migrations, models

def set_social_media(apps, schema_editor):
    submissions = FormSubmission.objects.filter(form_id=1)
    for submission in submissions:
        submission_name = submission.get_data()['nome-completo']
        candidate = CandidatePage.objects.filter(title=submission_name)
        if len(candidate) != 1:
            continue
        candidate = candidate[0]
        candidate.show_social_media = False
        candidate.save()

def unset_social_media(apps, scheme_editor):
    candidates = CandidatePage.objects.all().live()
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
