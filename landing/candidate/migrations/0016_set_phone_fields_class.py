from django.db import migrations, models
from candidate.models import form_submission_link_candidate
from wagtailstreamforms.models.form import Form

get_field_data = lambda field, data: field.__dict__['value'].get(data)

def update_phone_help_text(apps, schema_editor):
    form = Form.objects.get(title='Enquete')
    fields = [field for field in form.fields
        if get_field_data(field, 'label') == 'Telefone do contato']
    for field in fields:
        help_text = get_field_data(field, 'help_text')
        if 'phone' in help_text:
            continue
        field.__dict__['value'].update({'help_text': help_text + ' phone'})
    form.save()

def update_phone_help_text_reverse(apps, schema_editor):
    form = Form.objects.get(title='Enquete')
    fields = [field for field in form.fields
        if get_field_data(field, 'label') == 'Telefone do contato']
    for field in fields:
        help_text = get_field_data(field, 'help_text')
        help_text.replace('phone', '')
        field.__dict__['value'].update({'help_text': help_text})
    form.save()

class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('candidate', '0015_alter_votacaoprosicao_data_hora_registro'),
    ]

    operations = [
        migrations.AlterField(
            model_name='candidatepage',
            name='manager_site',
            field=models.URLField(blank=True, null=True),
        ),
        migrations.RunPython(update_phone_help_text, update_phone_help_text_reverse),
    ]
