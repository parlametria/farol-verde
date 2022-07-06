from django.db import migrations, models
import django.db.models.deletion
import wagtail.core.blocks
import wagtail.core.fields
import wagtail.images.blocks
from home.models import CandidatesPage
from wagtail.core.models import Page

def create_candidates_pages(apps, schema_editor):
    home = Page.objects.get(title='Home')

    candidates_page = CandidatesPage(title="Candidatos", slug="candidatos")

    home.add_child(instance=candidates_page)
    home.save()

class Migration(migrations.Migration):

    dependencies = [
        ('wagtailcore', '0066_collection_management_permissions'),
        ('home', '0002_create_surveys_and_remove_fields'),
    ]

    operations = [
        migrations.CreateModel(
            name='CandidatesPage',
            fields=[
                ('page_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='wagtailcore.page')),
            ],
            options={
                'abstract': False,
            },
            bases=('wagtailcore.page',),
        ),
        migrations.RunPython(create_candidates_pages),
    ]
