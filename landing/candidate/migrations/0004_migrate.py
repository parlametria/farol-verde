from django.db import migrations, models
from candidate.models import form_submission_link_candidate
from wagtailstreamforms.models import FormSubmission


def migrate_submissions_to_pages(apps, schema_editor):
    submissions = FormSubmission.objects.all()
    submissions = submissions.filter(form_id=1)
    for submission in submissions:
        form_submission_link_candidate(None, submission)


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("candidate", "0003_auto_20220713_1734"),
    ]

    operations = [
        migrations.AlterField(
            model_name="candidatepage",
            name="manager_site",
            field=models.URLField(blank=True, null=True),
        ),
        migrations.RunPython(migrate_submissions_to_pages),
    ]
