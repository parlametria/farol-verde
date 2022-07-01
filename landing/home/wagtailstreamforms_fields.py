from django import forms
from wagtailstreamforms.fields import BaseField, register
from wagtail.core import blocks
from django.utils.translation import gettext_lazy as _

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
                "required": False,
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
        choices = [(c['id'], c['value']) for c in block_value.get("choices")]
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

@register("dropdown")
class DropdownField(BaseField):
    field_class = forms.ChoiceField
    icon = "arrow-down-big"
    label = _("Dropdown field")

    def get_options(self, block_value):
        options = super().get_options(block_value)
        choices = [(c['id'], c["value"]) for c in block_value.get("choices")]
        if block_value.get("empty_label"):
            choices.insert(0, ("", block_value.get("empty_label")))
        options.update({"choices": choices})
        return options

    def get_form_block(self):
        return blocks.StructBlock(
            [
                ("label", blocks.CharBlock()),
                ("help_text", blocks.CharBlock(required=False)),
                ("required", blocks.BooleanBlock(required=False)),
                ("empty_label", blocks.CharBlock(required=False)),
                ("choices", blocks.ListBlock(blocks.CharBlock(label="Option"))),
            ],
            icon=self.icon,
            label=self.label,
        )

@register("multiselect")
class MultiSelectField(BaseField):
    field_class = forms.MultipleChoiceField
    icon = "list-ul"
    label = _("Multiselect field")

    def get_options(self, block_value):
        options = super().get_options(block_value)
        choices = [(c['id'], c["value"]) for c in block_value.get("choices")]
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

@register("checkboxes")
class CheckboxesField(BaseField):
    field_class = forms.MultipleChoiceField
    widget = forms.widgets.CheckboxSelectMultiple
    icon = "tick-inverse"
    label = _("Checkboxes")

    def get_options(self, block_value):
        options = super().get_options(block_value)
        choices = [(c['id'], c["value"]) for c in block_value.get("choices")]
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
