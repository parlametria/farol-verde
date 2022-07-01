from django.contrib import messages
from django.shortcuts import redirect
from django.template.response import TemplateResponse
from django.utils.translation import gettext_lazy as _
from wagtail.core.hooks import register

from wagtailstreamforms.utils.requests import get_form_instance_from_request

@register('before_serve_page')
def process_form(page, request, *args, **kwargs):
    if request.method == 'POST':
        form_def = get_form_instance_from_request(request)

        if form_def:
            form = form_def.get_form(request.POST, request.FILES, page=page, user=request.user)
            context = page.get_context(request, *args, **kwargs)

            # CPF Validation
            cpf_valid = True
            cpf_field = list(filter(lambda x: x.label.lower() == 'cpf', form))
            if len(cpf_field):
                cpf_field = cpf_field[0]
                cpf_valid = len(cpf_field) > 0 and not (cpf_field.value() and cpf_field.value().isdigit())

            # Email Validation
            email_valid = True
            email_field = list(filter(lambda x: x.label.lower() == 'e-mail', form))
            email_confirmation_field = list(filter(lambda x: x.label.lower() == 'confirma e-mail', form))
            if len(email_field) and len(email_confirmation_field):
                email_field = email_field[0]
                email_confirmation_field = email_confirmation_field[0]
                email_valid = email_field == email_confirmation_field

            if form.is_valid() and cpf_valid and email_valid:
                form_def.process_form_submission(form)

                if form_def.success_message:
                    messages.success(request, form_def.success_message, fail_silently=True)

                redirect_page = form_def.post_redirect_page or page

                return redirect(redirect_page.get_url(request), context=context)

            else:
                context.update({
                    'invalid_stream_form_reference': form.data.get('form_reference'),
                    'invalid_stream_form': form
                })

                if not cpf_valid:
                    messages.error(request, _('CPF inválido'), fail_silently=True)

                if not email_valid:
                    messages.error(request, _('E-mails não estão iguais'), fail_silently=True)

                if form_def.error_message:
                    messages.error(request, form_def.error_message, fail_silently=True)

                return TemplateResponse(
                    request,
                    page.get_template(request, *args, **kwargs),
                    context
                )