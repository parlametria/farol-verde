# Generated by Django 3.2.12 on 2022-06-24 18:57

from django.db import migrations, models
import django.db.models.deletion
import wagtail.core.blocks
import wagtail.core.fields
import wagtailstreamforms.blocks
from wagtail.core.models import Page
from home.models import SurveysPage

def create_survey_page(apps, schema_editor):
    home = Page.objects.get(title='Home')

    survey_page = SurveysPage(title="Survey", slug="surveys")

    home.add_child(instance=survey_page)
    home.save()

class Migration(migrations.Migration):

    dependencies = [
        ('wagtailcore', '0066_collection_management_permissions'),
        ('home', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='SurveysPage',
            fields=[
                ('page_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='wagtailcore.page')),
                ('surveys', wagtail.core.fields.StreamField([('form', wagtail.core.blocks.StructBlock([('form', wagtailstreamforms.blocks.FormChooserBlock()), ('form_action', wagtail.core.blocks.CharBlock(help_text='The form post action. "" or "." for the current page or a url', required=False)), ('form_reference', wagtailstreamforms.blocks.InfoBlock(help_text='This form will be given a unique reference once saved', required=False))]))], blank=True, null=True)),
            ],
            options={
                'abstract': False,
            },
            bases=('wagtailcore.page',),
        ),
        migrations.RemoveField(
            model_name='landingpage',
            name='clients',
        ),
        migrations.RemoveField(
            model_name='landingpage',
            name='surveys',
        ),
        migrations.AlterField(
            model_name='landingpage',
            name='heading',
            field=wagtail.core.fields.RichTextField(default='Tenetur nesciunt quae aspernatur, incidunt suscipit beatae totam qui ut, nam possimus adipisci cum quaerat? Odio maxime sint, officiis excepturi veritatis quod accusantium quidem corporis sapiente delectus ut, ullam cum a praesentium ea nam soluta molestiae, blanditiis assumenda quia beatae. In veritatis quod nisi incidunt suscipit nesciunt iure. Rerum deserunt ad ipsum repudiandae magni exercitationem laboriosam amet saepe labore illo? Maxime modi temporibus suscipit impedit, libero alias nostrum ipsa consequuntur dignissimos, eveniet alias qui aperiam ex ipsam ipsa quod ea. Similique eligendi est delectus ipsa ullam quisquam quis inventore voluptas corrupti, mollitia dolorum ab veniam voluptatibus ex alias debitis ratione. Quae fugit expedita, veniam id tenetur veritatis, voluptatum corrupti nam ipsam sed quidem quam iste modi soluta, omnis magnam similique corporis voluptates rerum quidem est sed? Corporis distinctio non sunt alias, necessitatibus inventore asperiores, ea dolore dolor autem, atque sunt eius soluta minima nostrum aspernatur facere doloremque? In dolores fugit nihil iusto officia, fugit atque impedit porro totam magnam, qui ea repudiandae corporis repellat aspernatur, et dolorem voluptatem explicabo eligendi quibusdam? Et odio harum sed non voluptatum suscipit asperiores, facilis voluptate dolore nihil aliquam ab qui non dolor quisquam? Quam a provident, non vitae facere dolorem recusandae, id quis beatae cum sapiente, voluptate vero corporis soluta culpa recusandae officiis delectus, maiores beatae excepturi quam hic accusantium. Voluptatem ex quisquam inventore dolor ea minus libero nam, distinctio hic deleniti reiciendis nobis accusamus magnam atque, earum doloribus culpa ullam eveniet quae qui aliquam sapiente nisi explicabo, ratione eius aperiam pariatur sit maxime hic laudantium, quisquam animi deserunt in itaque harum veniam velit culpa provident dolor veritatis. Placeat ullam nesciunt expedita atque? Ab recusandae animi illum beatae nihil perferendis qui id provident, facere tempora similique.'),
        ),
        migrations.RunPython(create_survey_page),
    ]
