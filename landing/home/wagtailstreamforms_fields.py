from django import forms
from wagtailstreamforms.fields import BaseField, register
from wagtail.core import blocks
from django.utils.translation import gettext_lazy as _


@register("category")
class CategoryField(BaseField):
    field_class = forms.CharField
    type = "category"
    icon = "redirect"

    def get_form_block(self):
        return blocks.StructBlock(
            [
                ("label", blocks.CharBlock()),
            ],
            icon=self.icon,
            label=self.label,
        )

    def get_options(self, block_value):
        options = super().get_options(block_value)
        options.update(
            {
                "help_text": "category_category",
                "required": True,
            }
        )
        return options


@register("title")
class CategoryField(BaseField):
    field_class = forms.CharField
    type = "title"
    icon = "title"

    def get_form_block(self):
        return blocks.StructBlock(
            [
                ("label", blocks.CharBlock()),
            ],
            icon=self.icon,
            label=self.label,
        )

    def get_options(self, block_value):
        options = super().get_options(block_value)
        options.update(
            {
                "help_text": "title_title",
                "required": True,
            }
        )
        return options


@register("radio")
class RadioField(BaseField):
    field_class = forms.ChoiceField
    widget = forms.widgets.RadioSelect
    icon = "radio-empty"
    label = _("Radio buttons")

    def get_options(self, block_value):
        options = super().get_options(block_value)
        print(block_value)
        choices = [(value, value["value"]) for value in block_value.get("choices")]
        options.update({"choices": choices})
        return options

    def get_form_block(self):
        return blocks.StructBlock(
            [
                ("label", blocks.CharBlock()),
                ("help_text", blocks.CharBlock(required=False)),
                ("required", blocks.BooleanBlock(required=False)),
                ("choices", blocks.ListBlock(blocks.CharBlock(label="Option"))),
            ],
            icon=self.icon,
            label=self.label,
        )
