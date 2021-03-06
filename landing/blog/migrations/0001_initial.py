# Generated by Django 3.2.12 on 2022-06-08 16:24

from django.db import migrations, models
import django.db.models.deletion
import modelcluster.contrib.taggit
import modelcluster.fields
import wagtail.core.blocks
import wagtail.core.fields
import wagtail_color_panel.fields


class Migration(migrations.Migration):
    initial = True

    dependencies = [
        ("wagtailredirects", "0007_add_autocreate_fields"),
        ("wagtailcore", "0062_comment_models_and_pagesubscription"),
        ("taggit", "0004_alter_taggeditem_content_type_alter_taggeditem_tag"),
        ("taggit", "0003_taggeditem_add_unique_index"),
        ("home", "0001_initial"),
        ("wagtailforms", "0004_add_verbose_name_plural"),
        ("wagtailcore", "0066_collection_management_permissions"),
    ]

    operations = [
        migrations.CreateModel(
            name="BlogCategory",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=255)),
                (
                    "color",
                    wagtail_color_panel.fields.ColorField(
                        default="#30bfd3", max_length=7
                    ),
                ),
                ("icon", models.CharField(default="fa-graduation-cap", max_length=255)),
            ],
            options={
                "verbose_name_plural": "blog categories",
            },
        ),
        migrations.CreateModel(
            name="BlogIndexPage",
            fields=[
                (
                    "page_ptr",
                    models.OneToOneField(
                        auto_created=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        parent_link=True,
                        primary_key=True,
                        serialize=False,
                        to="wagtailcore.page",
                    ),
                ),
                (
                    "sidebar_panels",
                    wagtail.core.fields.StreamField(
                        [
                            (
                                "sidebar_card",
                                wagtail.core.blocks.StructBlock(
                                    [
                                        (
                                            "title",
                                            wagtail.core.blocks.RichTextBlock(
                                                required=True
                                            ),
                                        ),
                                        (
                                            "tag",
                                            wagtail.core.blocks.CharBlock(
                                                blank=True, required=False
                                            ),
                                        ),
                                    ]
                                ),
                            )
                        ],
                        blank=True,
                        null=True,
                    ),
                ),
            ],
            options={
                "abstract": False,
            },
            bases=("wagtailcore.page",),
        ),
        migrations.CreateModel(
            name="BlogPage",
            fields=[
                (
                    "page_ptr",
                    models.OneToOneField(
                        auto_created=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        parent_link=True,
                        primary_key=True,
                        serialize=False,
                        to="wagtailcore.page",
                    ),
                ),
                ("date", models.DateField(verbose_name="Post date")),
                ("intro", models.CharField(max_length=250)),
                ("body", wagtail.core.fields.RichTextField(blank=True)),
                ("cover_image", models.ImageField(upload_to="")),
                (
                    "category",
                    models.ForeignKey(
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        to="blog.blogcategory",
                    ),
                ),
            ],
            options={
                "abstract": False,
            },
            bases=("wagtailcore.page",),
        ),
        migrations.CreateModel(
            name="BlogPageCard",
            fields=[
                ("id", models.AutoField(primary_key=True, serialize=False)),
                (
                    "content_object",
                    modelcluster.fields.ParentalKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="tagged_items",
                        to="blog.blogpage",
                    ),
                ),
                (
                    "tag",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="blog_blogpagecard_items",
                        to="taggit.tag",
                    ),
                ),
            ],
            options={
                "abstract": False,
            },
        ),
        migrations.AddField(
            model_name="blogpage",
            name="tags",
            field=modelcluster.contrib.taggit.ClusterTaggableManager(
                blank=True,
                help_text="A comma-separated list of tags.",
                through="blog.BlogPageCard",
                to="taggit.Tag",
                verbose_name="Tags",
            ),
        ),
        migrations.CreateModel(
            name="BlogPost",
            fields=[
                (
                    "page_ptr",
                    models.OneToOneField(
                        auto_created=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        parent_link=True,
                        primary_key=True,
                        serialize=False,
                        to="wagtailcore.page",
                    ),
                ),
                ("date", models.DateField(verbose_name="Post date")),
                ("intro_text", models.CharField(max_length=250)),
                ("body", wagtail.core.fields.RichTextField(blank=True)),
                ("cover_image", models.ImageField(upload_to="")),
                (
                    "category",
                    models.ForeignKey(
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        to="blog.blogcategory",
                    ),
                ),
            ],
            options={
                "abstract": False,
            },
            bases=("wagtailcore.page",),
        ),
        migrations.CreateModel(
            name="BlogPostCard",
            fields=[
                ("id", models.AutoField(primary_key=True, serialize=False)),
                (
                    "content_object",
                    modelcluster.fields.ParentalKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="tagged_items",
                        to="blog.blogpost",
                    ),
                ),
                (
                    "tag",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="blog_blogpostcard_items",
                        to="taggit.tag",
                    ),
                ),
            ],
            options={
                "abstract": False,
            },
        ),
        migrations.RemoveField(
            model_name="blogpagecard",
            name="content_object",
        ),
        migrations.RemoveField(
            model_name="blogpagecard",
            name="tag",
        ),
        migrations.DeleteModel(
            name="BlogPage",
        ),
        migrations.DeleteModel(
            name="BlogPageCard",
        ),
        migrations.AddField(
            model_name="blogpost",
            name="tags",
            field=modelcluster.contrib.taggit.ClusterTaggableManager(
                blank=True,
                help_text="A comma-separated list of tags.",
                through="blog.BlogPostCard",
                to="taggit.Tag",
                verbose_name="Tags",
            ),
        ),
    ]
