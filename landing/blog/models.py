from email.policy import default
from django.db import models

from django import forms

from wagtail.snippets.models import register_snippet
from wagtail.core import blocks
from wagtail.core.fields import StreamField
from wagtail.core.models import Page
from wagtail.core.fields import RichTextField
from wagtail.admin.edit_handlers import FieldPanel, StreamFieldPanel
from modelcluster.fields import ParentalKey
from modelcluster.contrib.taggit import ClusterTaggableManager
from taggit.models import TaggedItemBase
from wagtail.search import index

from wagtail_color_panel.fields import ColorField
from wagtail_color_panel.edit_handlers import NativeColorPanel


class BlogPostCard(TaggedItemBase):
    id = models.AutoField(primary_key=True)
    content_object = ParentalKey(
        "BlogPost", related_name="tagged_items", on_delete=models.CASCADE
    )


class BlogIndexPage(Page):
    is_creatable = False

    parent_page_types = [
        "home.LandingPage",
    ]

    subpage_types = [
        "blog.BlogPost",
    ]

    ajax_template = "blog/blog_index_page_ajax.html"
    sidebar_panels = StreamField(
        [
            (
                "sidebar_card",
                blocks.StructBlock(
                    [
                        ("title", blocks.RichTextBlock(required=True)),
                        ("tag", blocks.CharBlock(required=False, blank=True)),
                    ]
                ),
            )
        ],
        blank=True,
        null=True,
    )

    def get_context(self, request):
        children_objects = BlogPost.objects.live().public().order_by("-date")

        search_term = request.GET.get("search")
        tag = request.GET.get("tag")
        category = request.GET.get("category")
        start_count = request.GET.get("start") or 0
        if not start_count:
            start_count = 0
        else:
            start_count = int(start_count)

        filtered_post = children_objects
        if tag:
            filtered_post = filtered_post.filter(tags__name=tag)

        if category:
            filtered_post = filtered_post.filter(category__name=category)

        if search_term:
            filtered_post = filtered_post.search(search_term)

        tags = BlogPost.objects.distinct().values("tags__name").order_by("tags__name")
        tags = [tag["tags__name"] for tag in tags]

        context = super().get_context(request)
        context["filtered_posts"] = list(filtered_post)[
            start_count : start_count + 10
        ]  # TODO: remover isso e usar paginação
        context["have_new_post"] = start_count > 0
        context["all_posts"] = children_objects
        context["tags"] = tags
        context["categories"] = BlogCategory.objects.all()

        return context

    content_panels = Page.content_panels + [
        StreamFieldPanel("sidebar_panels"),
    ]


class BlogPost(Page):
    date = models.DateField("Post date", blank=False)
    intro_text = models.CharField(max_length=250)
    body = RichTextField(blank=True)
    tags = ClusterTaggableManager(through=BlogPostCard, blank=True)
    category = models.ForeignKey(
        "blog.BlogCategory", on_delete=models.SET_NULL, null=True
    )
    cover_image = models.ImageField(null=False, blank=False)

    def get_context(self, request):
        panels = BlogIndexPage.objects.first().specific.sidebar_panels

        tags = BlogPost.objects.distinct().values("tags__name").order_by("tags__name")
        tags = [tag["tags__name"] for tag in tags]

        context = super().get_context(request)
        context["all_posts"] = BlogPost.objects.live().public()
        context["panels"] = panels
        context["tags"] = tags

        return context

    search_fields = Page.search_fields + [
        index.SearchField("intro_text"),
        index.SearchField("body"),
        index.FilterField("tags"),
    ]

    content_panels = Page.content_panels + [
        FieldPanel("body", classname="full"),
        StreamFieldPanel("category", widget=forms.Select),
        FieldPanel("cover_image"),
        FieldPanel("date"),
        FieldPanel("tags"),
        FieldPanel("intro_text"),
    ]

    @property
    def previous_post(self):
        if self.get_prev_siblings():
            return self.get_prev_siblings().live().first()
        else:
            return self.get_siblings().live().last()

    @property
    def next_post(self):
        if self.get_next_siblings():
            return self.get_next_siblings().live().first()
        else:
            return self.get_siblings().live().first()


@register_snippet
class BlogCategory(models.Model):
    name = models.CharField(max_length=255)
    color = ColorField(default="#30bfd3")
    icon = models.CharField(max_length=255, default="fa-graduation-cap")

    panels = [
        FieldPanel("name"),
        NativeColorPanel("color"),
        FieldPanel("icon"),
    ]

    def __str__(self):
        return self.name

    class Meta:
        verbose_name_plural = "blog categories"
