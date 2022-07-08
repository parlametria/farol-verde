from wagtail.core.models import Page

from wagtail.core.fields import RichTextField, StreamField
from wagtail.admin.edit_handlers import StreamFieldPanel, FieldPanel
from wagtailstreamforms.blocks import WagtailFormBlock
from wagtail.core.blocks import StructBlock, ChoiceBlock, URLBlock
from candidate.models import CandidateIndexPage

class LandingPage(Page):
    is_creatable = False

    heading = RichTextField(
        null=False,
        blank=False,
        default="Tenetur nesciunt quae aspernatur, incidunt suscipit beatae totam qui ut, nam possimus adipisci cum quaerat? Odio maxime sint, officiis excepturi veritatis quod accusantium quidem corporis sapiente delectus ut, ullam cum a praesentium ea nam soluta molestiae, blanditiis assumenda quia beatae. In veritatis quod nisi incidunt suscipit nesciunt iure. Rerum deserunt ad ipsum repudiandae magni exercitationem laboriosam amet saepe labore illo? Maxime modi temporibus suscipit impedit, libero alias nostrum ipsa consequuntur dignissimos, eveniet alias qui aperiam ex ipsam ipsa quod ea. Similique eligendi est delectus ipsa ullam quisquam quis inventore voluptas corrupti, mollitia dolorum ab veniam voluptatibus ex alias debitis ratione. Quae fugit expedita, veniam id tenetur veritatis, voluptatum corrupti nam ipsam sed quidem quam iste modi soluta, omnis magnam similique corporis voluptates rerum quidem est sed? Corporis distinctio non sunt alias, necessitatibus inventore asperiores, ea dolore dolor autem, atque sunt eius soluta minima nostrum aspernatur facere doloremque? In dolores fugit nihil iusto officia, fugit atque impedit porro totam magnam, qui ea repudiandae corporis repellat aspernatur, et dolorem voluptatem explicabo eligendi quibusdam? Et odio harum sed non voluptatum suscipit asperiores, facilis voluptate dolore nihil aliquam ab qui non dolor quisquam? Quam a provident, non vitae facere dolorem recusandae, id quis beatae cum sapiente, voluptate vero corporis soluta culpa recusandae officiis delectus, maiores beatae excepturi quam hic accusantium. Voluptatem ex quisquam inventore dolor ea minus libero nam, distinctio hic deleniti reiciendis nobis accusamus magnam atque, earum doloribus culpa ullam eveniet quae qui aliquam sapiente nisi explicabo, ratione eius aperiam pariatur sit maxime hic laudantium, quisquam animi deserunt in itaque harum veniam velit culpa provident dolor veritatis. Placeat ullam nesciunt expedita atque? Ab recusandae animi illum beatae nihil perferendis qui id provident, facere tempora similique.",
    )

    content_panels = Page.content_panels + [
        FieldPanel("heading"),
    ]

    def get_context(self, request):
        context = super(LandingPage, self).get_context(request)
        survey_url = SurveysPage.objects.get(title="Enquete").slug
        contact_url = SurveysPage.objects.get(title="Contato").slug
        candidates_url = CandidateIndexPage.objects.first().slug
        context["survey_url"] = survey_url
        context["contact_url"] = contact_url
        context["candidates_url"] = candidates_url
        return context


class SurveysPage(Page):
    surveys = StreamField(
        [
            ("form", WagtailFormBlock()),
        ],
        blank=True,
        null=True,
    )

    content_panels = Page.content_panels + [
        StreamFieldPanel("surveys"),
    ]

