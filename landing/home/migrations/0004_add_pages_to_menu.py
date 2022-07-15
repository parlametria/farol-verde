from django.db import migrations, models
from candidate.models import CandidateIndexPage
from home.models import SurveysPage
from blog.models import BlogIndexPage

def add_pages_to_menu(apps, schema_editor):
    candidates = CandidateIndexPage.objects.first()
    candidates.show_in_menus=True
    candidates.save()
    surveys = SurveysPage.objects.get(title="Enquete")
    surveys.show_in_menus=True
    surveys.save()
    blogs = BlogIndexPage.objects.first()
    blogs.show_in_menus=True
    blogs.save()

class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('home', '0003_auto_20220713_0519'),
    ]

    operations = [
        migrations.RunPython(add_pages_to_menu),
    ]
