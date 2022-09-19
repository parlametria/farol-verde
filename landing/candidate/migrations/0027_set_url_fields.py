from django.db import migrations, models
from wagtailstreamforms.models.form import Form

get_field_data = lambda field, data: field.__dict__["value"].get(data)
selected_fields = [
    "Link para o site da campanha",
    "Twitter",
    "Facebook",
    "Instagram",
    "Youtube",
]


def set_url_fields(apps, schema_editor):
    form = Form.objects.get(title="Enquete")
    fields = [
        field
        for field in form.fields
        if get_field_data(field, "label") in selected_fields
    ]
    for field in fields:
        help_text = get_field_data(field, "help_text")
        if "phone" in help_text:
            continue
        field.__dict__["value"].update({"help_text": help_text + " url-field"})
    form.save()


def update_set_url_fields(apps, schema_editor):
    form = Form.objects.get(title="Enquete")
    fields = [
        field
        for field in form.fields
        if get_field_data(field, "label") in selected_fields
    ]
    for field in fields:
        help_text = get_field_data(field, "help_text")
        help_text.replace("url-field", "")
        field.__dict__["value"].update({"help_text": help_text})
    form.save()


class Migration(migrations.Migration):

    dependencies = [
        ("candidate", "0026_candidatepage_tse_urn_code"),
    ]

    operations = [
        migrations.RunPython(set_url_fields, update_set_url_fields),
    ]
