from django.db import migrations, models
from candidate.models import form_submission_link_candidate
from wagtailstreamforms.models.form import Form

social_questions = ['twitter', 'facebook', 'instagram', 'youtube']
get_field_data = lambda field, data: field.__dict__['value'].get(data)

def update_social_help_text(apps, schema_editor):
    form = Form.objects.get(title='Enquete')
    fields = [field for field in form.fields
        if get_field_data(field, 'label').lower() in social_questions]
    for field in fields:
        field.__dict__['value'].update({'help_text': get_field_data(field, 'label').lower() + ' social'})
    form.save()

def update_social_help_text_reverse(apps, schema_editor):
    form = Form.objects.get(title='Enquete')
    fields = [field for field in form.fields
        if get_field_data(field, 'label').lower() in social_questions]
    for field in fields:
        field.__dict__['value'].update({'help_text': get_field_data(field, 'label')})
    form.save()

class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('candidate', '0009_auto_20220804_2101'),
    ]

    operations = [
        migrations.AlterField(
            model_name='candidatepage',
            name='manager_site',
            field=models.URLField(blank=True, null=True),
        ),
        migrations.RunPython(update_social_help_text, update_social_help_text_reverse),
    ]
