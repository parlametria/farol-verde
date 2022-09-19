import re
from django.contrib import messages
from django.shortcuts import redirect
from django.template.response import TemplateResponse
from django.utils.translation import gettext_lazy as _
from wagtail.core.hooks import register

from wagtailstreamforms.utils.requests import get_form_instance_from_request


@register("before_serve_page")
def process_form(page, request, *args, **kwargs):
    if request.method == "POST":
        form_def = get_form_instance_from_request(request)

        if form_def:
            form = form_def.get_form(
                request.POST, request.FILES, page=page, user=request.user
            )
            context = page.get_context(request, *args, **kwargs)

            # CPF Validation
            cpf_valid = False
            cpf_field = list(filter(lambda x: x.label.lower() == "cpf", form))
            if len(cpf_field):
                cpf_field = cpf_field[0]
                cpf_valid = (
                    len(cpf_field) > 0
                    and len(cpf_field.value()) == 11
                    and cpf_field.value().isdigit()
                )
            else:
                cpf_valid = True

            # Email Validation
            email_valid = False
            email_field = list(filter(lambda x: x.label.lower() == "e-mail", form))
            email_confirmation_field = list(
                filter(lambda x: x.label.lower() == "confirmação de e-mail", form)
            )
            regex = re.compile(
                r"([A-Za-z0-9]+[.-_])*[A-Za-z0-9]+@[A-Za-z0-9-]+(\.[A-Z|a-z]{2,})+"
            )
            if len(email_field) and len(email_confirmation_field):
                email_field = email_field[0]
                email_confirmation_field = email_confirmation_field[0]
                email_valid = (
                    email_field.value() == email_confirmation_field.value()
                    and re.fullmatch(regex, email_field.value())
                )
            else:
                email_valid = True

            # Email Validation
            contact_email_valid = False
            contact_email_field = list(
                filter(lambda x: x.label.lower() == "e-mail do contato", form)
            )
            if len(contact_email_field):
                contact_email_field = contact_email_field[0]
                contact_email_valid = re.fullmatch(regex, contact_email_field.value())
            else:
                contact_email_valid = True

            if form.is_valid() and cpf_valid and email_valid and contact_email_valid:
                form_def.process_form_submission(form)

                if form_def.success_message:
                    messages.success(
                        request, form_def.success_message, fail_silently=True
                    )

                redirect_page = form_def.post_redirect_page or page

                return redirect(redirect_page.get_url(request), context=context)

            else:
                context.update(
                    {
                        "invalid_stream_form_reference": form.data.get(
                            "form_reference"
                        ),
                        "invalid_stream_form": form,
                    }
                )

                if not cpf_valid:
                    messages.error(request, _("CPF inválido"), fail_silently=True)

                if not email_valid:
                    messages.error(
                        request,
                        _("E-mail e confirmação de e-mail inválidos"),
                        fail_silently=True,
                    )

                if not contact_email_valid:
                    messages.error(
                        request, _("E-mail de contato inválido"), fail_silently=True
                    )

                if form_def.error_message:
                    messages.error(request, form_def.error_message, fail_silently=True)

                return TemplateResponse(
                    request, page.get_template(request, *args, **kwargs), context
                )
