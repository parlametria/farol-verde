--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1 (Debian 13.1-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO root;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO root;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO root;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO root;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO root;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO root;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO root;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO root;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO root;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO root;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO root;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO root;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: blog_blogcategory; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blog_blogcategory (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    color character varying(7) NOT NULL,
    icon character varying(255) NOT NULL
);


ALTER TABLE public.blog_blogcategory OWNER TO root;

--
-- Name: blog_blogcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.blog_blogcategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_blogcategory_id_seq OWNER TO root;

--
-- Name: blog_blogcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.blog_blogcategory_id_seq OWNED BY public.blog_blogcategory.id;


--
-- Name: blog_blogindexpage; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blog_blogindexpage (
    page_ptr_id integer NOT NULL,
    sidebar_panels text
);


ALTER TABLE public.blog_blogindexpage OWNER TO root;

--
-- Name: blog_blogpost; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blog_blogpost (
    page_ptr_id integer NOT NULL,
    date date NOT NULL,
    intro_text character varying(250) NOT NULL,
    body text NOT NULL,
    cover_image character varying(100) NOT NULL,
    category_id bigint
);


ALTER TABLE public.blog_blogpost OWNER TO root;

--
-- Name: blog_blogpostcard; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.blog_blogpostcard (
    id integer NOT NULL,
    content_object_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.blog_blogpostcard OWNER TO root;

--
-- Name: blog_blogpostcard_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.blog_blogpostcard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_blogpostcard_id_seq OWNER TO root;

--
-- Name: blog_blogpostcard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.blog_blogpostcard_id_seq OWNED BY public.blog_blogpostcard.id;


--
-- Name: candidate_candidateindexpage; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.candidate_candidateindexpage (
    page_ptr_id integer NOT NULL,
    description character varying(255) NOT NULL
);


ALTER TABLE public.candidate_candidateindexpage OWNER TO root;

--
-- Name: candidate_candidatepage; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.candidate_candidatepage (
    page_ptr_id integer NOT NULL,
    id_autor integer NOT NULL,
    id_parlametria integer NOT NULL,
    id_serenata integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.candidate_candidatepage OWNER TO root;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO root;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO root;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO root;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO root;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO root;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO root;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO root;

--
-- Name: home_landingpage; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.home_landingpage (
    page_ptr_id integer NOT NULL,
    heading text NOT NULL
);


ALTER TABLE public.home_landingpage OWNER TO root;

--
-- Name: home_surveyspage; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.home_surveyspage (
    page_ptr_id integer NOT NULL,
    surveys text
);


ALTER TABLE public.home_surveyspage OWNER TO root;

--
-- Name: taggit_tag; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.taggit_tag (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


ALTER TABLE public.taggit_tag OWNER TO root;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.taggit_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_tag_id_seq OWNER TO root;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.taggit_tag_id_seq OWNED BY public.taggit_tag.id;


--
-- Name: taggit_taggeditem; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.taggit_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.taggit_taggeditem OWNER TO root;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.taggit_taggeditem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_taggeditem_id_seq OWNER TO root;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.taggit_taggeditem_id_seq OWNED BY public.taggit_taggeditem.id;


--
-- Name: wagtailadmin_admin; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailadmin_admin (
    id integer NOT NULL
);


ALTER TABLE public.wagtailadmin_admin OWNER TO root;

--
-- Name: wagtailadmin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailadmin_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailadmin_admin_id_seq OWNER TO root;

--
-- Name: wagtailadmin_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailadmin_admin_id_seq OWNED BY public.wagtailadmin_admin.id;


--
-- Name: wagtailcore_collection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_collection (
    id integer NOT NULL,
    path character varying(255) NOT NULL COLLATE pg_catalog."C",
    depth integer NOT NULL,
    numchild integer NOT NULL,
    name character varying(255) NOT NULL,
    CONSTRAINT wagtailcore_collection_depth_check CHECK ((depth >= 0)),
    CONSTRAINT wagtailcore_collection_numchild_check CHECK ((numchild >= 0))
);


ALTER TABLE public.wagtailcore_collection OWNER TO root;

--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collection_id_seq OWNER TO root;

--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_collection_id_seq OWNED BY public.wagtailcore_collection.id;


--
-- Name: wagtailcore_collectionviewrestriction; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_collectionviewrestriction (
    id integer NOT NULL,
    restriction_type character varying(20) NOT NULL,
    password character varying(255) NOT NULL,
    collection_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_collectionviewrestriction OWNER TO root;

--
-- Name: wagtailcore_collectionviewrestriction_groups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_collectionviewrestriction_groups (
    id integer NOT NULL,
    collectionviewrestriction_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_collectionviewrestriction_groups OWNER TO root;

--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_collectionviewrestriction_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collectionviewrestriction_groups_id_seq OWNER TO root;

--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_collectionviewrestriction_groups_id_seq OWNED BY public.wagtailcore_collectionviewrestriction_groups.id;


--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_collectionviewrestriction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_collectionviewrestriction_id_seq OWNER TO root;

--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_collectionviewrestriction_id_seq OWNED BY public.wagtailcore_collectionviewrestriction.id;


--
-- Name: wagtailcore_comment; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_comment (
    id integer NOT NULL,
    text text NOT NULL,
    contentpath text NOT NULL,
    "position" text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    resolved_at timestamp with time zone,
    page_id integer NOT NULL,
    resolved_by_id integer,
    revision_created_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_comment OWNER TO root;

--
-- Name: wagtailcore_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_comment_id_seq OWNER TO root;

--
-- Name: wagtailcore_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_comment_id_seq OWNED BY public.wagtailcore_comment.id;


--
-- Name: wagtailcore_commentreply; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_commentreply (
    id integer NOT NULL,
    text text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    comment_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_commentreply OWNER TO root;

--
-- Name: wagtailcore_commentreply_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_commentreply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_commentreply_id_seq OWNER TO root;

--
-- Name: wagtailcore_commentreply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_commentreply_id_seq OWNED BY public.wagtailcore_commentreply.id;


--
-- Name: wagtailcore_groupapprovaltask; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_groupapprovaltask (
    task_ptr_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_groupapprovaltask OWNER TO root;

--
-- Name: wagtailcore_groupapprovaltask_groups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_groupapprovaltask_groups (
    id integer NOT NULL,
    groupapprovaltask_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_groupapprovaltask_groups OWNER TO root;

--
-- Name: wagtailcore_groupapprovaltask_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_groupapprovaltask_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_groupapprovaltask_groups_id_seq OWNER TO root;

--
-- Name: wagtailcore_groupapprovaltask_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_groupapprovaltask_groups_id_seq OWNED BY public.wagtailcore_groupapprovaltask_groups.id;


--
-- Name: wagtailcore_groupcollectionpermission; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_groupcollectionpermission (
    id integer NOT NULL,
    collection_id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_groupcollectionpermission OWNER TO root;

--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_groupcollectionpermission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_groupcollectionpermission_id_seq OWNER TO root;

--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_groupcollectionpermission_id_seq OWNED BY public.wagtailcore_groupcollectionpermission.id;


--
-- Name: wagtailcore_grouppagepermission; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_grouppagepermission (
    id integer NOT NULL,
    permission_type character varying(20) NOT NULL,
    group_id integer NOT NULL,
    page_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_grouppagepermission OWNER TO root;

--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_grouppagepermission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_grouppagepermission_id_seq OWNER TO root;

--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_grouppagepermission_id_seq OWNED BY public.wagtailcore_grouppagepermission.id;


--
-- Name: wagtailcore_locale; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_locale (
    id integer NOT NULL,
    language_code character varying(100) NOT NULL
);


ALTER TABLE public.wagtailcore_locale OWNER TO root;

--
-- Name: wagtailcore_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_locale_id_seq OWNER TO root;

--
-- Name: wagtailcore_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_locale_id_seq OWNED BY public.wagtailcore_locale.id;


--
-- Name: wagtailcore_modellogentry; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_modellogentry (
    id integer NOT NULL,
    label text NOT NULL,
    action character varying(255) NOT NULL,
    data_json text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    content_changed boolean NOT NULL,
    deleted boolean NOT NULL,
    object_id character varying(255) NOT NULL,
    content_type_id integer,
    user_id integer,
    uuid uuid
);


ALTER TABLE public.wagtailcore_modellogentry OWNER TO root;

--
-- Name: wagtailcore_modellogentry_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_modellogentry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_modellogentry_id_seq OWNER TO root;

--
-- Name: wagtailcore_modellogentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_modellogentry_id_seq OWNED BY public.wagtailcore_modellogentry.id;


--
-- Name: wagtailcore_page; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_page (
    id integer NOT NULL,
    path character varying(255) NOT NULL COLLATE pg_catalog."C",
    depth integer NOT NULL,
    numchild integer NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    live boolean NOT NULL,
    has_unpublished_changes boolean NOT NULL,
    url_path text NOT NULL,
    seo_title character varying(255) NOT NULL,
    show_in_menus boolean NOT NULL,
    search_description text NOT NULL,
    go_live_at timestamp with time zone,
    expire_at timestamp with time zone,
    expired boolean NOT NULL,
    content_type_id integer NOT NULL,
    owner_id integer,
    locked boolean NOT NULL,
    latest_revision_created_at timestamp with time zone,
    first_published_at timestamp with time zone,
    live_revision_id integer,
    last_published_at timestamp with time zone,
    draft_title character varying(255) NOT NULL,
    locked_at timestamp with time zone,
    locked_by_id integer,
    translation_key uuid NOT NULL,
    locale_id integer NOT NULL,
    alias_of_id integer,
    CONSTRAINT wagtailcore_page_depth_check CHECK ((depth >= 0)),
    CONSTRAINT wagtailcore_page_numchild_check CHECK ((numchild >= 0))
);


ALTER TABLE public.wagtailcore_page OWNER TO root;

--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_page_id_seq OWNER TO root;

--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_page_id_seq OWNED BY public.wagtailcore_page.id;


--
-- Name: wagtailcore_pagelogentry; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_pagelogentry (
    id integer NOT NULL,
    label text NOT NULL,
    action character varying(255) NOT NULL,
    data_json text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    content_changed boolean NOT NULL,
    deleted boolean NOT NULL,
    content_type_id integer,
    page_id integer NOT NULL,
    revision_id integer,
    user_id integer,
    uuid uuid
);


ALTER TABLE public.wagtailcore_pagelogentry OWNER TO root;

--
-- Name: wagtailcore_pagelogentry_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_pagelogentry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pagelogentry_id_seq OWNER TO root;

--
-- Name: wagtailcore_pagelogentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_pagelogentry_id_seq OWNED BY public.wagtailcore_pagelogentry.id;


--
-- Name: wagtailcore_pagerevision; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_pagerevision (
    id integer NOT NULL,
    submitted_for_moderation boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    content_json text NOT NULL,
    approved_go_live_at timestamp with time zone,
    page_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.wagtailcore_pagerevision OWNER TO root;

--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_pagerevision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pagerevision_id_seq OWNER TO root;

--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_pagerevision_id_seq OWNED BY public.wagtailcore_pagerevision.id;


--
-- Name: wagtailcore_pagesubscription; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_pagesubscription (
    id integer NOT NULL,
    comment_notifications boolean NOT NULL,
    page_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_pagesubscription OWNER TO root;

--
-- Name: wagtailcore_pagesubscription_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_pagesubscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pagesubscription_id_seq OWNER TO root;

--
-- Name: wagtailcore_pagesubscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_pagesubscription_id_seq OWNED BY public.wagtailcore_pagesubscription.id;


--
-- Name: wagtailcore_pageviewrestriction; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_pageviewrestriction (
    id integer NOT NULL,
    password character varying(255) NOT NULL,
    page_id integer NOT NULL,
    restriction_type character varying(20) NOT NULL
);


ALTER TABLE public.wagtailcore_pageviewrestriction OWNER TO root;

--
-- Name: wagtailcore_pageviewrestriction_groups; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_pageviewrestriction_groups (
    id integer NOT NULL,
    pageviewrestriction_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_pageviewrestriction_groups OWNER TO root;

--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_pageviewrestriction_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pageviewrestriction_groups_id_seq OWNER TO root;

--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_pageviewrestriction_groups_id_seq OWNED BY public.wagtailcore_pageviewrestriction_groups.id;


--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_pageviewrestriction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pageviewrestriction_id_seq OWNER TO root;

--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_pageviewrestriction_id_seq OWNED BY public.wagtailcore_pageviewrestriction.id;


--
-- Name: wagtailcore_site; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_site (
    id integer NOT NULL,
    hostname character varying(255) NOT NULL,
    port integer NOT NULL,
    is_default_site boolean NOT NULL,
    root_page_id integer NOT NULL,
    site_name character varying(255) NOT NULL
);


ALTER TABLE public.wagtailcore_site OWNER TO root;

--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_site_id_seq OWNER TO root;

--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_site_id_seq OWNED BY public.wagtailcore_site.id;


--
-- Name: wagtailcore_task; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_task (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    active boolean NOT NULL,
    content_type_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_task OWNER TO root;

--
-- Name: wagtailcore_task_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_task_id_seq OWNER TO root;

--
-- Name: wagtailcore_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_task_id_seq OWNED BY public.wagtailcore_task.id;


--
-- Name: wagtailcore_taskstate; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_taskstate (
    id integer NOT NULL,
    status character varying(50) NOT NULL,
    started_at timestamp with time zone NOT NULL,
    finished_at timestamp with time zone,
    content_type_id integer NOT NULL,
    page_revision_id integer NOT NULL,
    task_id integer NOT NULL,
    workflow_state_id integer NOT NULL,
    finished_by_id integer,
    comment text NOT NULL
);


ALTER TABLE public.wagtailcore_taskstate OWNER TO root;

--
-- Name: wagtailcore_taskstate_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_taskstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_taskstate_id_seq OWNER TO root;

--
-- Name: wagtailcore_taskstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_taskstate_id_seq OWNED BY public.wagtailcore_taskstate.id;


--
-- Name: wagtailcore_workflow; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_workflow (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.wagtailcore_workflow OWNER TO root;

--
-- Name: wagtailcore_workflow_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_workflow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_workflow_id_seq OWNER TO root;

--
-- Name: wagtailcore_workflow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_workflow_id_seq OWNED BY public.wagtailcore_workflow.id;


--
-- Name: wagtailcore_workflowpage; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_workflowpage (
    page_id integer NOT NULL,
    workflow_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_workflowpage OWNER TO root;

--
-- Name: wagtailcore_workflowstate; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_workflowstate (
    id integer NOT NULL,
    status character varying(50) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    current_task_state_id integer,
    page_id integer NOT NULL,
    requested_by_id integer,
    workflow_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_workflowstate OWNER TO root;

--
-- Name: wagtailcore_workflowstate_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_workflowstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_workflowstate_id_seq OWNER TO root;

--
-- Name: wagtailcore_workflowstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_workflowstate_id_seq OWNED BY public.wagtailcore_workflowstate.id;


--
-- Name: wagtailcore_workflowtask; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailcore_workflowtask (
    id integer NOT NULL,
    sort_order integer,
    task_id integer NOT NULL,
    workflow_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_workflowtask OWNER TO root;

--
-- Name: wagtailcore_workflowtask_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailcore_workflowtask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_workflowtask_id_seq OWNER TO root;

--
-- Name: wagtailcore_workflowtask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailcore_workflowtask_id_seq OWNED BY public.wagtailcore_workflowtask.id;


--
-- Name: wagtaildocs_document; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtaildocs_document (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    file character varying(100) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    uploaded_by_user_id integer,
    collection_id integer NOT NULL,
    file_size integer,
    file_hash character varying(40) NOT NULL,
    CONSTRAINT wagtaildocs_document_file_size_check CHECK ((file_size >= 0))
);


ALTER TABLE public.wagtaildocs_document OWNER TO root;

--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtaildocs_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtaildocs_document_id_seq OWNER TO root;

--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtaildocs_document_id_seq OWNED BY public.wagtaildocs_document.id;


--
-- Name: wagtaildocs_uploadeddocument; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtaildocs_uploadeddocument (
    id integer NOT NULL,
    file character varying(200) NOT NULL,
    uploaded_by_user_id integer
);


ALTER TABLE public.wagtaildocs_uploadeddocument OWNER TO root;

--
-- Name: wagtaildocs_uploadeddocument_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtaildocs_uploadeddocument_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtaildocs_uploadeddocument_id_seq OWNER TO root;

--
-- Name: wagtaildocs_uploadeddocument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtaildocs_uploadeddocument_id_seq OWNED BY public.wagtaildocs_uploadeddocument.id;


--
-- Name: wagtailembeds_embed; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailembeds_embed (
    id integer NOT NULL,
    url text NOT NULL,
    max_width smallint,
    type character varying(10) NOT NULL,
    html text NOT NULL,
    title text NOT NULL,
    author_name text NOT NULL,
    provider_name text NOT NULL,
    thumbnail_url text NOT NULL,
    width integer,
    height integer,
    last_updated timestamp with time zone NOT NULL,
    hash character varying(32) NOT NULL,
    cache_until timestamp with time zone
);


ALTER TABLE public.wagtailembeds_embed OWNER TO root;

--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailembeds_embed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailembeds_embed_id_seq OWNER TO root;

--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailembeds_embed_id_seq OWNED BY public.wagtailembeds_embed.id;


--
-- Name: wagtailforms_formsubmission; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailforms_formsubmission (
    id integer NOT NULL,
    form_data text NOT NULL,
    submit_time timestamp with time zone NOT NULL,
    page_id integer NOT NULL
);


ALTER TABLE public.wagtailforms_formsubmission OWNER TO root;

--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailforms_formsubmission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailforms_formsubmission_id_seq OWNER TO root;

--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailforms_formsubmission_id_seq OWNED BY public.wagtailforms_formsubmission.id;


--
-- Name: wagtailimages_image; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailimages_image (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    file character varying(100) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    focal_point_x integer,
    focal_point_y integer,
    focal_point_width integer,
    focal_point_height integer,
    uploaded_by_user_id integer,
    file_size integer,
    collection_id integer NOT NULL,
    file_hash character varying(40) NOT NULL,
    CONSTRAINT wagtailimages_image_file_size_check CHECK ((file_size >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_height_check CHECK ((focal_point_height >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_width_check CHECK ((focal_point_width >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_x_check CHECK ((focal_point_x >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_y_check CHECK ((focal_point_y >= 0))
);


ALTER TABLE public.wagtailimages_image OWNER TO root;

--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailimages_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_image_id_seq OWNER TO root;

--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailimages_image_id_seq OWNED BY public.wagtailimages_image.id;


--
-- Name: wagtailimages_rendition; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailimages_rendition (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    focal_point_key character varying(16) NOT NULL,
    filter_spec character varying(255) NOT NULL,
    image_id integer NOT NULL
);


ALTER TABLE public.wagtailimages_rendition OWNER TO root;

--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailimages_rendition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_rendition_id_seq OWNER TO root;

--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailimages_rendition_id_seq OWNED BY public.wagtailimages_rendition.id;


--
-- Name: wagtailimages_uploadedimage; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailimages_uploadedimage (
    id integer NOT NULL,
    file character varying(200) NOT NULL,
    uploaded_by_user_id integer
);


ALTER TABLE public.wagtailimages_uploadedimage OWNER TO root;

--
-- Name: wagtailimages_uploadedimage_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailimages_uploadedimage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_uploadedimage_id_seq OWNER TO root;

--
-- Name: wagtailimages_uploadedimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailimages_uploadedimage_id_seq OWNED BY public.wagtailimages_uploadedimage.id;


--
-- Name: wagtailredirects_redirect; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailredirects_redirect (
    id integer NOT NULL,
    old_path character varying(255) NOT NULL,
    is_permanent boolean NOT NULL,
    redirect_link character varying(255) NOT NULL,
    redirect_page_id integer,
    site_id integer,
    automatically_created boolean NOT NULL,
    created_at timestamp with time zone,
    redirect_page_route_path character varying(255) NOT NULL
);


ALTER TABLE public.wagtailredirects_redirect OWNER TO root;

--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailredirects_redirect_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailredirects_redirect_id_seq OWNER TO root;

--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailredirects_redirect_id_seq OWNED BY public.wagtailredirects_redirect.id;


--
-- Name: wagtailsearch_editorspick; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailsearch_editorspick (
    id integer NOT NULL,
    sort_order integer,
    description text NOT NULL,
    page_id integer NOT NULL,
    query_id integer NOT NULL
);


ALTER TABLE public.wagtailsearch_editorspick OWNER TO root;

--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailsearch_editorspick_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_editorspick_id_seq OWNER TO root;

--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailsearch_editorspick_id_seq OWNED BY public.wagtailsearch_editorspick.id;


--
-- Name: wagtailsearch_indexentry; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailsearch_indexentry (
    id integer NOT NULL,
    object_id character varying(50) NOT NULL,
    title_norm double precision NOT NULL,
    content_type_id integer NOT NULL,
    autocomplete tsvector NOT NULL,
    title tsvector NOT NULL,
    body tsvector NOT NULL
);


ALTER TABLE public.wagtailsearch_indexentry OWNER TO root;

--
-- Name: wagtailsearch_indexentry_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailsearch_indexentry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_indexentry_id_seq OWNER TO root;

--
-- Name: wagtailsearch_indexentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailsearch_indexentry_id_seq OWNED BY public.wagtailsearch_indexentry.id;


--
-- Name: wagtailsearch_query; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailsearch_query (
    id integer NOT NULL,
    query_string character varying(255) NOT NULL
);


ALTER TABLE public.wagtailsearch_query OWNER TO root;

--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailsearch_query_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_query_id_seq OWNER TO root;

--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailsearch_query_id_seq OWNED BY public.wagtailsearch_query.id;


--
-- Name: wagtailsearch_querydailyhits; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailsearch_querydailyhits (
    id integer NOT NULL,
    date date NOT NULL,
    hits integer NOT NULL,
    query_id integer NOT NULL
);


ALTER TABLE public.wagtailsearch_querydailyhits OWNER TO root;

--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailsearch_querydailyhits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_querydailyhits_id_seq OWNER TO root;

--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailsearch_querydailyhits_id_seq OWNED BY public.wagtailsearch_querydailyhits.id;


--
-- Name: wagtailstreamforms_form; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailstreamforms_form (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    template_name character varying(255) NOT NULL,
    fields text NOT NULL,
    submit_button_text character varying(100) NOT NULL,
    success_message character varying(255) NOT NULL,
    error_message character varying(255) NOT NULL,
    process_form_submission_hooks text NOT NULL,
    post_redirect_page_id integer,
    site_id integer
);


ALTER TABLE public.wagtailstreamforms_form OWNER TO root;

--
-- Name: wagtailstreamforms_form_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailstreamforms_form_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailstreamforms_form_id_seq OWNER TO root;

--
-- Name: wagtailstreamforms_form_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailstreamforms_form_id_seq OWNED BY public.wagtailstreamforms_form.id;


--
-- Name: wagtailstreamforms_formsubmission; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailstreamforms_formsubmission (
    id integer NOT NULL,
    form_data text NOT NULL,
    submit_time timestamp with time zone NOT NULL,
    form_id integer NOT NULL
);


ALTER TABLE public.wagtailstreamforms_formsubmission OWNER TO root;

--
-- Name: wagtailstreamforms_formsubmission_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailstreamforms_formsubmission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailstreamforms_formsubmission_id_seq OWNER TO root;

--
-- Name: wagtailstreamforms_formsubmission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailstreamforms_formsubmission_id_seq OWNED BY public.wagtailstreamforms_formsubmission.id;


--
-- Name: wagtailstreamforms_formsubmissionfile; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailstreamforms_formsubmissionfile (
    id integer NOT NULL,
    field character varying(255) NOT NULL,
    file character varying(100) NOT NULL,
    submission_id integer NOT NULL
);


ALTER TABLE public.wagtailstreamforms_formsubmissionfile OWNER TO root;

--
-- Name: wagtailstreamforms_formsubmissionfile_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailstreamforms_formsubmissionfile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailstreamforms_formsubmissionfile_id_seq OWNER TO root;

--
-- Name: wagtailstreamforms_formsubmissionfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailstreamforms_formsubmissionfile_id_seq OWNED BY public.wagtailstreamforms_formsubmissionfile.id;


--
-- Name: wagtailusers_userprofile; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.wagtailusers_userprofile (
    id integer NOT NULL,
    submitted_notifications boolean NOT NULL,
    approved_notifications boolean NOT NULL,
    rejected_notifications boolean NOT NULL,
    user_id integer NOT NULL,
    preferred_language character varying(10) NOT NULL,
    current_time_zone character varying(40) NOT NULL,
    avatar character varying(100) NOT NULL,
    updated_comments_notifications boolean NOT NULL
);


ALTER TABLE public.wagtailusers_userprofile OWNER TO root;

--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.wagtailusers_userprofile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailusers_userprofile_id_seq OWNER TO root;

--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.wagtailusers_userprofile_id_seq OWNED BY public.wagtailusers_userprofile.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: blog_blogcategory id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogcategory ALTER COLUMN id SET DEFAULT nextval('public.blog_blogcategory_id_seq'::regclass);


--
-- Name: blog_blogpostcard id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogpostcard ALTER COLUMN id SET DEFAULT nextval('public.blog_blogpostcard_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: taggit_tag id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_tag ALTER COLUMN id SET DEFAULT nextval('public.taggit_tag_id_seq'::regclass);


--
-- Name: taggit_taggeditem id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_taggeditem ALTER COLUMN id SET DEFAULT nextval('public.taggit_taggeditem_id_seq'::regclass);


--
-- Name: wagtailadmin_admin id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailadmin_admin ALTER COLUMN id SET DEFAULT nextval('public.wagtailadmin_admin_id_seq'::regclass);


--
-- Name: wagtailcore_collection id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collection ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collection_id_seq'::regclass);


--
-- Name: wagtailcore_collectionviewrestriction id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collectionviewrestriction_id_seq'::regclass);


--
-- Name: wagtailcore_collectionviewrestriction_groups id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_collectionviewrestriction_groups_id_seq'::regclass);


--
-- Name: wagtailcore_comment id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_comment ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_comment_id_seq'::regclass);


--
-- Name: wagtailcore_commentreply id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_commentreply ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_commentreply_id_seq'::regclass);


--
-- Name: wagtailcore_groupapprovaltask_groups id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_groupapprovaltask_groups_id_seq'::regclass);


--
-- Name: wagtailcore_groupcollectionpermission id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_groupcollectionpermission_id_seq'::regclass);


--
-- Name: wagtailcore_grouppagepermission id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_grouppagepermission_id_seq'::regclass);


--
-- Name: wagtailcore_locale id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_locale ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_locale_id_seq'::regclass);


--
-- Name: wagtailcore_modellogentry id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_modellogentry ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_modellogentry_id_seq'::regclass);


--
-- Name: wagtailcore_page id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_page_id_seq'::regclass);


--
-- Name: wagtailcore_pagelogentry id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagelogentry ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pagelogentry_id_seq'::regclass);


--
-- Name: wagtailcore_pagerevision id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagerevision ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pagerevision_id_seq'::regclass);


--
-- Name: wagtailcore_pagesubscription id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pagesubscription_id_seq'::regclass);


--
-- Name: wagtailcore_pageviewrestriction id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pageviewrestriction_id_seq'::regclass);


--
-- Name: wagtailcore_pageviewrestriction_groups id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_pageviewrestriction_groups_id_seq'::regclass);


--
-- Name: wagtailcore_site id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_site ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_site_id_seq'::regclass);


--
-- Name: wagtailcore_task id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_task ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_task_id_seq'::regclass);


--
-- Name: wagtailcore_taskstate id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_taskstate ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_taskstate_id_seq'::regclass);


--
-- Name: wagtailcore_workflow id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflow ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_workflow_id_seq'::regclass);


--
-- Name: wagtailcore_workflowstate id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowstate ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_workflowstate_id_seq'::regclass);


--
-- Name: wagtailcore_workflowtask id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowtask ALTER COLUMN id SET DEFAULT nextval('public.wagtailcore_workflowtask_id_seq'::regclass);


--
-- Name: wagtaildocs_document id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtaildocs_document ALTER COLUMN id SET DEFAULT nextval('public.wagtaildocs_document_id_seq'::regclass);


--
-- Name: wagtaildocs_uploadeddocument id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtaildocs_uploadeddocument ALTER COLUMN id SET DEFAULT nextval('public.wagtaildocs_uploadeddocument_id_seq'::regclass);


--
-- Name: wagtailembeds_embed id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailembeds_embed ALTER COLUMN id SET DEFAULT nextval('public.wagtailembeds_embed_id_seq'::regclass);


--
-- Name: wagtailforms_formsubmission id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailforms_formsubmission ALTER COLUMN id SET DEFAULT nextval('public.wagtailforms_formsubmission_id_seq'::regclass);


--
-- Name: wagtailimages_image id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_image ALTER COLUMN id SET DEFAULT nextval('public.wagtailimages_image_id_seq'::regclass);


--
-- Name: wagtailimages_rendition id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_rendition ALTER COLUMN id SET DEFAULT nextval('public.wagtailimages_rendition_id_seq'::regclass);


--
-- Name: wagtailimages_uploadedimage id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_uploadedimage ALTER COLUMN id SET DEFAULT nextval('public.wagtailimages_uploadedimage_id_seq'::regclass);


--
-- Name: wagtailredirects_redirect id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailredirects_redirect ALTER COLUMN id SET DEFAULT nextval('public.wagtailredirects_redirect_id_seq'::regclass);


--
-- Name: wagtailsearch_editorspick id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_editorspick ALTER COLUMN id SET DEFAULT nextval('public.wagtailsearch_editorspick_id_seq'::regclass);


--
-- Name: wagtailsearch_indexentry id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_indexentry ALTER COLUMN id SET DEFAULT nextval('public.wagtailsearch_indexentry_id_seq'::regclass);


--
-- Name: wagtailsearch_query id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_query ALTER COLUMN id SET DEFAULT nextval('public.wagtailsearch_query_id_seq'::regclass);


--
-- Name: wagtailsearch_querydailyhits id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_querydailyhits ALTER COLUMN id SET DEFAULT nextval('public.wagtailsearch_querydailyhits_id_seq'::regclass);


--
-- Name: wagtailstreamforms_form id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_form ALTER COLUMN id SET DEFAULT nextval('public.wagtailstreamforms_form_id_seq'::regclass);


--
-- Name: wagtailstreamforms_formsubmission id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_formsubmission ALTER COLUMN id SET DEFAULT nextval('public.wagtailstreamforms_formsubmission_id_seq'::regclass);


--
-- Name: wagtailstreamforms_formsubmissionfile id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_formsubmissionfile ALTER COLUMN id SET DEFAULT nextval('public.wagtailstreamforms_formsubmissionfile_id_seq'::regclass);


--
-- Name: wagtailusers_userprofile id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailusers_userprofile ALTER COLUMN id SET DEFAULT nextval('public.wagtailusers_userprofile_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.auth_group (id, name) FROM stdin;
1	Moderators
2	Editors
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	1
2	2	1
3	1	2
4	1	3
5	1	4
6	2	2
7	2	3
8	2	4
9	1	5
10	2	5
11	1	8
12	1	6
13	1	7
14	2	8
15	2	6
16	2	7
17	1	9
18	2	9
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can access Wagtail admin	5	access_admin
2	Can add document	6	add_document
3	Can change document	6	change_document
4	Can delete document	6	delete_document
5	Can choose document	6	choose_document
6	Can add image	7	add_image
7	Can change image	7	change_image
8	Can delete image	7	delete_image
9	Can choose image	7	choose_image
10	Can add Form	8	add_form
11	Can change Form	8	change_form
12	Can delete Form	8	delete_form
13	Can view Form	8	view_form
14	Can add Form submission	9	add_formsubmission
15	Can change Form submission	9	change_formsubmission
16	Can delete Form submission	9	delete_formsubmission
17	Can view Form submission	9	view_formsubmission
18	Can add Form submission file	10	add_formsubmissionfile
19	Can change Form submission file	10	change_formsubmissionfile
20	Can delete Form submission file	10	delete_formsubmissionfile
21	Can view Form submission file	10	view_formsubmissionfile
22	Can add landing page	3	add_landingpage
23	Can change landing page	3	change_landingpage
24	Can delete landing page	3	delete_landingpage
25	Can view landing page	3	view_landingpage
26	Can add surveys page	4	add_surveyspage
27	Can change surveys page	4	change_surveyspage
28	Can delete surveys page	4	delete_surveyspage
29	Can view surveys page	4	view_surveyspage
30	Can add blog category	11	add_blogcategory
31	Can change blog category	11	change_blogcategory
32	Can delete blog category	11	delete_blogcategory
33	Can view blog category	11	view_blogcategory
34	Can add blog index page	12	add_blogindexpage
35	Can change blog index page	12	change_blogindexpage
36	Can delete blog index page	12	delete_blogindexpage
37	Can view blog index page	12	view_blogindexpage
38	Can add blog post	13	add_blogpost
39	Can change blog post	13	change_blogpost
40	Can delete blog post	13	delete_blogpost
41	Can view blog post	13	view_blogpost
42	Can add blog post card	14	add_blogpostcard
43	Can change blog post card	14	change_blogpostcard
44	Can delete blog post card	14	delete_blogpostcard
45	Can view blog post card	14	view_blogpostcard
46	Can add form submission	15	add_formsubmission
47	Can change form submission	15	change_formsubmission
48	Can delete form submission	15	delete_formsubmission
49	Can view form submission	15	view_formsubmission
50	Can add redirect	16	add_redirect
51	Can change redirect	16	change_redirect
52	Can delete redirect	16	delete_redirect
53	Can view redirect	16	view_redirect
54	Can add embed	17	add_embed
55	Can change embed	17	change_embed
56	Can delete embed	17	delete_embed
57	Can view embed	17	view_embed
58	Can add user profile	18	add_userprofile
59	Can change user profile	18	change_userprofile
60	Can delete user profile	18	delete_userprofile
61	Can view user profile	18	view_userprofile
62	Can view document	6	view_document
63	Can add uploaded document	19	add_uploadeddocument
64	Can change uploaded document	19	change_uploadeddocument
65	Can delete uploaded document	19	delete_uploadeddocument
66	Can view uploaded document	19	view_uploadeddocument
67	Can view image	7	view_image
68	Can add rendition	20	add_rendition
69	Can change rendition	20	change_rendition
70	Can delete rendition	20	delete_rendition
71	Can view rendition	20	view_rendition
72	Can add uploaded image	21	add_uploadedimage
73	Can change uploaded image	21	change_uploadedimage
74	Can delete uploaded image	21	delete_uploadedimage
75	Can view uploaded image	21	view_uploadedimage
76	Can add query	22	add_query
77	Can change query	22	change_query
78	Can delete query	22	delete_query
79	Can view query	22	view_query
80	Can add Query Daily Hits	23	add_querydailyhits
81	Can change Query Daily Hits	23	change_querydailyhits
82	Can delete Query Daily Hits	23	delete_querydailyhits
83	Can view Query Daily Hits	23	view_querydailyhits
84	Can add index entry	24	add_indexentry
85	Can change index entry	24	change_indexentry
86	Can delete index entry	24	delete_indexentry
87	Can view index entry	24	view_indexentry
88	Can add page	1	add_page
89	Can change page	1	change_page
90	Can delete page	1	delete_page
91	Can view page	1	view_page
92	Can add group page permission	25	add_grouppagepermission
93	Can change group page permission	25	change_grouppagepermission
94	Can delete group page permission	25	delete_grouppagepermission
95	Can view group page permission	25	view_grouppagepermission
96	Can add page revision	26	add_pagerevision
97	Can change page revision	26	change_pagerevision
98	Can delete page revision	26	delete_pagerevision
99	Can view page revision	26	view_pagerevision
100	Can add page view restriction	27	add_pageviewrestriction
101	Can change page view restriction	27	change_pageviewrestriction
102	Can delete page view restriction	27	delete_pageviewrestriction
103	Can view page view restriction	27	view_pageviewrestriction
104	Can add site	28	add_site
105	Can change site	28	change_site
106	Can delete site	28	delete_site
107	Can view site	28	view_site
108	Can add collection	29	add_collection
109	Can change collection	29	change_collection
110	Can delete collection	29	delete_collection
111	Can view collection	29	view_collection
112	Can add group collection permission	30	add_groupcollectionpermission
113	Can change group collection permission	30	change_groupcollectionpermission
114	Can delete group collection permission	30	delete_groupcollectionpermission
115	Can view group collection permission	30	view_groupcollectionpermission
116	Can add collection view restriction	31	add_collectionviewrestriction
117	Can change collection view restriction	31	change_collectionviewrestriction
118	Can delete collection view restriction	31	delete_collectionviewrestriction
119	Can view collection view restriction	31	view_collectionviewrestriction
120	Can add task	32	add_task
121	Can change task	32	change_task
122	Can delete task	32	delete_task
123	Can view task	32	view_task
124	Can add Task state	33	add_taskstate
125	Can change Task state	33	change_taskstate
126	Can delete Task state	33	delete_taskstate
127	Can view Task state	33	view_taskstate
128	Can add workflow	34	add_workflow
129	Can change workflow	34	change_workflow
130	Can delete workflow	34	delete_workflow
131	Can view workflow	34	view_workflow
132	Can add Group approval task	2	add_groupapprovaltask
133	Can change Group approval task	2	change_groupapprovaltask
134	Can delete Group approval task	2	delete_groupapprovaltask
135	Can view Group approval task	2	view_groupapprovaltask
136	Can add Workflow state	35	add_workflowstate
137	Can change Workflow state	35	change_workflowstate
138	Can delete Workflow state	35	delete_workflowstate
139	Can view Workflow state	35	view_workflowstate
140	Can add workflow page	36	add_workflowpage
141	Can change workflow page	36	change_workflowpage
142	Can delete workflow page	36	delete_workflowpage
143	Can view workflow page	36	view_workflowpage
144	Can add workflow task order	37	add_workflowtask
145	Can change workflow task order	37	change_workflowtask
146	Can delete workflow task order	37	delete_workflowtask
147	Can view workflow task order	37	view_workflowtask
148	Can add page log entry	38	add_pagelogentry
149	Can change page log entry	38	change_pagelogentry
150	Can delete page log entry	38	delete_pagelogentry
151	Can view page log entry	38	view_pagelogentry
152	Can add locale	39	add_locale
153	Can change locale	39	change_locale
154	Can delete locale	39	delete_locale
155	Can view locale	39	view_locale
156	Can add comment	40	add_comment
157	Can change comment	40	change_comment
158	Can delete comment	40	delete_comment
159	Can view comment	40	view_comment
160	Can add comment reply	41	add_commentreply
161	Can change comment reply	41	change_commentreply
162	Can delete comment reply	41	delete_commentreply
163	Can view comment reply	41	view_commentreply
164	Can add page subscription	42	add_pagesubscription
165	Can change page subscription	42	change_pagesubscription
166	Can delete page subscription	42	delete_pagesubscription
167	Can view page subscription	42	view_pagesubscription
168	Can add model log entry	43	add_modellogentry
169	Can change model log entry	43	change_modellogentry
170	Can delete model log entry	43	delete_modellogentry
171	Can view model log entry	43	view_modellogentry
172	Can add tag	44	add_tag
173	Can change tag	44	change_tag
174	Can delete tag	44	delete_tag
175	Can view tag	44	view_tag
176	Can add tagged item	45	add_taggeditem
177	Can change tagged item	45	change_taggeditem
178	Can delete tagged item	45	delete_taggeditem
179	Can view tagged item	45	view_taggeditem
180	Can add log entry	46	add_logentry
181	Can change log entry	46	change_logentry
182	Can delete log entry	46	delete_logentry
183	Can view log entry	46	view_logentry
184	Can add permission	47	add_permission
185	Can change permission	47	change_permission
186	Can delete permission	47	delete_permission
187	Can view permission	47	view_permission
188	Can add group	48	add_group
189	Can change group	48	change_group
190	Can delete group	48	delete_group
191	Can view group	48	view_group
192	Can add user	49	add_user
193	Can change user	49	change_user
194	Can delete user	49	delete_user
195	Can view user	49	view_user
196	Can add content type	50	add_contenttype
197	Can change content type	50	change_contenttype
198	Can delete content type	50	delete_contenttype
199	Can view content type	50	view_contenttype
200	Can add session	51	add_session
201	Can change session	51	change_session
202	Can delete session	51	delete_session
203	Can view session	51	view_session
204	Can add candidate page	52	add_candidatepage
205	Can change candidate page	52	change_candidatepage
206	Can delete candidate page	52	delete_candidatepage
207	Can view candidate page	52	view_candidatepage
208	Can add candidate index page	53	add_candidateindexpage
209	Can change candidate index page	53	change_candidateindexpage
210	Can delete candidate index page	53	delete_candidateindexpage
211	Can view candidate index page	53	view_candidateindexpage
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$260000$wBK4QL3pKHU5SkDNriluil$6NR4LRKyuSo4QWAHW8WIj3AovWxFzcefvTwVtzkRHAI=	2022-07-05 19:48:19.186983+00	t	dadocapital			admin@dadocapital.org.br	t	t	2022-06-27 20:03:14.049533+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: blog_blogcategory; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blog_blogcategory (id, name, color, icon) FROM stdin;
1	Atualizações	#22d871	fa-solid fa-newspaper
\.


--
-- Data for Name: blog_blogindexpage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blog_blogindexpage (page_ptr_id, sidebar_panels) FROM stdin;
6	[]
\.


--
-- Data for Name: blog_blogpost; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blog_blogpost (page_ptr_id, date, intro_text, body, cover_image, category_id) FROM stdin;
7	2022-07-01	O Painel oferecerá informações sobre como os candidatos à reeleição (Senado e Câmara) se posicionaram frente às principais votações nos temas de Clima & Meio Ambiente durante a atual legislatura (2019/2022) bem como sobre proposições legislativas por	<p data-block-key="espig">O Painel Farol Verde é uma iniciativa do Instituto Democracia e Sustentabilidade (IDS) em parceria com o GT Socioambiental da Rede de Advocacy Colaborativo (RAC) e com algumas das mais importantes organizações e redes da sociedade civil. O objetivo do Painel é oferecer aos eleitores de todo o país informações e dados qualificados e confiáveis sobre os posicionamentos públicos e opiniões de (pré)candidatos(as) à Câmara Federal e ao Senado a respeito das pautas de Mudança Climática, Meio Ambiente, Direitos Socioambientais e Sustentabilidade.</p><p data-block-key="4arvl">O propósito do Painel Farol Verde é promover transparência e divulgar dados públicos disponíveis a respeito do posicionamento de candidatos ao legislativo federal nas eleições de 2022 comprometidos ou que estejam tratando dos temas de Mudança Climática, Meio Ambiente, Direitos Socioambientais e Sustentabilidade para clarear e iluminar aos eleitores e eleitoras de todo o país, ampliando suas opções para um voto mais consciente e consequente em relação ao Clima, Meio Ambiente e Desenvolvimento Sustentável no Brasil.</p><p data-block-key="34iuj">O Painel oferecerá informações sobre como os candidatos à reeleição (Senado e Câmara) se posicionaram frente às principais votações nos temas de Clima &amp; Meio Ambiente durante a atual legislatura (2019/2022) bem como sobre proposições legislativas por eles apresentadas e seus posicionamentos nas redes sociais sobre os temas de interesse do painel.</p><p data-block-key="e8hb9">O Painel Farol Verde também vai oferecer informações sobre os novos candidatos ou candidatos que ainda não tem mandato no legislativo federal que aderirem ao Painel e preencherem uma enquete com 12 perguntas sobre o seu posicionamento a respeito de vários temas ligados à pauta climática e socioambiental. A enquete tem perguntas sobre desmatamento zero nos biomas brasileiros, reforma tributária verde, moratória da soja no Pantanal, liberação de caça de animais silvestres, proteção constitucional da água e do clima como direitos fundamentais, apoio ao fundo de restauração da Mata Atlântica, regularização fundiária na Amazônia, liberação de agrotóxicos, desincentivo ao consumo de produtos prejudiciais à saúde e meio ambiente, incentivo ao uso público de unidades de conservação e retomada de demarcação de terras indígenas em todo País.</p><p data-block-key="34edd">Com base nos dados e informações disponíveis no Painel Farol Verde, de forma prática e ágil em um único portal, o eleitor e a eleitora brasileiros de todos os estados poderão pesquisar as candidaturas e considerar de forma responsável as pautas de Clima, Meio Ambiente, Direitos Socioambientais e Sustentabilidade na hora do seu importante e decisivo voto para deputado federal ou senado. </p><p data-block-key="hbh5">Sabemos que se o Brasil vier a ter, o que esperamos que venha a ter, um novo Presidente da República aliado e favorável às pautas de Clima &amp; Sustentabilidade, será absolutamente crucial e determinante que o congresso nacional jogue a favor e esteja em maior sintonia com as pautas referidas. Por isso fazemos dois importantes convites: </p><p data-block-key="65nh8">1 - Aos pré-candidatos e pré-candidatas a deputado(a) federal ou senador(a) em todo Brasil que têm compromissos públicos com as pautas aqui tratadas, estejam convidad@s a participar do Painel. Para tanto, preencham a enquete e ofereçam informações sobre seus posicionamentos a respeito dos temas de interesse por intermédio do Painel Farol Verde.</p><p data-block-key="b5f81">2 - A todos os eleitores e eleitoras, que pesquisem no Painel Farol Verde candidat@s em sintonia positiva com os temas aqui tratados (Clima &amp; Meio Ambiente) e @s convidem a participar do Painel, respondendo à Enquete. </p><p data-block-key="crvj2"><b>Se você é +1 pelo Clima, pelo Meio Ambiente e pela Sustentabilidade, consulte o Farol Verde antes de votar para o Congresso Nacional.</b></p><p data-block-key="6occ"><b>Divulgue o Painel aos seus candidatos(as) e também aos seus amigos e amigas, eleitores, e faça a diferença nessas eleições. </b></p>	placeholder_1.png	1
\.


--
-- Data for Name: blog_blogpostcard; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.blog_blogpostcard (id, content_object_id, tag_id) FROM stdin;
\.


--
-- Data for Name: candidate_candidateindexpage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.candidate_candidateindexpage (page_ptr_id, description) FROM stdin;
\.


--
-- Data for Name: candidate_candidatepage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.candidate_candidatepage (page_ptr_id, id_autor, id_parlametria, id_serenata, name) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	wagtailcore	page
2	wagtailcore	groupapprovaltask
3	home	landingpage
4	home	surveyspage
5	wagtailadmin	admin
6	wagtaildocs	document
7	wagtailimages	image
8	wagtailstreamforms	form
9	wagtailstreamforms	formsubmission
10	wagtailstreamforms	formsubmissionfile
11	blog	blogcategory
12	blog	blogindexpage
13	blog	blogpost
14	blog	blogpostcard
15	wagtailforms	formsubmission
16	wagtailredirects	redirect
17	wagtailembeds	embed
18	wagtailusers	userprofile
19	wagtaildocs	uploadeddocument
20	wagtailimages	rendition
21	wagtailimages	uploadedimage
22	wagtailsearch	query
23	wagtailsearch	querydailyhits
24	wagtailsearch	indexentry
25	wagtailcore	grouppagepermission
26	wagtailcore	pagerevision
27	wagtailcore	pageviewrestriction
28	wagtailcore	site
29	wagtailcore	collection
30	wagtailcore	groupcollectionpermission
31	wagtailcore	collectionviewrestriction
32	wagtailcore	task
33	wagtailcore	taskstate
34	wagtailcore	workflow
35	wagtailcore	workflowstate
36	wagtailcore	workflowpage
37	wagtailcore	workflowtask
38	wagtailcore	pagelogentry
39	wagtailcore	locale
40	wagtailcore	comment
41	wagtailcore	commentreply
42	wagtailcore	pagesubscription
43	wagtailcore	modellogentry
44	taggit	tag
45	taggit	taggeditem
46	admin	logentry
47	auth	permission
48	auth	group
49	auth	user
50	contenttypes	contenttype
51	sessions	session
52	candidate	candidatepage
53	candidate	candidateindexpage
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-06-27 20:01:29.315381+00
2	auth	0001_initial	2022-06-27 20:01:29.566573+00
3	admin	0001_initial	2022-06-27 20:01:29.623439+00
4	admin	0002_logentry_remove_auto_add	2022-06-27 20:01:29.636526+00
5	admin	0003_logentry_add_action_flag_choices	2022-06-27 20:01:29.646392+00
6	contenttypes	0002_remove_content_type_name	2022-06-27 20:01:29.719038+00
7	auth	0002_alter_permission_name_max_length	2022-06-27 20:01:29.729193+00
8	auth	0003_alter_user_email_max_length	2022-06-27 20:01:29.739227+00
9	auth	0004_alter_user_username_opts	2022-06-27 20:01:29.748957+00
10	auth	0005_alter_user_last_login_null	2022-06-27 20:01:29.758824+00
11	auth	0006_require_contenttypes_0002	2022-06-27 20:01:29.761158+00
12	auth	0007_alter_validators_add_error_messages	2022-06-27 20:01:29.770292+00
13	auth	0008_alter_user_username_max_length	2022-06-27 20:01:29.792763+00
14	auth	0009_alter_user_last_name_max_length	2022-06-27 20:01:29.804761+00
15	auth	0010_alter_group_name_max_length	2022-06-27 20:01:29.816706+00
16	auth	0011_update_proxy_permissions	2022-06-27 20:01:29.829206+00
17	auth	0012_alter_user_first_name_max_length	2022-06-27 20:01:29.839938+00
18	wagtailcore	0001_initial	2022-06-27 20:01:30.267766+00
19	wagtailcore	0002_initial_data	2022-06-27 20:01:30.269896+00
20	wagtailcore	0003_add_uniqueness_constraint_on_group_page_permission	2022-06-27 20:01:30.271713+00
21	wagtailcore	0004_page_locked	2022-06-27 20:01:30.27345+00
22	wagtailcore	0005_add_page_lock_permission_to_moderators	2022-06-27 20:01:30.275243+00
23	wagtailcore	0006_add_lock_page_permission	2022-06-27 20:01:30.276984+00
24	wagtailcore	0007_page_latest_revision_created_at	2022-06-27 20:01:30.278725+00
25	wagtailcore	0008_populate_latest_revision_created_at	2022-06-27 20:01:30.280503+00
26	wagtailcore	0009_remove_auto_now_add_from_pagerevision_created_at	2022-06-27 20:01:30.282241+00
27	wagtailcore	0010_change_page_owner_to_null_on_delete	2022-06-27 20:01:30.28394+00
28	wagtailcore	0011_page_first_published_at	2022-06-27 20:01:30.285674+00
29	wagtailcore	0012_extend_page_slug_field	2022-06-27 20:01:30.287365+00
30	wagtailcore	0013_update_golive_expire_help_text	2022-06-27 20:01:30.289137+00
31	wagtailcore	0014_add_verbose_name	2022-06-27 20:01:30.290865+00
32	wagtailcore	0015_add_more_verbose_names	2022-06-27 20:01:30.29255+00
33	wagtailcore	0016_change_page_url_path_to_text_field	2022-06-27 20:01:30.294316+00
34	wagtailredirects	0001_initial	2022-06-27 20:01:30.365755+00
35	wagtailredirects	0002_add_verbose_names	2022-06-27 20:01:30.393689+00
36	wagtailredirects	0003_make_site_field_editable	2022-06-27 20:01:30.409519+00
37	wagtailredirects	0004_set_unique_on_path_and_site	2022-06-27 20:01:30.453787+00
38	wagtailredirects	0005_capitalizeverbose	2022-06-27 20:01:30.525217+00
39	wagtailredirects	0006_redirect_increase_max_length	2022-06-27 20:01:30.546136+00
40	wagtailredirects	0007_add_autocreate_fields	2022-06-27 20:01:30.581561+00
41	wagtailforms	0001_initial	2022-06-27 20:01:30.654611+00
42	wagtailforms	0002_add_verbose_names	2022-06-27 20:01:30.681183+00
43	wagtailforms	0003_capitalizeverbose	2022-06-27 20:01:30.703552+00
44	wagtailforms	0004_add_verbose_name_plural	2022-06-27 20:01:30.715871+00
45	wagtailcore	0017_change_edit_page_permission_description	2022-06-27 20:01:30.732301+00
46	wagtailcore	0018_pagerevision_submitted_for_moderation_index	2022-06-27 20:01:30.765008+00
47	wagtailcore	0019_verbose_names_cleanup	2022-06-27 20:01:30.828106+00
48	wagtailcore	0020_add_index_on_page_first_published_at	2022-06-27 20:01:30.851008+00
49	wagtailcore	0021_capitalizeverbose	2022-06-27 20:01:31.307303+00
50	wagtailcore	0022_add_site_name	2022-06-27 20:01:31.330051+00
51	wagtailcore	0023_alter_page_revision_on_delete_behaviour	2022-06-27 20:01:31.346226+00
52	wagtailcore	0024_collection	2022-06-27 20:01:31.385745+00
53	wagtailcore	0025_collection_initial_data	2022-06-27 20:01:31.408841+00
54	wagtailcore	0026_group_collection_permission	2022-06-27 20:01:31.489463+00
55	wagtailcore	0027_fix_collection_path_collation	2022-06-27 20:01:31.52035+00
56	wagtailcore	0024_alter_page_content_type_on_delete_behaviour	2022-06-27 20:01:31.544972+00
57	wagtailcore	0028_merge	2022-06-27 20:01:31.547559+00
58	wagtailcore	0029_unicode_slugfield_dj19	2022-06-27 20:01:31.563244+00
59	wagtailcore	0030_index_on_pagerevision_created_at	2022-06-27 20:01:31.584773+00
60	wagtailcore	0031_add_page_view_restriction_types	2022-06-27 20:01:31.683864+00
61	wagtailcore	0032_add_bulk_delete_page_permission	2022-06-27 20:01:31.70042+00
62	wagtailcore	0033_remove_golive_expiry_help_text	2022-06-27 20:01:31.73257+00
63	wagtailcore	0034_page_live_revision	2022-06-27 20:01:31.759438+00
64	wagtailcore	0035_page_last_published_at	2022-06-27 20:01:31.776304+00
65	wagtailcore	0036_populate_page_last_published_at	2022-06-27 20:01:31.798074+00
66	wagtailcore	0037_set_page_owner_editable	2022-06-27 20:01:31.817809+00
67	wagtailcore	0038_make_first_published_at_editable	2022-06-27 20:01:31.834809+00
68	wagtailcore	0039_collectionviewrestriction	2022-06-27 20:01:32.012829+00
69	wagtailcore	0040_page_draft_title	2022-06-27 20:01:32.051054+00
70	wagtailcore	0041_group_collection_permissions_verbose_name_plural	2022-06-27 20:01:32.067917+00
71	wagtailcore	0042_index_on_pagerevision_approved_go_live_at	2022-06-27 20:01:32.091923+00
72	wagtailcore	0043_lock_fields	2022-06-27 20:01:32.138756+00
73	wagtailcore	0044_add_unlock_grouppagepermission	2022-06-27 20:01:32.158052+00
74	wagtailcore	0045_assign_unlock_grouppagepermission	2022-06-27 20:01:32.18786+00
75	wagtailcore	0046_site_name_remove_null	2022-06-27 20:01:32.206988+00
76	wagtailcore	0047_add_workflow_models	2022-06-27 20:01:32.684871+00
77	wagtailcore	0048_add_default_workflows	2022-06-27 20:01:32.792087+00
78	wagtailcore	0049_taskstate_finished_by	2022-06-27 20:01:32.829766+00
79	wagtailcore	0050_workflow_rejected_to_needs_changes	2022-06-27 20:01:32.899126+00
80	wagtailcore	0051_taskstate_comment	2022-06-27 20:01:32.932072+00
81	wagtailcore	0052_pagelogentry	2022-06-27 20:01:33.028733+00
82	wagtailcore	0053_locale_model	2022-06-27 20:01:33.057934+00
83	wagtailcore	0054_initial_locale	2022-06-27 20:01:33.091529+00
84	wagtailcore	0055_page_locale_fields	2022-06-27 20:01:33.259351+00
85	wagtailcore	0056_page_locale_fields_populate	2022-06-27 20:01:33.292918+00
86	wagtailcore	0057_page_locale_fields_notnull	2022-06-27 20:01:33.360897+00
87	wagtailcore	0058_page_alias_of	2022-06-27 20:01:33.401958+00
88	wagtailcore	0059_apply_collection_ordering	2022-06-27 20:01:33.433175+00
89	wagtailcore	0060_fix_workflow_unique_constraint	2022-06-27 20:01:33.486892+00
90	wagtailcore	0061_change_promote_tab_helpt_text_and_verbose_names	2022-06-27 20:01:33.535619+00
91	wagtailcore	0062_comment_models_and_pagesubscription	2022-06-27 20:01:33.796907+00
92	wagtailcore	0063_modellogentry	2022-06-27 20:01:33.899551+00
93	wagtailcore	0064_log_timestamp_indexes	2022-06-27 20:01:33.960767+00
94	wagtailcore	0065_log_entry_uuid	2022-06-27 20:01:34.009723+00
95	wagtailcore	0066_collection_management_permissions	2022-06-27 20:01:34.06047+00
96	taggit	0001_initial	2022-06-27 20:01:34.177836+00
97	taggit	0002_auto_20150616_2121	2022-06-27 20:01:34.1994+00
98	taggit	0003_taggeditem_add_unique_index	2022-06-27 20:01:34.230759+00
99	taggit	0004_alter_taggeditem_content_type_alter_taggeditem_tag	2022-06-27 20:01:34.383666+00
100	home	0001_initial	2022-06-27 20:01:34.595489+00
101	blog	0001_initial	2022-06-27 20:01:35.129939+00
102	home	0002_create_surveys_and_remove_fields	2022-06-27 20:01:35.425694+00
103	sessions	0001_initial	2022-06-27 20:01:35.464055+00
104	wagtailadmin	0001_create_admin_access_permissions	2022-06-27 20:01:35.517771+00
105	wagtailadmin	0002_admin	2022-06-27 20:01:35.522826+00
106	wagtailadmin	0003_admin_managed	2022-06-27 20:01:35.542995+00
107	wagtaildocs	0001_initial	2022-06-27 20:01:35.612314+00
108	wagtaildocs	0002_initial_data	2022-06-27 20:01:35.665105+00
109	wagtaildocs	0003_add_verbose_names	2022-06-27 20:01:35.750502+00
110	wagtaildocs	0004_capitalizeverbose	2022-06-27 20:01:35.916213+00
111	wagtaildocs	0005_document_collection	2022-06-27 20:01:35.975627+00
112	wagtaildocs	0006_copy_document_permissions_to_collections	2022-06-27 20:01:36.031998+00
113	wagtaildocs	0005_alter_uploaded_by_user_on_delete_action	2022-06-27 20:01:36.076554+00
114	wagtaildocs	0007_merge	2022-06-27 20:01:36.079297+00
115	wagtaildocs	0008_document_file_size	2022-06-27 20:01:36.108188+00
116	wagtaildocs	0009_document_verbose_name_plural	2022-06-27 20:01:36.138108+00
117	wagtaildocs	0010_document_file_hash	2022-06-27 20:01:36.167481+00
118	wagtaildocs	0011_add_choose_permissions	2022-06-27 20:01:36.374158+00
119	wagtaildocs	0012_uploadeddocument	2022-06-27 20:01:36.440949+00
120	wagtailembeds	0001_initial	2022-06-27 20:01:36.476905+00
121	wagtailembeds	0002_add_verbose_names	2022-06-27 20:01:36.499045+00
122	wagtailembeds	0003_capitalizeverbose	2022-06-27 20:01:36.50517+00
123	wagtailembeds	0004_embed_verbose_name_plural	2022-06-27 20:01:36.510395+00
124	wagtailembeds	0005_specify_thumbnail_url_max_length	2022-06-27 20:01:36.51677+00
125	wagtailembeds	0006_add_embed_hash	2022-06-27 20:01:36.523215+00
126	wagtailembeds	0007_populate_hash	2022-06-27 20:01:36.570326+00
127	wagtailembeds	0008_allow_long_urls	2022-06-27 20:01:36.618389+00
128	wagtailembeds	0009_embed_cache_until	2022-06-27 20:01:36.635586+00
129	wagtailimages	0001_initial	2022-06-27 20:01:36.933166+00
130	wagtailimages	0002_initial_data	2022-06-27 20:01:36.935283+00
131	wagtailimages	0003_fix_focal_point_fields	2022-06-27 20:01:36.937276+00
132	wagtailimages	0004_make_focal_point_key_not_nullable	2022-06-27 20:01:36.939249+00
133	wagtailimages	0005_make_filter_spec_unique	2022-06-27 20:01:36.941159+00
134	wagtailimages	0006_add_verbose_names	2022-06-27 20:01:36.943176+00
135	wagtailimages	0007_image_file_size	2022-06-27 20:01:36.94525+00
136	wagtailimages	0008_image_created_at_index	2022-06-27 20:01:36.947376+00
137	wagtailimages	0009_capitalizeverbose	2022-06-27 20:01:36.949334+00
138	wagtailimages	0010_change_on_delete_behaviour	2022-06-27 20:01:36.951216+00
139	wagtailimages	0011_image_collection	2022-06-27 20:01:36.953063+00
140	wagtailimages	0012_copy_image_permissions_to_collections	2022-06-27 20:01:36.954952+00
141	wagtailimages	0013_make_rendition_upload_callable	2022-06-27 20:01:36.956941+00
142	wagtailimages	0014_add_filter_spec_field	2022-06-27 20:01:36.958846+00
143	wagtailimages	0015_fill_filter_spec_field	2022-06-27 20:01:36.960947+00
144	wagtailimages	0016_deprecate_rendition_filter_relation	2022-06-27 20:01:36.962858+00
145	wagtailimages	0017_reduce_focal_point_key_max_length	2022-06-27 20:01:36.964895+00
146	wagtailimages	0018_remove_rendition_filter	2022-06-27 20:01:36.966832+00
147	wagtailimages	0019_delete_filter	2022-06-27 20:01:36.968843+00
148	wagtailimages	0020_add-verbose-name	2022-06-27 20:01:36.97076+00
149	wagtailimages	0021_image_file_hash	2022-06-27 20:01:36.972638+00
150	wagtailimages	0022_uploadedimage	2022-06-27 20:01:37.04224+00
151	wagtailimages	0023_add_choose_permissions	2022-06-27 20:01:37.171325+00
152	wagtailsearch	0001_initial	2022-06-27 20:01:37.470841+00
153	wagtailsearch	0002_add_verbose_names	2022-06-27 20:01:37.570063+00
154	wagtailsearch	0003_remove_editors_pick	2022-06-27 20:01:37.619761+00
155	wagtailsearch	0004_querydailyhits_verbose_name_plural	2022-06-27 20:01:37.627821+00
156	wagtailsearch	0005_create_indexentry	2022-06-27 20:01:37.71876+00
157	wagtailsearch	0006_customise_indexentry	2022-06-27 20:01:37.828192+00
158	wagtailstreamforms	0001_initial	2022-06-27 20:01:38.084071+00
159	wagtailstreamforms	0002_form_site	2022-06-27 20:01:38.146514+00
160	wagtailusers	0001_initial	2022-06-27 20:01:38.225189+00
161	wagtailusers	0002_add_verbose_name_on_userprofile	2022-06-27 20:01:38.395122+00
162	wagtailusers	0003_add_verbose_names	2022-06-27 20:01:38.42062+00
163	wagtailusers	0004_capitalizeverbose	2022-06-27 20:01:38.519105+00
164	wagtailusers	0005_make_related_name_wagtail_specific	2022-06-27 20:01:38.570048+00
165	wagtailusers	0006_userprofile_prefered_language	2022-06-27 20:01:38.596653+00
166	wagtailusers	0007_userprofile_current_time_zone	2022-06-27 20:01:38.624424+00
167	wagtailusers	0008_userprofile_avatar	2022-06-27 20:01:38.651185+00
168	wagtailusers	0009_userprofile_verbose_name_plural	2022-06-27 20:01:38.676191+00
169	wagtailusers	0010_userprofile_updated_comments_notifications	2022-06-27 20:01:38.704928+00
170	wagtailimages	0001_squashed_0021	2022-06-27 20:01:38.711627+00
171	wagtailcore	0001_squashed_0016_change_page_url_path_to_text_field	2022-06-27 20:01:38.713716+00
172	candidate	0001_initial	2022-07-01 20:01:52.034029+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
wnc57vfv5lo8g22u68rp02nz0t39tztj	.eJxVjEEOwiAQRe_C2pBpC7S4dO8ZyMAMFjVgSptojHe3TbrQ7X_vv7dwuMyjWypPLpE4ikYcfjeP4cZ5A3TFfCkylDxPyctNkTut8lyI76fd_QuMWMf1HahjDzywt9Yg2dChJmN06zHqXqnYel4JxwG175sOQEdFAARKse1hi1auNZXs-PlI00scmxasAfh8ATl4QKg:1o5v27:awANHWUESIBCu5_XBWywIrby3yfsyQE8DfIlrdvektY	2022-07-11 20:08:31.052288+00
0ovwfqixazybhlzh69lv07l8bc782qna	.eJztW_tP47gW_l-Qyi-eVkn6XokfSoGFGQodymM0VyvkJG7qNomL82Bgdf_3e46dPkl3Z3aHu3CvpWFIbMc-Po_vHPsTv-_d0yyd3GcJk_fc3_tlz977sN7mUm_GYuzwpzQORM0TcSq5W8MhtaI3qQ2Ez8LDYuzGBBOaTOBrz68z12Id5na7Lep3vTpt-q1W03HpuNluNMaOy6CHjTu06bbtumU1xw3fsnyr0WDdtoWTJixJuIjv2bc5l097v1gf9h5pkFIeVueS5Zw9Vut7v_xrz0vkOOK-H7JHKlkqQKgDe14fym6afEse8yev4d6dtL82r49PHk9bvHdhecnZSSBvB3fOaf4taH8ZPPpHH3ucDh3f7sjLMNqP2bf0YD_lacgOTqgUIbll0mf7E0Z9HgcHlfZhxXHcUHizBB4q9V6leagbZ-ypaHEc0Z01H_DN6cP_KUy67Ko0-_HyZzniac6WI7I4SZ9C5i97fTZPJ7rb0i08DnnMRjjsCuzF1mRpHukhLIZdPO3q9WlKi1YQvn2E_6DjxUZ8tx1OyjdySeZSzCv9euWwnvBUEF-QIQWxQrKmOYIDel0cG4mcSZJKGidzKlV7L_Y4JYz4PM_CgEriU18kRM_ac0PuwZvPk7mI1fijnPGEUCJZMmfFmnORcA8chkawZWhhxKOxz2GH8C0VJGQBT0Ka8lyQMfOZpCGsmLAYliIxTQgLGVezt9WyTZbgJI7lOMQTEQrOUo5iiYw8ZIywJGVTGuFOUlgJhUhIyiKqvhtkPtXCtqGhH_JIvdgp9ygYok8GjAvSi1wO4jJsOOIS95KQkYB9UN1DYZ-MjDJYC15cHsKGYHZQHCVeCA4PymKEh1nEY3ikQu8jFaAa6CietUipUKbRGlQy0GgeciV7ksEYbca1_atlsojkAjQaoSwACImnRIbZ8YWBKtRbBNYI6WqCXl2g2nHn9MV-4eMjBrrPRZhzbbBij1pLOXhPLMghSM7DWu01AkT5uBiPE1b4st3U34QsDhbT2B3dphZaLnx4eX6ELxAsfz3MNr8c0PnWgP0kzIKDCXhd1dlPmLjXaASPVHqTe58lnuTzFDz-YD8Q9yHP2T0F0FJ4qR_BbVG3SfX68rp3fn9yeTUYHVir5rOLs-uzso7B2cX9xc2gpKP3Za1j74PdarbaVsdutGttx7Jb7cZvL2EaYDJQ_0GIprtBu5vOPp73p5Ob0eFJW9inXRH06N3h9cnxsZjeXeW9wR09F_3zebt3Opze8I93g9lJ2K679JnRL95JAdqFrPexSPkYgg01lByIuEDz_uXF6Ob8-phckpPe1eU5uT2-OjomvYvr4xGBh1tQ1RV6MwZ-xbH3XeE_fS_e-5aQ0x14_-Yxvu029OdlGL8b0bOIEh4D9CK0UkTiM9gUTzOI6SMWCU9SDe4vQKzidM6ORhWni-oGqPGYhIFgPyLIr9ebMBhCSiBXANsIZD0_Fx71nkhfhNQFeFOgDtNd9fpqOjUJDYNMgTH8KOzi0VxIgOoUkE3IgMb8mW4BHgMQ8xH4KUlgeabk9HgOIAQOI9wpU0utUlyhBDFmkoH8WwC8AF3ITgvYBV2NhYxeLqxT3kNGQ-W2-KIQdswXkAhbSIQrGcHUuJHttlMlDJmDTRazV_pOpWdpjc91xu2Cnlb5EdoxKXX1dizSV7-dCOH_ZJkrAc1HKl3q-dbTL8VckaUvU99W5vu7ie9VMsHPDSPKWq38f69Uet0K6Se7yd-oj9ZC9R1VSG8_LFg68aI_yS4LFNU73IGUGgLB3wTi4JrjFtgl2aabopYB3zRygVbXsA0RL2GrcJDgq2OptK8nA_tKDgE3R8OCibdlidf9WdkRlmptGdLPJOYciEGaArovowuaUTAomwCMT3S50SUuuInanN4nAgaIt7XuKkAReIVEP4bIhYIrwTBAOMajTfYyT2AY6xSH-Y2up5TlRjhICzOBZhArlGnegYPVQxFaP1C-pIAgGmkheilfpfA_cjvUoMg3_Q7Abu0NcQ8WgwIiXngfKBagIcZ-DNkydFVfwSNAXISYUMiL9mcs9iYM27HSYjEMTXWBYztkzmSQxZh3C_nQ6tv4vg7-jOQ6uiRfmjzkgcohRQCpRA7guQ7I6E4b5ViN9Jay4P62BQEPi8BwWoBnJnHnRR3icoGrugq5GJdCAa1kSusEr5uydCEjJTkaCwdEWOfp3IntqkKbUlToEMKLxjTEUSF3QaGb0a_y2yLRwAsUfgqpYfkcUpRkSgCINMgzGx8iemMlq3SpKlAtV5CpDCyUkqgOV3-RncYZWDrSqUllkLngCuexQwkDC6Y0eyElJQPQGOmloUaoeJEJJQsySGUb1Sp-gRPylaZi-Daiz0pFjZjTP1AHDWCzWpffsGDAoWAxgDqMxVyJi5vPIjUcVONnqsqUbJr5XANH4S4J1aWHjykrQuSja0l7Y8osERuFCs6dxSpjK-BR2VLmW_KiwlJwGV8ZzweXld7LLQFkYRqHyNPZO2CqYom2bj3eAZA5fObMy4GsD1HvUgBmTDx-cUYox6sXJWBcVmtqwxMdesXRYBHwha_zkCjsIdpwMdpNnaNUvIlFCYXng2U5tR7ci8oqQfBEz1flqvCLNA_Wm7PkIeMJlmcrYM0kLQ5ACUeMlCs5Ec2geVUHbZw-ysupHy0gIZgmuBFfI-rq6IiBzzyeoEurok9VgOAuGe5sCeiQFPTVYk2D3tt3u1bEGjvy54hCVVLktgSTjK46Sc7xxIuhp11B1_yQCuhidM7iCV0NAS_C9EmGYEKwqqqO8Fi_BgowGgpuVamNaS7kysrLkmzT1Kri2rYfLpYsC0nqJiLMdDYCl5IA6OpA60P2kngwwGYUV6FegLUPXgkXsD8VAWZnLQ5ZnGqISuocWgA2UxEXNxcrV4SEBvkcSrEaIUMYxnHSMX1WmvTF1n0ErJtzeECFvxOHadJ2Z1buMDapkp7KF7rCqq4VSOxlK8UD6iKE8C4CC-EXkSQXPQtQL7wQDacLhl60OIeisrcPxZvmoQA5-mDq6_v4xWFVWQJ8qNKwUCwIb8BDOAHI1Wm9Br8h6NF0QpcOqkiDj1cFGtMFZVF2RH9YVZZW6htH9tLqHAt_9aYLta7Pd9wovIOk13GDqF7uTA4601oKKTu-oxXQD4pUwqLydLfMLsq4MGoZu6h9dX-prh8X6l5zEqyPnc6OM57yyiJucWbtQ1jKl_qPLuowiQEGQmtRSR1r13k3GcPLOlZrR8YA6BeeDsrFfVbFObTBQOHajYd62772gEZaCuiqIg1ThOl1m2oAxZMNHNClzsewxhLILwog_--wSFYJiVSvvxqLVGYXN7WDHSzEkbo1VJmuiA68EVP4U3IbvHlIXo6kEQ8UkONDAZ6LoFQvkOYWxy3AdY44uLzoi8EmpVeJr-j232Ukp_HPUX0eTVkg5NOBvQ_fswO8DKpa7apl76c0SA72AaakuEdTHpjbsr97W6aZ1QWaVEV1jGhSVTcNVYUmVXhQaFJlURXXeusEbLvTrXUcp9voNEsI2OYuytUKbvu8fnrX7oXX4vE0yvN5OHE_Z1_dgXi2biP5_K3Oh9ZDfzi7bcnel2b9tjnoRcf56Sl7sINHQ7kaytVQroZyNZSroVwN5frWwsJQroZyNZSroVwN5WooV0O5GsrVUK5vzO0M5fpqlKthXA3jahhXw7gaxtUwrsuFDeNqGNeXjKuHN773EB8BOzD0q6Ff_wL92rHqtUaz1W1Z7T_9-9fWLjLWffTrE3n-6akhL58eP53PDvPe7OFz8tgaHT98_DrsD4fZxG-w-vThcyCPopuuPRsOo77Tv8gmn2Zf3wAZCxmWB-U4aPhMw2caPvP7yokGlXm4K4wMn2n4zP9PPrPe4NmOKttUZYbP_AmEeWfidn-gfDF8puEzDZ9p-Mw3B2T1BvP9ciAzfKbhM1_L7SbupFnudYbONH9BWsJ_N-NJp9xhDJ9p-Mwf5GCa445d7kyGz3yjNvNkPnXKbWb4zH-Qz2wJzys3i6Ez3zqdaRhMw2D-KINp251Os2bZbbvRKiEw27soy5NnO_1V2P71zbVLxRcvPfPa_qdoEtWngxs77rRGRze_0tmp6I780fTzRT04uzrrjuTomfXPnTNuKEtDWRrK0lCWhrI0lKWhLE0ZZihLQ1kaytJQloayNJSloSwNZWkoy_dLWRrG0jCWhrE0jKVhLA1juVzYMJaGsTR_gGnoy59OX3adWqvlOG27_tu__wPDEuJs:1o7ORY:1S4_7koqk2lGiCVABQ85fagGrsLVnc8tHHVW87r5PaI	2022-07-15 21:44:52.713438+00
0vu0mcjxbwkk300fkbfdm6pnea83vc6m	.eJxVjEEOwiAQRe_C2pBpC7S4dO8ZyMAMFjVgSptojHe3TbrQ7X_vv7dwuMyjWypPLpE4ikYcfjeP4cZ5A3TFfCkylDxPyctNkTut8lyI76fd_QuMWMf1HahjDzywt9Yg2dChJmN06zHqXqnYel4JxwG175sOQEdFAARKse1hi1auNZXs-PlI00scmxasAfh8ATl4QKg:1o8oWx:uBxDa3Q2pHc4vRDAgpw7zaUShwBoXreUO7VMcHX64Lc	2022-07-19 19:48:19.189513+00
\.


--
-- Data for Name: home_landingpage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.home_landingpage (page_ptr_id, heading) FROM stdin;
3	<p data-block-key="o9k5q"><br/>O <b>Painel Farol Verde</b> pretende ampliar a transparência nas Eleições de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais responsáveis com as agendas de Clima e Meio Ambiente.</p><p data-block-key="7kofh">Para você, <i>candidata e candidato ao Legislativo Federal</i>, é uma plataforma confiável ao divulgar informações e posicionamentos de campanhas comprometidas com a Sustentabilidade e com a Democracia. A adesão de sua candidatura ao Painel é voluntária e gratuita e a publicação é republicana e suprapartidária.</p><p data-block-key="10ecr">Para você, <i>eleitora e eleitor brasileiro</i>, é um mapa prático, ágil e em um único portal que facilita sua pesquisa de informações e posicionamentos de candidaturas ao Congresso Nacional nas Eleições de 2022, ampliando suas opções para um voto mais consciente e consequente com a Mudança Climática, com o Meio Ambiente, com a Biodiversidade e com os Direitos Socioambientais. A participação cidadã é livre, bem vinda, democrática e sustentável.</p>
\.


--
-- Data for Name: home_surveyspage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.home_surveyspage (page_ptr_id, surveys) FROM stdin;
4	[{"type": "form", "value": {"form": 1, "form_action": "", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}, "id": "ae1609be-d87a-4c7e-a8bd-5152150047c9"}]
8	[{"type": "form", "value": {"form": 2, "form_action": "", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}, "id": "ae1609be-d87a-4c7e-a8bd-5152150047c9"}]
\.


--
-- Data for Name: taggit_tag; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.taggit_tag (id, name, slug) FROM stdin;
\.


--
-- Data for Name: taggit_taggeditem; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.taggit_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Data for Name: wagtailadmin_admin; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailadmin_admin (id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_collection; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_collection (id, path, depth, numchild, name) FROM stdin;
1	0001	1	1	Root
2	00010001	2	0	Atualizações
\.


--
-- Data for Name: wagtailcore_collectionviewrestriction; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_collectionviewrestriction (id, restriction_type, password, collection_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_collectionviewrestriction_groups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_collectionviewrestriction_groups (id, collectionviewrestriction_id, group_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_comment; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_comment (id, text, contentpath, "position", created_at, updated_at, resolved_at, page_id, resolved_by_id, revision_created_id, user_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_commentreply; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_commentreply (id, text, created_at, updated_at, comment_id, user_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_groupapprovaltask; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_groupapprovaltask (task_ptr_id) FROM stdin;
1
\.


--
-- Data for Name: wagtailcore_groupapprovaltask_groups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_groupapprovaltask_groups (id, groupapprovaltask_id, group_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: wagtailcore_groupcollectionpermission; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_groupcollectionpermission (id, collection_id, group_id, permission_id) FROM stdin;
1	1	1	2
2	1	2	2
3	1	1	3
4	1	2	3
5	1	1	5
6	1	2	5
7	1	1	6
8	1	2	6
9	1	1	7
10	1	2	7
11	1	1	9
12	1	2	9
\.


--
-- Data for Name: wagtailcore_grouppagepermission; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_grouppagepermission (id, permission_type, group_id, page_id) FROM stdin;
1	add	1	1
2	edit	1	1
3	publish	1	1
4	add	2	1
5	edit	2	1
6	lock	1	1
7	unlock	1	1
\.


--
-- Data for Name: wagtailcore_locale; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_locale (id, language_code) FROM stdin;
1	en
\.


--
-- Data for Name: wagtailcore_modellogentry; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_modellogentry (id, label, action, data_json, "timestamp", content_changed, deleted, object_id, content_type_id, user_id, uuid) FROM stdin;
1	Enquete	wagtail.edit	""	2022-06-27 20:11:20.525387+00	f	f	1	8	1	790ee993-0f0f-4fcd-8ab6-444161ae54a7
2	Enquete	wagtail.edit	""	2022-06-27 20:14:52.289525+00	f	f	1	8	1	ccb64a21-bbee-48a3-af00-fe3ed4fcb41d
3	Enquete	wagtail.edit	""	2022-06-27 20:17:30.905753+00	f	f	1	8	1	4f4376cd-e042-4062-829c-8c1aec316b52
4	Enquete	wagtail.edit	""	2022-06-27 20:25:30.24106+00	f	f	1	8	1	bcb7104a-3537-4b9c-ba1c-4acc605e1467
5	Enquete	wagtail.edit	""	2022-06-27 20:26:41.847303+00	f	f	1	8	1	1d9e3025-c2bd-446e-bce0-222cc328a71f
6	Enquete	wagtail.edit	""	2022-06-27 20:27:16.054412+00	f	f	1	8	1	bc8e3cda-97f5-4480-a001-a5f868582808
7	Enquete	wagtail.edit	""	2022-06-27 20:38:00.485585+00	f	f	1	8	1	b78d749c-6125-4a57-a6d6-85c117a60753
8	Enquete	wagtail.edit	""	2022-06-27 20:38:27.695735+00	f	f	1	8	1	f64ffd9d-5b9b-4ee0-b5d4-2f8aa31bcc73
9	Enquete	wagtail.edit	""	2022-06-27 20:39:11.895025+00	f	f	1	8	1	2c2d44ce-26e3-4c92-9256-e3bb4bfd10ff
10	Enquete	wagtail.edit	""	2022-06-27 20:39:53.956322+00	f	f	1	8	1	e959b68f-fd1b-49f4-95ff-fbfcaa0d6c75
11	Enquete	wagtail.edit	""	2022-06-27 20:59:31.514823+00	f	f	1	8	1	398a45e9-1ce9-49a3-a9f4-fdd7556cb3c6
12	Enquete	wagtail.edit	""	2022-06-27 21:03:10.817105+00	f	f	1	8	1	2c5f7ae1-d259-4ee1-959d-25e873d9bb75
13	Atualizações	wagtail.create	""	2022-07-01 20:47:41.105938+00	f	f	2	29	1	46ed82d6-c97d-47b0-a884-ae102c898169
14	Atualizações	wagtail.create	""	2022-07-01 20:51:16.480373+00	f	f	1	11	1	75a65df3-2d06-4e3b-b9fa-8bc9fd62af56
15	Enquete	wagtail.edit	""	2022-07-03 15:03:44.896103+00	f	f	1	8	1	e608d508-44ed-4049-abdd-957c32735d8f
16	Enquete	wagtail.edit	""	2022-07-03 15:06:41.853111+00	f	f	1	8	1	b64aa812-99ad-4d8b-b846-1c2ec9555e83
17	Enquete	wagtail.edit	""	2022-07-03 15:16:20.850649+00	f	f	1	8	1	acec2e19-d371-4bc4-9e0b-4672fecf2d4a
18	Enquete	wagtail.edit	""	2022-07-03 15:30:09.089647+00	f	f	1	8	1	d981274d-76dc-41c6-b56a-3b5a25f17094
19	Enquete	wagtail.edit	""	2022-07-03 16:24:26.998222+00	f	f	1	8	1	10e1a606-fd27-41b3-8b11-d18d1e19d1ba
20	Enquete	wagtail.edit	""	2022-07-03 16:30:23.426432+00	f	f	1	8	1	884b4cf0-34c9-42d7-86ce-9ccfaeed3cad
21	Enquete	wagtail.edit	""	2022-07-03 16:31:32.772175+00	f	f	1	8	1	19073aa5-4558-4230-86a1-cf33aa6128b0
22	Enquete	wagtail.edit	""	2022-07-04 14:57:38.046834+00	f	f	1	8	1	9dd659a0-e978-4889-a467-2feee18a150e
23	Enquete	wagtail.edit	""	2022-07-04 14:58:31.193848+00	f	f	1	8	1	13e6b6f4-e9ed-4fc5-8db7-3486798a8453
24	Enquete	wagtail.edit	""	2022-07-04 23:25:11.288709+00	f	f	1	8	1	060396b2-2405-486c-816f-9974198af7ba
25	Enquete	wagtail.edit	""	2022-07-04 23:28:09.366361+00	f	f	1	8	1	71bfdc02-f2dd-48ff-bfb1-9269296aab48
26	Enquete	wagtail.edit	""	2022-07-04 23:38:13.852644+00	f	f	1	8	1	79104aef-849b-418f-b450-36c3d3716a10
27	Enquete	wagtail.edit	""	2022-07-04 23:39:43.92423+00	f	f	1	8	1	01f9376d-e32a-45ce-ab9e-2a478bd04071
28	Contato	wagtail.edit	""	2022-07-05 17:02:11.79385+00	f	f	2	8	1	bbcf203b-3542-4299-988a-c35cc90d1f31
29	Contato	wagtail.edit	""	2022-07-05 17:03:04.02542+00	f	f	2	8	1	98b7c54c-7277-4a0d-ab56-f21a38ed3f12
30	Contato	wagtail.edit	""	2022-07-05 19:48:52.882009+00	f	f	2	8	1	a9636703-8c5d-4d8b-b977-4ed83502eb24
\.


--
-- Data for Name: wagtailcore_page; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_page (id, path, depth, numchild, title, slug, live, has_unpublished_changes, url_path, seo_title, show_in_menus, search_description, go_live_at, expire_at, expired, content_type_id, owner_id, locked, latest_revision_created_at, first_published_at, live_revision_id, last_published_at, draft_title, locked_at, locked_by_id, translation_key, locale_id, alias_of_id) FROM stdin;
7	0001000200030001	4	0	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	consulte-o-farol-verde-antes-de-votar-em-2022	t	f	/home-2/blog/consulte-o-farol-verde-antes-de-votar-em-2022/		f		\N	\N	f	13	1	f	2022-07-01 21:45:55.800872+00	2022-07-01 21:45:55.836945+00	15	2022-07-01 21:45:55.836945+00	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	\N	\N	f2027852-d6e3-4fa6-bbc8-7d0bf912eaa5	1	\N
6	000100020003	3	1	Blog	blog	t	f	/home-2/blog/		f		\N	\N	f	12	\N	f	2022-07-01 21:46:46.406432+00	2022-07-01 21:46:46.430092+00	17	2022-07-01 21:46:46.430092+00	Blog	\N	\N	1f3ae39a-6411-4ed5-b2df-dfb9890fa156	1	\N
4	000100020001	3	0	Enquete	enquete	t	f	/home-2/enquete/		f		\N	\N	f	4	\N	f	2022-06-27 20:43:30.147473+00	2022-06-27 20:05:42.514549+00	7	2022-06-27 20:43:30.176119+00	Enquete	\N	\N	3dd2e884-9cb6-4201-a86f-7d6a03d1702c	1	\N
1	0001	1	1	Root	root	t	f	/		f		\N	\N	f	1	\N	f	\N	\N	\N	\N	Root	\N	\N	fb3764b9-0546-48ec-966d-8b3eba6e6941	1	\N
8	000100020004	3	0	Contato	contato	t	f	/home-2/contato/		f		\N	\N	f	4	1	f	2022-07-05 17:03:22.234914+00	2022-07-05 17:03:22.26014+00	25	2022-07-05 17:03:22.26014+00	Contato	\N	\N	152a1685-f04d-48d3-be7c-411fb1cdbcfd	1	\N
3	00010002	2	3	Farol Verde	home-2	t	f	/home-2/	Farol Verde	f	O Painel Farol Verde pretende ampliar a transparência nas Eleições de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais responsáveis com as agendas de Clima e Meio Ambiente.	\N	\N	f	3	\N	f	2022-07-08 14:02:03.837116+00	2022-06-27 20:41:57.486683+00	28	2022-07-08 14:02:03.868611+00	Farol Verde	\N	\N	ec2abb2e-ad36-4f80-a989-e7b52d8b3b51	1	\N
\.


--
-- Data for Name: wagtailcore_pagelogentry; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_pagelogentry (id, label, action, data_json, "timestamp", content_changed, deleted, content_type_id, page_id, revision_id, user_id, uuid) FROM stdin;
1	Home	wagtail.create	""	2022-06-27 20:01:34.564055+00	t	f	3	3	\N	\N	\N
2	Survey	wagtail.create	""	2022-06-27 20:01:35.397221+00	t	f	4	4	\N	\N	\N
3	Survey	wagtail.edit	""	2022-06-27 20:05:38.701333+00	t	f	4	4	1	1	3fae1575-06d1-4ffe-8d03-6476d395c9ad
4	Survey	wagtail.edit	""	2022-06-27 20:05:42.502158+00	t	f	4	4	2	1	5ccc1253-ebcf-49fd-9e70-ae497034faaa
5	Survey	wagtail.publish	null	2022-06-27 20:05:42.541156+00	f	f	4	4	2	1	5ccc1253-ebcf-49fd-9e70-ae497034faaa
6	Survey	wagtail.edit	""	2022-06-27 20:23:08.425204+00	t	f	4	4	3	1	fe177d6f-ebbb-45f2-ab03-febc4bece291
7	Survey	wagtail.publish	null	2022-06-27 20:23:08.493541+00	t	f	4	4	3	1	fe177d6f-ebbb-45f2-ab03-febc4bece291
8	Home	wagtail.edit	""	2022-06-27 20:40:30.918004+00	t	f	3	3	4	1	793306ee-1f6d-49be-bbb8-26e76371bebc
9	Farol Verde	wagtail.edit	""	2022-06-27 20:41:41.085594+00	t	f	3	3	5	1	0f305721-84d5-4ce5-bc45-d3fc432794c7
10	Farol Verde	wagtail.edit	""	2022-06-27 20:41:57.474308+00	t	f	3	3	6	1	6585d952-5c08-43cf-889d-da913ec42aa3
11	Farol Verde	wagtail.rename	{"title": {"old": "Home", "new": "Farol Verde"}}	2022-06-27 20:41:57.515031+00	f	f	3	3	6	1	6585d952-5c08-43cf-889d-da913ec42aa3
12	Farol Verde	wagtail.publish	{"title": {"old": "Home", "new": "Farol Verde"}}	2022-06-27 20:41:57.52013+00	f	f	3	3	6	1	6585d952-5c08-43cf-889d-da913ec42aa3
13	Welcome to your new Wagtail site!	wagtail.unpublish	""	2022-06-27 20:42:39.542547+00	f	f	1	2	\N	1	9b0dc11c-19ca-4abb-8cbf-39d07809951b
14	Enquete	wagtail.edit	""	2022-06-27 20:43:30.16164+00	t	f	4	4	7	1	f2f32a74-9222-405d-93a7-b240c733dd75
15	Enquete	wagtail.rename	{"title": {"old": "Survey", "new": "Enquete"}}	2022-06-27 20:43:30.202602+00	f	f	4	4	7	1	f2f32a74-9222-405d-93a7-b240c733dd75
16	Enquete	wagtail.publish	{"title": {"old": "Survey", "new": "Enquete"}}	2022-06-27 20:43:30.207588+00	t	f	4	4	7	1	f2f32a74-9222-405d-93a7-b240c733dd75
17	Welcome to your new Wagtail site!	wagtail.delete	""	2022-06-27 21:01:08.479952+00	f	t	1	2	\N	1	bef704d0-9c90-44f8-834a-00816944041e
18	Farol Verde	wagtail.edit	""	2022-07-01 20:03:35.910111+00	t	f	3	3	8	1	93c0616f-418e-41dd-9245-e3ae4572a8db
19	Farol Verde	wagtail.publish	null	2022-07-01 20:03:35.955725+00	t	f	3	3	8	1	93c0616f-418e-41dd-9245-e3ae4572a8db
20	Farol Verde	wagtail.edit	""	2022-07-01 20:42:25.395752+00	t	f	3	3	9	1	5cb05cdf-e748-4896-968a-b0c4cd5e7e4f
21	Farol Verde	wagtail.edit	""	2022-07-01 20:48:30.33374+00	t	f	3	3	10	1	17bb9e6f-ca28-49f5-9961-dae68e4a66ce
22	Farol Verde	wagtail.publish	null	2022-07-01 20:48:30.371779+00	f	f	3	3	10	1	17bb9e6f-ca28-49f5-9961-dae68e4a66ce
23	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	wagtail.create	""	2022-07-01 20:53:10.931392+00	t	f	13	5	\N	1	baabf92d-f6a4-40f9-ab82-3302bb4c7150
24	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	wagtail.edit	""	2022-07-01 20:53:17.017555+00	t	f	13	5	12	1	e990a9b3-8a09-4704-add3-b1b18815d2da
25	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	wagtail.edit	""	2022-07-01 20:57:20.349329+00	t	f	13	5	13	1	c1dc1605-aaed-4417-af94-bd5fa7710caf
26	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	wagtail.publish	null	2022-07-01 20:57:20.395293+00	f	f	13	5	13	1	c1dc1605-aaed-4417-af94-bd5fa7710caf
27	Blog	wagtail.create	""	2022-07-01 21:42:43.636554+00	t	f	12	6	\N	\N	\N
28	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	wagtail.delete	""	2022-07-01 21:43:47.037869+00	f	t	13	5	\N	1	26d2905b-c3fe-434c-8b57-13e177017ef9
29	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	wagtail.create	""	2022-07-01 21:44:46.048778+00	t	f	13	7	\N	1	ec918583-9822-47cf-84f8-1d60768cbcab
30	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	wagtail.edit	""	2022-07-01 21:45:55.821717+00	t	f	13	7	15	1	93f02cf7-7350-4059-ae7f-f75e0565fe92
31	CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!	wagtail.publish	null	2022-07-01 21:45:55.876232+00	t	f	13	7	15	1	93f02cf7-7350-4059-ae7f-f75e0565fe92
32	Blog	wagtail.edit	""	2022-07-01 21:46:41.338735+00	t	f	12	6	16	1	cacac15b-d8c8-46ee-81bb-149d8a6b7ff7
33	Blog	wagtail.edit	""	2022-07-01 21:46:46.418847+00	t	f	12	6	17	1	2d22371f-c73e-4198-b7af-80b51c38f30b
34	Blog	wagtail.publish	null	2022-07-01 21:46:46.456369+00	f	f	12	6	17	1	2d22371f-c73e-4198-b7af-80b51c38f30b
35	Farol Verde	wagtail.edit	""	2022-07-04 19:38:03.671236+00	t	f	3	3	18	1	88dc530a-89d1-4680-89a8-f875c66185d0
36	Farol Verde	wagtail.publish	null	2022-07-04 19:38:03.713238+00	t	f	3	3	18	1	88dc530a-89d1-4680-89a8-f875c66185d0
37	Farol Verde	wagtail.edit	""	2022-07-04 23:31:06.669878+00	t	f	3	3	19	1	1a910d7a-92a7-494f-bd74-eb781b187357
38	Farol Verde	wagtail.publish	null	2022-07-04 23:31:06.714069+00	t	f	3	3	19	1	1a910d7a-92a7-494f-bd74-eb781b187357
39	Enquete	wagtail.create	""	2022-07-05 16:53:52.072071+00	t	f	4	8	\N	1	b570c9c9-58cf-4758-afeb-6679b98c8c5d
40	Enquete	wagtail.copy	{"page": {"id": 8, "title": "Enquete", "locale": {"id": 1, "language_code": "en"}}, "source": {"id": 3, "title": "Farol Verde"}, "destination": {"id": 3, "title": "Farol Verde"}, "keep_live": false, "source_locale": {"id": 1, "language_code": "en"}}	2022-07-05 16:53:52.116009+00	f	f	4	8	\N	1	b570c9c9-58cf-4758-afeb-6679b98c8c5d
41	Contato	wagtail.edit	""	2022-07-05 17:03:22.24726+00	t	f	4	8	25	1	7ce15bd8-b152-4769-b84d-d749110b0288
42	Contato	wagtail.publish	null	2022-07-05 17:03:22.28923+00	t	f	4	8	25	1	7ce15bd8-b152-4769-b84d-d749110b0288
43	Farol Verde	wagtail.edit	""	2022-07-08 13:48:29.490315+00	t	f	3	3	26	1	00450d4d-a687-452a-9ed7-94075dc84b94
44	Farol Verde	wagtail.edit	""	2022-07-08 13:48:43.268475+00	t	f	3	3	27	1	ffa61c2a-1c57-412d-9e0a-eae8a83c4daa
45	Farol Verde	wagtail.publish	null	2022-07-08 13:48:43.308476+00	f	f	3	3	27	1	ffa61c2a-1c57-412d-9e0a-eae8a83c4daa
46	Farol Verde	wagtail.edit	""	2022-07-08 14:02:03.853071+00	t	f	3	3	28	1	254c1c61-9e23-4c5b-8840-409cefd1f0fe
47	Farol Verde	wagtail.publish	null	2022-07-08 14:02:03.895799+00	f	f	3	3	28	1	254c1c61-9e23-4c5b-8840-409cefd1f0fe
\.


--
-- Data for Name: wagtailcore_pagerevision; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_pagerevision (id, submitted_for_moderation, created_at, content_json, approved_go_live_at, page_id, user_id) FROM stdin;
1	f	2022-06-27 20:05:38.684526+00	{"pk": 4, "path": "000100020001", "depth": 3, "numchild": 0, "translation_key": "3dd2e884-9cb6-4201-a86f-7d6a03d1702c", "locale": 1, "title": "Survey", "draft_title": "Survey", "slug": "surveys", "content_type": 4, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/surveys/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	4	1
28	f	2022-07-08 14:02:03.837116+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 3, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/", "owner": null, "seo_title": "Farol Verde", "show_in_menus": false, "search_description": "O Painel Farol Verde pretende ampliar a transpar\\u00eancia nas Elei\\u00e7\\u00f5es de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais respons\\u00e1veis com as agendas de Clima e Meio Ambiente.", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:41:57.486Z", "last_published_at": "2022-07-08T13:48:43.281Z", "latest_revision_created_at": "2022-07-08T13:48:43.255Z", "live_revision": 27, "alias_of": null, "heading": "<p data-block-key=\\"o9k5q\\"><br/>O <b>Painel Farol Verde</b> pretende ampliar a transpar\\u00eancia nas Elei\\u00e7\\u00f5es de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais respons\\u00e1veis com as agendas de Clima e Meio Ambiente.</p><p data-block-key=\\"7kofh\\">Para voc\\u00ea, <i>candidata e candidato ao Legislativo Federal</i>, \\u00e9 uma plataforma confi\\u00e1vel ao divulgar informa\\u00e7\\u00f5es e posicionamentos de campanhas comprometidas com a Sustentabilidade e com a Democracia. A ades\\u00e3o de sua candidatura ao Painel \\u00e9 volunt\\u00e1ria e gratuita e a publica\\u00e7\\u00e3o \\u00e9 republicana e suprapartid\\u00e1ria.</p><p data-block-key=\\"10ecr\\">Para voc\\u00ea, <i>eleitora e eleitor brasileiro</i>, \\u00e9 um mapa pr\\u00e1tico, \\u00e1gil e em um \\u00fanico portal que facilita sua pesquisa de informa\\u00e7\\u00f5es e posicionamentos de candidaturas ao Congresso Nacional nas Elei\\u00e7\\u00f5es de 2022, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente com a Mudan\\u00e7a Clim\\u00e1tica, com o Meio Ambiente, com a Biodiversidade e com os Direitos Socioambientais. A participa\\u00e7\\u00e3o cidad\\u00e3 \\u00e9 livre, bem vinda, democr\\u00e1tica e sustent\\u00e1vel.</p>", "wagtail_admin_comments": []}	\N	3	1
5	f	2022-06-27 20:41:41.072308+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 1, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Home", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": true, "url_path": "/home-2/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": "2022-06-27T20:40:30.905Z", "live_revision": null, "alias_of": null, "heading": "<h2 data-block-key=\\"o9k5q\\">Clima e Meio Ambiente nas Elei\\u00e7\\u00f5es para o Congresso Nacional em 2022</h2><p data-block-key=\\"361lb\\">Tenetur nesciunt quae aspernatur, incidunt suscipit beatae totam qui ut, nam possimus adipisci cum quaerat? Odio maxime sint, officiis excepturi veritatis quod accusantium quidem corporis sapiente delectus ut, ullam cum a praesentium ea nam soluta molestiae, blanditiis assumenda quia beatae. In veritatis quod nisi incidunt suscipit nesciunt iure. Rerum deserunt ad ipsum repudiandae magni exercitationem laboriosam amet saepe labore illo? Maxime modi temporibus suscipit impedit, libero alias nostrum ipsa consequuntur dignissimos, eveniet alias qui aperiam ex ipsam ipsa quod ea.</p><p data-block-key=\\"52crf\\">Similique eligendi est delectus ipsa ullam quisquam quis inventore voluptas corrupti, mollitia dolorum ab veniam voluptatibus ex alias debitis ratione. Quae fugit expedita, veniam id tenetur veritatis, voluptatum corrupti nam ipsam sed quidem quam iste modi soluta, omnis magnam similique corporis voluptates rerum quidem est sed? Corporis distinctio non sunt alias, necessitatibus inventore asperiores, ea dolore dolor autem, atque sunt eius soluta minima nostrum aspernatur facere doloremque? In dolores fugit nihil iusto officia, fugit atque impedit porro totam magnam, qui ea repudiandae corporis repellat aspernatur, et dolorem voluptatem explicabo eligendi quibusdam? Et odio harum sed non voluptatum suscipit asperiores, facilis voluptate dolore nihil aliquam ab qui non dolor quisquam?</p><p data-block-key=\\"3ajlq\\">Quam a provident, non vitae facere dolorem recusandae, id quis beatae cum sapiente, voluptate vero corporis soluta culpa recusandae officiis delectus, maiores beatae excepturi quam hic accusantium. Voluptatem ex quisquam inventore dolor ea minus libero nam, distinctio hic deleniti reiciendis nobis accusamus magnam atque, earum doloribus culpa ullam eveniet quae qui aliquam sapiente nisi explicabo, ratione eius aperiam pariatur sit maxime hic laudantium, quisquam animi deserunt in itaque harum veniam velit culpa provident dolor veritatis. Placeat ullam nesciunt expedita atque? Ab recusandae animi illum beatae nihil perferendis qui id provident, facere tempora similique.</p>", "wagtail_admin_comments": []}	\N	3	1
18	f	2022-07-04 19:38:03.65659+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 2, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:41:57.486Z", "last_published_at": "2022-07-01T20:48:30.345Z", "latest_revision_created_at": "2022-07-01T20:48:30.321Z", "live_revision": 10, "alias_of": null, "heading": "<p data-block-key=\\"o9k5q\\"><br/><br/><br/></p><p data-block-key=\\"881pl\\">O <b>Painel Farol Verde</b> pretende ampliar a transpar\\u00eancia nas Elei\\u00e7\\u00f5es de 2022, iluminando caminhos para que sejamos, eleitores e candidates ao Legislativo Federal, cada vez mais respons\\u00e1veis com as agendas de Clima e Meio Ambiente.</p><p data-block-key=\\"3cvhq\\">Para voc\\u00ea, <i>candidata e candidato ao Legislativo Federal</i>, \\u00e9 uma plataforma confi\\u00e1vel ao divulgar informa\\u00e7\\u00f5es e posicionamentos de campanhas comprometidas com a Sustentabilidade e com a Democracia. A ades\\u00e3o de sua candidatura ao Painel \\u00e9 volunt\\u00e1ria e gratuita e a publica\\u00e7\\u00e3o \\u00e9 republicana e suprapartid\\u00e1ria.</p><p data-block-key=\\"71v2j\\">Para voc\\u00ea, <i>eleitora e eleitor brasileiro</i>, \\u00e9 um mapa pr\\u00e1tico, \\u00e1gil e em um \\u00fanico portal que facilita sua pesquisa de informa\\u00e7\\u00f5es e posicionamentos de candidaturas ao Congresso Nacional nas Elei\\u00e7\\u00f5es de 2022, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente com a Mudan\\u00e7a Clim\\u00e1tica, com o Meio Ambiente, com a Biodiversidade e com os Direitos Socioambientais. A participa\\u00e7\\u00e3o cidad\\u00e3 \\u00e9 livre, bem vinda, democr\\u00e1tica e sustent\\u00e1vel.</p>", "wagtail_admin_comments": []}	\N	3	1
2	f	2022-06-27 20:05:42.490185+00	{"pk": 4, "path": "000100020001", "depth": 3, "numchild": 0, "translation_key": "3dd2e884-9cb6-4201-a86f-7d6a03d1702c", "locale": 1, "title": "Survey", "draft_title": "Survey", "slug": "surveys", "content_type": 4, "live": true, "has_unpublished_changes": true, "url_path": "/home-2/surveys/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": "2022-06-27T20:05:38.684Z", "live_revision": null, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	4	1
3	f	2022-06-27 20:23:08.413066+00	{"pk": 4, "path": "000100020001", "depth": 3, "numchild": 0, "translation_key": "3dd2e884-9cb6-4201-a86f-7d6a03d1702c", "locale": 1, "title": "Survey", "draft_title": "Survey", "slug": "enquete", "content_type": 4, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/surveys/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:05:42.514Z", "last_published_at": "2022-06-27T20:05:42.514Z", "latest_revision_created_at": "2022-06-27T20:05:42.490Z", "live_revision": 2, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	4	1
19	f	2022-07-04 23:31:06.651598+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 2, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:41:57.486Z", "last_published_at": "2022-07-04T19:38:03.686Z", "latest_revision_created_at": "2022-07-04T19:38:03.656Z", "live_revision": 18, "alias_of": null, "heading": "<p data-block-key=\\"o9k5q\\"><br/>O <b>Painel Farol Verde</b> pretende ampliar a transpar\\u00eancia nas Elei\\u00e7\\u00f5es de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais respons\\u00e1veis com as agendas de Clima e Meio Ambiente. </p><p data-block-key=\\"7kofh\\">Para voc\\u00ea, <i>candidata e candidato ao Legislativo Federal</i>, \\u00e9 uma plataforma confi\\u00e1vel ao divulgar informa\\u00e7\\u00f5es e posicionamentos de campanhas comprometidas com a Sustentabilidade e com a Democracia. A ades\\u00e3o de sua candidatura ao Painel \\u00e9 volunt\\u00e1ria e gratuita e a publica\\u00e7\\u00e3o \\u00e9 republicana e suprapartid\\u00e1ria.</p><p data-block-key=\\"10ecr\\">Para voc\\u00ea, <i>eleitora e eleitor brasileiro</i>, \\u00e9 um mapa pr\\u00e1tico, \\u00e1gil e em um \\u00fanico portal que facilita sua pesquisa de informa\\u00e7\\u00f5es e posicionamentos de candidaturas ao Congresso Nacional nas Elei\\u00e7\\u00f5es de 2022, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente com a Mudan\\u00e7a Clim\\u00e1tica, com o Meio Ambiente, com a Biodiversidade e com os Direitos Socioambientais. A participa\\u00e7\\u00e3o cidad\\u00e3 \\u00e9 livre, bem vinda, democr\\u00e1tica e sustent\\u00e1vel. </p>", "wagtail_admin_comments": []}	\N	3	1
4	f	2022-06-27 20:40:30.905158+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 1, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Home", "draft_title": "Home", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "alias_of": null, "heading": "<h2 data-block-key=\\"o9k5q\\">Clima e Meio Ambiente nas Elei\\u00e7\\u00f5es para o Congresso Nacional em 2022</h2><p data-block-key=\\"361lb\\">Tenetur nesciunt quae aspernatur, incidunt suscipit beatae totam qui ut, nam possimus adipisci cum quaerat? Odio maxime sint, officiis excepturi veritatis quod accusantium quidem corporis sapiente delectus ut, ullam cum a praesentium ea nam soluta molestiae, blanditiis assumenda quia beatae. In veritatis quod nisi incidunt suscipit nesciunt iure. Rerum deserunt ad ipsum repudiandae magni exercitationem laboriosam amet saepe labore illo? Maxime modi temporibus suscipit impedit, libero alias nostrum ipsa consequuntur dignissimos, eveniet alias qui aperiam ex ipsam ipsa quod ea. </p><p data-block-key=\\"52crf\\">Similique eligendi est delectus ipsa ullam quisquam quis inventore voluptas corrupti, mollitia dolorum ab veniam voluptatibus ex alias debitis ratione. Quae fugit expedita, veniam id tenetur veritatis, voluptatum corrupti nam ipsam sed quidem quam iste modi soluta, omnis magnam similique corporis voluptates rerum quidem est sed? Corporis distinctio non sunt alias, necessitatibus inventore asperiores, ea dolore dolor autem, atque sunt eius soluta minima nostrum aspernatur facere doloremque? In dolores fugit nihil iusto officia, fugit atque impedit porro totam magnam, qui ea repudiandae corporis repellat aspernatur, et dolorem voluptatem explicabo eligendi quibusdam? Et odio harum sed non voluptatum suscipit asperiores, facilis voluptate dolore nihil aliquam ab qui non dolor quisquam? </p><p data-block-key=\\"3ajlq\\">Quam a provident, non vitae facere dolorem recusandae, id quis beatae cum sapiente, voluptate vero corporis soluta culpa recusandae officiis delectus, maiores beatae excepturi quam hic accusantium. Voluptatem ex quisquam inventore dolor ea minus libero nam, distinctio hic deleniti reiciendis nobis accusamus magnam atque, earum doloribus culpa ullam eveniet quae qui aliquam sapiente nisi explicabo, ratione eius aperiam pariatur sit maxime hic laudantium, quisquam animi deserunt in itaque harum veniam velit culpa provident dolor veritatis. Placeat ullam nesciunt expedita atque? Ab recusandae animi illum beatae nihil perferendis qui id provident, facere tempora similique.</p>", "wagtail_admin_comments": []}	\N	3	1
27	f	2022-07-08 13:48:43.255347+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 3, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": true, "url_path": "/home-2/", "owner": null, "seo_title": "Farol Verde", "show_in_menus": false, "search_description": "O Painel Farol Verde pretende ampliar a transpar\\u00eancia nas Elei\\u00e7\\u00f5es de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais respons\\u00e1veis com as agendas de Clima e Meio Ambiente.", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:41:57.486Z", "last_published_at": "2022-07-04T23:31:06.686Z", "latest_revision_created_at": "2022-07-08T13:48:29.476Z", "live_revision": 19, "alias_of": null, "heading": "<p data-block-key=\\"o9k5q\\"><br/>O <b>Painel Farol Verde</b> pretende ampliar a transpar\\u00eancia nas Elei\\u00e7\\u00f5es de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais respons\\u00e1veis com as agendas de Clima e Meio Ambiente.</p><p data-block-key=\\"7kofh\\">Para voc\\u00ea, <i>candidata e candidato ao Legislativo Federal</i>, \\u00e9 uma plataforma confi\\u00e1vel ao divulgar informa\\u00e7\\u00f5es e posicionamentos de campanhas comprometidas com a Sustentabilidade e com a Democracia. A ades\\u00e3o de sua candidatura ao Painel \\u00e9 volunt\\u00e1ria e gratuita e a publica\\u00e7\\u00e3o \\u00e9 republicana e suprapartid\\u00e1ria.</p><p data-block-key=\\"10ecr\\">Para voc\\u00ea, <i>eleitora e eleitor brasileiro</i>, \\u00e9 um mapa pr\\u00e1tico, \\u00e1gil e em um \\u00fanico portal que facilita sua pesquisa de informa\\u00e7\\u00f5es e posicionamentos de candidaturas ao Congresso Nacional nas Elei\\u00e7\\u00f5es de 2022, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente com a Mudan\\u00e7a Clim\\u00e1tica, com o Meio Ambiente, com a Biodiversidade e com os Direitos Socioambientais. A participa\\u00e7\\u00e3o cidad\\u00e3 \\u00e9 livre, bem vinda, democr\\u00e1tica e sustent\\u00e1vel.</p>", "wagtail_admin_comments": []}	\N	3	1
7	f	2022-06-27 20:43:30.147473+00	{"pk": 4, "path": "000100020001", "depth": 3, "numchild": 0, "translation_key": "3dd2e884-9cb6-4201-a86f-7d6a03d1702c", "locale": 1, "title": "Enquete", "draft_title": "Survey", "slug": "enquete", "content_type": 4, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/enquete/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:05:42.514Z", "last_published_at": "2022-06-27T20:23:08.440Z", "latest_revision_created_at": "2022-06-27T20:23:08.413Z", "live_revision": 3, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	4	1
6	f	2022-06-27 20:41:57.461362+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 1, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": true, "url_path": "/home-2/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": "2022-06-27T20:41:41.072Z", "live_revision": null, "alias_of": null, "heading": "<h2 data-block-key=\\"o9k5q\\">Clima e Meio Ambiente nas Elei\\u00e7\\u00f5es para o Congresso Nacional em 2022</h2><p data-block-key=\\"361lb\\">Tenetur nesciunt quae aspernatur, incidunt suscipit beatae totam qui ut, nam possimus adipisci cum quaerat? Odio maxime sint, officiis excepturi veritatis quod accusantium quidem corporis sapiente delectus ut, ullam cum a praesentium ea nam soluta molestiae, blanditiis assumenda quia beatae. In veritatis quod nisi incidunt suscipit nesciunt iure. Rerum deserunt ad ipsum repudiandae magni exercitationem laboriosam amet saepe labore illo? Maxime modi temporibus suscipit impedit, libero alias nostrum ipsa consequuntur dignissimos, eveniet alias qui aperiam ex ipsam ipsa quod ea.</p><p data-block-key=\\"52crf\\">Similique eligendi est delectus ipsa ullam quisquam quis inventore voluptas corrupti, mollitia dolorum ab veniam voluptatibus ex alias debitis ratione. Quae fugit expedita, veniam id tenetur veritatis, voluptatum corrupti nam ipsam sed quidem quam iste modi soluta, omnis magnam similique corporis voluptates rerum quidem est sed? Corporis distinctio non sunt alias, necessitatibus inventore asperiores, ea dolore dolor autem, atque sunt eius soluta minima nostrum aspernatur facere doloremque? In dolores fugit nihil iusto officia, fugit atque impedit porro totam magnam, qui ea repudiandae corporis repellat aspernatur, et dolorem voluptatem explicabo eligendi quibusdam? Et odio harum sed non voluptatum suscipit asperiores, facilis voluptate dolore nihil aliquam ab qui non dolor quisquam?</p><p data-block-key=\\"3ajlq\\">Quam a provident, non vitae facere dolorem recusandae, id quis beatae cum sapiente, voluptate vero corporis soluta culpa recusandae officiis delectus, maiores beatae excepturi quam hic accusantium. Voluptatem ex quisquam inventore dolor ea minus libero nam, distinctio hic deleniti reiciendis nobis accusamus magnam atque, earum doloribus culpa ullam eveniet quae qui aliquam sapiente nisi explicabo, ratione eius aperiam pariatur sit maxime hic laudantium, quisquam animi deserunt in itaque harum veniam velit culpa provident dolor veritatis. Placeat ullam nesciunt expedita atque? Ab recusandae animi illum beatae nihil perferendis qui id provident, facere tempora similique.</p>", "wagtail_admin_comments": []}	\N	3	1
17	f	2022-07-01 21:46:46.406432+00	{"pk": 6, "path": "000100020003", "depth": 3, "numchild": 1, "translation_key": "1f3ae39a-6411-4ed5-b2df-dfb9890fa156", "locale": 1, "title": "Blog", "draft_title": "Blog", "slug": "blog", "content_type": 12, "live": true, "has_unpublished_changes": true, "url_path": "/home-2/blog/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": "2022-07-01T21:46:41.326Z", "live_revision": null, "alias_of": null, "sidebar_panels": "[]", "wagtail_admin_comments": []}	\N	6	1
9	f	2022-07-01 20:42:25.382643+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 1, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:41:57.486Z", "last_published_at": "2022-07-01T20:03:35.926Z", "latest_revision_created_at": "2022-07-01T20:03:35.894Z", "live_revision": 8, "alias_of": null, "heading": "<p data-block-key=\\"o9k5q\\"><br/><br/><br/></p><p data-block-key=\\"db7lh\\">O prop\\u00f3sito do <b>Painel Farol Verde</b> \\u00e9 promover transpar\\u00eancia e divulgar dados p\\u00fablicos dispon\\u00edveis a respeito do posicionamento de candidatos ao legislativo federal e senado nas elei\\u00e7\\u00f5es de 2022 comprometidos ou que estejam tratando dos temas de Mudan\\u00e7as Clim\\u00e1ticas, Meio Ambiente, Direitos Socioambientais e Sustentabilidade para clarear e iluminar aos eleitores e eleitoras de todo Pa\\u00eds, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente em rela\\u00e7\\u00e3o ao Clima, Meio Ambiente e Desenvolvimento Sustent\\u00e1vel no Brasil..</p>", "wagtail_admin_comments": []}	\N	3	1
24	f	2022-07-05 16:53:52.106363+00	{"pk": 8, "path": "000100020004", "depth": 3, "numchild": 0, "translation_key": "152a1685-f04d-48d3-be7c-411fb1cdbcfd", "locale": 1, "title": "Contato", "draft_title": "Enquete", "slug": "contato", "content_type": 4, "live": false, "has_unpublished_changes": true, "url_path": "/home-2/enquete/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": "2022-06-27T20:23:08.440Z", "latest_revision_created_at": "2022-06-27T20:43:30.147Z", "live_revision": 3, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	8	1
21	f	2022-06-27 20:05:42.490185+00	{"pk": 8, "path": "000100020001", "depth": 3, "numchild": 0, "translation_key": "3dd2e884-9cb6-4201-a86f-7d6a03d1702c", "locale": 1, "title": "Survey", "draft_title": "Survey", "slug": "surveys", "content_type": 4, "live": true, "has_unpublished_changes": true, "url_path": "/home-2/surveys/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": "2022-06-27T20:05:38.684Z", "live_revision": null, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	8	1
22	f	2022-06-27 20:23:08.413066+00	{"pk": 8, "path": "000100020001", "depth": 3, "numchild": 0, "translation_key": "3dd2e884-9cb6-4201-a86f-7d6a03d1702c", "locale": 1, "title": "Survey", "draft_title": "Survey", "slug": "enquete", "content_type": 4, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/surveys/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:05:42.514Z", "last_published_at": "2022-06-27T20:05:42.514Z", "latest_revision_created_at": "2022-06-27T20:05:42.490Z", "live_revision": 2, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	8	1
23	f	2022-06-27 20:43:30.147473+00	{"pk": 8, "path": "000100020001", "depth": 3, "numchild": 0, "translation_key": "3dd2e884-9cb6-4201-a86f-7d6a03d1702c", "locale": 1, "title": "Enquete", "draft_title": "Survey", "slug": "enquete", "content_type": 4, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/enquete/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:05:42.514Z", "last_published_at": "2022-06-27T20:23:08.440Z", "latest_revision_created_at": "2022-06-27T20:23:08.413Z", "live_revision": 3, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	8	1
14	f	2022-07-01 21:44:46.064876+00	{"pk": 7, "path": "0001000200030001", "depth": 4, "numchild": 0, "translation_key": "f2027852-d6e3-4fa6-bbc8-7d0bf912eaa5", "locale": 1, "title": "CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!", "draft_title": "CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!", "slug": "consulte-o-farol-verde-antes-de-votar-em-2022", "content_type": 13, "live": false, "has_unpublished_changes": false, "url_path": "/home-2/blog/consulte-o-farol-verde-antes-de-votar-em-2022/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "alias_of": null, "date": "2022-07-01", "intro_text": "O Painel oferecer\\u00e1 informa\\u00e7\\u00f5es sobre como os candidatos \\u00e0 reelei\\u00e7\\u00e3o (Senado e C\\u00e2mara) se posicionaram frente \\u00e0s principais vota\\u00e7\\u00f5es nos temas de Clima & Meio Ambiente durante a atual legislatura (2019/2022) bem como sobre proposi\\u00e7\\u00f5es legislativas por", "body": "<p data-block-key=\\"espig\\">O Painel Farol Verde \\u00e9 uma iniciativa do Instituto Democracia e Sustentabilidade (IDS) em parceria com o GT Socioambiental da Rede de Advocacy Colaborativo (RAC) e com algumas das mais importantes organiza\\u00e7\\u00f5es e redes da sociedade civil. O objetivo do Painel \\u00e9 oferecer aos eleitores de todo o pa\\u00eds informa\\u00e7\\u00f5es e dados qualificados e confi\\u00e1veis sobre os posicionamentos p\\u00fablicos e opini\\u00f5es\\u00a0de (pr\\u00e9)candidatos(as) \\u00e0 C\\u00e2mara Federal e ao Senado\\u00a0a respeito das pautas de Mudan\\u00e7a Clim\\u00e1tica, Meio Ambiente, Direitos Socioambientais e Sustentabilidade.</p><p data-block-key=\\"4arvl\\">O prop\\u00f3sito do Painel Farol Verde \\u00e9 promover transpar\\u00eancia e divulgar dados p\\u00fablicos dispon\\u00edveis a respeito do posicionamento de candidatos ao legislativo federal nas elei\\u00e7\\u00f5es de 2022 comprometidos ou que estejam tratando dos temas de Mudan\\u00e7a Clim\\u00e1tica, Meio Ambiente, Direitos Socioambientais e Sustentabilidade para clarear e iluminar aos eleitores e eleitoras de todo o pa\\u00eds, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente em rela\\u00e7\\u00e3o ao Clima, Meio Ambiente e Desenvolvimento Sustent\\u00e1vel no Brasil.</p><p data-block-key=\\"34iuj\\">O Painel oferecer\\u00e1 informa\\u00e7\\u00f5es sobre como os candidatos \\u00e0 reelei\\u00e7\\u00e3o (Senado e C\\u00e2mara) se posicionaram frente \\u00e0s principais vota\\u00e7\\u00f5es nos temas de Clima &amp; Meio Ambiente durante a atual legislatura (2019/2022) bem como sobre proposi\\u00e7\\u00f5es legislativas por eles apresentadas e seus posicionamentos nas redes sociais sobre os temas de interesse do painel.</p><p data-block-key=\\"e8hb9\\">O Painel Farol Verde tamb\\u00e9m vai oferecer informa\\u00e7\\u00f5es sobre os novos candidatos ou candidatos que ainda n\\u00e3o tem mandato no legislativo federal que aderirem ao Painel e preencherem uma enquete com 12 perguntas sobre o seu posicionamento a respeito de v\\u00e1rios temas ligados \\u00e0 pauta clim\\u00e1tica e socioambiental. A enquete tem perguntas sobre desmatamento zero nos\\u00a0biomas brasileiros, reforma tribut\\u00e1ria verde, morat\\u00f3ria da soja no Pantanal, libera\\u00e7\\u00e3o de ca\\u00e7a de animais silvestres, prote\\u00e7\\u00e3o constitucional da \\u00e1gua e do clima como direitos fundamentais, apoio ao fundo de restaura\\u00e7\\u00e3o da Mata Atl\\u00e2ntica, regulariza\\u00e7\\u00e3o fundi\\u00e1ria na Amaz\\u00f4nia, libera\\u00e7\\u00e3o de agrot\\u00f3xicos, desincentivo ao consumo de produtos prejudiciais \\u00e0 sa\\u00fade e meio ambiente, incentivo ao uso p\\u00fablico de unidades de conserva\\u00e7\\u00e3o e retomada de demarca\\u00e7\\u00e3o de terras ind\\u00edgenas em todo Pa\\u00eds.</p><p data-block-key=\\"34edd\\">Com base nos dados e informa\\u00e7\\u00f5es dispon\\u00edveis no Painel Farol Verde, de forma pr\\u00e1tica e \\u00e1gil em um \\u00fanico portal, o eleitor e a eleitora brasileiros de todos os estados poder\\u00e3o pesquisar as candidaturas e considerar de forma respons\\u00e1vel as pautas de Clima, Meio Ambiente, Direitos Socioambientais e Sustentabilidade na hora do seu importante e decisivo voto para deputado federal ou senado.\\u00a0</p><p data-block-key=\\"hbh5\\">Sabemos que se o Brasil vier a ter, o que esperamos que venha a ter, um novo Presidente da Rep\\u00fablica aliado e favor\\u00e1vel \\u00e0s pautas de Clima &amp; Sustentabilidade, ser\\u00e1 absolutamente crucial e determinante que o congresso nacional jogue a favor e esteja em maior sintonia com as pautas referidas.  Por isso fazemos dois importantes convites:\\u00a0</p><p data-block-key=\\"65nh8\\">1 - Aos pr\\u00e9-candidatos e pr\\u00e9-candidatas a deputado(a) federal ou senador(a) em todo Brasil que t\\u00eam compromissos p\\u00fablicos com as pautas aqui tratadas, estejam convidad@s a participar do Painel. Para tanto, preencham a enquete e ofere\\u00e7am informa\\u00e7\\u00f5es sobre seus posicionamentos a respeito dos temas de interesse por interm\\u00e9dio do Painel Farol Verde.</p><p data-block-key=\\"b5f81\\">2 - A todos os eleitores e eleitoras, que pesquisem no Painel Farol Verde candidat@s em sintonia positiva com os temas aqui tratados (Clima &amp; Meio Ambiente) e\\u00a0@s convidem a participar do Painel, respondendo \\u00e0 Enquete.\\u00a0</p><p data-block-key=\\"crvj2\\"><b>Se voc\\u00ea \\u00e9 +1 pelo Clima, pelo Meio Ambiente e pela Sustentabilidade, consulte o Farol Verde antes de votar para o Congresso Nacional.</b></p><p data-block-key=\\"6occ\\"><b>Divulgue o Painel aos seus candidatos(as) e tamb\\u00e9m aos seus amigos e amigas, eleitores, e fa\\u00e7a a diferen\\u00e7a nessas elei\\u00e7\\u00f5es.\\u00a0</b></p>", "category": 1, "cover_image": "placeholder_1.png", "wagtail_admin_comments": [], "tagged_items": []}	\N	7	1
15	f	2022-07-01 21:45:55.800872+00	{"pk": 7, "path": "0001000200030001", "depth": 4, "numchild": 0, "translation_key": "f2027852-d6e3-4fa6-bbc8-7d0bf912eaa5", "locale": 1, "title": "CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!", "draft_title": "CONSULTE O FAROL VERDE ANTES DE VOTAR em 2022!", "slug": "consulte-o-farol-verde-antes-de-votar-em-2022", "content_type": 13, "live": false, "has_unpublished_changes": true, "url_path": "/home-2/blog/consulte-o-farol-verde-antes-de-votar-em-2022/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": "2022-07-01T21:44:46.064Z", "live_revision": null, "alias_of": null, "date": "2022-07-01", "intro_text": "O Painel oferecer\\u00e1 informa\\u00e7\\u00f5es sobre como os candidatos \\u00e0 reelei\\u00e7\\u00e3o (Senado e C\\u00e2mara) se posicionaram frente \\u00e0s principais vota\\u00e7\\u00f5es nos temas de Clima & Meio Ambiente durante a atual legislatura (2019/2022) bem como sobre proposi\\u00e7\\u00f5es legislativas por", "body": "<p data-block-key=\\"espig\\">O Painel Farol Verde \\u00e9 uma iniciativa do Instituto Democracia e Sustentabilidade (IDS) em parceria com o GT Socioambiental da Rede de Advocacy Colaborativo (RAC) e com algumas das mais importantes organiza\\u00e7\\u00f5es e redes da sociedade civil. O objetivo do Painel \\u00e9 oferecer aos eleitores de todo o pa\\u00eds informa\\u00e7\\u00f5es e dados qualificados e confi\\u00e1veis sobre os posicionamentos p\\u00fablicos e opini\\u00f5es\\u00a0de (pr\\u00e9)candidatos(as) \\u00e0 C\\u00e2mara Federal e ao Senado\\u00a0a respeito das pautas de Mudan\\u00e7a Clim\\u00e1tica, Meio Ambiente, Direitos Socioambientais e Sustentabilidade.</p><p data-block-key=\\"4arvl\\">O prop\\u00f3sito do Painel Farol Verde \\u00e9 promover transpar\\u00eancia e divulgar dados p\\u00fablicos dispon\\u00edveis a respeito do posicionamento de candidatos ao legislativo federal nas elei\\u00e7\\u00f5es de 2022 comprometidos ou que estejam tratando dos temas de Mudan\\u00e7a Clim\\u00e1tica, Meio Ambiente, Direitos Socioambientais e Sustentabilidade para clarear e iluminar aos eleitores e eleitoras de todo o pa\\u00eds, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente em rela\\u00e7\\u00e3o ao Clima, Meio Ambiente e Desenvolvimento Sustent\\u00e1vel no Brasil.</p><p data-block-key=\\"34iuj\\">O Painel oferecer\\u00e1 informa\\u00e7\\u00f5es sobre como os candidatos \\u00e0 reelei\\u00e7\\u00e3o (Senado e C\\u00e2mara) se posicionaram frente \\u00e0s principais vota\\u00e7\\u00f5es nos temas de Clima &amp; Meio Ambiente durante a atual legislatura (2019/2022) bem como sobre proposi\\u00e7\\u00f5es legislativas por eles apresentadas e seus posicionamentos nas redes sociais sobre os temas de interesse do painel.</p><p data-block-key=\\"e8hb9\\">O Painel Farol Verde tamb\\u00e9m vai oferecer informa\\u00e7\\u00f5es sobre os novos candidatos ou candidatos que ainda n\\u00e3o tem mandato no legislativo federal que aderirem ao Painel e preencherem uma enquete com 12 perguntas sobre o seu posicionamento a respeito de v\\u00e1rios temas ligados \\u00e0 pauta clim\\u00e1tica e socioambiental. A enquete tem perguntas sobre desmatamento zero nos\\u00a0biomas brasileiros, reforma tribut\\u00e1ria verde, morat\\u00f3ria da soja no Pantanal, libera\\u00e7\\u00e3o de ca\\u00e7a de animais silvestres, prote\\u00e7\\u00e3o constitucional da \\u00e1gua e do clima como direitos fundamentais, apoio ao fundo de restaura\\u00e7\\u00e3o da Mata Atl\\u00e2ntica, regulariza\\u00e7\\u00e3o fundi\\u00e1ria na Amaz\\u00f4nia, libera\\u00e7\\u00e3o de agrot\\u00f3xicos, desincentivo ao consumo de produtos prejudiciais \\u00e0 sa\\u00fade e meio ambiente, incentivo ao uso p\\u00fablico de unidades de conserva\\u00e7\\u00e3o e retomada de demarca\\u00e7\\u00e3o de terras ind\\u00edgenas em todo Pa\\u00eds.</p><p data-block-key=\\"34edd\\">Com base nos dados e informa\\u00e7\\u00f5es dispon\\u00edveis no Painel Farol Verde, de forma pr\\u00e1tica e \\u00e1gil em um \\u00fanico portal, o eleitor e a eleitora brasileiros de todos os estados poder\\u00e3o pesquisar as candidaturas e considerar de forma respons\\u00e1vel as pautas de Clima, Meio Ambiente, Direitos Socioambientais e Sustentabilidade na hora do seu importante e decisivo voto para deputado federal ou senado.\\u00a0</p><p data-block-key=\\"hbh5\\">Sabemos que se o Brasil vier a ter, o que esperamos que venha a ter, um novo Presidente da Rep\\u00fablica aliado e favor\\u00e1vel \\u00e0s pautas de Clima &amp; Sustentabilidade, ser\\u00e1 absolutamente crucial e determinante que o congresso nacional jogue a favor e esteja em maior sintonia com as pautas referidas. Por isso fazemos dois importantes convites:\\u00a0</p><p data-block-key=\\"65nh8\\">1 - Aos pr\\u00e9-candidatos e pr\\u00e9-candidatas a deputado(a) federal ou senador(a) em todo Brasil que t\\u00eam compromissos p\\u00fablicos com as pautas aqui tratadas, estejam convidad@s a participar do Painel. Para tanto, preencham a enquete e ofere\\u00e7am informa\\u00e7\\u00f5es sobre seus posicionamentos a respeito dos temas de interesse por interm\\u00e9dio do Painel Farol Verde.</p><p data-block-key=\\"b5f81\\">2 - A todos os eleitores e eleitoras, que pesquisem no Painel Farol Verde candidat@s em sintonia positiva com os temas aqui tratados (Clima &amp; Meio Ambiente) e\\u00a0@s convidem a participar do Painel, respondendo \\u00e0 Enquete.\\u00a0</p><p data-block-key=\\"crvj2\\"><b>Se voc\\u00ea \\u00e9 +1 pelo Clima, pelo Meio Ambiente e pela Sustentabilidade, consulte o Farol Verde antes de votar para o Congresso Nacional.</b></p><p data-block-key=\\"6occ\\"><b>Divulgue o Painel aos seus candidatos(as) e tamb\\u00e9m aos seus amigos e amigas, eleitores, e fa\\u00e7a a diferen\\u00e7a nessas elei\\u00e7\\u00f5es.\\u00a0</b></p>", "category": 1, "cover_image": "placeholder_1.png", "wagtail_admin_comments": [], "tagged_items": []}	\N	7	1
16	f	2022-07-01 21:46:41.326074+00	{"pk": 6, "path": "000100020003", "depth": 3, "numchild": 1, "translation_key": "1f3ae39a-6411-4ed5-b2df-dfb9890fa156", "locale": 1, "title": "Blog", "draft_title": "Blog", "slug": "blog", "content_type": 12, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/blog/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "alias_of": null, "sidebar_panels": "[]", "wagtail_admin_comments": []}	\N	6	1
8	f	2022-07-01 20:03:35.894668+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 1, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:41:57.486Z", "last_published_at": "2022-06-27T20:41:57.486Z", "latest_revision_created_at": "2022-06-27T20:41:57.461Z", "live_revision": 6, "alias_of": null, "heading": "<p data-block-key=\\"o9k5q\\"><br/><br/><br/></p><p data-block-key=\\"db7lh\\">O prop\\u00f3sito do <b>Painel Farol Verde</b> \\u00e9 mobilizar e iluminar com a m\\u00e1xima transpar\\u00eancia os eleitores e eleitoras para buscarem as melhores op\\u00e7\\u00f5es de candidaturas para o legislativo federal comprometidas com os temas de Mudan\\u00e7as Clim\\u00e1ticas, Meio Ambiente, Direitos Socioambientais e Sustentabilidade.</p>", "wagtail_admin_comments": []}	\N	3	1
25	f	2022-07-05 17:03:22.234914+00	{"pk": 8, "path": "000100020004", "depth": 3, "numchild": 0, "translation_key": "152a1685-f04d-48d3-be7c-411fb1cdbcfd", "locale": 1, "title": "Contato", "draft_title": "Contato", "slug": "contato", "content_type": 4, "live": false, "has_unpublished_changes": true, "url_path": "/home-2/contato/", "owner": 1, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": "2022-06-27T20:23:08.440Z", "latest_revision_created_at": "2022-07-05T16:53:52.106Z", "live_revision": 3, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 2, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	8	1
20	f	2022-06-27 20:05:38.684526+00	{"pk": 8, "path": "000100020001", "depth": 3, "numchild": 0, "translation_key": "3dd2e884-9cb6-4201-a86f-7d6a03d1702c", "locale": 1, "title": "Survey", "draft_title": "Survey", "slug": "surveys", "content_type": 4, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/surveys/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": null, "last_published_at": null, "latest_revision_created_at": null, "live_revision": null, "alias_of": null, "surveys": "[{\\"type\\": \\"form\\", \\"value\\": {\\"form\\": 1, \\"form_action\\": \\"\\", \\"form_reference\\": \\"68ae4dd4-9c5c-4fa6-806e-cffd57880eb9\\"}, \\"id\\": \\"ae1609be-d87a-4c7e-a8bd-5152150047c9\\"}]", "wagtail_admin_comments": []}	\N	8	1
10	f	2022-07-01 20:48:30.321759+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 1, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": true, "url_path": "/home-2/", "owner": null, "seo_title": "", "show_in_menus": false, "search_description": "", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:41:57.486Z", "last_published_at": "2022-07-01T20:03:35.926Z", "latest_revision_created_at": "2022-07-01T20:42:25.382Z", "live_revision": 8, "alias_of": null, "heading": "<p data-block-key=\\"o9k5q\\"><br/><br/><br/></p><p data-block-key=\\"db7lh\\">O prop\\u00f3sito do <b>Painel Farol Verde</b> \\u00e9 promover transpar\\u00eancia e divulgar dados p\\u00fablicos dispon\\u00edveis a respeito do posicionamento de candidatos ao legislativo federal e senado nas elei\\u00e7\\u00f5es de 2022 comprometidos ou que estejam tratando dos temas de Mudan\\u00e7as Clim\\u00e1ticas, Meio Ambiente, Direitos Socioambientais e Sustentabilidade para clarear e iluminar aos eleitores e eleitoras de todo Pa\\u00eds, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente em rela\\u00e7\\u00e3o ao Clima, Meio Ambiente e Desenvolvimento Sustent\\u00e1vel no Brasil..</p>", "wagtail_admin_comments": []}	\N	3	1
26	f	2022-07-08 13:48:29.476514+00	{"pk": 3, "path": "00010002", "depth": 2, "numchild": 3, "translation_key": "ec2abb2e-ad36-4f80-a989-e7b52d8b3b51", "locale": 1, "title": "Farol Verde", "draft_title": "Farol Verde", "slug": "home-2", "content_type": 3, "live": true, "has_unpublished_changes": false, "url_path": "/home-2/", "owner": null, "seo_title": "Farol Verde", "show_in_menus": false, "search_description": "O Painel Farol Verde pretende ampliar a transpar\\u00eancia nas Elei\\u00e7\\u00f5es de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais respons\\u00e1veis com as agendas de Clima e Meio Ambiente.", "go_live_at": null, "expire_at": null, "expired": false, "locked": false, "locked_at": null, "locked_by": null, "first_published_at": "2022-06-27T20:41:57.486Z", "last_published_at": "2022-07-04T23:31:06.686Z", "latest_revision_created_at": "2022-07-04T23:31:06.651Z", "live_revision": 19, "alias_of": null, "heading": "<p data-block-key=\\"o9k5q\\"><br/>O <b>Painel Farol Verde</b> pretende ampliar a transpar\\u00eancia nas Elei\\u00e7\\u00f5es de 2022, iluminando caminhos para que sejamos, eleitores e candidatos ao Congresso Nacional, cada vez mais respons\\u00e1veis com as agendas de Clima e Meio Ambiente.</p><p data-block-key=\\"7kofh\\">Para voc\\u00ea, <i>candidata e candidato ao Legislativo Federal</i>, \\u00e9 uma plataforma confi\\u00e1vel ao divulgar informa\\u00e7\\u00f5es e posicionamentos de campanhas comprometidas com a Sustentabilidade e com a Democracia. A ades\\u00e3o de sua candidatura ao Painel \\u00e9 volunt\\u00e1ria e gratuita e a publica\\u00e7\\u00e3o \\u00e9 republicana e suprapartid\\u00e1ria.</p><p data-block-key=\\"10ecr\\">Para voc\\u00ea, <i>eleitora e eleitor brasileiro</i>, \\u00e9 um mapa pr\\u00e1tico, \\u00e1gil e em um \\u00fanico portal que facilita sua pesquisa de informa\\u00e7\\u00f5es e posicionamentos de candidaturas ao Congresso Nacional nas Elei\\u00e7\\u00f5es de 2022, ampliando suas op\\u00e7\\u00f5es para um voto mais consciente e consequente com a Mudan\\u00e7a Clim\\u00e1tica, com o Meio Ambiente, com a Biodiversidade e com os Direitos Socioambientais. A participa\\u00e7\\u00e3o cidad\\u00e3 \\u00e9 livre, bem vinda, democr\\u00e1tica e sustent\\u00e1vel.</p>", "wagtail_admin_comments": []}	\N	3	1
\.


--
-- Data for Name: wagtailcore_pagesubscription; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_pagesubscription (id, comment_notifications, page_id, user_id) FROM stdin;
1	f	4	1
4	t	7	1
5	f	6	1
6	f	8	1
2	f	3	1
\.


--
-- Data for Name: wagtailcore_pageviewrestriction; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_pageviewrestriction (id, password, page_id, restriction_type) FROM stdin;
\.


--
-- Data for Name: wagtailcore_pageviewrestriction_groups; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_pageviewrestriction_groups (id, pageviewrestriction_id, group_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_site; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_site (id, hostname, port, is_default_site, root_page_id, site_name) FROM stdin;
1	localhost	80	t	3	
\.


--
-- Data for Name: wagtailcore_task; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_task (id, name, active, content_type_id) FROM stdin;
1	Moderators approval	t	2
\.


--
-- Data for Name: wagtailcore_taskstate; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_taskstate (id, status, started_at, finished_at, content_type_id, page_revision_id, task_id, workflow_state_id, finished_by_id, comment) FROM stdin;
\.


--
-- Data for Name: wagtailcore_workflow; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_workflow (id, name, active) FROM stdin;
1	Moderators approval	t
\.


--
-- Data for Name: wagtailcore_workflowpage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_workflowpage (page_id, workflow_id) FROM stdin;
1	1
\.


--
-- Data for Name: wagtailcore_workflowstate; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_workflowstate (id, status, created_at, current_task_state_id, page_id, requested_by_id, workflow_id) FROM stdin;
\.


--
-- Data for Name: wagtailcore_workflowtask; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailcore_workflowtask (id, sort_order, task_id, workflow_id) FROM stdin;
1	0	1	1
\.


--
-- Data for Name: wagtaildocs_document; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtaildocs_document (id, title, file, created_at, uploaded_by_user_id, collection_id, file_size, file_hash) FROM stdin;
\.


--
-- Data for Name: wagtaildocs_uploadeddocument; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtaildocs_uploadeddocument (id, file, uploaded_by_user_id) FROM stdin;
\.


--
-- Data for Name: wagtailembeds_embed; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailembeds_embed (id, url, max_width, type, html, title, author_name, provider_name, thumbnail_url, width, height, last_updated, hash, cache_until) FROM stdin;
\.


--
-- Data for Name: wagtailforms_formsubmission; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailforms_formsubmission (id, form_data, submit_time, page_id) FROM stdin;
\.


--
-- Data for Name: wagtailimages_image; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailimages_image (id, title, file, width, height, created_at, focal_point_x, focal_point_y, focal_point_width, focal_point_height, uploaded_by_user_id, file_size, collection_id, file_hash) FROM stdin;
\.


--
-- Data for Name: wagtailimages_rendition; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailimages_rendition (id, file, width, height, focal_point_key, filter_spec, image_id) FROM stdin;
\.


--
-- Data for Name: wagtailimages_uploadedimage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailimages_uploadedimage (id, file, uploaded_by_user_id) FROM stdin;
\.


--
-- Data for Name: wagtailredirects_redirect; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailredirects_redirect (id, old_path, is_permanent, redirect_link, redirect_page_id, site_id, automatically_created, created_at, redirect_page_route_path) FROM stdin;
1	/surveys	t		4	1	t	2022-06-27 20:23:08.481586+00	
\.


--
-- Data for Name: wagtailsearch_editorspick; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailsearch_editorspick (id, sort_order, description, page_id, query_id) FROM stdin;
\.


--
-- Data for Name: wagtailsearch_indexentry; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailsearch_indexentry (id, object_id, title_norm, content_type_id, autocomplete, title, body) FROM stdin;
\.


--
-- Data for Name: wagtailsearch_query; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailsearch_query (id, query_string) FROM stdin;
\.


--
-- Data for Name: wagtailsearch_querydailyhits; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailsearch_querydailyhits (id, date, hits, query_id) FROM stdin;
\.


--
-- Data for Name: wagtailstreamforms_form; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailstreamforms_form (id, title, slug, template_name, fields, submit_button_text, success_message, error_message, process_form_submission_hooks, post_redirect_page_id, site_id) FROM stdin;
1	Enquete	enquete	home/surveys/survey.html	[{"type": "category", "value": {"label": "Informa\\u00e7\\u00f5es do Candidato(a)"}, "id": "66f8642b-4122-439b-ba34-7f787b0f1b37"}, {"type": "singleline", "value": {"label": "Nome Completo", "help_text": "Nome Completo", "required": true, "default_value": ""}, "id": "12b33a93-ffa9-4444-9213-53c683cfc06a"}, {"type": "singleline", "value": {"label": "Nome de Campanha", "help_text": "Nome de Campanha", "required": true, "default_value": ""}, "id": "1e007b17-00eb-47a5-b251-41f6d3c23b4d"}, {"type": "number", "value": {"label": "CPF", "help_text": "O CPF do pr\\u00e9-candidato(a)", "required": true, "default_value": ""}, "id": "74738fb2-6231-48cb-bbcd-65af29057025"}, {"type": "email", "value": {"label": "E-mail", "help_text": "O e-mail do pr\\u00e9-candidato(a)", "required": true, "default_value": ""}, "id": "841ced8f-8825-48d3-9705-aa31c57b8610"}, {"type": "email", "value": {"label": "Confirma\\u00e7\\u00e3o de E-mail", "help_text": "O e-mail do pr\\u00e9-candidato(a)", "required": true, "default_value": ""}, "id": "aa8e95c9-a98b-4727-81be-95394beaaaee"}, {"type": "radio", "value": {"label": "\\u00c9 candidato(a) a qual vaga no pleito de 2022?", "help_text": "\\u00c9 candidato(a) a qual vaga no pleito de 2022?", "required": true, "choices": [{"type": "item", "value": "Deputado(a) Federal", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "Senador(a)", "id": "66cecd4f-2e1c-4138-bb4a-8fc028ce3be3"}]}, "id": "8a3a9fc4-ad4f-44b9-aaf2-d763529b0b28"}, {"type": "category", "value": {"label": "Redes Sociais"}, "id": "f2fb0894-35ac-49f8-a117-08bd73c22591"}, {"type": "url", "value": {"label": "Twitter", "help_text": "Twitter", "required": false, "default_value": ""}, "id": "dfa20a49-c363-4172-aabe-a9c3e31ecd8a"}, {"type": "url", "value": {"label": "Facebook", "help_text": "Facebook", "required": false, "default_value": ""}, "id": "1f98ca57-b3db-443b-82ce-00351db8efad"}, {"type": "url", "value": {"label": "Instagram", "help_text": "Instagram", "required": false, "default_value": ""}, "id": "fce7bab1-1640-4923-bedc-dddc3f8cc7a8"}, {"type": "url", "value": {"label": "Youtube", "help_text": "Youtube", "required": false, "default_value": ""}, "id": "a828672c-2c31-4d92-a5b9-293b8f4d5d7b"}, {"type": "category", "value": {"label": "Contato de gabinete / Coordena\\u00e7\\u00e3o de campanha"}, "id": "ad7a22e9-1d96-40c8-9257-0a25a6d74435"}, {"type": "singleline", "value": {"label": "Nome Completo do Contato", "help_text": "Nome Completo do Contato", "required": true, "default_value": ""}, "id": "e9e73d2f-4f0d-4f61-804c-94cc833635b2"}, {"type": "email", "value": {"label": "E-mail do contato", "help_text": "E-mail do contato", "required": true, "default_value": ""}, "id": "bda128b8-3c09-479d-b013-3b5028cfb287"}, {"type": "email", "value": {"label": "Confirma\\u00e7\\u00e3o do e-mail do contato", "help_text": "Confirma\\u00e7\\u00e3o do e-mail do contato", "required": true, "default_value": ""}, "id": "6fe20f45-2fc8-4f8b-9a2d-19875f51391b"}, {"type": "number", "value": {"label": "Telefone do contato", "help_text": "", "required": true, "default_value": ""}, "id": "aa03f3db-3035-4f6f-8aec-5cb37fe2ad0e"}, {"type": "url", "value": {"label": "Link para o site da campanha", "help_text": "Link para o site da campanha", "required": false, "default_value": ""}, "id": "6c482846-e045-430d-9ca0-c051cb87e007"}, {"type": "category", "value": {"label": "Domic\\u00edlio Eleitoral"}, "id": "2374e6a2-7ee7-4dd6-b3c4-0d22996a53ed"}, {"type": "dropdown", "value": {"label": "UF", "help_text": "UF", "required": true, "empty_label": "", "choices": [{"type": "item", "value": "AC", "id": "9d5434d4-4427-4eee-a8c3-1ebe5ae36eaa"}, {"type": "item", "value": "AL", "id": "f0d3a851-1c22-4fc7-bd3f-7a5eb18a12a9"}, {"type": "item", "value": "AP", "id": "b768881e-3764-4d90-a990-664cea35e91b"}, {"type": "item", "value": "AM", "id": "57486efd-db38-4382-ac7c-a3cdc73cc694"}, {"type": "item", "value": "BA", "id": "6d79f111-c783-4256-be5a-5d131f395785"}, {"type": "item", "value": "CE", "id": "fb386012-6db5-4380-8266-c7d5eb01b231"}, {"type": "item", "value": "DF", "id": "72b95b54-5332-4726-8225-bfce66adf1ed"}, {"type": "item", "value": "ES", "id": "6413c039-bca4-4ef7-86c7-f8aea32f0552"}, {"type": "item", "value": "GO", "id": "8326dbce-e547-4b15-b6d1-9ca02f5302ce"}, {"type": "item", "value": "MA", "id": "915547fd-cec9-415a-b0b6-2a393dce9335"}, {"type": "item", "value": "MT", "id": "321888f7-dea4-46ad-b296-a897d112693e"}, {"type": "item", "value": "MS", "id": "26fef399-0f2f-480e-98a6-4feea15f9e5d"}, {"type": "item", "value": "MG", "id": "c2394bf4-6bb2-43a7-b404-4649d9bcea35"}, {"type": "item", "value": "PA", "id": "630e87d4-aff6-49ff-a0c5-47fb85059289"}, {"type": "item", "value": "PB", "id": "404a4f9c-e817-458f-9ce2-8497ef7193af"}, {"type": "item", "value": "PR", "id": "599f0697-0340-47ac-8cc5-55316255aa46"}, {"type": "item", "value": "PE", "id": "1dfa656d-2a46-4bd7-9eb8-2018bf6e89db"}, {"type": "item", "value": "PI", "id": "62ee9031-e058-46b0-91e2-a40eb91d3c99"}, {"type": "item", "value": "RJ", "id": "a3a1abae-470c-448f-a734-6365d263b2e3"}, {"type": "item", "value": "RN", "id": "1773feb7-138c-4374-9790-7a0d68d7b667"}, {"type": "item", "value": "RS", "id": "9fd3d53c-fb73-4499-a805-283338e8bd3e"}, {"type": "item", "value": "RO", "id": "16122a01-3d52-4f39-94bd-d37acbbbdfa8"}, {"type": "item", "value": "RR", "id": "526b0fa8-5f39-4e01-9a0e-b4aa558f9adc"}, {"type": "item", "value": "SC", "id": "1b561dd1-fecc-4fef-9f92-2d2d3d471708"}, {"type": "item", "value": "SP", "id": "dc92a90c-aed6-405c-948e-c3c5c15e6eff"}, {"type": "item", "value": "SE", "id": "addee909-8b57-4e6a-8d94-4e808ffd9b4e"}, {"type": "item", "value": "TO", "id": "a756fc9b-d9fe-436a-b0d4-1a544c66e2fc"}]}, "id": "a3e3fa11-002d-4d3f-8ba2-d908d118737f"}, {"type": "singleline", "value": {"label": "Munic\\u00edpio", "help_text": "Munic\\u00edpio", "required": true, "default_value": ""}, "id": "c2f14fdf-e9fc-47c0-bb81-8f4be1cc02bc"}, {"type": "category", "value": {"label": "Perguntas"}, "id": "25f124fa-ff04-40f3-b2fe-1ee42bcbf3e9"}, {"type": "title", "value": {"label": "1. Clima"}, "id": "d66d1541-70fb-4895-85f0-d174d7443af0"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel \\u00e0 inclus\\u00e3o da \\u201cseguran\\u00e7a clim\\u00e1tica\\" em nossa Constitui\\u00e7\\u00e3o Federal, como direito fundamental (no art. 5\\u00ba), como princ\\u00edpio da Ordem Econ\\u00f4mica e Financeira Nacional (no art. 170) e como n\\u00facleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econ\\u00f4mico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudan\\u00e7a Clim\\u00e1tica no Brasil.", "help_text": "Sou favor\\u00e1vel \\u00e0 inclus\\u00e3o da \\u201cseguran\\u00e7a clim\\u00e1tica\\" em nossa Constitui\\u00e7\\u00e3o Federal, como direito fundamental (no art. 5\\u00ba), como princ\\u00edpio da Ordem Econ\\u00f4mica e Financeira Nacional (no art. 170) e como n\\u00facleo essencial do direito ao meio ambiente ecologicamente equilibrado (no art. 225), pois assim garantimos um novo pacto econ\\u00f4mico, ambiental e social entre empresas, governo e sociedade, em torno da agenda de Mudan\\u00e7a Clim\\u00e1tica no Brasil.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "f69fa9c7-f9ff-49fa-a89c-3ddd363c70e2"}, {"type": "title", "value": {"label": "2. \\u00c1gua"}, "id": "1f97e6bb-d9c8-4964-aa5b-28793fb3fe14"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel \\u00e0 inclus\\u00e3o do \\u201cacesso \\u00e0 \\u00e1gua pot\\u00e1vel e ao esgotamento sanit\\u00e1rio\\u201d no artigo 5\\u00b0 da Constitui\\u00e7\\u00e3o Federal, para entrarem formalmente no rol de direitos humanos fundamentais.", "help_text": "Sou favor\\u00e1vel \\u00e0 inclus\\u00e3o do \\u201cacesso \\u00e0 \\u00e1gua pot\\u00e1vel e ao esgotamento sanit\\u00e1rio\\u201d no artigo 5\\u00b0 da Constitui\\u00e7\\u00e3o Federal, para entrarem formalmente no rol de direitos humanos fundamentais.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "ecf0933b-ba1b-41da-a9df-42e91b0b7c81"}, {"type": "title", "value": {"label": "3. Desmatamento"}, "id": "48cf1995-7b5b-43b1-b4bb-fe2267e3a460"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel \\u00e0 pol\\u00edtica de \\u201cdesmatamento zero\\u201d em todos os biomas brasileiros, porque acredito ser poss\\u00edvel manter, e at\\u00e9 aumentar, a produ\\u00e7\\u00e3o agropecu\\u00e1ria atual sem novos desmatamentos, por meio da convers\\u00e3o de pastagens degradadas ou subaproveitadas.", "help_text": "Sou favor\\u00e1vel \\u00e0 pol\\u00edtica de \\u201cdesmatamento zero\\u201d em todos os biomas brasileiros, porque acredito ser poss\\u00edvel manter, e at\\u00e9 aumentar, a produ\\u00e7\\u00e3o agropecu\\u00e1ria atual sem novos desmatamentos, por meio da convers\\u00e3o de pastagens degradadas ou subaproveitadas.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "7dd188e6-4e4e-430d-81e2-ce4fdb984132"}, {"type": "title", "value": {"label": "4. Terras Ind\\u00edgenas"}, "id": "8a502403-6f63-4e64-bcc6-cddd0ebf4c2f"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel \\u00e0 retomada dos processos demarcat\\u00f3rios de Terras Ind\\u00edgenas no Brasil, pois sei que ainda h\\u00e1 mais de 200 processos pendentes, e concordo que os povos e as culturas ind\\u00edgenas contribuem para o enfrentamento da mudan\\u00e7a clim\\u00e1tica, para a conserva\\u00e7\\u00e3o dessas \\u00c1reas Protegidas e da sociobiodiversidade brasileira.", "help_text": "Sou favor\\u00e1vel \\u00e0 retomada dos processos demarcat\\u00f3rios de Terras Ind\\u00edgenas no Brasil, pois sei que ainda h\\u00e1 mais de 200 processos pendentes, e concordo que os povos e as culturas ind\\u00edgenas contribuem para o enfrentamento da mudan\\u00e7a clim\\u00e1tica, para a conserva\\u00e7\\u00e3o dessas \\u00c1reas Protegidas e da sociobiodiversidade brasileira.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "5f298652-cda4-4369-8001-6661342d47ee"}, {"type": "title", "value": {"label": "5. Reforma Tribut\\u00e1ria"}, "id": "0b7b3271-4011-42f8-86fb-5a197beb80db"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel a uma reforma e a uma pol\\u00edtica tribut\\u00e1ria socioambiental progressiva e promotora de sa\\u00fade, que reduza tributos sobre atividades econ\\u00f4micas com baixas emiss\\u00f5es de Gases de Efeito Estufa (GEE) e com baixo n\\u00edvel de polui\\u00e7\\u00e3o, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas \\u00e0 sa\\u00fade.", "help_text": "Sou favor\\u00e1vel a uma reforma e a uma pol\\u00edtica tribut\\u00e1ria socioambiental progressiva e promotora de sa\\u00fade, que reduza tributos sobre atividades econ\\u00f4micas com baixas emiss\\u00f5es de Gases de Efeito Estufa (GEE) e com baixo n\\u00edvel de polui\\u00e7\\u00e3o, e que, ao mesmo tempo, aumente tributos para atividades altamente emissoras de GEE, de poluentes ou nocivas \\u00e0 sa\\u00fade.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "59a6fa75-e040-4727-8f63-4cecadc2b74d"}, {"type": "title", "value": {"label": "6. Sa\\u00fade e Consumo"}, "id": "07e3417d-f61a-45b3-9e9d-f08c295b5b59"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel \\u00e0 redu\\u00e7\\u00e3o do consumo de produtos nocivos \\u00e0 sa\\u00fade e ao meio ambiente, tais como \\u00e1lcool e tabaco, alimentos ultraprocessados, agrot\\u00f3xicos e combust\\u00edveis f\\u00f3sseis, e concordo com a ado\\u00e7\\u00e3o de medidas regulat\\u00f3rias para esses produtos, como tributa\\u00e7\\u00e3o progressiva, restri\\u00e7\\u00e3o da publicidade, garantia de ambientes protegidos de seus efeitos e informa\\u00e7\\u00e3o adequada para seu consumo.", "help_text": "Sou favor\\u00e1vel \\u00e0 redu\\u00e7\\u00e3o do consumo de produtos nocivos \\u00e0 sa\\u00fade e ao meio ambiente, tais como \\u00e1lcool e tabaco, alimentos ultraprocessados, agrot\\u00f3xicos e combust\\u00edveis f\\u00f3sseis, e concordo com a ado\\u00e7\\u00e3o de medidas regulat\\u00f3rias para esses produtos, como tributa\\u00e7\\u00e3o progressiva, restri\\u00e7\\u00e3o da publicidade, garantia de ambientes protegidos de seus efeitos e informa\\u00e7\\u00e3o adequada para seu consumo.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "446b106b-4528-4117-a0f9-4de40a94798e"}, {"type": "title", "value": {"label": "7. Defesa Agropecu\\u00e1ria e Agrot\\u00f3xicos"}, "id": "42720de5-d975-470a-a5bb-18c4344be1bc"}, {"type": "radio", "value": {"label": "Sou contra a flexibiliza\\u00e7\\u00e3o das leis de Defesa Agropecu\\u00e1ria, pois os programas de autocontrole geridos pelas empresas do setor n\\u00e3o devem substituir o poder p\\u00fablico na fiscaliza\\u00e7\\u00e3o da qualidade de rebanhos, de lavouras e de seus produtos, assim como n\\u00e3o concordo com a flexibiliza\\u00e7\\u00e3o das regras para registro e utiliza\\u00e7\\u00e3o de agrot\\u00f3xicos e pesticidas no Brasil.", "help_text": "Sou contra a flexibiliza\\u00e7\\u00e3o das leis de Defesa Agropecu\\u00e1ria, pois os programas de autocontrole geridos pelas empresas do setor n\\u00e3o devem substituir o poder p\\u00fablico na fiscaliza\\u00e7\\u00e3o da qualidade de rebanhos, de lavouras e de seus produtos, assim como n\\u00e3o concordo com a flexibiliza\\u00e7\\u00e3o das regras para registro e utiliza\\u00e7\\u00e3o de agrot\\u00f3xicos e pesticidas no Brasil.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "09c8756f-beaa-41bb-b914-b7f3c0deba42"}, {"type": "title", "value": {"label": "8. Unidades de Conserva\\u00e7\\u00e3o"}, "id": "46a68ba5-cce8-497c-b509-cc0dde028d9d"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel \\u00e0s parcerias entre o setor p\\u00fablico e o setor privado para a implementa\\u00e7\\u00e3o e gest\\u00e3o sustent\\u00e1vel de Parques Nacionais, Parques Estaduais e outras Unidades de Conserva\\u00e7\\u00e3o onde seja permitido o uso p\\u00fablico.", "help_text": "Sou favor\\u00e1vel \\u00e0s parcerias entre o setor p\\u00fablico e o setor privado para a implementa\\u00e7\\u00e3o e gest\\u00e3o sustent\\u00e1vel de Parques Nacionais, Parques Estaduais e outras Unidades de Conserva\\u00e7\\u00e3o onde seja permitido o uso p\\u00fablico.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "53d2db41-4e2b-4369-b443-ef04a1886268"}, {"type": "title", "value": {"label": "9. Ca\\u00e7a de animais silvestres"}, "id": "7891cb1b-a34a-4237-bb4d-428ef84a95cf"}, {"type": "radio", "value": {"label": "Sou contra a libera\\u00e7\\u00e3o da ca\\u00e7a de animais silvestres no Brasil, excetuadas as situa\\u00e7\\u00f5es j\\u00e1 previstas na Lei Federal n\\u00ba 5.197/1967, como o controle de esp\\u00e9cies invasoras e de animais silvestres considerados nocivos \\u00e0 agricultura ou \\u00e0 sa\\u00fade p\\u00fablica.", "help_text": "Sou contra a libera\\u00e7\\u00e3o da ca\\u00e7a de animais silvestres no Brasil, excetuadas as situa\\u00e7\\u00f5es j\\u00e1 previstas na Lei Federal n\\u00ba 5.197/1967, como o controle de esp\\u00e9cies invasoras e de animais silvestres considerados nocivos \\u00e0 agricultura ou \\u00e0 sa\\u00fade p\\u00fablica.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "200b45b2-b2df-48e7-a0e7-79a59bd4509a"}, {"type": "title", "value": {"label": "10. Mata Atl\\u00e2ntica"}, "id": "a3188f2d-ed58-4776-858d-bda14c6f1e01"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel ao Fundo de Restaura\\u00e7\\u00e3o do Bioma Mata Atl\\u00e2ntica e me comprometo a apoiar sua implanta\\u00e7\\u00e3o, conforme a Lei Federal n\\u00ba 11.428/2006, visando \\u00e0 conserva\\u00e7\\u00e3o de remanescentes de vegeta\\u00e7\\u00e3o nativa, \\u00e0 pesquisa cient\\u00edfica ou \\u00e0 restaura\\u00e7\\u00e3o, pois sei que apenas 7% da cobertura original da Mata Atl\\u00e2ntica ainda est\\u00e1 de p\\u00e9.", "help_text": "Sou favor\\u00e1vel ao Fundo de Restaura\\u00e7\\u00e3o do Bioma Mata Atl\\u00e2ntica e me comprometo a apoiar sua implanta\\u00e7\\u00e3o, conforme a Lei Federal n\\u00ba 11.428/2006, visando \\u00e0 conserva\\u00e7\\u00e3o de remanescentes de vegeta\\u00e7\\u00e3o nativa, \\u00e0 pesquisa cient\\u00edfica ou \\u00e0 restaura\\u00e7\\u00e3o, pois sei que apenas 7% da cobertura original da Mata Atl\\u00e2ntica ainda est\\u00e1 de p\\u00e9.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "4e36c3c6-4dba-487b-8e4d-5429af230404"}, {"type": "title", "value": {"label": "11. Pantanal"}, "id": "3d8516f5-fe16-44d6-b040-8c09079f2c8c"}, {"type": "radio", "value": {"label": "Sou contra o plantio de soja nas plan\\u00edcies inund\\u00e1veis do bioma Pantanal brasileiro, que \\u00e9 considerado Patrim\\u00f4nio Nacional pela Constitui\\u00e7\\u00e3o Federal (\\u00a7 4\\u00ba do art. 225) e Reserva da Biosfera pelas Na\\u00e7\\u00f5es Unidas.", "help_text": "Sou contra o plantio de soja nas plan\\u00edcies inund\\u00e1veis do bioma Pantanal brasileiro, que \\u00e9 considerado Patrim\\u00f4nio Nacional pela Constitui\\u00e7\\u00e3o Federal (\\u00a7 4\\u00ba do art. 225) e Reserva da Biosfera pelas Na\\u00e7\\u00f5es Unidas.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "6091ce55-f166-4a2f-b7b8-e0bbea183d5e"}, {"type": "title", "value": {"label": "12. Amaz\\u00f4nia e Cerrado"}, "id": "4f9cc44c-db58-48f2-9182-990ffe28f518"}, {"type": "radio", "value": {"label": "Sou favor\\u00e1vel \\u00e0 destina\\u00e7\\u00e3o dos 60 milh\\u00f5es de hectares de florestas p\\u00fablicas n\\u00e3o destinadas na Amaz\\u00f4nia e no Cerrado para o uso sustent\\u00e1vel, a conserva\\u00e7\\u00e3o ambiental e a prote\\u00e7\\u00e3o dos povos ind\\u00edgenas, quilombolas, pequenos produtores extrativistas e Unidades de Conserva\\u00e7\\u00e3o, pois sei que esta medida \\u00e9 imprescind\\u00edvel para a economia das regi\\u00f5es citadas e o equil\\u00edbrio clim\\u00e1tico de todo o planeta.", "help_text": "Sou favor\\u00e1vel \\u00e0 destina\\u00e7\\u00e3o dos 60 milh\\u00f5es de hectares de florestas p\\u00fablicas n\\u00e3o destinadas na Amaz\\u00f4nia e no Cerrado para o uso sustent\\u00e1vel, a conserva\\u00e7\\u00e3o ambiental e a prote\\u00e7\\u00e3o dos povos ind\\u00edgenas, quilombolas, pequenos produtores extrativistas e Unidades de Conserva\\u00e7\\u00e3o, pois sei que esta medida \\u00e9 imprescind\\u00edvel para a economia das regi\\u00f5es citadas e o equil\\u00edbrio clim\\u00e1tico de todo o planeta.", "required": true, "choices": [{"type": "item", "value": "Sim", "id": "eafc84e3-1063-450b-9489-1bc9aee98215"}, {"type": "item", "value": "N\\u00e3o", "id": "20302a32-2c6d-4a08-a246-75a6da4900b9"}, {"type": "item", "value": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "id": "b6640986-a374-4eb3-9477-29eb8a771ef5"}]}, "id": "1b9c0623-b08e-4075-a9e5-00635c66bc11"}, {"type": "title", "value": {"label": "Termo de Consentimento"}, "id": "8dbc5787-2806-4dfb-a645-066098600d26"}, {"type": "checkboxes", "value": {"label": "Eu declaro, para fins da legisla\\u00e7\\u00e3o aplic\\u00e1vel (civil, penal, administrativa e eleitoral) que sou a/o (pr\\u00e9)candidata/o titular dos dados e informa\\u00e7\\u00f5es declarados ou tenho expressa autoriza\\u00e7\\u00e3o da/o pr\\u00f3pria/o para preencher este formul\\u00e1rio em seu nome e plenos poderes para autorizar a publica\\u00e7\\u00e3o destas informa\\u00e7\\u00f5es, gratuitamente, sem qualquer \\u00f4nus, no Painel Farol Verde para a finalidade de torn\\u00e1-las acess\\u00edveis a todos os eleitores interessados. Por oportuno, declaro ci\\u00eancia de que a presta\\u00e7\\u00e3o de informa\\u00e7\\u00f5es falsas ou a utiliza\\u00e7\\u00e3o de falsa identifica\\u00e7\\u00e3o pessoal podem ensejar responsabiliza\\u00e7\\u00e3o por crime contra a identidade, previstos no C\\u00f3digo Penal.", "help_text": "Eu declaro, para fins da legisla\\u00e7\\u00e3o aplic\\u00e1vel (civil, penal, administrativa e eleitoral) que sou a/o (pr\\u00e9)candidata/o titular dos dados e informa\\u00e7\\u00f5es declarados ou tenho expressa autoriza\\u00e7\\u00e3o da/o pr\\u00f3pria/o para preencher este formul\\u00e1rio em seu nome e plenos poderes para autorizar a publica\\u00e7\\u00e3o destas informa\\u00e7\\u00f5es, gratuitamente, sem qualquer \\u00f4nus, no Painel Farol Verde para a finalidade de torn\\u00e1-las acess\\u00edveis a todos os eleitores interessados. Por oportuno, declaro ci\\u00eancia de que a presta\\u00e7\\u00e3o de informa\\u00e7\\u00f5es falsas ou a utiliza\\u00e7\\u00e3o de falsa identifica\\u00e7\\u00e3o pessoal podem ensejar responsabiliza\\u00e7\\u00e3o por crime contra a identidade, previstos no C\\u00f3digo Penal.", "required": true, "choices": [{"type": "item", "value": "Declaro.", "id": "3206be3f-8f8d-484f-8365-51d3e2fbb363"}]}, "id": "e13b491a-15ff-4428-bb4b-b2abc38f7ba5"}]	Enviar Enquete	Obrigado pelas informações! Entraremos em contato. O Farol Verde agradece sua participação.	Erro na submissão. Verifique os campos abaixo.	save_form_submission_data	4	\N
2	Contato	contato	home/surveys/survey.html	[{"type": "category", "value": {"label": "Contato"}, "id": "96aa3804-c5cb-4051-8f96-00ef4cc17d3a"}, {"type": "title", "value": {"label": "Deixe seu contato e n\\u00f3s vamos avisar!"}, "id": "eb9e2545-9603-4305-9f26-14d2f0a36818"}, {"type": "singleline", "value": {"label": "Nome Completo", "help_text": "", "required": true, "default_value": ""}, "id": "e431b045-b7dd-4edb-8c9d-6370bff4dd2d"}, {"type": "email", "value": {"label": "E-mail", "help_text": "", "required": true, "default_value": ""}, "id": "1ddb2f07-f7e7-4eaf-a56f-b8e321e56f22"}, {"type": "email", "value": {"label": "Confirma\\u00e7\\u00e3o de e-mail", "help_text": "", "required": true, "default_value": ""}, "id": "638abffd-025b-4692-8d54-f3e828f7263f"}, {"type": "checkboxes", "value": {"label": "Autorizo o recebimento de email avisando sobre o lan\\u00e7amento e sobre eventuais atualiza\\u00e7\\u00f5es do Painel Farol Verde.", "help_text": "", "required": true, "choices": [{"type": "item", "value": "Sim, autorizo.", "id": "d20ea14a-91a3-4df7-9698-e1e694acfb76"}]}, "id": "8ee292d5-ac48-4253-970a-1e4357e213e1"}, {"type": "title", "value": {"label": "N\\u00e3o enviaremos qualquer outro email ou SPAM, jamais!"}, "id": "25428695-a065-49b6-83c8-010ce9ccf00c"}]	Enviar	Obrigado!		save_form_submission_data	8	\N
\.


--
-- Data for Name: wagtailstreamforms_formsubmission; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailstreamforms_formsubmission (id, form_data, submit_time, form_id) FROM stdin;
8	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Mateus B Fernandes", "e-mail": "mateus@idsbrasil.org", "confirmacao-de-e-mail": "mateus@idsbrasil.org", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": [], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 19:30:52.396862+00	2
9	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Mateus B Fernandes", "e-mail": "mateus@idsbrasil.org", "confirmacao-de-e-mail": "mateus@idsbrasil.org", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 19:35:37.702032+00	2
10	{"informacoes-do-candidatoa": "", "nome-completo": "Raphael Sebba Daher Fleury Curado", "nome-de-campanha": "Raphael Sebba", "cpf": "1285313127", "e-mail": "raphael.sebba@gmail.com", "confirmacao-de-e-mail": "raphael.sebba@gmail.com", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "https://twitter.com/raphaelsebba", "facebook": "https://m.facebook.com/raphael.sebba", "instagram": "https://instagram.com/raphaelsebba", "youtube": "https://youtube.com/c/RaphaelSebba", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "Brunna Azevedo Palmer", "e-mail-do-contato": "brunna.palmer@gmail.com", "confirmacao-do-e-mail-do-contato": "brunna.palmer@gmail.com", "telefone-do-contato": "61981268741", "link-para-o-site-da-campanha": "http://www.raphaelebba.com.br", "domicilio-eleitoral": "", "uf": "DF", "municipio": "Bras\\u00edlia", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Sim", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 20:09:17.918919+00	1
11	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Mateus B Fernandes", "e-mail": "mateus@idsbrasil.org", "confirmacao-de-e-mail": "mateus@idsbrasil.org", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 20:25:38.962824+00	2
12	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Andr\\u00e9 Lima", "e-mail": "alima1271@gmail.com", "confirmacao-de-e-mail": "alima1271@gmail.com", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 21:49:37.577938+00	2
13	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Val\\u00e9ria Leone Muguet", "e-mail": "leone.advogada@otmail.com", "confirmacao-de-e-mail": "leone.advogada@otmail.com", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 22:33:04.475506+00	2
14	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Haiuly Viana Gon\\u00e7alves de Oliveira", "e-mail": "haiuly.viana@gmail.com", "confirmacao-de-e-mail": "haiuly.viana@gmail.com", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 22:47:53.289257+00	2
15	{"informacoes-do-candidatoa": "", "nome-completo": "Pedro Ivo de Souza Batista", "nome-de-campanha": "Pedro Ivo e o Mandato Coletivo (provis\\u00f3rio)", "cpf": "13938169320", "e-mail": "batista.pedroivo@gmail.com", "confirmacao-de-e-mail": "batista.pedroivo@gmail.com", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Senador(a)", "redes-sociais": "", "twitter": "", "facebook": "", "instagram": "http://batista.pedroivo", "youtube": "", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "Everardo Aguiar", "e-mail-do-contato": "everardodeaguiar@gmail.com", "confirmacao-do-e-mail-do-contato": "everardodeaguiar@gmail.com", "telefone-do-contato": "61995583207", "link-para-o-site-da-campanha": "", "domicilio-eleitoral": "", "uf": "AC", "municipio": "Bras\\u00edlia", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 23:08:39.009548+00	1
16	{"informacoes-do-candidatoa": "", "nome-completo": "Rodrigo Antonio de Agostinho Mendon\\u00e7a", "nome-de-campanha": "Rodrigo Agostinho", "cpf": "26742283858", "e-mail": "rodrigo@rodrigoagostinho.com.br", "confirmacao-de-e-mail": "rodrigo@rodrigoagostinho.com.br", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "", "facebook": "", "instagram": "", "youtube": "", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "Rodrigo Agostinho", "e-mail-do-contato": "rodrigo@rodrigoagostinho.com.br", "confirmacao-do-e-mail-do-contato": "rodrigo@rodrigoagostinho.com.br", "telefone-do-contato": "14997726570", "link-para-o-site-da-campanha": "http://www.rodrigoagostinho.com.br", "domicilio-eleitoral": "", "uf": "SP", "municipio": "Bauru", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Sim", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 23:23:12.566844+00	1
17	{"informacoes-do-candidatoa": "", "nome-completo": "Jana\\u00edna Ferrato Elias", "nome-de-campanha": "BANCADA ECOSSISTEMA", "cpf": "32804590879", "e-mail": "jana.ferrato@uol.com.br", "confirmacao-de-e-mail": "jana.ferrato@uol.com.br", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "", "facebook": "https://fb.watch/e4wp6DJjTj/", "instagram": "https://instagram.com/bancada.ecossistema?igshid=YmMyMTA2M2Y=", "youtube": "", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "Patr\\u00edcia Claudia Aguiar", "e-mail-do-contato": "patriciaclaudia.aguiar@gmail.com", "confirmacao-do-e-mail-do-contato": "patriciaclaudia.aguiar@gmail.com", "telefone-do-contato": "11994248215", "link-para-o-site-da-campanha": "https://fb.watch/e4wp6DJjTj/", "domicilio-eleitoral": "", "uf": "AC", "municipio": "Itaquaquecetuba", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Sim", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-05 23:40:14.91775+00	1
18	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Caio T\\u00falio Vieira Costa", "e-mail": "caio@caete.biz", "confirmacao-de-e-mail": "caio@caete.biz", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-06 13:39:21.20309+00	2
19	{"informacoes-do-candidatoa": "", "nome-completo": "Thiago de Souza Bagatin", "nome-de-campanha": "Mandato Coletivo Ekoa", "cpf": "760448906", "e-mail": "lucianopadilha85@gmail.com", "confirmacao-de-e-mail": "lucianopadilha85@gmail.com", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "https://twitter.com/EkoaMandato", "facebook": "https://www.facebook.com/search/top/?q=coletivo%20ekoa", "instagram": "https://www.instagram.com/coletivoekoa/", "youtube": "https://www.youtube.com/channel/UCroCiLDMJVfIZCg38RBTzkQ", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "luciano padilha becker", "e-mail-do-contato": "lucianopadilha85@gmail.com", "confirmacao-do-e-mail-do-contato": "lucianopadilha85@gmail.com", "telefone-do-contato": "41988132834", "link-para-o-site-da-campanha": "", "domicilio-eleitoral": "", "uf": "AC", "municipio": "Curitiba", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Sim", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-06 14:20:35.700637+00	1
20	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "M\\u00f4nica Mercedes da Rosa", "e-mail": "monicamr33.2012@hotmail.com", "confirmacao-de-e-mail": "monicamr33.2012@hotmail.com", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 02:48:21.317354+00	2
21	{"informacoes-do-candidatoa": "", "nome-completo": "Alexandre Lu\\u00eds Nobre Terreri", "nome-de-campanha": "Alexandre Terreri", "cpf": "11547719893", "e-mail": "alexandreterreri18@gmail.com", "confirmacao-de-e-mail": "alexandreterreri18@gmail.com", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "https://twitter.com/AleTerreri18", "facebook": "https://www.facebook.com/alexandreterreri/", "instagram": "https://www.instagram.com/aleterreri/?hl=pt-br", "youtube": "", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "Alexandre Lu\\u00eds Nobre Terreri", "e-mail-do-contato": "alexandreterreri18@gmail.com", "confirmacao-do-e-mail-do-contato": "alexandreterreri18@gmail.com", "telefone-do-contato": "11966227479", "link-para-o-site-da-campanha": "", "domicilio-eleitoral": "", "uf": "AC", "municipio": "S\\u00e3o Paulo", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Sim", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 11:56:29.207697+00	1
22	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Luciana Claro Artilheiro", "e-mail": "artilheirosustentabilidade@gmail.com", "confirmacao-de-e-mail": "artilheirosustentabilidade@gmail.com", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 15:05:22.61162+00	2
23	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "Luciana Claro Artilheiro", "e-mail": "artilheirosustentabilidade@gmail.com", "confirmacao-de-e-mail": "artilheirosustentabilidade@gmail.com", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 15:05:35.999565+00	2
24	{"informacoes-do-candidatoa": "", "nome-completo": "Roberto Cabral Borges", "nome-de-campanha": "Roberto CABRAL", "cpf": "81983069604", "e-mail": "rcabralborges@gmail.com", "confirmacao-de-e-mail": "rcabralborges@gmail.com", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "", "facebook": "", "instagram": "", "youtube": "", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "Roberto Cabral Borges", "e-mail-do-contato": "rcabralborges@gmail.com", "confirmacao-do-e-mail-do-contato": "rcabralborges@gmail.com", "telefone-do-contato": "61999883066", "link-para-o-site-da-campanha": "http://redesustentabilidade.org.br", "domicilio-eleitoral": "", "uf": "AC", "municipio": "Bras\\u00edlia", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Sim", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 15:10:55.920876+00	1
25	{"informacoes-do-candidatoa": "", "nome-completo": "Maria Isabel Lopes da Cunha Soares", "nome-de-campanha": "Bezinha Soares", "cpf": "17370900827", "e-mail": "bezinhacunhasoares@gmail.com", "confirmacao-de-e-mail": "bezinhacunhasoares@gmail.com", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "https://twitter.com/Bezinhaisa", "facebook": "https://www.facebook.com/bezinhac/", "instagram": "https://www.instagram.com/bezinhasoares.sp/", "youtube": "", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "Luiz Antonio Magalh\\u00e3es", "e-mail-do-contato": "luiz.magalhaes@lam.comunicacao.com", "confirmacao-do-e-mail-do-contato": "luiz.magalhaes@lam.comunicacao.com", "telefone-do-contato": "11989111830", "link-para-o-site-da-campanha": "", "domicilio-eleitoral": "", "uf": "AC", "municipio": "S\\u00e3o Paulo", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Sim", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 16:02:23.811166+00	1
26	{"informacoes-do-candidatoa": "", "nome-completo": "Jana\\u00edna Ferrato Elias", "nome-de-campanha": "BANCADA ECOSSISTEMA", "cpf": "32804590879", "e-mail": "jana.ferrato@uol.com.br", "confirmacao-de-e-mail": "jana.ferrato@uol.com.br", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "https://twitter.com/home", "facebook": "https://www.facebook.com/106082205416428/posts/pfbid0qrm3L3vASrfZ5GJF9dmFdj4ZEovwzJxeABzsH9Qe586ybQ2Y72y3HdmSfvWrCk3zl/", "instagram": "https://instagram.com/bancada.ecossistema?igshid=YmMyMTA2M2Y=", "youtube": "https://www.youtube.com/", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "Patr\\u00edcia Claudia Aguiar", "e-mail-do-contato": "patriciaclaudia.aguiar@gmail.com", "confirmacao-do-e-mail-do-contato": "patriciaclaudia.aguiar@gmail.com", "telefone-do-contato": "11997998336", "link-para-o-site-da-campanha": "https://www.facebook.com/106082205416428/posts/pfbid0qrm3L3vASrfZ5GJF9dmFdj4ZEovwzJxeABzsH9Qe586ybQ2Y72y3HdmSfvWrCk3zl/", "domicilio-eleitoral": "", "uf": "AC", "municipio": "Itaquaquecetuba", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Sim", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "Sim", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 21:11:32.919646+00	1
27	{"informacoes-do-candidatoa": "", "nome-completo": "t", "nome-de-campanha": "teste", "cpf": "0", "e-mail": "teste@gmail.br", "confirmacao-de-e-mail": "teste@gmail.br", "e-candidatoa-a-qual-vaga-no-pleito-de-2022": "Deputado(a) Federal", "redes-sociais": "", "twitter": "http://twitter.com/testeTT", "facebook": "http://twitter.com/testeFb", "instagram": "http://twitter.com/testeIG", "youtube": "http://twitter.com/testeYT", "contato-de-gabinete-coordenacao-de-campanha": "", "nome-completo-do-contato": "t", "e-mail-do-contato": "teste@gmail.com", "confirmacao-do-e-mail-do-contato": "teste@gmail.com", "telefone-do-contato": "0", "link-para-o-site-da-campanha": "", "domicilio-eleitoral": "", "uf": "AC", "municipio": "AC", "perguntas": "", "1-clima": "", "sou-favoravel-a-inclusao-da-seguranca-climatica-em-nossa-constituicao-federal-como-direito-fundamental-no-art-5o-como-principio-da-ordem-economica-e-financeira-nacional-no-art-170-e-como-nucleo-essencial-do-direito-ao-meio-ambiente-ecologicamente-equilibrado-no-art-225-pois-assim-garantimos-um-novo-pacto-economico-ambiental-e-social-entre-empresas-governo-e-sociedade-em-torno-da-agenda-de-mudanca-climatica-no-brasil": "Sim", "2-agua": "", "sou-favoravel-a-inclusao-do-acesso-a-agua-potavel-e-ao-esgotamento-sanitario-no-artigo-5deg-da-constituicao-federal-para-entrarem-formalmente-no-rol-de-direitos-humanos-fundamentais": "Sim", "3-desmatamento": "", "sou-favoravel-a-politica-de-desmatamento-zero-em-todos-os-biomas-brasileiros-porque-acredito-ser-possivel-manter-e-ate-aumentar-a-producao-agropecuaria-atual-sem-novos-desmatamentos-por-meio-da-conversao-de-pastagens-degradadas-ou-subaproveitadas": "Sim", "4-terras-indigenas": "", "sou-favoravel-a-retomada-dos-processos-demarcatorios-de-terras-indigenas-no-brasil-pois-sei-que-ainda-ha-mais-de-200-processos-pendentes-e-concordo-que-os-povos-e-as-culturas-indigenas-contribuem-para-o-enfrentamento-da-mudanca-climatica-para-a-conservacao-dessas-areas-protegidas-e-da-sociobiodiversidade-brasileira": "Sim", "5-reforma-tributaria": "", "sou-favoravel-a-uma-reforma-e-a-uma-politica-tributaria-socioambiental-progressiva-e-promotora-de-saude-que-reduza-tributos-sobre-atividades-economicas-com-baixas-emissoes-de-gases-de-efeito-estufa-gee-e-com-baixo-nivel-de-poluicao-e-que-ao-mesmo-tempo-aumente-tributos-para-atividades-altamente-emissoras-de-gee-de-poluentes-ou-nocivas-a-saude": "Sim", "6-saude-e-consumo": "", "sou-favoravel-a-reducao-do-consumo-de-produtos-nocivos-a-saude-e-ao-meio-ambiente-tais-como-alcool-e-tabaco-alimentos-ultraprocessados-agrotoxicos-e-combustiveis-fosseis-e-concordo-com-a-adocao-de-medidas-regulatorias-para-esses-produtos-como-tributacao-progressiva-restricao-da-publicidade-garantia-de-ambientes-protegidos-de-seus-efeitos-e-informacao-adequada-para-seu-consumo": "Prefiro n\\u00e3o responder / N\\u00e3o sei", "7-defesa-agropecuaria-e-agrotoxicos": "", "sou-contra-a-flexibilizacao-das-leis-de-defesa-agropecuaria-pois-os-programas-de-autocontrole-geridos-pelas-empresas-do-setor-nao-devem-substituir-o-poder-publico-na-fiscalizacao-da-qualidade-de-rebanhos-de-lavouras-e-de-seus-produtos-assim-como-nao-concordo-com-a-flexibilizacao-das-regras-para-registro-e-utilizacao-de-agrotoxicos-e-pesticidas-no-brasil": "Sim", "8-unidades-de-conservacao": "", "sou-favoravel-as-parcerias-entre-o-setor-publico-e-o-setor-privado-para-a-implementacao-e-gestao-sustentavel-de-parques-nacionais-parques-estaduais-e-outras-unidades-de-conservacao-onde-seja-permitido-o-uso-publico": "N\\u00e3o", "9-caca-de-animais-silvestres": "", "sou-contra-a-liberacao-da-caca-de-animais-silvestres-no-brasil-excetuadas-as-situacoes-ja-previstas-na-lei-federal-no-51971967-como-o-controle-de-especies-invasoras-e-de-animais-silvestres-considerados-nocivos-a-agricultura-ou-a-saude-publica": "Sim", "10-mata-atlantica": "", "sou-favoravel-ao-fundo-de-restauracao-do-bioma-mata-atlantica-e-me-comprometo-a-apoiar-sua-implantacao-conforme-a-lei-federal-no-114282006-visando-a-conservacao-de-remanescentes-de-vegetacao-nativa-a-pesquisa-cientifica-ou-a-restauracao-pois-sei-que-apenas-7-da-cobertura-original-da-mata-atlantica-ainda-esta-de-pe": "Sim", "11-pantanal": "", "sou-contra-o-plantio-de-soja-nas-planicies-inundaveis-do-bioma-pantanal-brasileiro-que-e-considerado-patrimonio-nacional-pela-constituicao-federal-ss-4o-do-art-225-e-reserva-da-biosfera-pelas-nacoes-unidas": "Sim", "12-amazonia-e-cerrado": "", "sou-favoravel-a-destinacao-dos-60-milhoes-de-hectares-de-florestas-publicas-nao-destinadas-na-amazonia-e-no-cerrado-para-o-uso-sustentavel-a-conservacao-ambiental-e-a-protecao-dos-povos-indigenas-quilombolas-pequenos-produtores-extrativistas-e-unidades-de-conservacao-pois-sei-que-esta-medida-e-imprescindivel-para-a-economia-das-regioes-citadas-e-o-equilibrio-climatico-de-todo-o-planeta": "Sim", "termo-de-consentimento": "", "eu-declaro-para-fins-da-legislacao-aplicavel-civil-penal-administrativa-e-eleitoral-que-sou-ao-precandidatao-titular-dos-dados-e-informacoes-declarados-ou-tenho-expressa-autorizacao-dao-propriao-para-preencher-este-formulario-em-seu-nome-e-plenos-poderes-para-autorizar-a-publicacao-destas-informacoes-gratuitamente-sem-qualquer-onus-no-painel-farol-verde-para-a-finalidade-de-torna-las-acessiveis-a-todos-os-eleitores-interessados-por-oportuno-declaro-ciencia-de-que-a-prestacao-de-informacoes-falsas-ou-a-utilizacao-de-falsa-identificacao-pessoal-podem-ensejar-responsabilizacao-por-crime-contra-a-identidade-previstos-no-codigo-penal": ["Declaro."], "form_id": "1", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 21:27:56.550968+00	1
28	{"contato": "", "deixe-seu-contato-e-nos-vamos-avisar": "", "nome-completo": "t", "e-mail": "teste@gmail.br", "confirmacao-de-e-mail": "teste@gmail.br", "autorizo-o-recebimento-de-email-avisando-sobre-o-lancamento-e-sobre-eventuais-atualizacoes-do-painel-farol-verde": ["Sim, autorizo."], "nao-enviaremos-qualquer-outro-email-ou-spam-jamais": "", "form_id": "2", "form_reference": "68ae4dd4-9c5c-4fa6-806e-cffd57880eb9"}	2022-07-07 22:51:54.756727+00	2
\.


--
-- Data for Name: wagtailstreamforms_formsubmissionfile; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailstreamforms_formsubmissionfile (id, field, file, submission_id) FROM stdin;
\.


--
-- Data for Name: wagtailusers_userprofile; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.wagtailusers_userprofile (id, submitted_notifications, approved_notifications, rejected_notifications, user_id, preferred_language, current_time_zone, avatar, updated_comments_notifications) FROM stdin;
1	t	t	t	1				t
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 2, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 18, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 211, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: blog_blogcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.blog_blogcategory_id_seq', 1, true);


--
-- Name: blog_blogpostcard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.blog_blogpostcard_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 53, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 172, true);


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.taggit_tag_id_seq', 1, false);


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.taggit_taggeditem_id_seq', 1, false);


--
-- Name: wagtailadmin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailadmin_admin_id_seq', 1, false);


--
-- Name: wagtailcore_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_collection_id_seq', 2, true);


--
-- Name: wagtailcore_collectionviewrestriction_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_collectionviewrestriction_groups_id_seq', 1, false);


--
-- Name: wagtailcore_collectionviewrestriction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_collectionviewrestriction_id_seq', 1, false);


--
-- Name: wagtailcore_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_comment_id_seq', 1, false);


--
-- Name: wagtailcore_commentreply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_commentreply_id_seq', 1, false);


--
-- Name: wagtailcore_groupapprovaltask_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_groupapprovaltask_groups_id_seq', 1, true);


--
-- Name: wagtailcore_groupcollectionpermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_groupcollectionpermission_id_seq', 12, true);


--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_grouppagepermission_id_seq', 7, true);


--
-- Name: wagtailcore_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_locale_id_seq', 1, true);


--
-- Name: wagtailcore_modellogentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_modellogentry_id_seq', 30, true);


--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_page_id_seq', 8, true);


--
-- Name: wagtailcore_pagelogentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_pagelogentry_id_seq', 47, true);


--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_pagerevision_id_seq', 28, true);


--
-- Name: wagtailcore_pagesubscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_pagesubscription_id_seq', 6, true);


--
-- Name: wagtailcore_pageviewrestriction_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_pageviewrestriction_groups_id_seq', 1, false);


--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_pageviewrestriction_id_seq', 1, false);


--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_site_id_seq', 1, true);


--
-- Name: wagtailcore_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_task_id_seq', 1, true);


--
-- Name: wagtailcore_taskstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_taskstate_id_seq', 1, false);


--
-- Name: wagtailcore_workflow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_workflow_id_seq', 1, true);


--
-- Name: wagtailcore_workflowstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_workflowstate_id_seq', 1, false);


--
-- Name: wagtailcore_workflowtask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailcore_workflowtask_id_seq', 1, true);


--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtaildocs_document_id_seq', 1, false);


--
-- Name: wagtaildocs_uploadeddocument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtaildocs_uploadeddocument_id_seq', 1, false);


--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailembeds_embed_id_seq', 1, false);


--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailforms_formsubmission_id_seq', 1, false);


--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailimages_image_id_seq', 1, false);


--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailimages_rendition_id_seq', 1, false);


--
-- Name: wagtailimages_uploadedimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailimages_uploadedimage_id_seq', 1, false);


--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailredirects_redirect_id_seq', 1, true);


--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailsearch_editorspick_id_seq', 1, false);


--
-- Name: wagtailsearch_indexentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailsearch_indexentry_id_seq', 1, false);


--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailsearch_query_id_seq', 1, false);


--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailsearch_querydailyhits_id_seq', 1, false);


--
-- Name: wagtailstreamforms_form_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailstreamforms_form_id_seq', 2, true);


--
-- Name: wagtailstreamforms_formsubmission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailstreamforms_formsubmission_id_seq', 28, true);


--
-- Name: wagtailstreamforms_formsubmissionfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailstreamforms_formsubmissionfile_id_seq', 1, false);


--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.wagtailusers_userprofile_id_seq', 1, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: blog_blogcategory blog_blogcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogcategory
    ADD CONSTRAINT blog_blogcategory_pkey PRIMARY KEY (id);


--
-- Name: blog_blogindexpage blog_blogindexpage_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogindexpage
    ADD CONSTRAINT blog_blogindexpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: blog_blogpost blog_blogpost_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogpost
    ADD CONSTRAINT blog_blogpost_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: blog_blogpostcard blog_blogpostcard_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogpostcard
    ADD CONSTRAINT blog_blogpostcard_pkey PRIMARY KEY (id);


--
-- Name: candidate_candidateindexpage candidate_candidateindexpage_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.candidate_candidateindexpage
    ADD CONSTRAINT candidate_candidateindexpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: candidate_candidatepage candidate_candidatepage_id_autor_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.candidate_candidatepage
    ADD CONSTRAINT candidate_candidatepage_id_autor_key UNIQUE (id_autor);


--
-- Name: candidate_candidatepage candidate_candidatepage_id_parlametria_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.candidate_candidatepage
    ADD CONSTRAINT candidate_candidatepage_id_parlametria_key UNIQUE (id_parlametria);


--
-- Name: candidate_candidatepage candidate_candidatepage_id_serenata_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.candidate_candidatepage
    ADD CONSTRAINT candidate_candidatepage_id_serenata_key UNIQUE (id_serenata);


--
-- Name: candidate_candidatepage candidate_candidatepage_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.candidate_candidatepage
    ADD CONSTRAINT candidate_candidatepage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: home_landingpage home_landingpage_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.home_landingpage
    ADD CONSTRAINT home_landingpage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: home_surveyspage home_surveyspage_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.home_surveyspage
    ADD CONSTRAINT home_surveyspage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: taggit_tag taggit_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_name_key UNIQUE (name);


--
-- Name: taggit_tag taggit_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag taggit_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_slug_key UNIQUE (slug);


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_object_i_4bb97a8e_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_object_i_4bb97a8e_uniq UNIQUE (content_type_id, object_id, tag_id);


--
-- Name: taggit_taggeditem taggit_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: wagtailadmin_admin wagtailadmin_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailadmin_admin
    ADD CONSTRAINT wagtailadmin_admin_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collection wagtailcore_collection_path_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collection
    ADD CONSTRAINT wagtailcore_collection_path_key UNIQUE (path);


--
-- Name: wagtailcore_collection wagtailcore_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collection
    ADD CONSTRAINT wagtailcore_collection_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collectionvi_collectionviewrestrictio_988995ae_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collectionvi_collectionviewrestrictio_988995ae_uniq UNIQUE (collectionviewrestriction_id, group_id);


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collectionviewrestriction_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collectionviewrestriction_groups_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_collectionviewrestriction wagtailcore_collectionviewrestriction_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction
    ADD CONSTRAINT wagtailcore_collectionviewrestriction_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_comment wagtailcore_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_commentreply wagtailcore_commentreply_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_commentreply
    ADD CONSTRAINT wagtailcore_commentreply_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_groupapprovaltask_groups wagtailcore_groupapprova_groupapprovaltask_id_gro_bb5ee7eb_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups
    ADD CONSTRAINT wagtailcore_groupapprova_groupapprovaltask_id_gro_bb5ee7eb_uniq UNIQUE (groupapprovaltask_id, group_id);


--
-- Name: wagtailcore_groupapprovaltask_groups wagtailcore_groupapprovaltask_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups
    ADD CONSTRAINT wagtailcore_groupapprovaltask_groups_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_groupapprovaltask wagtailcore_groupapprovaltask_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask
    ADD CONSTRAINT wagtailcore_groupapprovaltask_pkey PRIMARY KEY (task_ptr_id);


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcollect_group_id_collection_id_p_a21cefe9_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcollect_group_id_collection_id_p_a21cefe9_uniq UNIQUE (group_id, collection_id, permission_id);


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcollectionpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcollectionpermission_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppageper_group_id_page_id_permiss_0898bdf8_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppageper_group_id_page_id_permiss_0898bdf8_uniq UNIQUE (group_id, page_id, permission_type);


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppagepermission_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppagepermission_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_locale wagtailcore_locale_language_code_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_locale
    ADD CONSTRAINT wagtailcore_locale_language_code_key UNIQUE (language_code);


--
-- Name: wagtailcore_locale wagtailcore_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_locale
    ADD CONSTRAINT wagtailcore_locale_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_modellogentry wagtailcore_modellogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_modellogentry
    ADD CONSTRAINT wagtailcore_modellogentry_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_page wagtailcore_page_path_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_path_key UNIQUE (path);


--
-- Name: wagtailcore_page wagtailcore_page_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_page wagtailcore_page_translation_key_locale_id_9b041bad_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_translation_key_locale_id_9b041bad_uniq UNIQUE (translation_key, locale_id);


--
-- Name: wagtailcore_pagelogentry wagtailcore_pagelogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagelogentry
    ADD CONSTRAINT wagtailcore_pagelogentry_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pagerevision wagtailcore_pagerevision_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pagerevision_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pagesubscription wagtailcore_pagesubscription_page_id_user_id_0cef73ed_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription
    ADD CONSTRAINT wagtailcore_pagesubscription_page_id_user_id_0cef73ed_uniq UNIQUE (page_id, user_id);


--
-- Name: wagtailcore_pagesubscription wagtailcore_pagesubscription_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription
    ADD CONSTRAINT wagtailcore_pagesubscription_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageviewrest_pageviewrestriction_id_g_d23f80bb_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageviewrest_pageviewrestriction_id_g_d23f80bb_uniq UNIQUE (pageviewrestriction_id, group_id);


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageviewrestriction_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageviewrestriction_groups_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pageviewrestriction wagtailcore_pageviewrestriction_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction
    ADD CONSTRAINT wagtailcore_pageviewrestriction_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_site wagtailcore_site_hostname_port_2c626d70_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_hostname_port_2c626d70_uniq UNIQUE (hostname, port);


--
-- Name: wagtailcore_site wagtailcore_site_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_task wagtailcore_task_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_task
    ADD CONSTRAINT wagtailcore_task_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_taskstate wagtailcore_taskstate_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstate_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_workflow wagtailcore_workflow_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflow
    ADD CONSTRAINT wagtailcore_workflow_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_workflowpage wagtailcore_workflowpage_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowpage
    ADD CONSTRAINT wagtailcore_workflowpage_pkey PRIMARY KEY (page_id);


--
-- Name: wagtailcore_workflowstate wagtailcore_workflowstate_current_task_state_id_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflowstate_current_task_state_id_key UNIQUE (current_task_state_id);


--
-- Name: wagtailcore_workflowstate wagtailcore_workflowstate_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflowstate_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_workflowtask wagtailcore_workflowtask_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowtask
    ADD CONSTRAINT wagtailcore_workflowtask_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_workflowtask wagtailcore_workflowtask_workflow_id_task_id_4ec7a62b_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowtask
    ADD CONSTRAINT wagtailcore_workflowtask_workflow_id_task_id_4ec7a62b_uniq UNIQUE (workflow_id, task_id);


--
-- Name: wagtaildocs_document wagtaildocs_document_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_pkey PRIMARY KEY (id);


--
-- Name: wagtaildocs_uploadeddocument wagtaildocs_uploadeddocument_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtaildocs_uploadeddocument
    ADD CONSTRAINT wagtaildocs_uploadeddocument_pkey PRIMARY KEY (id);


--
-- Name: wagtailembeds_embed wagtailembeds_embed_hash_c9bd8c9a_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailembeds_embed
    ADD CONSTRAINT wagtailembeds_embed_hash_c9bd8c9a_uniq UNIQUE (hash);


--
-- Name: wagtailembeds_embed wagtailembeds_embed_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailembeds_embed
    ADD CONSTRAINT wagtailembeds_embed_pkey PRIMARY KEY (id);


--
-- Name: wagtailforms_formsubmission wagtailforms_formsubmission_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailforms_formsubmission
    ADD CONSTRAINT wagtailforms_formsubmission_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_image wagtailimages_image_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_rendition wagtailimages_rendition_image_id_filter_spec_foc_323c8fe0_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendition_image_id_filter_spec_foc_323c8fe0_uniq UNIQUE (image_id, filter_spec, focal_point_key);


--
-- Name: wagtailimages_rendition wagtailimages_rendition_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendition_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_uploadedimage wagtailimages_uploadedimage_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_uploadedimage
    ADD CONSTRAINT wagtailimages_uploadedimage_pkey PRIMARY KEY (id);


--
-- Name: wagtailredirects_redirect wagtailredirects_redirect_old_path_site_id_783622d7_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_redirect_old_path_site_id_783622d7_uniq UNIQUE (old_path, site_id);


--
-- Name: wagtailredirects_redirect wagtailredirects_redirect_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_redirect_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_editorspick wagtailsearch_editorspick_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_editorspick
    ADD CONSTRAINT wagtailsearch_editorspick_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_indexentry wagtailsearch_indexentry_content_type_id_object_i_bcd7ba73_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_indexentry
    ADD CONSTRAINT wagtailsearch_indexentry_content_type_id_object_i_bcd7ba73_uniq UNIQUE (content_type_id, object_id);


--
-- Name: wagtailsearch_indexentry wagtailsearch_indexentry_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_indexentry
    ADD CONSTRAINT wagtailsearch_indexentry_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_query wagtailsearch_query_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_query
    ADD CONSTRAINT wagtailsearch_query_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_query wagtailsearch_query_query_string_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_query
    ADD CONSTRAINT wagtailsearch_query_query_string_key UNIQUE (query_string);


--
-- Name: wagtailsearch_querydailyhits wagtailsearch_querydailyhits_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsearch_querydailyhits_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_querydailyhits wagtailsearch_querydailyhits_query_id_date_1dd232e6_uniq; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsearch_querydailyhits_query_id_date_1dd232e6_uniq UNIQUE (query_id, date);


--
-- Name: wagtailstreamforms_form wagtailstreamforms_form_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_form
    ADD CONSTRAINT wagtailstreamforms_form_pkey PRIMARY KEY (id);


--
-- Name: wagtailstreamforms_form wagtailstreamforms_form_slug_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_form
    ADD CONSTRAINT wagtailstreamforms_form_slug_key UNIQUE (slug);


--
-- Name: wagtailstreamforms_formsubmission wagtailstreamforms_formsubmission_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_formsubmission
    ADD CONSTRAINT wagtailstreamforms_formsubmission_pkey PRIMARY KEY (id);


--
-- Name: wagtailstreamforms_formsubmissionfile wagtailstreamforms_formsubmissionfile_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_formsubmissionfile
    ADD CONSTRAINT wagtailstreamforms_formsubmissionfile_pkey PRIMARY KEY (id);


--
-- Name: wagtailusers_userprofile wagtailusers_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_pkey PRIMARY KEY (id);


--
-- Name: wagtailusers_userprofile wagtailusers_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: blog_blogpost_category_id_0e9835dd; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX blog_blogpost_category_id_0e9835dd ON public.blog_blogpost USING btree (category_id);


--
-- Name: blog_blogpostcard_content_object_id_fcef1803; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX blog_blogpostcard_content_object_id_fcef1803 ON public.blog_blogpostcard USING btree (content_object_id);


--
-- Name: blog_blogpostcard_tag_id_e51c9c2d; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX blog_blogpostcard_tag_id_e51c9c2d ON public.blog_blogpostcard USING btree (tag_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: taggit_tag_name_58eb2ed9_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX taggit_tag_name_58eb2ed9_like ON public.taggit_tag USING btree (name varchar_pattern_ops);


--
-- Name: taggit_tag_slug_6be58b2c_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX taggit_tag_slug_6be58b2c_like ON public.taggit_tag USING btree (slug varchar_pattern_ops);


--
-- Name: taggit_taggeditem_content_type_id_9957a03c; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX taggit_taggeditem_content_type_id_9957a03c ON public.taggit_taggeditem USING btree (content_type_id);


--
-- Name: taggit_taggeditem_content_type_id_object_id_196cc965_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX taggit_taggeditem_content_type_id_object_id_196cc965_idx ON public.taggit_taggeditem USING btree (content_type_id, object_id);


--
-- Name: taggit_taggeditem_object_id_e2d7d1df; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX taggit_taggeditem_object_id_e2d7d1df ON public.taggit_taggeditem USING btree (object_id);


--
-- Name: taggit_taggeditem_tag_id_f4f5b767; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX taggit_taggeditem_tag_id_f4f5b767 ON public.taggit_taggeditem USING btree (tag_id);


--
-- Name: unique_in_progress_workflow; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unique_in_progress_workflow ON public.wagtailcore_workflowstate USING btree (page_id) WHERE ((status)::text = ANY ((ARRAY['in_progress'::character varying, 'needs_changes'::character varying])::text[]));


--
-- Name: wagtailcore_collection_path_d848dc19_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_collection_path_d848dc19_like ON public.wagtailcore_collection USING btree (path varchar_pattern_ops);


--
-- Name: wagtailcore_collectionview_collectionviewrestriction__47320efd; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_collectionview_collectionviewrestriction__47320efd ON public.wagtailcore_collectionviewrestriction_groups USING btree (collectionviewrestriction_id);


--
-- Name: wagtailcore_collectionviewrestriction_collection_id_761908ec; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_collectionviewrestriction_collection_id_761908ec ON public.wagtailcore_collectionviewrestriction USING btree (collection_id);


--
-- Name: wagtailcore_collectionviewrestriction_groups_group_id_1823f2a3; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_collectionviewrestriction_groups_group_id_1823f2a3 ON public.wagtailcore_collectionviewrestriction_groups USING btree (group_id);


--
-- Name: wagtailcore_comment_page_id_108444b5; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_comment_page_id_108444b5 ON public.wagtailcore_comment USING btree (page_id);


--
-- Name: wagtailcore_comment_resolved_by_id_a282aa0e; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_comment_resolved_by_id_a282aa0e ON public.wagtailcore_comment USING btree (resolved_by_id);


--
-- Name: wagtailcore_comment_revision_created_id_1d058279; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_comment_revision_created_id_1d058279 ON public.wagtailcore_comment USING btree (revision_created_id);


--
-- Name: wagtailcore_comment_user_id_0c577ca6; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_comment_user_id_0c577ca6 ON public.wagtailcore_comment USING btree (user_id);


--
-- Name: wagtailcore_commentreply_comment_id_afc7e027; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_commentreply_comment_id_afc7e027 ON public.wagtailcore_commentreply USING btree (comment_id);


--
-- Name: wagtailcore_commentreply_user_id_d0b3b9c3; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_commentreply_user_id_d0b3b9c3 ON public.wagtailcore_commentreply USING btree (user_id);


--
-- Name: wagtailcore_groupapprovalt_groupapprovaltask_id_9a9255ea; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_groupapprovalt_groupapprovaltask_id_9a9255ea ON public.wagtailcore_groupapprovaltask_groups USING btree (groupapprovaltask_id);


--
-- Name: wagtailcore_groupapprovaltask_groups_group_id_2e64b61f; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_groupapprovaltask_groups_group_id_2e64b61f ON public.wagtailcore_groupapprovaltask_groups USING btree (group_id);


--
-- Name: wagtailcore_groupcollectionpermission_collection_id_5423575a; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_groupcollectionpermission_collection_id_5423575a ON public.wagtailcore_groupcollectionpermission USING btree (collection_id);


--
-- Name: wagtailcore_groupcollectionpermission_group_id_05d61460; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_groupcollectionpermission_group_id_05d61460 ON public.wagtailcore_groupcollectionpermission USING btree (group_id);


--
-- Name: wagtailcore_groupcollectionpermission_permission_id_1b626275; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_groupcollectionpermission_permission_id_1b626275 ON public.wagtailcore_groupcollectionpermission USING btree (permission_id);


--
-- Name: wagtailcore_grouppagepermission_group_id_fc07e671; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_grouppagepermission_group_id_fc07e671 ON public.wagtailcore_grouppagepermission USING btree (group_id);


--
-- Name: wagtailcore_grouppagepermission_page_id_710b114a; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_grouppagepermission_page_id_710b114a ON public.wagtailcore_grouppagepermission USING btree (page_id);


--
-- Name: wagtailcore_locale_language_code_03149338_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_locale_language_code_03149338_like ON public.wagtailcore_locale USING btree (language_code varchar_pattern_ops);


--
-- Name: wagtailcore_modellogentry_action_d2d856ee; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_modellogentry_action_d2d856ee ON public.wagtailcore_modellogentry USING btree (action);


--
-- Name: wagtailcore_modellogentry_action_d2d856ee_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_modellogentry_action_d2d856ee_like ON public.wagtailcore_modellogentry USING btree (action varchar_pattern_ops);


--
-- Name: wagtailcore_modellogentry_content_changed_8bc39742; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_modellogentry_content_changed_8bc39742 ON public.wagtailcore_modellogentry USING btree (content_changed);


--
-- Name: wagtailcore_modellogentry_content_type_id_68849e77; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_modellogentry_content_type_id_68849e77 ON public.wagtailcore_modellogentry USING btree (content_type_id);


--
-- Name: wagtailcore_modellogentry_object_id_e0e7d4ef; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_modellogentry_object_id_e0e7d4ef ON public.wagtailcore_modellogentry USING btree (object_id);


--
-- Name: wagtailcore_modellogentry_object_id_e0e7d4ef_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_modellogentry_object_id_e0e7d4ef_like ON public.wagtailcore_modellogentry USING btree (object_id varchar_pattern_ops);


--
-- Name: wagtailcore_modellogentry_timestamp_9694521b; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_modellogentry_timestamp_9694521b ON public.wagtailcore_modellogentry USING btree ("timestamp");


--
-- Name: wagtailcore_modellogentry_user_id_0278d1bf; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_modellogentry_user_id_0278d1bf ON public.wagtailcore_modellogentry USING btree (user_id);


--
-- Name: wagtailcore_page_alias_of_id_12945502; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_alias_of_id_12945502 ON public.wagtailcore_page USING btree (alias_of_id);


--
-- Name: wagtailcore_page_content_type_id_c28424df; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_content_type_id_c28424df ON public.wagtailcore_page USING btree (content_type_id);


--
-- Name: wagtailcore_page_first_published_at_2b5dd637; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_first_published_at_2b5dd637 ON public.wagtailcore_page USING btree (first_published_at);


--
-- Name: wagtailcore_page_live_revision_id_930bd822; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_live_revision_id_930bd822 ON public.wagtailcore_page USING btree (live_revision_id);


--
-- Name: wagtailcore_page_locale_id_3c7e30a6; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_locale_id_3c7e30a6 ON public.wagtailcore_page USING btree (locale_id);


--
-- Name: wagtailcore_page_locked_by_id_bcb86245; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_locked_by_id_bcb86245 ON public.wagtailcore_page USING btree (locked_by_id);


--
-- Name: wagtailcore_page_owner_id_fbf7c332; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_owner_id_fbf7c332 ON public.wagtailcore_page USING btree (owner_id);


--
-- Name: wagtailcore_page_path_98eba2c8_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_path_98eba2c8_like ON public.wagtailcore_page USING btree (path varchar_pattern_ops);


--
-- Name: wagtailcore_page_slug_e7c11b8f; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_slug_e7c11b8f ON public.wagtailcore_page USING btree (slug);


--
-- Name: wagtailcore_page_slug_e7c11b8f_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_page_slug_e7c11b8f_like ON public.wagtailcore_page USING btree (slug varchar_pattern_ops);


--
-- Name: wagtailcore_pagelogentry_action_c2408198; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagelogentry_action_c2408198 ON public.wagtailcore_pagelogentry USING btree (action);


--
-- Name: wagtailcore_pagelogentry_action_c2408198_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagelogentry_action_c2408198_like ON public.wagtailcore_pagelogentry USING btree (action varchar_pattern_ops);


--
-- Name: wagtailcore_pagelogentry_content_changed_99f27ade; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagelogentry_content_changed_99f27ade ON public.wagtailcore_pagelogentry USING btree (content_changed);


--
-- Name: wagtailcore_pagelogentry_content_type_id_74e7708a; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagelogentry_content_type_id_74e7708a ON public.wagtailcore_pagelogentry USING btree (content_type_id);


--
-- Name: wagtailcore_pagelogentry_page_id_8464e327; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagelogentry_page_id_8464e327 ON public.wagtailcore_pagelogentry USING btree (page_id);


--
-- Name: wagtailcore_pagelogentry_revision_id_8043d103; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagelogentry_revision_id_8043d103 ON public.wagtailcore_pagelogentry USING btree (revision_id);


--
-- Name: wagtailcore_pagelogentry_timestamp_deb774c4; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagelogentry_timestamp_deb774c4 ON public.wagtailcore_pagelogentry USING btree ("timestamp");


--
-- Name: wagtailcore_pagelogentry_user_id_604ccfd8; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagelogentry_user_id_604ccfd8 ON public.wagtailcore_pagelogentry USING btree (user_id);


--
-- Name: wagtailcore_pagerevision_approved_go_live_at_e56afc67; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagerevision_approved_go_live_at_e56afc67 ON public.wagtailcore_pagerevision USING btree (approved_go_live_at);


--
-- Name: wagtailcore_pagerevision_created_at_66954e3b; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagerevision_created_at_66954e3b ON public.wagtailcore_pagerevision USING btree (created_at);


--
-- Name: wagtailcore_pagerevision_page_id_d421cc1d; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagerevision_page_id_d421cc1d ON public.wagtailcore_pagerevision USING btree (page_id);


--
-- Name: wagtailcore_pagerevision_submitted_for_moderation_c682e44c; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagerevision_submitted_for_moderation_c682e44c ON public.wagtailcore_pagerevision USING btree (submitted_for_moderation);


--
-- Name: wagtailcore_pagerevision_user_id_2409d2f4; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagerevision_user_id_2409d2f4 ON public.wagtailcore_pagerevision USING btree (user_id);


--
-- Name: wagtailcore_pagesubscription_page_id_a085e7a6; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagesubscription_page_id_a085e7a6 ON public.wagtailcore_pagesubscription USING btree (page_id);


--
-- Name: wagtailcore_pagesubscription_user_id_89d7def9; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pagesubscription_user_id_89d7def9 ON public.wagtailcore_pagesubscription USING btree (user_id);


--
-- Name: wagtailcore_pageviewrestri_pageviewrestriction_id_f147a99a; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pageviewrestri_pageviewrestriction_id_f147a99a ON public.wagtailcore_pageviewrestriction_groups USING btree (pageviewrestriction_id);


--
-- Name: wagtailcore_pageviewrestriction_groups_group_id_6460f223; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pageviewrestriction_groups_group_id_6460f223 ON public.wagtailcore_pageviewrestriction_groups USING btree (group_id);


--
-- Name: wagtailcore_pageviewrestriction_page_id_15a8bea6; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_pageviewrestriction_page_id_15a8bea6 ON public.wagtailcore_pageviewrestriction USING btree (page_id);


--
-- Name: wagtailcore_site_hostname_96b20b46; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_site_hostname_96b20b46 ON public.wagtailcore_site USING btree (hostname);


--
-- Name: wagtailcore_site_hostname_96b20b46_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_site_hostname_96b20b46_like ON public.wagtailcore_site USING btree (hostname varchar_pattern_ops);


--
-- Name: wagtailcore_site_root_page_id_e02fb95c; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_site_root_page_id_e02fb95c ON public.wagtailcore_site USING btree (root_page_id);


--
-- Name: wagtailcore_task_content_type_id_249ab8ba; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_task_content_type_id_249ab8ba ON public.wagtailcore_task USING btree (content_type_id);


--
-- Name: wagtailcore_taskstate_content_type_id_0a758fdc; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_taskstate_content_type_id_0a758fdc ON public.wagtailcore_taskstate USING btree (content_type_id);


--
-- Name: wagtailcore_taskstate_finished_by_id_13f98229; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_taskstate_finished_by_id_13f98229 ON public.wagtailcore_taskstate USING btree (finished_by_id);


--
-- Name: wagtailcore_taskstate_page_revision_id_9f52c88e; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_taskstate_page_revision_id_9f52c88e ON public.wagtailcore_taskstate USING btree (page_revision_id);


--
-- Name: wagtailcore_taskstate_task_id_c3677c34; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_taskstate_task_id_c3677c34 ON public.wagtailcore_taskstate USING btree (task_id);


--
-- Name: wagtailcore_taskstate_workflow_state_id_9239a775; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_taskstate_workflow_state_id_9239a775 ON public.wagtailcore_taskstate USING btree (workflow_state_id);


--
-- Name: wagtailcore_workflowpage_workflow_id_56f56ff6; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_workflowpage_workflow_id_56f56ff6 ON public.wagtailcore_workflowpage USING btree (workflow_id);


--
-- Name: wagtailcore_workflowstate_page_id_6c962862; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_workflowstate_page_id_6c962862 ON public.wagtailcore_workflowstate USING btree (page_id);


--
-- Name: wagtailcore_workflowstate_requested_by_id_4090bca3; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_workflowstate_requested_by_id_4090bca3 ON public.wagtailcore_workflowstate USING btree (requested_by_id);


--
-- Name: wagtailcore_workflowstate_workflow_id_1f18378f; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_workflowstate_workflow_id_1f18378f ON public.wagtailcore_workflowstate USING btree (workflow_id);


--
-- Name: wagtailcore_workflowtask_task_id_ce7716fe; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_workflowtask_task_id_ce7716fe ON public.wagtailcore_workflowtask USING btree (task_id);


--
-- Name: wagtailcore_workflowtask_workflow_id_b9717175; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailcore_workflowtask_workflow_id_b9717175 ON public.wagtailcore_workflowtask USING btree (workflow_id);


--
-- Name: wagtaildocs_document_collection_id_23881625; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtaildocs_document_collection_id_23881625 ON public.wagtaildocs_document USING btree (collection_id);


--
-- Name: wagtaildocs_document_uploaded_by_user_id_17258b41; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtaildocs_document_uploaded_by_user_id_17258b41 ON public.wagtaildocs_document USING btree (uploaded_by_user_id);


--
-- Name: wagtaildocs_uploadeddocument_uploaded_by_user_id_8dd61a73; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtaildocs_uploadeddocument_uploaded_by_user_id_8dd61a73 ON public.wagtaildocs_uploadeddocument USING btree (uploaded_by_user_id);


--
-- Name: wagtailembeds_embed_cache_until_26c94bb0; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailembeds_embed_cache_until_26c94bb0 ON public.wagtailembeds_embed USING btree (cache_until);


--
-- Name: wagtailembeds_embed_hash_c9bd8c9a_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailembeds_embed_hash_c9bd8c9a_like ON public.wagtailembeds_embed USING btree (hash varchar_pattern_ops);


--
-- Name: wagtailforms_formsubmission_page_id_e48e93e7; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailforms_formsubmission_page_id_e48e93e7 ON public.wagtailforms_formsubmission USING btree (page_id);


--
-- Name: wagtailimages_image_collection_id_c2f8af7e; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailimages_image_collection_id_c2f8af7e ON public.wagtailimages_image USING btree (collection_id);


--
-- Name: wagtailimages_image_created_at_86fa6cd4; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailimages_image_created_at_86fa6cd4 ON public.wagtailimages_image USING btree (created_at);


--
-- Name: wagtailimages_image_uploaded_by_user_id_5d73dc75; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailimages_image_uploaded_by_user_id_5d73dc75 ON public.wagtailimages_image USING btree (uploaded_by_user_id);


--
-- Name: wagtailimages_rendition_filter_spec_1cba3201; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailimages_rendition_filter_spec_1cba3201 ON public.wagtailimages_rendition USING btree (filter_spec);


--
-- Name: wagtailimages_rendition_filter_spec_1cba3201_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailimages_rendition_filter_spec_1cba3201_like ON public.wagtailimages_rendition USING btree (filter_spec varchar_pattern_ops);


--
-- Name: wagtailimages_rendition_image_id_3e1fd774; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailimages_rendition_image_id_3e1fd774 ON public.wagtailimages_rendition USING btree (image_id);


--
-- Name: wagtailimages_uploadedimage_uploaded_by_user_id_85921689; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailimages_uploadedimage_uploaded_by_user_id_85921689 ON public.wagtailimages_uploadedimage USING btree (uploaded_by_user_id);


--
-- Name: wagtailredirects_redirect_old_path_bb35247b; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailredirects_redirect_old_path_bb35247b ON public.wagtailredirects_redirect USING btree (old_path);


--
-- Name: wagtailredirects_redirect_old_path_bb35247b_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailredirects_redirect_old_path_bb35247b_like ON public.wagtailredirects_redirect USING btree (old_path varchar_pattern_ops);


--
-- Name: wagtailredirects_redirect_redirect_page_id_b5728a8f; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailredirects_redirect_redirect_page_id_b5728a8f ON public.wagtailredirects_redirect USING btree (redirect_page_id);


--
-- Name: wagtailredirects_redirect_site_id_780a0e1e; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailredirects_redirect_site_id_780a0e1e ON public.wagtailredirects_redirect USING btree (site_id);


--
-- Name: wagtailsear_autocom_476c89_gin; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailsear_autocom_476c89_gin ON public.wagtailsearch_indexentry USING gin (autocomplete);


--
-- Name: wagtailsear_body_90c85d_gin; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailsear_body_90c85d_gin ON public.wagtailsearch_indexentry USING gin (body);


--
-- Name: wagtailsear_title_9caae0_gin; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailsear_title_9caae0_gin ON public.wagtailsearch_indexentry USING gin (title);


--
-- Name: wagtailsearch_editorspick_page_id_28cbc274; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailsearch_editorspick_page_id_28cbc274 ON public.wagtailsearch_editorspick USING btree (page_id);


--
-- Name: wagtailsearch_editorspick_query_id_c6eee4a0; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailsearch_editorspick_query_id_c6eee4a0 ON public.wagtailsearch_editorspick USING btree (query_id);


--
-- Name: wagtailsearch_indexentry_content_type_id_62ed694f; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailsearch_indexentry_content_type_id_62ed694f ON public.wagtailsearch_indexentry USING btree (content_type_id);


--
-- Name: wagtailsearch_query_query_string_e785ea07_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailsearch_query_query_string_e785ea07_like ON public.wagtailsearch_query USING btree (query_string varchar_pattern_ops);


--
-- Name: wagtailsearch_querydailyhits_query_id_2185994b; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailsearch_querydailyhits_query_id_2185994b ON public.wagtailsearch_querydailyhits USING btree (query_id);


--
-- Name: wagtailstreamforms_form_post_redirect_page_id_03dfbd9e; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailstreamforms_form_post_redirect_page_id_03dfbd9e ON public.wagtailstreamforms_form USING btree (post_redirect_page_id);


--
-- Name: wagtailstreamforms_form_site_id_ae22c770; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailstreamforms_form_site_id_ae22c770 ON public.wagtailstreamforms_form USING btree (site_id);


--
-- Name: wagtailstreamforms_form_slug_8d60112f_like; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailstreamforms_form_slug_8d60112f_like ON public.wagtailstreamforms_form USING btree (slug varchar_pattern_ops);


--
-- Name: wagtailstreamforms_formsubmission_form_id_b73d2bb2; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailstreamforms_formsubmission_form_id_b73d2bb2 ON public.wagtailstreamforms_formsubmission USING btree (form_id);


--
-- Name: wagtailstreamforms_formsubmissionfile_submission_id_8d4718e1; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX wagtailstreamforms_formsubmissionfile_submission_id_8d4718e1 ON public.wagtailstreamforms_formsubmissionfile USING btree (submission_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogindexpage blog_blogindexpage_page_ptr_id_d87c3ac2_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogindexpage
    ADD CONSTRAINT blog_blogindexpage_page_ptr_id_d87c3ac2_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogpost blog_blogpost_category_id_0e9835dd_fk_blog_blogcategory_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogpost
    ADD CONSTRAINT blog_blogpost_category_id_0e9835dd_fk_blog_blogcategory_id FOREIGN KEY (category_id) REFERENCES public.blog_blogcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogpost blog_blogpost_page_ptr_id_5b917bdd_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogpost
    ADD CONSTRAINT blog_blogpost_page_ptr_id_5b917bdd_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogpostcard blog_blogpostcard_content_object_id_fcef1803_fk_blog_blog; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogpostcard
    ADD CONSTRAINT blog_blogpostcard_content_object_id_fcef1803_fk_blog_blog FOREIGN KEY (content_object_id) REFERENCES public.blog_blogpost(page_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: blog_blogpostcard blog_blogpostcard_tag_id_e51c9c2d_fk_taggit_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.blog_blogpostcard
    ADD CONSTRAINT blog_blogpostcard_tag_id_e51c9c2d_fk_taggit_tag_id FOREIGN KEY (tag_id) REFERENCES public.taggit_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: candidate_candidateindexpage candidate_candidatei_page_ptr_id_43aca678_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.candidate_candidateindexpage
    ADD CONSTRAINT candidate_candidatei_page_ptr_id_43aca678_fk_wagtailco FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: candidate_candidatepage candidate_candidatep_page_ptr_id_50c23722_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.candidate_candidatepage
    ADD CONSTRAINT candidate_candidatep_page_ptr_id_50c23722_fk_wagtailco FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: home_landingpage home_landingpage_page_ptr_id_5eef927c_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.home_landingpage
    ADD CONSTRAINT home_landingpage_page_ptr_id_5eef927c_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: home_surveyspage home_surveyspage_page_ptr_id_00ba86f8_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.home_surveyspage
    ADD CONSTRAINT home_surveyspage_page_ptr_id_00ba86f8_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_9957a03c_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_9957a03c_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id FOREIGN KEY (tag_id) REFERENCES public.taggit_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_collectionviewrestriction wagtailcore_collecti_collection_id_761908ec_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction
    ADD CONSTRAINT wagtailcore_collecti_collection_id_761908ec_fk_wagtailco FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collecti_collectionviewrestri_47320efd_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collecti_collectionviewrestri_47320efd_fk_wagtailco FOREIGN KEY (collectionviewrestriction_id) REFERENCES public.wagtailcore_collectionviewrestriction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_collectionviewrestriction_groups wagtailcore_collecti_group_id_1823f2a3_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_collectionviewrestriction_groups
    ADD CONSTRAINT wagtailcore_collecti_group_id_1823f2a3_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_comment wagtailcore_comment_page_id_108444b5_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_page_id_108444b5_fk_wagtailcore_page_id FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_comment wagtailcore_comment_resolved_by_id_a282aa0e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_resolved_by_id_a282aa0e_fk_auth_user_id FOREIGN KEY (resolved_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_comment wagtailcore_comment_revision_created_id_1d058279_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_revision_created_id_1d058279_fk_wagtailco FOREIGN KEY (revision_created_id) REFERENCES public.wagtailcore_pagerevision(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_comment wagtailcore_comment_user_id_0c577ca6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_comment
    ADD CONSTRAINT wagtailcore_comment_user_id_0c577ca6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_commentreply wagtailcore_commentr_comment_id_afc7e027_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_commentreply
    ADD CONSTRAINT wagtailcore_commentr_comment_id_afc7e027_fk_wagtailco FOREIGN KEY (comment_id) REFERENCES public.wagtailcore_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_commentreply wagtailcore_commentreply_user_id_d0b3b9c3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_commentreply
    ADD CONSTRAINT wagtailcore_commentreply_user_id_d0b3b9c3_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupapprovaltask_groups wagtailcore_groupapp_group_id_2e64b61f_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups
    ADD CONSTRAINT wagtailcore_groupapp_group_id_2e64b61f_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupapprovaltask_groups wagtailcore_groupapp_groupapprovaltask_id_9a9255ea_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask_groups
    ADD CONSTRAINT wagtailcore_groupapp_groupapprovaltask_id_9a9255ea_fk_wagtailco FOREIGN KEY (groupapprovaltask_id) REFERENCES public.wagtailcore_groupapprovaltask(task_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupapprovaltask wagtailcore_groupapp_task_ptr_id_cfe58781_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupapprovaltask
    ADD CONSTRAINT wagtailcore_groupapp_task_ptr_id_cfe58781_fk_wagtailco FOREIGN KEY (task_ptr_id) REFERENCES public.wagtailcore_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcol_collection_id_5423575a_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcol_collection_id_5423575a_fk_wagtailco FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcol_group_id_05d61460_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcol_group_id_05d61460_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_groupcollectionpermission wagtailcore_groupcol_permission_id_1b626275_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_groupcollectionpermission
    ADD CONSTRAINT wagtailcore_groupcol_permission_id_1b626275_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppag_group_id_fc07e671_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppag_group_id_fc07e671_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_grouppagepermission wagtailcore_grouppag_page_id_710b114a_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppag_page_id_710b114a_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_modellogentry wagtailcore_modellog_content_type_id_68849e77_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_modellogentry
    ADD CONSTRAINT wagtailcore_modellog_content_type_id_68849e77_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_alias_of_id_12945502_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_alias_of_id_12945502_fk_wagtailcore_page_id FOREIGN KEY (alias_of_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_content_type_id_c28424df_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_content_type_id_c28424df_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_live_revision_id_930bd822_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_live_revision_id_930bd822_fk_wagtailco FOREIGN KEY (live_revision_id) REFERENCES public.wagtailcore_pagerevision(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_locale_id_3c7e30a6_fk_wagtailcore_locale_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_locale_id_3c7e30a6_fk_wagtailcore_locale_id FOREIGN KEY (locale_id) REFERENCES public.wagtailcore_locale(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_locked_by_id_bcb86245_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_locked_by_id_bcb86245_fk_auth_user_id FOREIGN KEY (locked_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page wagtailcore_page_owner_id_fbf7c332_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_owner_id_fbf7c332_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pagelogentry wagtailcore_pageloge_content_type_id_74e7708a_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagelogentry
    ADD CONSTRAINT wagtailcore_pageloge_content_type_id_74e7708a_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pagerevision wagtailcore_pagerevi_page_id_d421cc1d_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pagerevi_page_id_d421cc1d_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pagerevision wagtailcore_pagerevision_user_id_2409d2f4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pagerevision_user_id_2409d2f4_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pagesubscription wagtailcore_pagesubs_page_id_a085e7a6_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription
    ADD CONSTRAINT wagtailcore_pagesubs_page_id_a085e7a6_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pagesubscription wagtailcore_pagesubscription_user_id_89d7def9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pagesubscription
    ADD CONSTRAINT wagtailcore_pagesubscription_user_id_89d7def9_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageview_group_id_6460f223_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageview_group_id_6460f223_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pageviewrestriction wagtailcore_pageview_page_id_15a8bea6_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction
    ADD CONSTRAINT wagtailcore_pageview_page_id_15a8bea6_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pageviewrestriction_groups wagtailcore_pageview_pageviewrestriction__f147a99a_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_pageviewrestriction_groups
    ADD CONSTRAINT wagtailcore_pageview_pageviewrestriction__f147a99a_fk_wagtailco FOREIGN KEY (pageviewrestriction_id) REFERENCES public.wagtailcore_pageviewrestriction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_site wagtailcore_site_root_page_id_e02fb95c_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_root_page_id_e02fb95c_fk_wagtailcore_page_id FOREIGN KEY (root_page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_task wagtailcore_task_content_type_id_249ab8ba_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_task
    ADD CONSTRAINT wagtailcore_task_content_type_id_249ab8ba_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_taskstate wagtailcore_taskstat_content_type_id_0a758fdc_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstat_content_type_id_0a758fdc_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_taskstate wagtailcore_taskstat_page_revision_id_9f52c88e_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstat_page_revision_id_9f52c88e_fk_wagtailco FOREIGN KEY (page_revision_id) REFERENCES public.wagtailcore_pagerevision(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_taskstate wagtailcore_taskstat_workflow_state_id_9239a775_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstat_workflow_state_id_9239a775_fk_wagtailco FOREIGN KEY (workflow_state_id) REFERENCES public.wagtailcore_workflowstate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_taskstate wagtailcore_taskstate_finished_by_id_13f98229_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstate_finished_by_id_13f98229_fk_auth_user_id FOREIGN KEY (finished_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_taskstate wagtailcore_taskstate_task_id_c3677c34_fk_wagtailcore_task_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_taskstate
    ADD CONSTRAINT wagtailcore_taskstate_task_id_c3677c34_fk_wagtailcore_task_id FOREIGN KEY (task_id) REFERENCES public.wagtailcore_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_workflowstate wagtailcore_workflow_current_task_state_i_3a1a0632_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflow_current_task_state_i_3a1a0632_fk_wagtailco FOREIGN KEY (current_task_state_id) REFERENCES public.wagtailcore_taskstate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_workflowstate wagtailcore_workflow_page_id_6c962862_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflow_page_id_6c962862_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_workflowpage wagtailcore_workflow_page_id_81e7bab6_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowpage
    ADD CONSTRAINT wagtailcore_workflow_page_id_81e7bab6_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_workflowstate wagtailcore_workflow_requested_by_id_4090bca3_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflow_requested_by_id_4090bca3_fk_auth_user FOREIGN KEY (requested_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_workflowtask wagtailcore_workflow_task_id_ce7716fe_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowtask
    ADD CONSTRAINT wagtailcore_workflow_task_id_ce7716fe_fk_wagtailco FOREIGN KEY (task_id) REFERENCES public.wagtailcore_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_workflowstate wagtailcore_workflow_workflow_id_1f18378f_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowstate
    ADD CONSTRAINT wagtailcore_workflow_workflow_id_1f18378f_fk_wagtailco FOREIGN KEY (workflow_id) REFERENCES public.wagtailcore_workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_workflowpage wagtailcore_workflow_workflow_id_56f56ff6_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowpage
    ADD CONSTRAINT wagtailcore_workflow_workflow_id_56f56ff6_fk_wagtailco FOREIGN KEY (workflow_id) REFERENCES public.wagtailcore_workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_workflowtask wagtailcore_workflow_workflow_id_b9717175_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailcore_workflowtask
    ADD CONSTRAINT wagtailcore_workflow_workflow_id_b9717175_fk_wagtailco FOREIGN KEY (workflow_id) REFERENCES public.wagtailcore_workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtaildocs_document wagtaildocs_document_collection_id_23881625_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_collection_id_23881625_fk_wagtailco FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtaildocs_document wagtaildocs_document_uploaded_by_user_id_17258b41_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_uploaded_by_user_id_17258b41_fk_auth_user FOREIGN KEY (uploaded_by_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtaildocs_uploadeddocument wagtaildocs_uploaded_uploaded_by_user_id_8dd61a73_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtaildocs_uploadeddocument
    ADD CONSTRAINT wagtaildocs_uploaded_uploaded_by_user_id_8dd61a73_fk_auth_user FOREIGN KEY (uploaded_by_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailforms_formsubmission wagtailforms_formsub_page_id_e48e93e7_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailforms_formsubmission
    ADD CONSTRAINT wagtailforms_formsub_page_id_e48e93e7_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailimages_image wagtailimages_image_collection_id_c2f8af7e_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_collection_id_c2f8af7e_fk_wagtailco FOREIGN KEY (collection_id) REFERENCES public.wagtailcore_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailimages_image wagtailimages_image_uploaded_by_user_id_5d73dc75_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_uploaded_by_user_id_5d73dc75_fk_auth_user FOREIGN KEY (uploaded_by_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailimages_rendition wagtailimages_rendit_image_id_3e1fd774_fk_wagtailim; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendit_image_id_3e1fd774_fk_wagtailim FOREIGN KEY (image_id) REFERENCES public.wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailimages_uploadedimage wagtailimages_upload_uploaded_by_user_id_85921689_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailimages_uploadedimage
    ADD CONSTRAINT wagtailimages_upload_uploaded_by_user_id_85921689_fk_auth_user FOREIGN KEY (uploaded_by_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailredirects_redirect wagtailredirects_red_redirect_page_id_b5728a8f_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_red_redirect_page_id_b5728a8f_fk_wagtailco FOREIGN KEY (redirect_page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailredirects_redirect wagtailredirects_red_site_id_780a0e1e_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_red_site_id_780a0e1e_fk_wagtailco FOREIGN KEY (site_id) REFERENCES public.wagtailcore_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsearch_editorspick wagtailsearch_editor_page_id_28cbc274_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_editorspick
    ADD CONSTRAINT wagtailsearch_editor_page_id_28cbc274_fk_wagtailco FOREIGN KEY (page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsearch_editorspick wagtailsearch_editor_query_id_c6eee4a0_fk_wagtailse; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_editorspick
    ADD CONSTRAINT wagtailsearch_editor_query_id_c6eee4a0_fk_wagtailse FOREIGN KEY (query_id) REFERENCES public.wagtailsearch_query(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsearch_indexentry wagtailsearch_indexe_content_type_id_62ed694f_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_indexentry
    ADD CONSTRAINT wagtailsearch_indexe_content_type_id_62ed694f_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsearch_querydailyhits wagtailsearch_queryd_query_id_2185994b_fk_wagtailse; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsearch_queryd_query_id_2185994b_fk_wagtailse FOREIGN KEY (query_id) REFERENCES public.wagtailsearch_query(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailstreamforms_formsubmission wagtailstreamforms_f_form_id_b73d2bb2_fk_wagtailst; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_formsubmission
    ADD CONSTRAINT wagtailstreamforms_f_form_id_b73d2bb2_fk_wagtailst FOREIGN KEY (form_id) REFERENCES public.wagtailstreamforms_form(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailstreamforms_form wagtailstreamforms_f_post_redirect_page_i_03dfbd9e_fk_wagtailco; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_form
    ADD CONSTRAINT wagtailstreamforms_f_post_redirect_page_i_03dfbd9e_fk_wagtailco FOREIGN KEY (post_redirect_page_id) REFERENCES public.wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailstreamforms_formsubmissionfile wagtailstreamforms_f_submission_id_8d4718e1_fk_wagtailst; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_formsubmissionfile
    ADD CONSTRAINT wagtailstreamforms_f_submission_id_8d4718e1_fk_wagtailst FOREIGN KEY (submission_id) REFERENCES public.wagtailstreamforms_formsubmission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailstreamforms_form wagtailstreamforms_form_site_id_ae22c770_fk_wagtailcore_site_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailstreamforms_form
    ADD CONSTRAINT wagtailstreamforms_form_site_id_ae22c770_fk_wagtailcore_site_id FOREIGN KEY (site_id) REFERENCES public.wagtailcore_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailusers_userprofile wagtailusers_userprofile_user_id_59c92331_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_user_id_59c92331_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

