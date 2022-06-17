from django.db import models

from wagtail.core.models import Page

from wagtail.core.fields import RichTextField, StreamField
from wagtail.images.blocks import ImageChooserBlock
from wagtail.core.blocks import StructBlock, URLBlock
from wagtail.admin.edit_handlers import StreamFieldPanel, FieldPanel
from wagtailstreamforms.blocks import WagtailFormBlock


class LandingPage(Page):
    is_creatable = False
    ajax_template = 'home/landing_page.html'


    heading = RichTextField(
        null=False, blank=False, default="<h1><b>Bem vindo ao boilerplate Wagtail da Pencil.</b></h1>"
    )

    subheading = RichTextField(
        null=False,
        blank=False,
        default="<h4>Esse é o subheading do boilerplate.</h4>",
    )

    surveys = StreamField([
        ('form', WagtailFormBlock()),
    ], blank=True, null=True)

    clients = StreamField(
        [
            (
                "clients",
                StructBlock(
                    [
                        ("image", ImageChooserBlock()),
                        ("link", URLBlock(max_length=100)),
                    ]
                ),
            )
        ],
        null=True,
        blank=True,
    )

    content_panels = Page.content_panels + [
        FieldPanel("heading"),
        FieldPanel("subheading"),
        StreamFieldPanel("surveys"),
        StreamFieldPanel("clients"),
    ]
