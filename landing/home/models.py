from django.db import models

from wagtail.core.models import Page

from wagtail.core.fields import RichTextField, StreamField
from wagtail.images.blocks import ImageChooserBlock
from wagtail.core.blocks import StructBlock, URLBlock, RichTextBlock
from wagtail.admin.edit_handlers import StreamFieldPanel, FieldPanel


class LandingPage(Page):
    is_creatable = False

    heading = RichTextField(
        null=False, blank=False, default="<h1><b>Bem vindo ao boilerplate Wagtail da Pencil.</b></h1>"
    )
    subheading = RichTextField(
        null=False,
        blank=False,
        default="<h4>Esse é o subheading do boilerplate.</h4>",
    )

    features = StreamField(
        [
            (
                "features",
                StructBlock(
                    [
                        ("image", ImageChooserBlock()),
                        ("text", RichTextBlock()),
                    ]
                ),
            )
        ],
        null=True,
        blank=True,
    )

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
        StreamFieldPanel("features"),
        StreamFieldPanel("clients"),
    ]
