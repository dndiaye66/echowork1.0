--
-- PostgreSQL database dump
--

\restrict ALPqOyVp7chy3YUjZWNv33E80LfUJqP6UmXQrMYkA7WZgE8LbCEd5hbaqwVthsQ

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)

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

--
-- Name: AdvertisementStatus; Type: TYPE; Schema: public; Owner: echowork
--

CREATE TYPE public."AdvertisementStatus" AS ENUM (
    'ACTIVE',
    'PAUSED',
    'ENDED'
);


ALTER TYPE public."AdvertisementStatus" OWNER TO echowork;

--
-- Name: AdvertisementType; Type: TYPE; Schema: public; Owner: echowork
--

CREATE TYPE public."AdvertisementType" AS ENUM (
    'BANNER',
    'SPONSORED'
);


ALTER TYPE public."AdvertisementType" OWNER TO echowork;

--
-- Name: CompanySize; Type: TYPE; Schema: public; Owner: echowork
--

CREATE TYPE public."CompanySize" AS ENUM (
    'TPE',
    'PME',
    'GRANDE'
);


ALTER TYPE public."CompanySize" OWNER TO echowork;

--
-- Name: ProfileType; Type: TYPE; Schema: public; Owner: echowork
--

CREATE TYPE public."ProfileType" AS ENUM (
    'CLIENT',
    'EMPLOYEE',
    'SUPPLIER',
    'OTHER'
);


ALTER TYPE public."ProfileType" OWNER TO echowork;

--
-- Name: ReviewContext; Type: TYPE; Schema: public; Owner: echowork
--

CREATE TYPE public."ReviewContext" AS ENUM (
    'CLIENT',
    'EMPLOYEE',
    'SUPPLIER',
    'OTHER'
);


ALTER TYPE public."ReviewContext" OWNER TO echowork;

--
-- Name: ReviewStatus; Type: TYPE; Schema: public; Owner: echowork
--

CREATE TYPE public."ReviewStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);


ALTER TYPE public."ReviewStatus" OWNER TO echowork;

--
-- Name: SubscriptionPlan; Type: TYPE; Schema: public; Owner: echowork
--

CREATE TYPE public."SubscriptionPlan" AS ENUM (
    'FREE',
    'PRO',
    'PREMIUM'
);


ALTER TYPE public."SubscriptionPlan" OWNER TO echowork;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: echowork
--

CREATE TYPE public."UserRole" AS ENUM (
    'USER',
    'ADMIN',
    'MODERATOR'
);


ALTER TYPE public."UserRole" OWNER TO echowork;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Advertisement; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."Advertisement" (
    id integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    "imageUrl" text,
    "companyId" integer,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    type public."AdvertisementType" DEFAULT 'BANNER'::public."AdvertisementType" NOT NULL,
    status public."AdvertisementStatus" DEFAULT 'ACTIVE'::public."AdvertisementStatus" NOT NULL
);


ALTER TABLE public."Advertisement" OWNER TO echowork;

--
-- Name: Advertisement_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."Advertisement_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Advertisement_id_seq" OWNER TO echowork;

--
-- Name: Advertisement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."Advertisement_id_seq" OWNED BY public."Advertisement".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    "parentId" integer
);


ALTER TABLE public."Category" OWNER TO echowork;

--
-- Name: CategoryKeyword; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."CategoryKeyword" (
    id integer NOT NULL,
    "categoryId" integer NOT NULL,
    keyword text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."CategoryKeyword" OWNER TO echowork;

--
-- Name: CategoryKeyword_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."CategoryKeyword_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CategoryKeyword_id_seq" OWNER TO echowork;

--
-- Name: CategoryKeyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."CategoryKeyword_id_seq" OWNED BY public."CategoryKeyword".id;


--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Category_id_seq" OWNER TO echowork;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Company; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."Company" (
    id integer NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text,
    "imageUrl" text,
    "categoryId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    activite text,
    adresse text,
    tel text,
    ville text,
    ninea text,
    rccm text,
    size public."CompanySize",
    "isVerified" boolean DEFAULT false NOT NULL,
    "claimedByUserId" integer
);


ALTER TABLE public."Company" OWNER TO echowork;

--
-- Name: CompanyLocation; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."CompanyLocation" (
    id integer NOT NULL,
    "companyId" integer NOT NULL,
    region text,
    department text,
    city text,
    address text,
    lat double precision,
    lng double precision,
    "isPrimary" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."CompanyLocation" OWNER TO echowork;

--
-- Name: CompanyLocation_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."CompanyLocation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CompanyLocation_id_seq" OWNER TO echowork;

--
-- Name: CompanyLocation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."CompanyLocation_id_seq" OWNED BY public."CompanyLocation".id;


--
-- Name: CompanyScore; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."CompanyScore" (
    id integer NOT NULL,
    "companyId" integer NOT NULL,
    "globalScore" double precision DEFAULT 0 NOT NULL,
    "trustIndex" double precision DEFAULT 0 NOT NULL,
    "totalReviews" integer DEFAULT 0 NOT NULL,
    "lastUpdated" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."CompanyScore" OWNER TO echowork;

--
-- Name: CompanyScore_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."CompanyScore_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CompanyScore_id_seq" OWNER TO echowork;

--
-- Name: CompanyScore_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."CompanyScore_id_seq" OWNED BY public."CompanyScore".id;


--
-- Name: Company_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."Company_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Company_id_seq" OWNER TO echowork;

--
-- Name: Company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."Company_id_seq" OWNED BY public."Company".id;


--
-- Name: JobOffer; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."JobOffer" (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    salary text,
    location text,
    "companyId" integer NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."JobOffer" OWNER TO echowork;

--
-- Name: JobOffer_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."JobOffer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."JobOffer_id_seq" OWNER TO echowork;

--
-- Name: JobOffer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."JobOffer_id_seq" OWNED BY public."JobOffer".id;


--
-- Name: RatingCriteria; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."RatingCriteria" (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    weight double precision DEFAULT 1.0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."RatingCriteria" OWNER TO echowork;

--
-- Name: RatingCriteria_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."RatingCriteria_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."RatingCriteria_id_seq" OWNER TO echowork;

--
-- Name: RatingCriteria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."RatingCriteria_id_seq" OWNED BY public."RatingCriteria".id;


--
-- Name: Review; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."Review" (
    id integer NOT NULL,
    rating integer NOT NULL,
    comment text NOT NULL,
    "userId" integer NOT NULL,
    "companyId" integer NOT NULL,
    upvotes integer DEFAULT 0 NOT NULL,
    downvotes integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    context public."ReviewContext" DEFAULT 'CLIENT'::public."ReviewContext" NOT NULL,
    status public."ReviewStatus" DEFAULT 'PENDING'::public."ReviewStatus" NOT NULL
);


ALTER TABLE public."Review" OWNER TO echowork;

--
-- Name: ReviewScore; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."ReviewScore" (
    id integer NOT NULL,
    "reviewId" integer NOT NULL,
    "criteriaId" integer NOT NULL,
    score integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."ReviewScore" OWNER TO echowork;

--
-- Name: ReviewScore_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."ReviewScore_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ReviewScore_id_seq" OWNER TO echowork;

--
-- Name: ReviewScore_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."ReviewScore_id_seq" OWNED BY public."ReviewScore".id;


--
-- Name: Review_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."Review_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Review_id_seq" OWNER TO echowork;

--
-- Name: Review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."Review_id_seq" OWNED BY public."Review".id;


--
-- Name: Subscription; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."Subscription" (
    id integer NOT NULL,
    "companyId" integer NOT NULL,
    plan public."SubscriptionPlan" DEFAULT 'FREE'::public."SubscriptionPlan" NOT NULL,
    "startDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "endDate" timestamp(3) without time zone,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Subscription" OWNER TO echowork;

--
-- Name: Subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."Subscription_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Subscription_id_seq" OWNER TO echowork;

--
-- Name: Subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."Subscription_id_seq" OWNED BY public."Subscription".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    role public."UserRole" DEFAULT 'USER'::public."UserRole" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    phone text,
    "isVerified" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."User" OWNER TO echowork;

--
-- Name: UserProfile; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public."UserProfile" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "fullName" text,
    "profileType" public."ProfileType" DEFAULT 'CLIENT'::public."ProfileType" NOT NULL,
    "trustScore" double precision DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."UserProfile" OWNER TO echowork;

--
-- Name: UserProfile_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."UserProfile_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserProfile_id_seq" OWNER TO echowork;

--
-- Name: UserProfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."UserProfile_id_seq" OWNED BY public."UserProfile".id;


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: echowork
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO echowork;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: echowork
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: echowork
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO echowork;

--
-- Name: Advertisement id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Advertisement" ALTER COLUMN id SET DEFAULT nextval('public."Advertisement_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: CategoryKeyword id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CategoryKeyword" ALTER COLUMN id SET DEFAULT nextval('public."CategoryKeyword_id_seq"'::regclass);


--
-- Name: Company id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Company" ALTER COLUMN id SET DEFAULT nextval('public."Company_id_seq"'::regclass);


--
-- Name: CompanyLocation id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CompanyLocation" ALTER COLUMN id SET DEFAULT nextval('public."CompanyLocation_id_seq"'::regclass);


--
-- Name: CompanyScore id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CompanyScore" ALTER COLUMN id SET DEFAULT nextval('public."CompanyScore_id_seq"'::regclass);


--
-- Name: JobOffer id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."JobOffer" ALTER COLUMN id SET DEFAULT nextval('public."JobOffer_id_seq"'::regclass);


--
-- Name: RatingCriteria id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."RatingCriteria" ALTER COLUMN id SET DEFAULT nextval('public."RatingCriteria_id_seq"'::regclass);


--
-- Name: Review id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Review" ALTER COLUMN id SET DEFAULT nextval('public."Review_id_seq"'::regclass);


--
-- Name: ReviewScore id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."ReviewScore" ALTER COLUMN id SET DEFAULT nextval('public."ReviewScore_id_seq"'::regclass);


--
-- Name: Subscription id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Subscription" ALTER COLUMN id SET DEFAULT nextval('public."Subscription_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: UserProfile id; Type: DEFAULT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."UserProfile" ALTER COLUMN id SET DEFAULT nextval('public."UserProfile_id_seq"'::regclass);


--
-- Data for Name: Advertisement; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."Advertisement" (id, title, content, "imageUrl", "companyId", "startDate", "endDate", "isActive", "createdAt", "updatedAt", type, status) FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."Category" (id, name, slug, "parentId") FROM stdin;
1	Énergie et Pétrole	energie-et-petrole	\N
2	Commerce et Distribution	commerce-et-distribution	\N
3	Services	services	\N
4	Agriculture et Alimentation	agriculture-et-alimentation	\N
5	Santé et Pharmacie	sante-et-pharmacie	\N
6	Construction et BTP	construction-et-btp	\N
7	Industrie	industrie	\N
8	Automobile	automobile	\N
9	Télécommunications	telecommunications	\N
10	Transport et Logistique	transport-et-logistique	\N
11	Immobilier	immobilier	\N
12	Restauration et Hôtellerie	restauration-et-hotellerie	\N
13	Informatique et Numérique	informatique-et-numerique	\N
14	Banques et Institutions Financières	banques-et-institutions-financieres	\N
15	Ecole et Enseignement Superieure	ecole-et-enseignement-superieure	\N
\.


--
-- Data for Name: CategoryKeyword; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."CategoryKeyword" (id, "categoryId", keyword, "createdAt") FROM stdin;
\.


--
-- Data for Name: Company; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."Company" (id, name, slug, description, "imageUrl", "categoryId", "createdAt", "updatedAt", activite, adresse, tel, ville, ninea, rccm, size, "isVerified", "claimedByUserId") FROM stdin;
717	Ets Narimane Hachem	ets-narimane-hachem	Commerce	\N	2	2026-03-02 23:11:12.067	2026-03-02 23:11:12.067	Commerce	Rue Quai Henry Jay Sud Saintt Louis 0 Dakar Meubles De Carthage (Katy Ben Ayad) Vente Mobiliers Divers Avenue Faidherbe	33 823 49 59	Saint-Louis	\N	\N	\N	f	\N
718	Pharmacie Darou Salam	pharmacie-darou-salam	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.07	2026-03-02 23:11:12.07	Vente De Produits Pharmaceutiques	Quartier Thiaroye Gare Route De Yeumbeul Pikine	33 973 63 73	Pikine	\N	\N	\N	f	\N
719	Mame Balla Seck	mame-balla-seck	Commerce	\N	2	2026-03-02 23:11:12.072	2026-03-02 23:11:12.072	Commerce	Rue Buggeaud Leona Kaolack	77 637 32 72	Kaolack	\N	\N	\N	f	\N
720	Focus Industries	focus-industries	Commerce	\N	2	2026-03-02 23:11:12.075	2026-03-02 23:11:12.075	Commerce	Route Des Hydrocarbures Bel Air 0 Dakar Pharmacie Actuel (Brigitte Soarez Daluz) Vente De Produits Pharmaceutiques Avenue Cheikh Anta Diop X Canal 4	33 824 16 86	Dakar	\N	\N	\N	f	\N
721	Neptune Optique Sarl	neptune-optique-sarl	Commerce De Materiel De Musique Et D'Instruments D'Optique	\N	2	2026-03-02 23:11:12.078	2026-03-02 23:11:12.078	Commerce De Materiel De Musique Et D'Instruments D'Optique	Rue,Parchappe Rez De Chaussee	33 825 44 00	Dakar	\N	\N	\N	f	\N
722	Pharmacie Papa Djibril Gueye (Ibrahima Gueye)	pharmacie-papa-djibril-gueye-ibrahima-gueye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.082	2026-03-02 23:11:12.082	Vente De Produits Pharmaceutiques	Quartier Taif Sica p Mbao	33 855 00 93	Dakar	\N	\N	\N	f	\N
723	Pharmacie Nourou Dareyni - Assane Dieng	pharmacie-nourou-dareyni-assane-dieng	Vente De Produits Pharmaceutiques Derkle -	\N	2	2026-03-02 23:11:12.085	2026-03-02 23:11:12.085	Vente De Produits Pharmaceutiques Derkle -	Rue 1	77 575 09 67	Dakar	\N	\N	\N	f	\N
724	Sisodis - Sarl (Societe D'Integration De Solutions Et De	sisodis-sarl-societe-d-integration-de-solutions-et-de	Distribution - Sarl) Vente De Materiels Electriques	\N	2	2026-03-02 23:11:12.088	2026-03-02 23:11:12.088	Distribution - Sarl) Vente De Materiels Electriques	Bccd	33 835 85 38	Dakar	\N	\N	\N	f	\N
725	Pharmacie Diamaguene (Mohamadou Diop)	pharmacie-diamaguene-mohamadou-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.09	2026-03-02 23:11:12.09	Vente De Produits Pharmaceutiques	Quartier Diamaguen e - Mboro 33 955 43 8 Pikine Pharmacie El Hadj Seydou Nourou Tall (Dr Lamine Ndiaye) Vente De Produits Pharmaceutiques Cite Serigne Manso ur Sy - Pikine Tally Icotaf	33 864 23 62	Mboro	\N	\N	\N	f	\N
726	Pharmacie Yaye Diabou	pharmacie-yaye-diabou	Vente De Produits Pharmaceutiques Sor Isra	\N	2	2026-03-02 23:11:12.092	2026-03-02 23:11:12.092	Vente De Produits Pharmaceutiques Sor Isra	Avenue Ma codou Ndiaye	33 834 08 42	Saint-Louis	\N	\N	\N	f	\N
727	Planete Tours Voyages - Sarl Agence De Voyage -	planete-tours-voyages-sarl-agence-de-voyage	Vente De Billets D'Avion	\N	2	2026-03-02 23:11:12.095	2026-03-02 23:11:12.095	Vente De Billets D'Avion	Avenue G eorges Pompidou - Dakar	33 961 18 75	Dakar	\N	\N	\N	f	\N
728	Africa Pieces Detachees	africa-pieces-detachees	Vente De Pieces Detachees	\N	2	2026-03-02 23:11:12.099	2026-03-02 23:11:12.099	Vente De Pieces Detachees	Route De Rufisque	33 823 74 23	Dakar	\N	\N	\N	f	\N
729	Pharmacie Serigne Saliou Mbacke (Dr Mor Gueye)	pharmacie-serigne-saliou-mbacke-dr-mor-gueye	Vente De Produits Pharmaceutiques Fatick 0 Dakar Cogiex (Compagnie Generale D'Import-Export - Sarl) Commerce Impasse Boulangerie Ouakam 0 Dakar Pharmacie	\N	2	2026-03-02 23:11:12.102	2026-03-02 23:11:12.102	Vente De Produits Pharmaceutiques Fatick 0 Dakar Cogiex (Compagnie Generale D'Import-Export - Sarl) Commerce Impasse Boulangerie Ouakam 0 Dakar Pharmacie	Abdourahmane (Dr Binta Mbengue) Vente De Produits Pharmaceutiques Hann Mariste - Sca t Urbam N° 365 -	33 827 64 93	Fatick	\N	\N	\N	f	\N
730	Pharmacie Amadou (Mamadou Dieye)	pharmacie-amadou-mamadou-dieye	Vente De Produits Pharmaceutiques Cite Comico 4 N° 2 82	\N	2	2026-03-02 23:11:12.104	2026-03-02 23:11:12.104	Vente De Produits Pharmaceutiques Cite Comico 4 N° 2 82	Route De Boune	33 832 46 00	Yeumbeul	\N	\N	\N	f	\N
731	Experteam Int Consulting -	experteam-int-consulting	Commerce - Services	\N	2	2026-03-02 23:11:12.109	2026-03-02 23:11:12.109	Commerce - Services	Rue De L'Ocean - Yo ff	33 878 11 95	Dakar	\N	\N	\N	f	\N
732	Pharmacie Medina Baye (Fatou Samb Cisse )	pharmacie-medina-baye-fatou-samb-cisse	Vente De Produits Pharmaceutiques Medina Baye 0 Mbour Sobaco Sarl Commerce Nguekokh Village 0 Dakar Pharmacie Du Cap-Vert Joubaily Lina Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.112	2026-03-02 23:11:12.112	Vente De Produits Pharmaceutiques Medina Baye 0 Mbour Sobaco Sarl Commerce Nguekokh Village 0 Dakar Pharmacie Du Cap-Vert Joubaily Lina Vente De Produits Pharmaceutiques	Avenue Lamine Guey e	33 820 10 99	Kaolack	\N	\N	\N	f	\N
733	Jet Equip (Niokhor Diop Prestation De	jet-equip-niokhor-diop-prestation-de	Services - Commerce Point E Villa N° 1 3 0 Dakar La Maison Du Medecin Distribution Materiel Medical	\N	2	2026-03-02 23:11:12.115	2026-03-02 23:11:12.115	Services - Commerce Point E Villa N° 1 3 0 Dakar La Maison Du Medecin Distribution Materiel Medical	Rue El Hadji Mbaye Gue ye	33 821 74 06	Dakar	\N	\N	\N	f	\N
734	Etablissements Dioko	etablissements-dioko	Commerce	\N	2	2026-03-02 23:11:12.117	2026-03-02 23:11:12.117	Commerce	Avenue General Degaulle Sor	33 822 50 02	Saint-Louis	\N	\N	\N	f	\N
1709	Apanguesso Suarl Station	apanguesso-suarl-station	Services Shell Relais 82	\N	1	2026-03-02 23:11:14.336	2026-03-02 23:11:14.336	Services Shell Relais 82	Route De Dakar Mbour 0 Mbour Sotouso Club Du Baobab Hotellerie Somone	33 957 39 39	Mbour	\N	\N	\N	f	\N
1710	Sarl Holidays Market	sarl-holidays-market	Commerce General Saly Portudal - Mbour 0 Mbour Sdds (Elton Mbour) Commerce General Oncad 0 Mbour Saly City Sa Promotion	\N	2	2026-03-02 23:11:14.34	2026-03-02 23:11:14.34	Commerce General Saly Portudal - Mbour 0 Mbour Sdds (Elton Mbour) Commerce General Oncad 0 Mbour Saly City Sa Promotion	Immobiliere Mbour Ngaparou	77 469 38 19	Mbour	\N	\N	\N	f	\N
1711	Aluminium Miroiterie Du Senegal	aluminium-miroiterie-du-senegal-1	Commerce	\N	2	2026-03-02 23:11:14.348	2026-03-02 23:11:14.348	Commerce	Quartier Medine - Mbour	77 633 02 73	Mbour	\N	\N	\N	f	\N
1712	Quincaillerie Gaffari Et Fils - Sarl	quincaillerie-gaffari-et-fils-sarl-1	Commerce Quincaillerie	\N	2	2026-03-02 23:11:14.352	2026-03-02 23:11:14.352	Commerce Quincaillerie	Rue Malick Sy - Mbour	33 957 56 46	Mbour	\N	\N	\N	f	\N
1713	Epicerie Du Coin (Elie Mejaes Chouery Et Fils)	epicerie-du-coin-elie-mejaes-chouery-et-fils-1	Commerce General Alimentaire	\N	2	2026-03-02 23:11:14.357	2026-03-02 23:11:14.357	Commerce General Alimentaire	Avenue Malick Sy - Escale - Mbour	33 957 30 56	Mbour	\N	\N	\N	f	\N
1714	L'Achat Malin	l-achat-malin-1	Commerce General	\N	2	2026-03-02 23:11:14.363	2026-03-02 23:11:14.363	Commerce General	Rue El H. Malick Sy (Mbour)	33 957 50 22	Mbour	\N	\N	\N	f	\N
1715	Prix Bas	prix-bas-1	Distribution	\N	2	2026-03-02 23:11:14.369	2026-03-02 23:11:14.369	Distribution	(Abdoul Aziz Ndiaye) Commerce General Quartier Escale Mbour	33 957 10 88	Mbour	\N	\N	\N	f	\N
1716	Makhoudia Seck	makhoudia-seck	Commerce General Mbour Escale 0 Mbour Sarl Mor Lat Sall Diop Commerce General Saly Carrefour- Mbour 0 Mbour Etude Maitre Marie Ba Services Fournis Aux Entreprises Saly En Face Ecole Francaise Jacques Prevert 339571175 Mbour Pharmacie - Saly (Mme Diouf Amy Ndiaye) Vente De Produits Pharmaceutiques Saly Portudal -Station Touristique De Saly 33 95712 05 Mbour Darou Salam Suarl Commerce Saly Carrefour 0 Mbour Signal	\N	2	2026-03-02 23:11:14.372	2026-03-02 23:11:14.372	Commerce General Mbour Escale 0 Mbour Sarl Mor Lat Sall Diop Commerce General Saly Carrefour- Mbour 0 Mbour Etude Maitre Marie Ba Services Fournis Aux Entreprises Saly En Face Ecole Francaise Jacques Prevert 339571175 Mbour Pharmacie - Saly (Mme Diouf Amy Ndiaye) Vente De Produits Pharmaceutiques Saly Portudal -Station Touristique De Saly 33 95712 05 Mbour Darou Salam Suarl Commerce Saly Carrefour 0 Mbour Signal	Routes Sarl Signalisation Routiere Sindian Route De Mbour	33 957 17 36	Mbour	\N	\N	\N	f	\N
1717	Polaquad Sarl	polaquad-sarl	Commerce De Pieces Detachees Et D'Accessoires Automobiles	\N	2	2026-03-02 23:11:14.375	2026-03-02 23:11:14.375	Commerce De Pieces Detachees Et D'Accessoires Automobiles	Quartier Cite Lagune N°44 0 Mbour Saly Glace Sarl Fabrique De Glace Saly Carrefour Route Nationale N° 1 Mbour 0 Mbour Allelua Suarl Commerce General Thiadiaye	33 867 47 98	Mbour	\N	\N	\N	f	\N
1718	Pharmacie Mbouroise	pharmacie-mbouroise-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.379	2026-03-02 23:11:14.379	Vente De Produits Pharmaceutiques	Route De L'Hopital 0 Mbour L'Avalanche Sarl Supermarche Grand Mbour Route Nationale N° 1	33 954 76 66	Mbour	\N	\N	\N	f	\N
1719	Sene Djeune - Sarl	sene-djeune-sarl-1	Commerce De Produits Halieutique Usine Ikagel Mballing	\N	2	2026-03-02 23:11:14.383	2026-03-02 23:11:14.383	Commerce De Produits Halieutique Usine Ikagel Mballing	Route De Joal Mbour	33 832 84 84	Mbour	\N	\N	\N	f	\N
1720	Clinique Du Littoral Sau Prestataire De	clinique-du-littoral-sau-prestataire-de	Service Medical Saly Center	\N	5	2026-03-02 23:11:14.386	2026-03-02 23:11:14.386	Service Medical Saly Center	Route De Ngaparou	33 957 39 39	Mbour	\N	\N	\N	f	\N
1721	Pharmacie Salve Regina	pharmacie-salve-regina-1	Vente De Produits Pahrmaceutiques	\N	2	2026-03-02 23:11:14.389	2026-03-02 23:11:14.389	Vente De Produits Pahrmaceutiques	Route Du Golf Saly	33 957 07 70	Mbour	\N	\N	\N	f	\N
1722	Sobaco Sarl	sobaco-sarl	Commerce Nguekokh Village 0 Mbour Boulangerie Touba Madiyana (Abibou Diop) Fabrication De Pain Et Patisserie	\N	2	2026-03-02 23:11:14.392	2026-03-02 23:11:14.392	Commerce Nguekokh Village 0 Mbour Boulangerie Touba Madiyana (Abibou Diop) Fabrication De Pain Et Patisserie	Quartier 11 Novembre Mbour 0 Mbour Boulangerie Borom Gaw Ane Boulangerie Quartier 11 Novembre Mbour 0 Mbour Sci Ouest Africa Societe Immobiliere Saly Nord Mbour	33 951 14 23	Mbour	\N	\N	\N	f	\N
1723	Entreprise Activité Adresse Téléphone Mbour Pharmacie Aby Diere (Dr Aboubacar Coly)	entreprise-activite-adresse-telephone-mbour-pharmacie-aby-diere-dr-aboubacar-coly	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.394	2026-03-02 23:11:14.394	Vente De Produits Pharmaceutiques	Quartier Medina Nationale 1 Juste Station 33957 07 65 Mbour Cavadis Sarl Commerce General Avenue El Hadji Malick Sy Mbour 0 Mbour L'Usine Suarl Vente De Moto Quads- Garage Mecanique Ngaparou, Route De Saly 772574814 Mbour Saly Services Sarl Vente De Pieces Detachees Route De Saly	33 957 11 78	Ville	\N	\N	\N	f	\N
735	Entreprise Activité Adresse Téléphone Dakar Pharmacie Abdourahmane Mbengue (Dr Dieumbe Diop)	entreprise-activite-adresse-telephone-dakar-pharmacie-abdourahmane-mbengue-dr-dieumbe-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.119	2026-03-02 23:11:12.119	Vente De Produits Pharmaceutiques	Route De La Plage Yoff Tonghor	33 961 00 15	Ville	\N	\N	\N	f	\N
736	Pharmacie Mactar Diaw	pharmacie-mactar-diaw	Vente De Produits Pharmaceutiques Zone De Captage Gr and Yoff Dakar 0 Dakar Pharmacie Capa Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.122	2026-03-02 23:11:12.122	Vente De Produits Pharmaceutiques Zone De Captage Gr and Yoff Dakar 0 Dakar Pharmacie Capa Vente De Produits Pharmaceutiques	Bccd	77 641 11 25	Dakar	\N	\N	\N	f	\N
737	Ndiogou Seck	ndiogou-seck	Commerce General	\N	2	2026-03-02 23:11:12.125	2026-03-02 23:11:12.125	Commerce General	Rue 19X20 Medina	33 961 45 01	Dakar	\N	\N	\N	f	\N
738	Modis Sarl	modis-sarl	Commerce Import Export	\N	2	2026-03-02 23:11:12.127	2026-03-02 23:11:12.127	Commerce Import Export	Rue Abdou Karim Bougi	33 823 68 20	Dakar	\N	\N	\N	f	\N
739	Pharmacie Mame Diarra Bousso Niang	pharmacie-mame-diarra-bousso-niang	Vente De Produits Pharmaceutiques Sinthiou Bamambe 0 Dakar Img (International Medical Group) Vente Materiel Medical D'Occasion Et Renove	\N	2	2026-03-02 23:11:12.128	2026-03-02 23:11:12.128	Vente De Produits Pharmaceutiques Sinthiou Bamambe 0 Dakar Img (International Medical Group) Vente Materiel Medical D'Occasion Et Renove	Route De L'Aeroport Cite Yves Niang N° 21	33 821 67 67	Kanel	\N	\N	\N	f	\N
740	Epicerie Libre	epicerie-libre-1	Service (Habib Nahme) Commerce	\N	2	2026-03-02 23:11:12.131	2026-03-02 23:11:12.131	Service (Habib Nahme) Commerce	Rue De La Gare	33 820 67 29	Thies	\N	\N	\N	f	\N
741	Baleine Export Sarl Traitement Et Exportation De Produits De Mer -	baleine-export-sarl-traitement-et-exportation-de-produits-de-mer	Vente De Produits Alimentaires	\N	2	2026-03-02 23:11:12.133	2026-03-02 23:11:12.133	Vente De Produits Alimentaires	Route De Rufisque - Zone Industrielle Sonepi	33 835 22 23	Thiaroye	\N	\N	\N	f	\N
742	Pharmacie Nafissa (Abibou Sall)	pharmacie-nafissa-abibou-sall	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.135	2026-03-02 23:11:12.135	Vente De Produits Pharmaceutiques	Route De L'Aeropor t Cite Bceao Villa 13	33 865 25 45	Dakar	\N	\N	\N	f	\N
743	Phenix Uniformes	phenix-uniformes	Commerce Sicap	\N	2	2026-03-02 23:11:12.136	2026-03-02 23:11:12.136	Commerce Sicap	Rue 10 Rue Benez	33 820 40 68	Dakar	\N	\N	\N	f	\N
744	Delta Metal Sarl	delta-metal-sarl	Commerce De Materiaux De Construction	\N	2	2026-03-02 23:11:12.138	2026-03-02 23:11:12.138	Commerce De Materiaux De Construction	Boulevard Du Centenaire De La Commune De Dakar	33 864 00 31	Dakar	\N	\N	\N	f	\N
745	Quincallerie Touba Ndienne-Keur Songoma Tall	quincallerie-touba-ndienne-keur-songoma-tall	Commerce General	\N	2	2026-03-02 23:11:12.14	2026-03-02 23:11:12.14	Commerce General	Rue De Paris X Ave General Degaulle Sor Saint Louis	77 644 35 42	Saint-Louis	\N	\N	\N	f	\N
746	Pharmacie Château D'Eau	pharmacie-chateau-d-eau	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.142	2026-03-02 23:11:12.142	Vente De Produits Pharmaceutiques	Rue Macodou Ndiaye Leona Sor	33 961 00 10	Saint-Louis	\N	\N	\N	f	\N
747	Prodis Sarl	prodis-sarl	Vente De Portables	\N	2	2026-03-02 23:11:12.143	2026-03-02 23:11:12.143	Vente De Portables	Avenue Hassan 2	33 961 23 90	Dakar	\N	\N	\N	f	\N
748	Alysyn Group Sarl	alysyn-group-sarl	Commerce General Ngor Virage Toumdoul Riah Yoff 0 Dakar Pharmacie Mota (Ndeye Mboye Diouf Cisse) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.145	2026-03-02 23:11:12.145	Commerce General Ngor Virage Toumdoul Riah Yoff 0 Dakar Pharmacie Mota (Ndeye Mboye Diouf Cisse) Vente De Produits Pharmaceutiques	Route De L'Aeropor t En Face Cite Bceao 0 Pikine Modou Gueye Commerce General Pikine Tally Boumack Marche Zing 0 Dakar Mecaburo Fabrication - Entretien - Reparation Et Commerce De Machines De Bureau Avenue Lamine Gueye	33 842 84 84	Dakar	\N	\N	\N	f	\N
749	Gie Jappo Ligueye Jarignu	gie-jappo-ligueye-jarignu	Commerce General	\N	2	2026-03-02 23:11:12.147	2026-03-02 23:11:12.147	Commerce General	Quartier Leona 0 Mbour Pharmacie Aby Diere (Dr Aboubacar Coly) Vente De Produits Pharmaceutiques Quartier Medina Na tionale 1 Juste Station 33957 07 65 Dakar Socosy (Societe Commerciale Sylla Yaram) Commerce Usine Ben Tally N° 1647 33824 57 37 Thies Cheikh Diop Commerce Thies Marcche Central 0 Dakar Mexis-Group Sarl Commerce General Rue 19 X 22 Medina	33 822 23 10	Kaolack	\N	\N	\N	f	\N
750	Socos Et Freres (Societede	socos-et-freres-societede	Commerce Socos Et Frere) Sarl Commerce	\N	2	2026-03-02 23:11:12.148	2026-03-02 23:11:12.148	Commerce Socos Et Frere) Sarl Commerce	Rue Grasland	77 545 39 49	Dakar	\N	\N	\N	f	\N
751	Tine Energie Sarl Location Et	tine-energie-sarl-location-et	Vente De Groupes Electrogenes	\N	1	2026-03-02 23:11:12.15	2026-03-02 23:11:12.15	Vente De Groupes Electrogenes	Route De Rufisque En Face Lotissement Les Baobabs A Grand Mbao	33 824 90 90	Dakar	\N	\N	\N	f	\N
752	Hassan Aly Fardoune	hassan-aly-fardoune	Vente De Materiel Electrique	\N	2	2026-03-02 23:11:12.151	2026-03-02 23:11:12.151	Vente De Materiel Electrique	Rue Galandou Diouf	33 837 91 70	Dakar	\N	\N	\N	f	\N
753	Prodipa	prodipa	(Production Et Distribution De Produits Alimentaires) Production Et Distribution De Produits Alimentaires	\N	2	2026-03-02 23:11:12.153	2026-03-02 23:11:12.153	(Production Et Distribution De Produits Alimentaires) Production Et Distribution De Produits Alimentaires	Bccd	33 823 32 27	Dakar	\N	\N	\N	f	\N
754	Sbe Senegal - Sarl	sbe-senegal-sarl	Commerce De Produits Agricoles Vdn	\N	2	2026-03-02 23:11:12.155	2026-03-02 23:11:12.155	Commerce De Produits Agricoles Vdn	Immeuble Pyramid 0 Dakar Green Food Suarl Vente De Produit Alimentaires, Fruits Et Legumes Avenue Blaise Diagne	33 832 44 89	Dakar	\N	\N	\N	f	\N
755	Pharmacie Le Kalounaye Diamorale	pharmacie-le-kalounaye-diamorale	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.156	2026-03-02 23:11:12.156	Vente De Produits Pharmaceutiques	Rue Cite Ptt Casto rs	33 864 70 16	Dakar	\N	\N	\N	f	\N
756	Pharmacie Diaw Ara (Docteur Lamine Sankhare)	pharmacie-diaw-ara-docteur-lamine-sankhare	Vente De Produits Pharmaceutiques Diaw Are Bakel 0 Dakar Pharmacie Maimouna (Dr Maissa Diouf) Vente De Produits Pharmaceutiques Medina	\N	2	2026-03-02 23:11:12.158	2026-03-02 23:11:12.158	Vente De Produits Pharmaceutiques Diaw Are Bakel 0 Dakar Pharmacie Maimouna (Dr Maissa Diouf) Vente De Produits Pharmaceutiques Medina	Rue 37 X 28 0 Kaolack Pharmacie Du Sine (Alassane W Attara) Vente De Produits Pharmaceutiques Quartier Kasnack	33 825 10 66	Bakel	\N	\N	\N	f	\N
757	Au Bon Accueil (Mr Souaybel Thoumas)	au-bon-accueil-mr-souaybel-thoumas	Commerce	\N	2	2026-03-02 23:11:12.16	2026-03-02 23:11:12.16	Commerce	Rue Mass Diokhane	33 941 17 85	Dakar	\N	\N	\N	f	\N
758	Pharmacie Hann Maristes (Dr Aissatou Marie Ndaw )	pharmacie-hann-maristes-dr-aissatou-marie-ndaw	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.161	2026-03-02 23:11:12.161	Vente De Produits Pharmaceutiques	Route Du Front De Terre	33 821 74 05	Dakar	\N	\N	\N	f	\N
759	Pharmacie La Thiessoise - Suarl	pharmacie-la-thiessoise-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.163	2026-03-02 23:11:12.163	Vente De Produits Pharmaceutiques	Bd Colin 0 Tamba Boubacar Sidy Diallo Commerce En Face Cbao Tambacounda 0 Guediaw Aye Pharmacie Alhadia / Docteur Ndeye Bineta Paye Vente De Produits Pharmaceutiques Cite Fadia N° 0009 8 Face U 6	33 832 18 44	Thies	\N	\N	\N	f	\N
760	Aye Pharmacie Pai	aye-pharmacie-pai	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.164	2026-03-02 23:11:12.164	Vente De Produits Pharmaceutiques	Rue Hlm Las Palmas	33 821 42 75	Guediaw	\N	\N	\N	f	\N
761	Pharmacie Fogny	pharmacie-fogny	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.166	2026-03-02 23:11:12.166	Vente De Produits Pharmaceutiques	Route De Boune Yeu mbeul Afia 1	77 655 82 48	Pikine	\N	\N	\N	f	\N
762	Gie Horizons Dentaires	gie-horizons-dentaires	Commerce - Ventes De Produits Dentaires	\N	2	2026-03-02 23:11:12.168	2026-03-02 23:11:12.168	Commerce - Ventes De Produits Dentaires	Rue Amadou A ssane Ndoye	33 836 23 02	Dakar	\N	\N	\N	f	\N
763	Pharmacie El Hadji Ibrahima Niass (Alioune Diouf)	pharmacie-el-hadji-ibrahima-niass-alioune-diouf	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.169	2026-03-02 23:11:12.169	Vente De Produits Pharmaceutiques	Avenue Bourguiba X Route Du Front De Terre	33 821 05 77	Dakar	\N	\N	\N	f	\N
764	Espace Telecom	espace-telecom	Commerce General	\N	2	2026-03-02 23:11:12.171	2026-03-02 23:11:12.171	Commerce General	Rue Jules Ferry	33 864 65 01	Dakar	\N	\N	\N	f	\N
765	Cavadis Sarl	cavadis-sarl	Commerce General	\N	2	2026-03-02 23:11:12.173	2026-03-02 23:11:12.173	Commerce General	Avenue El Hadji Malick Sy Mbour 0 Ville Entreprise Activité Adresse Téléphone Dakar Pharmacie Scat Urbam (Dr Maimouna Niang Ndiaye) Vente De Produits Pharmaceutiques Scat Urbam N° B-04 Sud Grand-Yoff	77 655 97 98	Mbour	\N	\N	\N	f	\N
766	Sw Edish Machinery And Trucks Senegal	sw-edish-machinery-and-trucks-senegal	Vente Engins Et Piece S Aux Mines Btp Almadies	\N	2	2026-03-02 23:11:12.174	2026-03-02 23:11:12.174	Vente Engins Et Piece S Aux Mines Btp Almadies	Route De Ngor 5 -7	33 827 29 34	Dakar	\N	\N	\N	f	\N
767	Pharmacie Fass Mbao	pharmacie-fass-mbao	Vente De Produits Pharmaceutiques Fass Mbao	\N	2	2026-03-02 23:11:12.176	2026-03-02 23:11:12.176	Vente De Produits Pharmaceutiques Fass Mbao	(Route D e Rufisque)	33 842 89 95	Dakar	\N	\N	\N	f	\N
768	L'Usine Suarl	l-usine-suarl	Vente De Moto Quads- Garage Mecanique Ngaparou, Rout e De Saly 772574814 Dakar Barry Et Freres Sarl Commerce General	\N	2	2026-03-02 23:11:12.178	2026-03-02 23:11:12.178	Vente De Moto Quads- Garage Mecanique Ngaparou, Rout e De Saly 772574814 Dakar Barry Et Freres Sarl Commerce General	Rue 23 X 18 Medina 0 Kaolack Pharmacie De La Passoire Vente De Produits Pharmaceutiques Quartier Taba Ngoy e Ii - N° 158 B - Kaolack	33 834 93 13	Mbour	\N	\N	\N	f	\N
769	Predieri Metalli Senegal Sa	predieri-metalli-senegal-sa	Commerce D'Aluminium	\N	2	2026-03-02 23:11:12.18	2026-03-02 23:11:12.18	Commerce D'Aluminium	Avenue Felix Eboue En Face Mole 10	33 941 46 06	Dakar	\N	\N	\N	f	\N
770	Pharmacie Fatima (Docteur Khaly Sall )	pharmacie-fatima-docteur-khaly-sall	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.182	2026-03-02 23:11:12.182	Vente De Produits Pharmaceutiques	Rue Petersen X Esc arfait	30 186 74 66	Dakar	\N	\N	\N	f	\N
771	Saly	saly	Services Sarl Vente De Pieces Detachees	\N	2	2026-03-02 23:11:12.184	2026-03-02 23:11:12.184	Services Sarl Vente De Pieces Detachees	Route De Saly	33 869 24 64	Mbour	\N	\N	\N	f	\N
772	Societe Touba Quincaillerie Generale Sarl	societe-touba-quincaillerie-generale-sarl	Commerce General	\N	2	2026-03-02 23:11:12.186	2026-03-02 23:11:12.186	Commerce General	Quartier Darou Minam - Touba	33 824 51 94	Touba	\N	\N	\N	f	\N
773	Gie Thiaroye Poids Lourds	gie-thiaroye-poids-lourds	Commerce	\N	2	2026-03-02 23:11:12.189	2026-03-02 23:11:12.189	Commerce	Route De Rufisque 0 Dakar Africa Alliance Senegal - Sarl Agence De Voyages & Tourisme - Vente Billets D'Avion Avenue Albert Sarraut	33 978 12 95	Pikine	\N	\N	\N	f	\N
774	Canadian Bottling Company Sarl Traitement Et	canadian-bottling-company-sarl-traitement-et	Vente D'Eau	\N	2	2026-03-02 23:11:12.191	2026-03-02 23:11:12.191	Vente D'Eau	Rue 50 Liberte 6 Extension Bis	33 823 26 76	Dakar	\N	\N	\N	f	\N
775	Gie Mafatioul Bisri	gie-mafatioul-bisri	Commerce - Prestation De Service	\N	2	2026-03-02 23:11:12.193	2026-03-02 23:11:12.193	Commerce - Prestation De Service	Avenue John F.Kenne dy Kaolack 0 Meckhe Afric'Art Sarl Autres Commerces Mekhe Route De Pekesse	33 970 34 22	Kaolack	\N	\N	\N	f	\N
776	Rassoul Carreaux Surl	rassoul-carreaux-surl	Commerce Carreaux Et Tuiles Parcelles Assainies Unit e 22 N° 379 33 835 76 4 Saly Ab Star Senegal Vente De Quads Saly Carrefour 0 Dakar Pharmacie Tamsir Oumar Sall (Magatte Ba) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.195	2026-03-02 23:11:12.195	Commerce Carreaux Et Tuiles Parcelles Assainies Unit e 22 N° 379 33 835 76 4 Saly Ab Star Senegal Vente De Quads Saly Carrefour 0 Dakar Pharmacie Tamsir Oumar Sall (Magatte Ba) Vente De Produits Pharmaceutiques	Rue 22 X 17 Medina 0 Dakar Atex Sarl (Societe Alliance Technoligie Expertise) Commerce - Btp - Travaux De Refection Sacre Cœur 3 N ° 9054	33 820 13 28	Dakar	\N	\N	\N	f	\N
777	Pharmacie Yelitare	pharmacie-yelitare	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.197	2026-03-02 23:11:12.197	Vente De Produits Pharmaceutiques	Route Nationale Nd ioum	33 825 39 39	Ndioum	\N	\N	\N	f	\N
778	2Nd Etablissement - Sarl	2nd-etablissement-sarl	Commerce General Hlm Fass	\N	2	2026-03-02 23:11:12.199	2026-03-02 23:11:12.199	Commerce General Hlm Fass	Immeuble Jamil	33 965 30 32	Dakar	\N	\N	\N	f	\N
779	Prosem - Sarl (Ex - Prophyse)	prosem-sarl-ex-prophyse	Commerce Pdts Agricoles - Activites Annexes A L'Agriculture	\N	2	2026-03-02 23:11:12.201	2026-03-02 23:11:12.201	Commerce Pdts Agricoles - Activites Annexes A L'Agriculture	Rue Ramez Bourgi (Ex - Essarts)	77 637 63 57	Dakar	\N	\N	\N	f	\N
780	Fouad Ali Hoballah Autres	fouad-ali-hoballah-autres	Commerce - Distribution De Produits Alimentaires	\N	2	2026-03-02 23:11:12.203	2026-03-02 23:11:12.203	Commerce - Distribution De Produits Alimentaires	Rue Raffenel	33 835 41 25	Dakar	\N	\N	\N	f	\N
781	I.S. (Integral Solutions)	i-s-integral-solutions	Commerce	\N	2	2026-03-02 23:11:12.204	2026-03-02 23:11:12.204	Commerce	Rue De L'Ocean - Yoff	33 832 43 05	Dakar	\N	\N	\N	f	\N
782	Aye Pharmacie Nimzatt (Dr Aissatou Diagne Ba)	aye-pharmacie-nimzatt-dr-aissatou-diagne-ba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.206	2026-03-02 23:11:12.206	Vente De Produits Pharmaceutiques	Quartier Nimzatt N ° 1123	33 820 10 99	Guediaw	\N	\N	\N	f	\N
783	Icts Sarl (Nternational Company Of Trade And	icts-sarl-nternational-company-of-trade-and	Services Sarl) Distribution De Pompes Et Groupes Electrogenes	\N	2	2026-03-02 23:11:12.208	2026-03-02 23:11:12.208	Services Sarl) Distribution De Pompes Et Groupes Electrogenes	Bccd	33 837 42 42	Pikine	\N	\N	\N	f	\N
784	Pharmacie Khadidia	pharmacie-khadidia	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.209	2026-03-02 23:11:12.209	Vente De Produits Pharmaceutiques	Route Terme Sud Ou akam	33 867 00 68	Dakar	\N	\N	\N	f	\N
785	Sadecomi Sarl (Societe Africaine Pour Le Developpement	sadecomi-sarl-societe-africaine-pour-le-developpement	Commerce & Industrie - Sarl) Commerce	\N	2	2026-03-02 23:11:12.211	2026-03-02 23:11:12.211	Commerce & Industrie - Sarl) Commerce	Avenue Pasteur Imm. Pasteur	33 820 93 62	Dakar	\N	\N	\N	f	\N
786	Etablissements Raif Jaber	etablissements-raif-jaber	Commerce	\N	2	2026-03-02 23:11:12.213	2026-03-02 23:11:12.213	Commerce	Rue Galandou Diouf 33 8214830 Dakar Senegal Fleurs Sarl Production Et Vente De Fleurs Et Legumes Route De Ca mberene	33 821 68 80	Dakar	\N	\N	\N	f	\N
787	Pharmacie Al Amine	pharmacie-al-amine	Vente De Produits Pharmaceutiques Unite 6 Keur Massa r 0 Dakar Senar Sarl Commerce General Fann Residence	\N	2	2026-03-02 23:11:12.214	2026-03-02 23:11:12.214	Vente De Produits Pharmaceutiques Unite 6 Keur Massa r 0 Dakar Senar Sarl Commerce General Fann Residence	Route De La Corniche Ouest Face Clinique Olympique	33 824 30 66	Pikine	\N	\N	\N	f	\N
788	Fls (Fournisseur Libres	fls-fournisseur-libres	Services) Commerce General	\N	2	2026-03-02 23:11:12.216	2026-03-02 23:11:12.216	Services) Commerce General	Rue 39 X 22 Medina Dakar	33 846 65 05	Dakar	\N	\N	\N	f	\N
789	Boulangerie Seydi Jamil Et Hussein Boulangerie	boulangerie-seydi-jamil-et-hussein-boulangerie	(Production Et Distribution De Pain) Thi es	\N	2	2026-03-02 23:11:12.218	2026-03-02 23:11:12.218	(Production Et Distribution De Pain) Thi es	Rue Verdun X Lyon 0 Dakar Pharmacie Les Allees (Dr Cheikh Sidy El Khair Beye) Vente De Produits Pharmaceutiques Zone B Villa N° 8- A	33 889 06 66	Thies	\N	\N	\N	f	\N
790	Pharmacie Khadimou Rassoul (Ousseynou Seck)	pharmacie-khadimou-rassoul-ousseynou-seck	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.22	2026-03-02 23:11:12.22	Vente De Produits Pharmaceutiques	Avenue Du General De Gaulle - Saint-Louis	33 832 28 29	Saint-Louis	\N	\N	\N	f	\N
791	Low Re Industries Sarl	low-re-industries-sarl	Commerce Point E	\N	2	2026-03-02 23:11:12.221	2026-03-02 23:11:12.221	Commerce Point E	Rue De Thies X Rue De Fatick	33 855 85 72	Dakar	\N	\N	\N	f	\N
792	Global Import-Export Surl	global-import-export-surl	Commerce General	\N	2	2026-03-02 23:11:12.223	2026-03-02 23:11:12.223	Commerce General	Rue De Thiong X Rue Raffenel	77 244 27 47	Dakar	\N	\N	\N	f	\N
793	Pharmacie Tamsir Oumar Sall (Dr Magatte W Oureyratou Ba Sidibe)	pharmacie-tamsir-oumar-sall-dr-magatte-w-oureyratou-ba-sidibe	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.225	2026-03-02 23:11:12.225	Vente De Produits Pharmaceutiques	Rue 17 X 22 Medina 0 Dakar Smbs (Societe Moderne Des Boulangeries Du Senegal) Vente De Fours Et Accessoires Rue Robert Brun	33 855 31 83	Dakar	\N	\N	\N	f	\N
794	Entreprise Activité Adresse Téléphone Dakar Senegal Miroir - Abass Haw Ili	entreprise-activite-adresse-telephone-dakar-senegal-miroir-abass-haw-ili	Commerce De Materiaux De Construction - Annexe Btp	\N	2	2026-03-02 23:11:12.226	2026-03-02 23:11:12.226	Commerce De Materiaux De Construction - Annexe Btp	Rue Armand Angrand X Avenue Blaise Diagne	33 822 15 11	Ville	\N	\N	\N	f	\N
795	Pharmacie Delorme (Mme Ousseynou Niang Diop)	pharmacie-delorme-mme-ousseynou-niang-diop	Vente De Produits Pharmaceutiques Fass Delorme 33823 03 05 Dakar Pharmacie	\N	2	2026-03-02 23:11:12.228	2026-03-02 23:11:12.228	Vente De Produits Pharmaceutiques Fass Delorme 33823 03 05 Dakar Pharmacie	Abdoulaye (Ndeye Fatou Ndiaye Top) Vente De Produits Pharmaceutiques Sicap Sacre Cœur 1 Villa N° 8466	33 822 24 82	Dakar	\N	\N	\N	f	\N
796	Chez Mon Ami (Doon Chang)	chez-mon-ami-doon-chang	Commerce	\N	2	2026-03-02 23:11:12.23	2026-03-02 23:11:12.23	Commerce	Avenue Lamine Gueye	33 864 49 26	Dakar	\N	\N	\N	f	\N
797	Ste Boye Et Fils Sarl	ste-boye-et-fils-sarl	Commerce Quaincaillerie	\N	2	2026-03-02 23:11:12.231	2026-03-02 23:11:12.231	Commerce Quaincaillerie	Avenue De Gaule Saint Louis	33 962 14 10	Saint-Louis	\N	\N	\N	f	\N
798	Sega Kante	sega-kante	Commerce General	\N	2	2026-03-02 23:11:12.233	2026-03-02 23:11:12.233	Commerce General	Route De Bakel Kidira 0 Dakar Pharmacie Mariama Diane Vente De Produits Pharmaceutiques Quartier Yoff Cite Ranhrar Villa N°6	33 879 13 09	Bakel	\N	\N	\N	f	\N
799	Pharmacie Aime Cesaire (Sokhna Boye)	pharmacie-aime-cesaire-sokhna-boye	Vente De Produits Pharmaceutiques Fann Residence	\N	2	2026-03-02 23:11:12.235	2026-03-02 23:11:12.235	Vente De Produits Pharmaceutiques Fann Residence	Rue Aime Cesaire 0 Dakar Pharmacie Almadies Ngor Vente De Produits Pharmaceutiques Ngor Village	33 820 51 52	Dakar	\N	\N	\N	f	\N
800	Telogik Sarl Prestation De	telogik-sarl-prestation-de	Services Et Commerce Central Park Aven ue M Sy X	\N	2	2026-03-02 23:11:12.236	2026-03-02 23:11:12.236	Services Et Commerce Central Park Aven ue M Sy X	Autoroute	33 820 69 11	Dakar	\N	\N	\N	f	\N
801	Pharmacie El Hadji Malick Sy - Maimouna Sy Diaw	pharmacie-el-hadji-malick-sy-maimouna-sy-diaw	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.24	2026-03-02 23:11:12.24	Vente De Produits Pharmaceutiques	Quartier Commercia l - Tivaouane	33 823 35 10	Tivaouane	\N	\N	\N	f	\N
802	Ecopres Suarl (Entreprise De	ecopres-suarl-entreprise-de	Commerce Et De Prestation De Services - Suarl) Commerce General	\N	2	2026-03-02 23:11:12.242	2026-03-02 23:11:12.242	Commerce Et De Prestation De Services - Suarl) Commerce General	Rue Marchand X Lamine Gueye	33 837 91 70	Dakar	\N	\N	\N	f	\N
803	Pharmacie Almamy (Alassane Ndiaye)	pharmacie-almamy-alassane-ndiaye	Vente De Produits Pharmaceutiques Marche Ndioum 0 Rufisque Helios Industries Suarl Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.244	2026-03-02 23:11:12.244	Vente De Produits Pharmaceutiques Marche Ndioum 0 Rufisque Helios Industries Suarl Vente De Produits Pharmaceutiques	Route De Rufisque	76 485 47 47	Saint-Louis	\N	\N	\N	f	\N
804	Pharmacie La Somone (Mamadou Lamine Sane)	pharmacie-la-somone-mamadou-lamine-sane	Vente De Produits Pharmaceutiques Somone 33957 75 06 Dakar Pharmacie La Pikinoise Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.246	2026-03-02 23:11:12.246	Vente De Produits Pharmaceutiques Somone 33957 75 06 Dakar Pharmacie La Pikinoise Vente De Produits Pharmaceutiques	Route Des Niayes - Quartier Djedah 2 - Pikine	33 832 92 96	Mbour	\N	\N	\N	f	\N
805	Pharmacie El Hadj Abdoulaye Niasse	pharmacie-el-hadj-abdoulaye-niasse	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.25	2026-03-02 23:11:12.25	Vente De Produits Pharmaceutiques	Rue Doloa X Faidhe rbe - Lot N° 96 - Leona	33 941 20 81	Kaolack	\N	\N	\N	f	\N
806	Pharmacie Mboro Escale (Abdoulaye Dieng)	pharmacie-mboro-escale-abdoulaye-dieng	Vente De Produits Pharmaceutiques Escale Mboro 0 Saraya Pharmacie Saraya	\N	2	2026-03-02 23:11:12.256	2026-03-02 23:11:12.256	Vente De Produits Pharmaceutiques Escale Mboro 0 Saraya Pharmacie Saraya	(Abdoul Adjidiou Barry) Vente De Produits Pharmaceutiques Quartier Mosquee, Saraya 0 Dakar Pharmacie Ndoss Vente De Produits Pharmaceutiques Point E X Avenue C heikh Anta Diop	33 941 43 92	Mboro	\N	\N	\N	f	\N
807	Alinea Sarl	alinea-sarl	Commerce Saly Carrefour	\N	2	2026-03-02 23:11:12.259	2026-03-02 23:11:12.259	Commerce Saly Carrefour	Route De Saly	33 825 56 62	Mbour	\N	\N	\N	f	\N
808	Technoform (Alioune Badara Sylla)	technoform-alioune-badara-sylla	Commerce Et Services	\N	2	2026-03-02 23:11:12.262	2026-03-02 23:11:12.262	Commerce Et Services	Rue 37 X 22 Medina	33 957 51 83	Dakar	\N	\N	\N	f	\N
809	Pharmacie Darabis (Nafissatou Bao Mbaye)	pharmacie-darabis-nafissatou-bao-mbaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.265	2026-03-02 23:11:12.265	Vente De Produits Pharmaceutiques	Avenue Bourguiba - Rue 10 - Villa N° 3	77 637 40 89	Dakar	\N	\N	\N	f	\N
810	Adb Group Suarl (Assistance	adb-group-suarl-assistance	Distribution Busness - Suarl) Commerce General	\N	2	2026-03-02 23:11:12.267	2026-03-02 23:11:12.267	Distribution Busness - Suarl) Commerce General	Imm. Sokhna Anta Mbacke Ave Cheikh A. Bamba	33 824 16 63	Dakar	\N	\N	\N	f	\N
811	Kama	kama	Services (Hachim K. Mouhamed) Commerce General	\N	2	2026-03-02 23:11:12.27	2026-03-02 23:11:12.27	Services (Hachim K. Mouhamed) Commerce General	Rue Abdou Karim Bourgi X Raffenel 0 Dakar Pharmacie Aeroport Vente De Produits Pharmaceutiques Aeroport Leopold S edar Senghor	33 834 06 71	Dakar	\N	\N	\N	f	\N
812	Dame Lo	dame-lo	Commerce General	\N	2	2026-03-02 23:11:12.272	2026-03-02 23:11:12.272	Commerce General	Quartier Medina Gounass Marche Thia roye	33 820 01 01	Pikine	\N	\N	\N	f	\N
813	Mandir Pharma Sarl (Pharmacie Diarama)	mandir-pharma-sarl-pharmacie-diarama	Commerce De Produits Pharmaceutique	\N	2	2026-03-02 23:11:12.274	2026-03-02 23:11:12.274	Commerce De Produits Pharmaceutique	Avenue Cheikh A Bamba El H Malick Sy 0 Dakar Munif Group Sa (Munited Fournitures Group Senegal - Sa) Commerce De Marchandises Diverses Rue Amadou Assane Ndoye	33 838 41 11	Dakar	\N	\N	\N	f	\N
814	Khadige El Sayed	khadige-el-sayed	Commerce	\N	2	2026-03-02 23:11:12.275	2026-03-02 23:11:12.275	Commerce	Rue Galandou Diouf 0 Dakar Pharmacie Sokhna Bousso (Dr Astou Niane Anne) Vente De Produits Pharmaceutiques Ouakam Pres Du Mar che	33 820 90 95	Dakar	\N	\N	\N	f	\N
815	Pharmacie Serigne Fallou Mbacke	pharmacie-serigne-fallou-mbacke	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.277	2026-03-02 23:11:12.277	Vente De Produits Pharmaceutiques	Avenue Malick Sy E ntree Autoroute	33 867 91 10	Dakar	\N	\N	\N	f	\N
816	Pharmacie Cheikh Ibrahima Fall Yare (Dr Khadissatou Fall)	pharmacie-cheikh-ibrahima-fall-yare-dr-khadissatou-fall	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.279	2026-03-02 23:11:12.279	Vente De Produits Pharmaceutiques	Rue Y X Av. Bourgu iba	33 942 11 92	Dakar	\N	\N	\N	f	\N
817	African Industrial	african-industrial	Services Group Senegal Vente De Materiels Industriels	\N	2	2026-03-02 23:11:12.281	2026-03-02 23:11:12.281	Services Group Senegal Vente De Materiels Industriels	Boulevard Centenaire Commune Dakar	77 538 46 45	Dakar	\N	\N	\N	f	\N
818	Entreprise Activité Adresse Téléphone Dakar Pharmacie Serigne Mbacke Madina	entreprise-activite-adresse-telephone-dakar-pharmacie-serigne-mbacke-madina	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.283	2026-03-02 23:11:12.283	Vente De Produits Pharmaceutiques	Quartier Rue 10 Pi kine N° 1568	33 966 84 09	Ville	\N	\N	\N	f	\N
819	Fmt (Fournitures Maintenance Technologies)	fmt-fournitures-maintenance-technologies	Commerce	\N	2	2026-03-02 23:11:12.285	2026-03-02 23:11:12.285	Commerce	Avenue Bourguiba X Rue 12 Ben Tally	33 834 95 99	Dakar	\N	\N	\N	f	\N
820	Pharmacie Gallieni (Dr Fatou Gueye W Ade)	pharmacie-gallieni-dr-fatou-gueye-w-ade	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.287	2026-03-02 23:11:12.287	Vente De Produits Pharmaceutiques	Rue Briere De L'Is le X Gallieni	33 835 09 78	Dakar	\N	\N	\N	f	\N
821	Ibrahima Sall	ibrahima-sall	Commerce	\N	2	2026-03-02 23:11:12.289	2026-03-02 23:11:12.289	Commerce	Route De Rufisque Thiaroye Sur Mer	33 964 31 02	Pikine	\N	\N	\N	f	\N
822	Sud Import Sarl	sud-import-sarl	Commerce	\N	2	2026-03-02 23:11:12.291	2026-03-02 23:11:12.291	Commerce	Rue Felix Eboue Dakar	33 832 50 58	Dakar	\N	\N	\N	f	\N
823	Pharmacie Afia 5	pharmacie-afia-5	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.293	2026-03-02 23:11:12.293	Vente De Produits Pharmaceutiques	Route De Boune - Villa N° 135 - Yeumbeul	77 644 62 41	Yeumbeul	\N	\N	\N	f	\N
824	Somaphy W Est Africa Sa	somaphy-w-est-africa-sa	Vente De Materiels Agricoles	\N	2	2026-03-02 23:11:12.295	2026-03-02 23:11:12.295	Vente De Materiels Agricoles	Immeuble Aresa Cite Com ico	77 016 38 49	Dakar	\N	\N	\N	f	\N
825	Scpa Sarl (Societe De Commercialisation De Produits Alimentaires)	scpa-sarl-societe-de-commercialisation-de-produits-alimentaires	Vente De Produits Alimentaires	\N	2	2026-03-02 23:11:12.296	2026-03-02 23:11:12.296	Vente De Produits Alimentaires	Rue Valmy	33 827 96 59	Dakar	\N	\N	\N	f	\N
826	Art Funeraire - Sa Fabriques -	art-funeraire-sa-fabriques	Ventes Et Organisation De Pompes Funebres	\N	2	2026-03-02 23:11:12.298	2026-03-02 23:11:12.298	Ventes Et Organisation De Pompes Funebres	Avenue Jean Jaures	33 948 54 22	Dakar	\N	\N	\N	f	\N
827	2Mi (Maintenance Mines Industries)	2mi-maintenance-mines-industries	Commerce Vehicules Et Accessoires	\N	2	2026-03-02 23:11:12.3	2026-03-02 23:11:12.3	Commerce Vehicules Et Accessoires	Autoroute En Face Technopole	33 821 09 23	Dakar	\N	\N	\N	f	\N
828	Bodego (Sami Hoballah)	bodego-sami-hoballah	Commerce General	\N	2	2026-03-02 23:11:12.301	2026-03-02 23:11:12.301	Commerce General	Route Principale De Saly	33 834 95 13	Mbour	\N	\N	\N	f	\N
829	Printronic (Print Electronic Sarl)	printronic-print-electronic-sarl	Commerce Import Export	\N	2	2026-03-02 23:11:12.303	2026-03-02 23:11:12.303	Commerce Import Export	Rue De Reims X Armand Angrand Dakar 0 Matam Pharmacie Samassa Vente De Produits Pharmaceutiques Hamady Ounare Depa rtement De Matam	33 837 77 03	Dakar	\N	\N	\N	f	\N
830	Mabirdha Trucks Sa	mabirdha-trucks-sa	Vente De Vehicule	\N	2	2026-03-02 23:11:12.305	2026-03-02 23:11:12.305	Vente De Vehicule	Avenue Cheikh Anta Diop Medina 0 Dakar Sw Isspharm Sau Commerce Medical Cite Ambassade De France Sacre Cœur 3 Vdn 0 Dakar Sgas Sarl (Compagny Generale Amar Sy) Commerce General Mermoz Pyrotechnique Villa N°31	33 864 73 10	Dakar	\N	\N	\N	f	\N
831	Ismail Haw Ili (Aksel France)	ismail-haw-ili-aksel-france	Commerce General	\N	2	2026-03-02 23:11:12.308	2026-03-02 23:11:12.308	Commerce General	Avenue Emile Badiane Face Service D 'Ygiene	33 957 36 63	Dakar	\N	\N	\N	f	\N
832	Monsieur Abdallah Tareck	monsieur-abdallah-tareck	Commerce	\N	2	2026-03-02 23:11:12.31	2026-03-02 23:11:12.31	Commerce	Rue Jules Ferry	33 823 23 62	Dakar	\N	\N	\N	f	\N
833	Pharmacie Noirot	pharmacie-noirot	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.312	2026-03-02 23:11:12.312	Vente De Produits Pharmaceutiques	Quartier Abattoirs Face Garage Koutal	33 823 87 87	Kaolack	\N	\N	\N	f	\N
834	Exodis - Sarl	exodis-sarl	Vente De Produits Et Materiels De Salon De Coiffures Et Autres Produits	\N	2	2026-03-02 23:11:12.314	2026-03-02 23:11:12.314	Vente De Produits Et Materiels De Salon De Coiffures Et Autres Produits	Rue Mohamed V X Felix Faure	33 834 27 91	Dakar	\N	\N	\N	f	\N
835	Pharmacie S Moutakha Mbacke - Psmm	pharmacie-s-moutakha-mbacke-psmm	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.316	2026-03-02 23:11:12.316	Vente De Produits Pharmaceutiques	Rue Felix Eboue	33 821 20 17	Dakar	\N	\N	\N	f	\N
836	Pharmacie Martin Luther King	pharmacie-martin-luther-king	Vente De Produits Pharmaceutiques Medina -	\N	2	2026-03-02 23:11:12.318	2026-03-02 23:11:12.318	Vente De Produits Pharmaceutiques Medina -	Rue 7 X B d Martin Luther King	33 842 40 41	Dakar	\N	\N	\N	f	\N
837	Supermache U (Thiery Martinet)	supermache-u-thiery-martinet	Commerce Alimentaires Diverses	\N	2	2026-03-02 23:11:12.321	2026-03-02 23:11:12.321	Commerce Alimentaires Diverses	Rue A. Seck Marie Par sine	33 822 05 86	Saint-Louis	\N	\N	\N	f	\N
838	Fabucen Sarl (Fassel Business Center)	fabucen-sarl-fassel-business-center	Commerce Face Chambre De Commerce De Fatick 0 Tambacound a Pharmacie Al Hamdoulilah( El Hadji Sarr) Vente De Produits Pharmaceutiques Qrt Camp Navetane 766930404 Dakar Acces Canada Senegal Vente De Documents, De Rapports	\N	2	2026-03-02 23:11:12.323	2026-03-02 23:11:12.323	Commerce Face Chambre De Commerce De Fatick 0 Tambacound a Pharmacie Al Hamdoulilah( El Hadji Sarr) Vente De Produits Pharmaceutiques Qrt Camp Navetane 766930404 Dakar Acces Canada Senegal Vente De Documents, De Rapports	Immeuble Excellence - Place De L'Independance	33 961 12 63	Fatick	\N	\N	\N	f	\N
839	Pharmacie Serigne Mansour Sy (Dr Oumar Barro)	pharmacie-serigne-mansour-sy-dr-oumar-barro	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.325	2026-03-02 23:11:12.325	Vente De Produits Pharmaceutiques	Route De L'Hopital - Tivaouane	33 849 64 46	Tivaouane	\N	\N	\N	f	\N
840	Biotecnology Equipements Sarl	biotecnology-equipements-sarl	Commerce	\N	2	2026-03-02 23:11:12.327	2026-03-02 23:11:12.327	Commerce	Avenue Bourguiba Dakar	33 855 91 72	Dakar	\N	\N	\N	f	\N
841	Pacosen (Papeterie Commerciale Senegalaise)	pacosen-papeterie-commerciale-senegalaise	Commerce Lbrairie Papeterie	\N	2	2026-03-02 23:11:12.329	2026-03-02 23:11:12.329	Commerce Lbrairie Papeterie	Avenue Lamine Gueye	33 825 27 60	Dakar	\N	\N	\N	f	\N
842	Pharmacie Mame Fatou Diasse - Ex Rassouloulah Guing uineo	pharmacie-mame-fatou-diasse-ex-rassouloulah-guing-uineo	Vente De Produits Pharmaceutiques Guinguineo 0 Dakar Socico (Societe De Commerce International Et De Construction) Importation - Vente De Friperie	\N	2	2026-03-02 23:11:12.331	2026-03-02 23:11:12.331	Vente De Produits Pharmaceutiques Guinguineo 0 Dakar Socico (Societe De Commerce International Et De Construction) Importation - Vente De Friperie	Rue 40 X 49 Colobane	33 823 35 38	Guinguineo	\N	\N	\N	f	\N
843	T.T.M. Sarl (Thiam & Freres Touba Madiyana Sarl)	t-t-m-sarl-thiam-freres-touba-madiyana-sarl	Commerce Pikine	\N	2	2026-03-02 23:11:12.334	2026-03-02 23:11:12.334	Commerce Pikine	Route Des Niayes Plle N° 7706 0 Dakar Phoenix Senegal Sarl (Ex Acs : Africa Computer Systems) Commerce De Materiel Informatique Immeuble Hajjar Po int E	33 823 04 16	Pikine	\N	\N	\N	f	\N
844	Alm	alm	Service Sarl Commerce General	\N	2	2026-03-02 23:11:12.335	2026-03-02 23:11:12.335	Service Sarl Commerce General	Rue 19 X 20 Medina	33 825 06 75	Dakar	\N	\N	\N	f	\N
845	Pharmacie Du Camp (Mohamed Affif Yactine)	pharmacie-du-camp-mohamed-affif-yactine	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.338	2026-03-02 23:11:12.338	Vente De Produits Pharmaceutiques	Avenue El Hadji Om ar Route De Khombole	33 823 68 20	Thies	\N	\N	\N	f	\N
846	Senegalaise Des Travaux Et De	senegalaise-des-travaux-et-de	Commerce Suarl Commerce Et Travaux Liberte 6 Extension 779393187 Dakar Pharmacie Diamaguene Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.339	2026-03-02 23:11:12.339	Commerce Suarl Commerce Et Travaux Liberte 6 Extension 779393187 Dakar Pharmacie Diamaguene Vente De Produits Pharmaceutiques	Route De Rufisque	33 820 49 08	Dakar	\N	\N	\N	f	\N
847	Hamady Ba	hamady-ba	Commerce Grand Dakar N° 252 0 Dakar Ets Sen Boutique (Bara Ndiaye ) Commerce De Materiaux De Construction	\N	2	2026-03-02 23:11:12.342	2026-03-02 23:11:12.342	Commerce Grand Dakar N° 252 0 Dakar Ets Sen Boutique (Bara Ndiaye ) Commerce De Materiaux De Construction	Rue Marchand X Autoroute N° 25	33 834 05 71	Dakar	\N	\N	\N	f	\N
848	Sunu Industries Sa	sunu-industries-sa	Commerce General	\N	2	2026-03-02 23:11:12.343	2026-03-02 23:11:12.343	Commerce General	Route De Rufisque	33 842 64 59	Pikine	\N	\N	\N	f	\N
849	Pharmacie Dr Abdou Mbengue (Arame Seck Mbengue)	pharmacie-dr-abdou-mbengue-arame-seck-mbengue	Vente De Produits Pharmaceutiques Yoff Layene	\N	2	2026-03-02 23:11:12.345	2026-03-02 23:11:12.345	Vente De Produits Pharmaceutiques Yoff Layene	Route Des Cimetieres	33 853 10 10	Dakar	\N	\N	\N	f	\N
850	Pharmacie Escale	pharmacie-escale	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.347	2026-03-02 23:11:12.347	Vente De Produits Pharmaceutiques	Route De Matam En Face De La Gendarme Richard Toll	33 869 01 55	Saint-Louis	\N	\N	\N	f	\N
851	Sin (La Senegalaise D'Importation Et De Negoce - Sarl)	sin-la-senegalaise-d-importation-et-de-negoce-sarl	Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:12.349	2026-03-02 23:11:12.349	Commerce De Marchandises Diverses	Rue Robert Brun	33 963 34 92	Dakar	\N	\N	\N	f	\N
852	Entreprise Activité Adresse Téléphone Kaolack 2Ck Suarl (Comptoir Commerciale De Kaolack - Suarl)	entreprise-activite-adresse-telephone-kaolack-2ck-suarl-comptoir-commerciale-de-kaolack-suarl	Commerce	\N	2	2026-03-02 23:11:12.351	2026-03-02 23:11:12.351	Commerce	Rue Ernest Renan	33 966 88 44	Ville	\N	\N	\N	f	\N
853	Media Afrique Sarl	media-afrique-sarl	Commerce General	\N	2	2026-03-02 23:11:12.353	2026-03-02 23:11:12.353	Commerce General	Avenue Georges Pompidou	33 965 41 23	Dakar	\N	\N	\N	f	\N
854	Aye Pharmacie Doyen Cheikh Dieng (Dr Deguene Dieng Camara)	aye-pharmacie-doyen-cheikh-dieng-dr-deguene-dieng-camara	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.355	2026-03-02 23:11:12.355	Vente De Produits Pharmaceutiques	Quartier Daro Aw N ° 704 - Guediaw Aye	33 849 94 49	Guediaw	\N	\N	\N	f	\N
855	Kid Suarl	kid-suarl	Vente En Gros De Produits Pharmaceutiques Et Medica ux Rte De Ngaparou X Ave Des Milliardaires 0 Dakar Gedis - Sarl (Generale De Distribution) Commerce General - Marchandises Diverses	\N	2	2026-03-02 23:11:12.356	2026-03-02 23:11:12.356	Vente En Gros De Produits Pharmaceutiques Et Medica ux Rte De Ngaparou X Ave Des Milliardaires 0 Dakar Gedis - Sarl (Generale De Distribution) Commerce General - Marchandises Diverses	Avenue Albe rt Sarraut	33 855 95 65	Mbour	\N	\N	\N	f	\N
856	Pharmacie Taw Feex (Dr Serigne Samb)	pharmacie-taw-feex-dr-serigne-samb	Vente De Produits Pharmaceutiques Thiaroye Tally Dia llo Pinthie 0 Dakar Vitalmine Senegal Sarl Commerce	\N	2	2026-03-02 23:11:12.358	2026-03-02 23:11:12.358	Vente De Produits Pharmaceutiques Thiaroye Tally Dia llo Pinthie 0 Dakar Vitalmine Senegal Sarl Commerce	Route De Rufisque Adp 1	33 835 57 56	Thiaroye	\N	\N	\N	f	\N
857	Sosedis (Societe Senegalaise De	sosedis-societe-senegalaise-de	Distribution) Commerce	\N	2	2026-03-02 23:11:12.36	2026-03-02 23:11:12.36	Distribution) Commerce	Rue 13 Prolongee X Bourguiba Sodida Zone Sonepi Lot 70	77 529 83 42	Dakar	\N	\N	\N	f	\N
858	Pharmacie Mbotty Pom	pharmacie-mbotty-pom	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.362	2026-03-02 23:11:12.362	Vente De Produits Pharmaceutiques	Bd De La Gueule Tapee - Immeuble Aldiouma Diallo	33 968 61 15	Dakar	\N	\N	\N	f	\N
859	Pharmacie Alhamdoulilah (Khoudia Tabane)	pharmacie-alhamdoulilah-khoudia-tabane	Vente De Produits Pharmaceutiques Pikine	\N	2	2026-03-02 23:11:12.364	2026-03-02 23:11:12.364	Vente De Produits Pharmaceutiques Pikine	Route Natio nale	33 864 12 41	Saint-Louis	\N	\N	\N	f	\N
860	Ibrahima Gueye Autres	ibrahima-gueye-autres	Commerces De Details	\N	2	2026-03-02 23:11:12.367	2026-03-02 23:11:12.367	Commerces De Details	Rue Ousmane Soce Diop- R ufisque 0 Mbour Diouf Constructions Sarl Commerce Saly Carrefour N 18K Face Nouvelle Senelec / Mbour 0 Dakar Distrifilm Sarl Vente De Films Plastiques Et Equipement Pour Emballages, Locations De Machines Patte D'Oie Builders	33 961 51 89	Rufisque	\N	\N	\N	f	\N
861	Papeterie Imprimerie Le Gandiol Imprimerie -	papeterie-imprimerie-le-gandiol-imprimerie	Vente De Marchandises Diverses	\N	2	2026-03-02 23:11:12.369	2026-03-02 23:11:12.369	Vente De Marchandises Diverses	Avenue B laise Diagne X Rue 31	33 855 98 88	Dakar	\N	\N	\N	f	\N
862	Pharmacie Cheikh Aw A Balla Mbacke (Abdoulaye Michel Faye)	pharmacie-cheikh-aw-a-balla-mbacke-abdoulaye-michel-faye	Vente De Produits Pharmaceutiques Boune Yeumbeul 33 8787927 Dakar Sodemed Sarl (Societe D'Equipements Medicaux) Vente De Materiel Medical, Produits Medicaux Et De Laboratoire Point E -	\N	2	2026-03-02 23:11:12.372	2026-03-02 23:11:12.372	Vente De Produits Pharmaceutiques Boune Yeumbeul 33 8787927 Dakar Sodemed Sarl (Societe D'Equipements Medicaux) Vente De Materiel Medical, Produits Medicaux Et De Laboratoire Point E -	Bd De L'Est X Rue 2 -	33 878 29 19	Dakar	\N	\N	\N	f	\N
863	Distrivet Sarl	distrivet-sarl	Commerce General Cite Alioune Sow - Fass Mbao 0 Pikine Pharmacie Dabakh Malick (Ndeye Oumy Diop) Vente De Produits Pharmaceutiques Bene Baraque	\N	2	2026-03-02 23:11:12.375	2026-03-02 23:11:12.375	Commerce General Cite Alioune Sow - Fass Mbao 0 Pikine Pharmacie Dabakh Malick (Ndeye Oumy Diop) Vente De Produits Pharmaceutiques Bene Baraque	Route De Malika	33 825 40 94	Pikine	\N	\N	\N	f	\N
864	Aye Pharmacie Sahm Guediaw Aye	aye-pharmacie-sahm-guediaw-aye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.377	2026-03-02 23:11:12.377	Vente De Produits Pharmaceutiques	Quartier Mbode - Villa N° 303 - Sahm Guediaw Aye	33 837 80 20	Guediaw	\N	\N	\N	f	\N
865	Escdp (Papa Mabaye Fall)	escdp-papa-mabaye-fall	Commerce Derriere La Gare Routiere	\N	2	2026-03-02 23:11:12.379	2026-03-02 23:11:12.379	Commerce Derriere La Gare Routiere	(Avenue Leopold Sedar Sen ghor) 0 Kaolack Gie Daaray Serigne Touba Production Et Vente De Pain Prokhane Kaolack	33 837 61 50	Thies	\N	\N	\N	f	\N
866	Pharmacie Abdoul Aziz Sy (Paas ) - Dr Tabara Kane	pharmacie-abdoul-aziz-sy-paas-dr-tabara-kane	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.381	2026-03-02 23:11:12.381	Vente De Produits Pharmaceutiques	Rue Bourmeister, Q uartier Sud - Saint Louis	33 944 40 15	Saint-Louis	\N	\N	\N	f	\N
867	Homea Sarl	homea-sarl	Commerce General	\N	2	2026-03-02 23:11:12.383	2026-03-02 23:11:12.383	Commerce General	Rue Mass Diokhane	33 961 31 29	Dakar	\N	\N	\N	f	\N
868	Pharmacie Vital - Diana Maroune	pharmacie-vital-diana-maroune	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.385	2026-03-02 23:11:12.385	Vente De Produits Pharmaceutiques	Rue Grasland X Mou sse Diop	33 842 71 00	Dakar	\N	\N	\N	f	\N
869	Pharmacie Bintou Rassoul	pharmacie-bintou-rassoul	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.386	2026-03-02 23:11:12.386	Vente De Produits Pharmaceutiques	Quartier Diacksao - Thiaroye	33 821 08 89	Dakar	\N	\N	\N	f	\N
870	Gie Diamalaye Autres	gie-diamalaye-autres	Commerces	\N	2	2026-03-02 23:11:12.389	2026-03-02 23:11:12.389	Commerces	Rue Fleurus 0 Dakar Technical House Vente De Materiels De Laboratoire Et Maintenance Avenue Blaise Diagne X Rue 13 Medina	33 834 37 93	Dakar	\N	\N	\N	f	\N
871	Entreprise Italia Sarl	entreprise-italia-sarl	Commerce General	\N	2	2026-03-02 23:11:12.392	2026-03-02 23:11:12.392	Commerce General	Route De Rufisque Thiaroye Sur Mer	77 452 57 37	Dakar	\N	\N	\N	f	\N
872	Abs Negoce Et Chimie Sarl	abs-negoce-et-chimie-sarl	Commerce	\N	2	2026-03-02 23:11:12.393	2026-03-02 23:11:12.393	Commerce	Avenue Blaise Diagne	33 827 43 29	Dakar	\N	\N	\N	f	\N
873	Pharmacie Carrefour Ocass (Michel Diouf)	pharmacie-carrefour-ocass-michel-diouf	Vente De Produits Pharmaceutiques Qrt Ndorong 0 Ville Entreprise Activité Adresse Téléphone Dakar Comptoir Commercial Talla Kane Sarl Commerce	\N	2	2026-03-02 23:11:12.395	2026-03-02 23:11:12.395	Vente De Produits Pharmaceutiques Qrt Ndorong 0 Ville Entreprise Activité Adresse Téléphone Dakar Comptoir Commercial Talla Kane Sarl Commerce	Rue 21 X 18 Medina 0 Thies Pharmacie Thierno Amadou Moctar Sakho Vente De Produits Pharmaceutiques Cite Senghor 0 Louga Pharmacie Amadou Ba Malal(Papa Boubacar Ba) Vente De Produits Pharmaceutiques Avenue El Hadji Sa mba Khary Cisse	33 821 68 63	Kaolack	\N	\N	\N	f	\N
874	Pharmacie Mame Sophie Ndiaye (Souleyemane Gning)	pharmacie-mame-sophie-ndiaye-souleyemane-gning	Vente De Produits Pharmaceutiques Rufisque Extension 2	\N	2	2026-03-02 23:11:12.397	2026-03-02 23:11:12.397	Vente De Produits Pharmaceutiques Rufisque Extension 2	Quartier Santa Yalla	33 860 61 61	Rufisque	\N	\N	\N	f	\N
875	Afric Perf Sarl	afric-perf-sarl	Commerce Sodida 34 H	\N	2	2026-03-02 23:11:12.399	2026-03-02 23:11:12.399	Commerce Sodida 34 H	Immeuble Les Dunes 3ème Etage	33 863 12 43	Dakar	\N	\N	\N	f	\N
876	La Superette Exotica Market	la-superette-exotica-market	Commerce Genera- Fournitures Diverses	\N	2	2026-03-02 23:11:12.402	2026-03-02 23:11:12.402	Commerce Genera- Fournitures Diverses	Route De Khor Sor Saint Louis	77 811 93 17	Saint-Louis	\N	\N	\N	f	\N
877	Alimentation Al Jaw Ad Superette (Toufik Ahmad Mohsen)	alimentation-al-jaw-ad-superette-toufik-ahmad-mohsen	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:12.409	2026-03-02 23:11:12.409	Commerce De Produits Alimentaires	Rue Abdou Karim Bo urgi	33 825 19 38	Dakar	\N	\N	\N	f	\N
878	La Brousse Suarl	la-brousse-suarl	Commerce	\N	2	2026-03-02 23:11:12.411	2026-03-02 23:11:12.411	Commerce	Route De Yenne X Todd	33 842 72 61	Rufisque	\N	\N	\N	f	\N
879	Pharmacie Du Stade Suarl	pharmacie-du-stade-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.414	2026-03-02 23:11:12.414	Vente De Produits Pharmaceutiques	Route Des Hlm Face Stade Municipal De Rufisque	77 860 18 19	Rufisque	\N	\N	\N	f	\N
880	Senlink Informatique (Gamou Gaye)	senlink-informatique-gamou-gaye	Vente De Materiels Et Consommables Ingormatiques	\N	2	2026-03-02 23:11:12.416	2026-03-02 23:11:12.416	Vente De Materiels Et Consommables Ingormatiques	Rue 03 X Blaise Diagne	77 531 69 03	Dakar	\N	\N	\N	f	\N
881	Station Total Fleuve (Becaye Guindo)	station-total-fleuve-becaye-guindo	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:12.419	2026-03-02 23:11:12.419	Vente De Produits Petroliers (Station D'Essence)	Route De Dakar - St-Louis	33 821 61 71	Saint-Louis	\N	\N	\N	f	\N
882	Pharmacie Mame Aw A	pharmacie-mame-aw-a	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.421	2026-03-02 23:11:12.421	Vente De Produits Pharmaceutiques	Quartier Daroulaye Tally Boumak - Thiaroye Gare	33 961 13 65	Dakar	\N	\N	\N	f	\N
883	Mona Lisa Papeterie (Mme Mouna W Ayzani)	mona-lisa-papeterie-mme-mouna-w-ayzani	Commerce	\N	2	2026-03-02 23:11:12.423	2026-03-02 23:11:12.423	Commerce	Route De L'Aeroport A Cote Station Shell Ng or	33 832 78 03	Dakar	\N	\N	\N	f	\N
884	Pharmacie W Ore Fall	pharmacie-w-ore-fall	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.425	2026-03-02 23:11:12.425	Vente De Produits Pharmaceutiques	Quartier Santhiaba N°122 Lot 40 Grand Yoff	33 820 17 60	Dakar	\N	\N	\N	f	\N
885	Pharmacie Serigne Saliou Mbacke (Dr Serigne Sougou Gueye)	pharmacie-serigne-saliou-mbacke-dr-serigne-sougou-gueye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.427	2026-03-02 23:11:12.427	Vente De Produits Pharmaceutiques	Quartier Thioce Es t 33957 13 85 Pikine Pharmacie El Hadj Mamadou Kande (Oumou Kande) Vente De Produits Pharmaceutiques Cite Mame Cire Zac Mbao	33 834 95 24	Mbour	\N	\N	\N	f	\N
886	Pharmacie Sindia (Mamadou Ciss)	pharmacie-sindia-mamadou-ciss	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.429	2026-03-02 23:11:12.429	Vente De Produits Pharmaceutiques	Route De Mbour Sin dia	33 870 02 75	Mbour	\N	\N	\N	f	\N
887	Sotex Africa Sarl (Societe Tunisienne D'Exploitation)	sotex-africa-sarl-societe-tunisienne-d-exploitation	Commerce - Distribution Et Representation De Tous Produits - Vente De Carreauf Et De Baignoirs	\N	2	2026-03-02 23:11:12.432	2026-03-02 23:11:12.432	Commerce - Distribution Et Representation De Tous Produits - Vente De Carreauf Et De Baignoirs	Avenue Lamine Gueye X Rue Marchand - Immeuble Mamadou Fall	77 534 84 59	Dakar	\N	\N	\N	f	\N
888	Pharmacie Mame Fatou Diop Yoro (Mouhamed Lamine Diaw )	pharmacie-mame-fatou-diop-yoro-mouhamed-lamine-diaw	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.434	2026-03-02 23:11:12.434	Vente De Produits Pharmaceutiques	Rue 11 X 12 Medina	33 834 17 49	Dakar	\N	\N	\N	f	\N
889	Gie Famille Dioum	gie-famille-dioum	Commerce	\N	2	2026-03-02 23:11:12.436	2026-03-02 23:11:12.436	Commerce	Rue 17 X Blaise Diagne 0 Rufisque Quincaillerie Le President Sarl Commerce Quincaillerie Bd Maurice Gueye En Face Clinique Rada - Rufisque 0 Dakar Pharmacie Bel Air - Salimatou Barry Vente De Produits Pharmaceutiques Avenue Felix Eboue X Ecole Mermoz	77 818 07 22	Dakar	\N	\N	\N	f	\N
890	Boulangerie Khalifa Ababacar Sy (Bada Gassama)	boulangerie-khalifa-ababacar-sy-bada-gassama	Production Et Vente De Pain Malika Plage N°470 0 Dakar Cge Du Senegal - Sa (Cie Generale D'Energie Du Senegal) Telecommunication - Froid Electromenager - Vente De Tous Materiels Electriques	\N	1	2026-03-02 23:11:12.437	2026-03-02 23:11:12.437	Production Et Vente De Pain Malika Plage N°470 0 Dakar Cge Du Senegal - Sa (Cie Generale D'Energie Du Senegal) Telecommunication - Froid Electromenager - Vente De Tous Materiels Electriques	Avenue Malick Sy X Rue Ambroise Mendy	33 855 20 31	Pikine	\N	\N	\N	f	\N
891	Pharmacie Fatim Zahra	pharmacie-fatim-zahra	Vente De Produits Pharmaceutiques Medina -	\N	2	2026-03-02 23:11:12.439	2026-03-02 23:11:12.439	Vente De Produits Pharmaceutiques Medina -	Rue 22 * 27	33 839 39 39	Dakar	\N	\N	\N	f	\N
892	Hassan Halaoui (Ok	hassan-halaoui-ok	Distribution) Commerce General	\N	2	2026-03-02 23:11:12.441	2026-03-02 23:11:12.441	Distribution) Commerce General	Rue Robert Brun	33 961 64 73	Dakar	\N	\N	\N	f	\N
893	Pharmacie Cheikh Ahmadou Bamba	pharmacie-cheikh-ahmadou-bamba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.443	2026-03-02 23:11:12.443	Vente De Produits Pharmaceutiques	Avenue Blaise Diag ne	33 855 57 12	Dakar	\N	\N	\N	f	\N
894	Pharmacie Khalifa Ababacar Sy	pharmacie-khalifa-ababacar-sy	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.445	2026-03-02 23:11:12.445	Vente De Produits Pharmaceutiques	Avenue El Hadji Malick Sy Ex Tally Icotaf Plle 5578	77 450 16 15	Pikine	\N	\N	\N	f	\N
895	Ets Aly Hassan Fakhry	ets-aly-hassan-fakhry	Commerce General	\N	2	2026-03-02 23:11:12.448	2026-03-02 23:11:12.448	Commerce General	Rue Galandou Diouf	77 638 94 99	Dakar	\N	\N	\N	f	\N
896	Pharmacie Darou Miname (Docteur Fallou Seck)	pharmacie-darou-miname-docteur-fallou-seck	Vente De Produits Pharmaceutiques Face Marche Nguela w - Mbour 0 Dakar Pharmacie Seydina Mandione Laye (Dr Libasse Gueye) Vente De Produits Pharmaceutiques Camberene 2 33 822 73 93. Dakar Stmm (Societe Trading Et De Materiel Medical) Vente De Materiel Medical	\N	2	2026-03-02 23:11:12.45	2026-03-02 23:11:12.45	Vente De Produits Pharmaceutiques Face Marche Nguela w - Mbour 0 Dakar Pharmacie Seydina Mandione Laye (Dr Libasse Gueye) Vente De Produits Pharmaceutiques Camberene 2 33 822 73 93. Dakar Stmm (Societe Trading Et De Materiel Medical) Vente De Materiel Medical	Rue B X 6 Point E Keur Mbagnick, Immeuble Hajar	33 981 51 58	Mbour	\N	\N	\N	f	\N
897	Pharmacie El Hadji Djily Mbaye (Seynabou Faye Coulibaly)	pharmacie-el-hadji-djily-mbaye-seynabou-faye-coulibaly	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.451	2026-03-02 23:11:12.451	Vente De Produits Pharmaceutiques	Avenue Bouna Alboury Ndiaye - Quartier Keur Kabas	33 842 01 01	Louga	\N	\N	\N	f	\N
898	Aye Thierno Mouctar Sow	aye-thierno-mouctar-sow	Commerce General Daroukhane Cite	\N	2	2026-03-02 23:11:12.454	2026-03-02 23:11:12.454	Commerce General Daroukhane Cite	Abdou Diouf N° 443 0 Guediaw Aye Ets Adama Ba Commerce General Marche Ndiareme	33 967 05 92	Guediaw	\N	\N	\N	f	\N
899	Pharmacie Le Goeland	pharmacie-le-goeland	Vente De Produits Pharmaceutiques Bld Djily Mbaye X	\N	2	2026-03-02 23:11:12.456	2026-03-02 23:11:12.456	Vente De Produits Pharmaceutiques Bld Djily Mbaye X	Rue Robert Denand	33 836 26 44	Dakar	\N	\N	\N	f	\N
900	Fouad Mohamed Hussein	fouad-mohamed-hussein	Commerce Appareils Electro Menagers - Climatisseurs - Ventilateurs Etc. (Arthur Martin Electoluf - Atlantic Climatisation)	\N	2	2026-03-02 23:11:12.458	2026-03-02 23:11:12.458	Commerce Appareils Electro Menagers - Climatisseurs - Ventilateurs Etc. (Arthur Martin Electoluf - Atlantic Climatisation)	Rue W Agane Diouf	77 551 68 99	Dakar	\N	\N	\N	f	\N
901	El Hadj Ousmane Diallo	el-hadj-ousmane-diallo	Commerce De Noix De Cajou Lyndiane Ziguinchor 774046490 Dakar Iroko - Surl Vente Meubles - Petits Objets En Bois - Travaux Factures - Divers Point E -	\N	2	2026-03-02 23:11:12.461	2026-03-02 23:11:12.461	Commerce De Noix De Cajou Lyndiane Ziguinchor 774046490 Dakar Iroko - Surl Vente Meubles - Petits Objets En Bois - Travaux Factures - Divers Point E -	Rue 2 X B Villa N° 5A	33 821 51 61	Ziguinchor	\N	\N	\N	f	\N
902	Galerie Sahelienne D'Industrie - Gsi	galerie-sahelienne-d-industrie-gsi	Commerce	\N	2	2026-03-02 23:11:12.462	2026-03-02 23:11:12.462	Commerce	Bccd X Route Des Emases 0 Dakar Global Sourcing Distribution Consommables Medicales Yoff Layene Vill a N°74	33 864 18 80	Dakar	\N	\N	\N	f	\N
903	Soner Sarl (Societe D'Energie Et De Construction)	soner-sarl-societe-d-energie-et-de-construction	Commerce General Sacre Cœur Ii Vdn Liberte 6 0 Dakar Moustapha Sylla (Ets Keur Khadim Sylla & Freres) Commerce General	\N	1	2026-03-02 23:11:12.464	2026-03-02 23:11:12.464	Commerce General Sacre Cœur Ii Vdn Liberte 6 0 Dakar Moustapha Sylla (Ets Keur Khadim Sylla & Freres) Commerce General	Rue Abdou Karim Bourgi	33 837 11 80	Dakar	\N	\N	\N	f	\N
904	Abscisse	abscisse	Distribution Afrique Commerce General Km 5	\N	2	2026-03-02 23:11:12.466	2026-03-02 23:11:12.466	Distribution Afrique Commerce General Km 5	Bccd 0 Foundiougne El Hadji Malick Sy Commerce Rue Quai Thiamene - Foundiougne	33 821 54 45	Dakar	\N	\N	\N	f	\N
905	Lacofa (La Commerciale Franco Afrique - Dis)	lacofa-la-commerciale-franco-afrique-dis	Commerce	\N	2	2026-03-02 23:11:12.467	2026-03-02 23:11:12.467	Commerce	Rue Felix Eboue	77 637 80 98	Dakar	\N	\N	\N	f	\N
906	Makhtar Diop	makhtar-diop	Commerce Tally Boumack - Pikine N° 3840 0 Dakar Sintrade Sa Commerce General	\N	2	2026-03-02 23:11:12.469	2026-03-02 23:11:12.469	Commerce Tally Boumack - Pikine N° 3840 0 Dakar Sintrade Sa Commerce General	Avenue Lamine Gueye	33 825 05 09	Pikine	\N	\N	\N	f	\N
907	Sen Technologie Pow Er Sarl	sen-technologie-pow-er-sarl	Commerce De Detail En Magasin Specialise D'Articles Et Appar	\N	2	2026-03-02 23:11:12.471	2026-03-02 23:11:12.471	Commerce De Detail En Magasin Specialise D'Articles Et Appar	Boulevard De La Liberation 0 Dakar Pharmacie Maty - Ouleymatou Boye Vente De Produits Pharmaceutiques Rond Point Liberte Vi - Lot N° 15	33 822 73 93	Dakar	\N	\N	\N	f	\N
908	Osaka Light Sarl	osaka-light-sarl	Commerce	\N	2	2026-03-02 23:11:12.473	2026-03-02 23:11:12.473	Commerce	Avenue Malick Sy	33 822 90 41	Dakar	\N	\N	\N	f	\N
909	Pharmacie Guy Seddele	pharmacie-guy-seddele	Vente De Produits Pharmaceutiques Pikine	\N	2	2026-03-02 23:11:12.474	2026-03-02 23:11:12.474	Vente De Produits Pharmaceutiques Pikine	Route Natio nale	33 855 12 63	Saint-Louis	\N	\N	\N	f	\N
910	Pharmacie Mame Diarra Bousso(Yero Diouma Dian)	pharmacie-mame-diarra-bousso-yero-diouma-dian	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.476	2026-03-02 23:11:12.476	Vente De Produits Pharmaceutiques	Rue Felix Eboue	33 878 13 79	Diourbel	\N	\N	\N	f	\N
911	Pharmacie W Agane Diouf (Expharmacie Amadou Sakhir Mbaye - Hussein Saiel	pharmacie-w-agane-diouf-expharmacie-amadou-sakhir-mbaye-hussein-saiel	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.478	2026-03-02 23:11:12.478	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e	33 971 34 35	Louga	\N	\N	\N	f	\N
912	Pharmacie Hersent (Cheikh Ibrahima Faye)	pharmacie-hersent-cheikh-ibrahima-faye	Vente De Produits Pharmaceutiques Hersent	\N	2	2026-03-02 23:11:12.485	2026-03-02 23:11:12.485	Vente De Produits Pharmaceutiques Hersent	Route De K hombole	33 967 10 17	Thies	\N	\N	\N	f	\N
913	Pharmacie Du Rond Point Nguinth(Maxime Marone Theodore Toupane)	pharmacie-du-rond-point-nguinth-maxime-marone-theodore-toupane	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.487	2026-03-02 23:11:12.487	Vente De Produits Pharmaceutiques	Quartier Nguinth T hies	33 951 32 19	Thies	\N	\N	\N	f	\N
914	Pharmacie Elimane Aly Dramane (Dr Souleymane Sy)	pharmacie-elimane-aly-dramane-dr-souleymane-sy	Vente De Produits Pharmaceutiques Malika 0 Dakar Hsinfei Trading And Investement Company (Natic) Commerce General	\N	2	2026-03-02 23:11:12.489	2026-03-02 23:11:12.489	Vente De Produits Pharmaceutiques Malika 0 Dakar Hsinfei Trading And Investement Company (Natic) Commerce General	Rue Malan Immeuble Electra	33 954 06 48	Pikine	\N	\N	\N	f	\N
915	Hussein Younes	hussein-younes	Commerce	\N	2	2026-03-02 23:11:12.491	2026-03-02 23:11:12.491	Commerce	Rue Du Liban Ex Tolbiac	33 867 21 46	Dakar	\N	\N	\N	f	\N
916	Pharmacie Bineta Diagne (Ndeye Aw A Diagne )	pharmacie-bineta-diagne-ndeye-aw-a-diagne	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.493	2026-03-02 23:11:12.493	Vente De Produits Pharmaceutiques	Avenue Dodds - Nda r Toute	33 822 25 66	Saint-Louis	\N	\N	\N	f	\N
917	Interfood Africa Sarl	interfood-africa-sarl	Commerce General	\N	2	2026-03-02 23:11:12.495	2026-03-02 23:11:12.495	Commerce General	Immeuble Cbao Route De L'Aeroport	33 961 23 81	Dakar	\N	\N	\N	f	\N
918	Pharmacie Sega Ndaw (Dr Khady Ndaw )	pharmacie-sega-ndaw-dr-khady-ndaw	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.496	2026-03-02 23:11:12.496	Vente De Produits Pharmaceutiques	Quartier Darou Sal am 6 Yeumbeul Nord 0 Thies Pharmacie De La Teranga (Mamadou Badara Seck) Vente De Produits Pharmaceutiques Rue Felix Houphoue t	33 822 55 14	Pikine	\N	\N	\N	f	\N
919	Gie Platinium Import	gie-platinium-import	Commerce De Quincaillerie	\N	2	2026-03-02 23:11:12.498	2026-03-02 23:11:12.498	Commerce De Quincaillerie	Rue Elhadji Malick Sy - Mb our	33 860 55 67	Thies	\N	\N	\N	f	\N
920	Pharmacie Dabakh Malick (Mame Fota Diop Fall)	pharmacie-dabakh-malick-mame-fota-diop-fall	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.5	2026-03-02 23:11:12.5	Vente De Produits Pharmaceutiques	Quartier Darou 0 Dakar Dynapharm Senegal Ventes De Complements Alimentaires Avenue Georges Po mpidou	33 835 94 02	Pikine	\N	\N	\N	f	\N
921	Ets Modou Mbaye Ndiaye	ets-modou-mbaye-ndiaye	Commerce Tivaouane 0 Mbour Pharmacie Seybatou Vente De Produits Pharmaceutiques Qrt Santhiie Oncad Mbour 0 Dakar Senop Sa (Senegal Operation) Production Et Distribution D'Eau	\N	2	2026-03-02 23:11:12.502	2026-03-02 23:11:12.502	Commerce Tivaouane 0 Mbour Pharmacie Seybatou Vente De Produits Pharmaceutiques Qrt Santhiie Oncad Mbour 0 Dakar Senop Sa (Senegal Operation) Production Et Distribution D'Eau	Immeuble Pyramid Vd n N°7	77 546 03 03	Tivaouane	\N	\N	\N	f	\N
922	Pharmacie Lamine Gueye Suarl	pharmacie-lamine-gueye-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.503	2026-03-02 23:11:12.503	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e	77 636 81 94	Dakar	\N	\N	\N	f	\N
923	Ets Serigne Abdou Lahat Mbacke	ets-serigne-abdou-lahat-mbacke	Commerce	\N	2	2026-03-02 23:11:12.505	2026-03-02 23:11:12.505	Commerce	Quartier Keury Souf Bambilor 0 Dakar Ets Ibrahima Diop Vente Et Fourniture De Materiel Rue Ngalandou Diouf	33 821 94 46	Rufisque	\N	\N	\N	f	\N
924	Entreprise Activité Adresse Téléphone Pikine Pharmacie Ainoumady (El Hadji Cheikh Goumbala)	entreprise-activite-adresse-telephone-pikine-pharmacie-ainoumady-el-hadji-cheikh-goumbala	Vente De Produits Pharmaceutiques Cite Ainoumady Keu r Massar 0 Dakar Orient Auto Services - Sarl Commerce Vehicules - Pieces Detachees - Reparations	\N	2	2026-03-02 23:11:12.507	2026-03-02 23:11:12.507	Vente De Produits Pharmaceutiques Cite Ainoumady Keu r Massar 0 Dakar Orient Auto Services - Sarl Commerce Vehicules - Pieces Detachees - Reparations	Route De Rufisque - Rue Des Hydrocarbures	33 823 42 97	Ville	\N	\N	\N	f	\N
925	Pharmacie Fatou Tordy Sy (Dr Aw A Sow W Ade)	pharmacie-fatou-tordy-sy-dr-aw-a-sow-w-ade	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.509	2026-03-02 23:11:12.509	Vente De Produits Pharmaceutiques	Quartier Toll Diaz Keur Mbaye Fall	33 821 47 11	Pikine	\N	\N	\N	f	\N
926	Housseynou Chamessidine Bonneterie - Confection -	housseynou-chamessidine-bonneterie-confection	Commerce Textile	\N	2	2026-03-02 23:11:12.511	2026-03-02 23:11:12.511	Commerce Textile	Bccd	33 855 59 33	Dakar	\N	\N	\N	f	\N
927	Equipement Trucks	equipement-trucks	Services Commerce Sotrac Mermoz 0 Dakar Offices Consommables (Mamadou Mansour Drame) Commerce	\N	2	2026-03-02 23:11:12.513	2026-03-02 23:11:12.513	Services Commerce Sotrac Mermoz 0 Dakar Offices Consommables (Mamadou Mansour Drame) Commerce	Avenue Blaise Diagne	33 821 78 72	Dakar	\N	\N	\N	f	\N
928	Pharmacie Mamadou Ngom (Sara Ngom)	pharmacie-mamadou-ngom-sara-ngom	Vente De Produits Pharmaceutiques Mbambilor Ndiassan e 0 Aere Lao Nouvelle Pharmacie Du Lao	\N	2	2026-03-02 23:11:12.514	2026-03-02 23:11:12.514	Vente De Produits Pharmaceutiques Mbambilor Ndiassan e 0 Aere Lao Nouvelle Pharmacie Du Lao	(Abdoulaye Toure) Vente De Produits Pharmaceutiques Quartier Garage - Aere Lao	33 855 06 60	Rufisque	\N	\N	\N	f	\N
929	Ibrahima Soly	ibrahima-soly	Vente De Marchandises	\N	2	2026-03-02 23:11:12.516	2026-03-02 23:11:12.516	Vente De Marchandises	Rue 9 Point E 0 Dakar Pharmacie Zahra Maristes Vente De Produits Pharmaceutiques Hann Hlm Maristes Immeuble L	33 822 73 93	Dakar	\N	\N	\N	f	\N
930	Tp Bat Solutions - Sarl Btp (Ex	tp-bat-solutions-sarl-btp-ex	Commerce)	\N	2	2026-03-02 23:11:12.518	2026-03-02 23:11:12.518	Commerce)	Avenue De Gaulle - Saint- Louis	33 832 62 40	Saint-Louis	\N	\N	\N	f	\N
931	Lama Boutique - Sarl	lama-boutique-sarl	Commerce Grand Dakar N° 30B (Ex Bopp	\N	2	2026-03-02 23:11:12.52	2026-03-02 23:11:12.52	Commerce Grand Dakar N° 30B (Ex Bopp	Rue 9 N°282)	33 961 27 71	Dakar	\N	\N	\N	f	\N
932	Neuf Suarl	neuf-suarl	Commerce General Centre Commercial Sea Plaza 0 Saint-Louis Sctv - Sarl (Societe Commerciale Touba Vaisselle - Sarl) Commerce General Ave General Degaulle Marche Sor 0 Dakar Clasana Sa Achat, Vente Et Location	\N	2	2026-03-02 23:11:12.522	2026-03-02 23:11:12.522	Commerce General Centre Commercial Sea Plaza 0 Saint-Louis Sctv - Sarl (Societe Commerciale Touba Vaisselle - Sarl) Commerce General Ave General Degaulle Marche Sor 0 Dakar Clasana Sa Achat, Vente Et Location	D'Immeubles Bccd	33 824 48 12	Dakar	\N	\N	\N	f	\N
933	El Hadji Fallou Amar	el-hadji-fallou-amar	Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:12.524	2026-03-02 23:11:12.524	Commerce De Marchandises Diverses	Rue Sandiniery 0 Richard-Toll Pharmacie Abdoul Aziz Sy (Dr Oumou Kaltome Fall Niang) Vente De Produits Pharmaceutiques Richard-Toll En Fa ce Da Saed Ndiangue	33 822 56 19	Dakar	\N	\N	\N	f	\N
934	Pharmacie Mame Ale Sylla	pharmacie-mame-ale-sylla	Vente De Produits Pharmaceutiques Rufisque Ouest, N° 515	\N	2	2026-03-02 23:11:12.525	2026-03-02 23:11:12.525	Vente De Produits Pharmaceutiques Rufisque Ouest, N° 515	Quartier Serigne Koki	33 963 34 34	Rufisque	\N	\N	\N	f	\N
935	Pharmacie Bass Ak Bara (Cheikh Tidiane Gaye)	pharmacie-bass-ak-bara-cheikh-tidiane-gaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.527	2026-03-02 23:11:12.527	Vente De Produits Pharmaceutiques	Avenue Cheikh Amad ou Bamba X Rue Y	77 566 68 86	Dakar	\N	\N	\N	f	\N
936	Pharmacie Naby - Madeleine Diop Baal	pharmacie-naby-madeleine-diop-baal	Vente De Produits Pharmaceutiques Diamaguene -	\N	2	2026-03-02 23:11:12.529	2026-03-02 23:11:12.529	Vente De Produits Pharmaceutiques Diamaguene -	Route De Thiaroye	33 949 17 55	Dakar	\N	\N	\N	f	\N
937	Pharmacie Mame Diarra Bousso (Khadidjatou Diop)	pharmacie-mame-diarra-bousso-khadidjatou-diop	Vente De Produits Pharmaceutiques Passage A Niveau S antiaba Louga 0 Saint-Louis Entreprise "Xelcom Services" Commerce General- Prestation De Services Ave General De Gaulle , Sor 0 Pikine Pharmacie Keur Souleymane (Dr Khardiatou K. Thioye) Vente De Produits Pharmaceutiques Pikine	\N	2	2026-03-02 23:11:12.531	2026-03-02 23:11:12.531	Vente De Produits Pharmaceutiques Passage A Niveau S antiaba Louga 0 Saint-Louis Entreprise "Xelcom Services" Commerce General- Prestation De Services Ave General De Gaulle , Sor 0 Pikine Pharmacie Keur Souleymane (Dr Khardiatou K. Thioye) Vente De Produits Pharmaceutiques Pikine	Rue 10 N° 6 70	33 834 59 22	Louga	\N	\N	\N	f	\N
938	Aliou Ndao	aliou-ndao	Commerce Marche Zinc Pikine Tally Boumack 0 Dakar Lps (Librairie Papeterie Le Senegal) - Ahmed Salif Fall Commerce Librairie Papeterie	\N	2	2026-03-02 23:11:12.533	2026-03-02 23:11:12.533	Commerce Marche Zinc Pikine Tally Boumack 0 Dakar Lps (Librairie Papeterie Le Senegal) - Ahmed Salif Fall Commerce Librairie Papeterie	Avenue Blaise Diagne	33 854 16 28	Pikine	\N	\N	\N	f	\N
939	Ets Baraka (Pathe Ndione)	ets-baraka-pathe-ndione	Commerce General	\N	2	2026-03-02 23:11:12.534	2026-03-02 23:11:12.534	Commerce General	Rue Laprine X Tolbiac	33 952 09 39	Dakar	\N	\N	\N	f	\N
940	Pharmacie Skhna Oumy Diop	pharmacie-skhna-oumy-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.536	2026-03-02 23:11:12.536	Vente De Produits Pharmaceutiques	Quartier Darou Kho udoss Touba	77 637 58 63	Mbacke	\N	\N	\N	f	\N
941	Pharmacie Marietou Seck (Aminata Diop)	pharmacie-marietou-seck-aminata-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.538	2026-03-02 23:11:12.538	Vente De Produits Pharmaceutiques	Quartier Dangou	33 967 28 40	Rufisque	\N	\N	\N	f	\N
942	Sen Marche Suarl (Societe Senegalaise D'Importation Et D'Exportation Marchandises)	sen-marche-suarl-societe-senegalaise-d-importation-et-d-exportation-marchandises	Commerce	\N	2	2026-03-02 23:11:12.54	2026-03-02 23:11:12.54	Commerce	Avenue De Caen En Face De La Poste 0 Dakar Combat Services Sarl Commerce General Cite Bceao N°7/E	33 836 74 70	Thies	\N	\N	\N	f	\N
943	Senkoom Sarl	senkoom-sarl	Commerce	\N	2	2026-03-02 23:11:12.547	2026-03-02 23:11:12.547	Commerce	Route De Rufisque 0 Dakar Rasela Sarl Commerce Rue Victor Hugo	33 835 03 70	Dakar	\N	\N	\N	f	\N
944	Ste De Papeterie La Colombe Sa	ste-de-papeterie-la-colombe-sa	Commerce Papeterie	\N	2	2026-03-02 23:11:12.551	2026-03-02 23:11:12.551	Commerce Papeterie	Rue Mousse Diop X Galandou Diouf	33 867 11 21	Dakar	\N	\N	\N	f	\N
945	Private Label	private-label	Commerce Liberte Vi Extension Nord	\N	2	2026-03-02 23:11:12.553	2026-03-02 23:11:12.553	Commerce Liberte Vi Extension Nord	Rue 50	33 822 35 76	Dakar	\N	\N	\N	f	\N
946	Aye Senebel Sarl	aye-senebel-sarl	Vente Materiels Et Consommables Informatiques P,A Unite 1 N°312 0 Thies Pharmacie Principale - Thies (Cheikh Ahmed Tidiane Gning) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.554	2026-03-02 23:11:12.554	Vente Materiels Et Consommables Informatiques P,A Unite 1 N°312 0 Thies Pharmacie Principale - Thies (Cheikh Ahmed Tidiane Gning) Vente De Produits Pharmaceutiques	Rue De La Gare Escale Nord Pres Cinema Agora 0 Pikine Ets Cheikh Sadibou Traore Et Fils Commerce De Marchandises Diverses Route De Rufisque	33 963 80 16	Guediaw	\N	\N	\N	f	\N
947	Pharmacie Bargny - Mme Gueye Ndiaye	pharmacie-bargny-mme-gueye-ndiaye	Vente De Produits Pharmaceutiques Bargny -	\N	2	2026-03-02 23:11:12.556	2026-03-02 23:11:12.556	Vente De Produits Pharmaceutiques Bargny -	Quartier Darou I	33 834 41 72	Bargny	\N	\N	\N	f	\N
948	Pharmacie Ndiouga Marame	pharmacie-ndiouga-marame	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.558	2026-03-02 23:11:12.558	Vente De Produits Pharmaceutiques	Quartier Thielol K anel	77 634 38 48	Kanel	\N	\N	\N	f	\N
949	Pharmacie Amadou	pharmacie-amadou	Vente De Produits Pharmaceutiques Ngallele Sor	\N	2	2026-03-02 23:11:12.56	2026-03-02 23:11:12.56	Vente De Produits Pharmaceutiques Ngallele Sor	Route De L'Ugb	77 901 17 41	Saint-Louis	\N	\N	\N	f	\N
950	Aye Pharmacie W Akhinane (Dr Oureye Dabo)	aye-pharmacie-w-akhinane-dr-oureye-dabo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.562	2026-03-02 23:11:12.562	Vente De Produits Pharmaceutiques	Quartier W Akhinan e 2 Plle N° 110 0 Dakar Mathoub Nagib Commerce De Meches Et Divers 87 Et 84, Rue Galandou Diouf	77 654 77 13	Guediaw	\N	\N	\N	f	\N
951	Pharmacie Au Lycee (Docteur Alioune Badara Ndiaye)	pharmacie-au-lycee-docteur-alioune-badara-ndiaye	Vente De Produits Pharmaceutiques Av Cheikh Ahmadou Bamba Taba Ngoye	\N	2	2026-03-02 23:11:12.564	2026-03-02 23:11:12.564	Vente De Produits Pharmaceutiques Av Cheikh Ahmadou Bamba Taba Ngoye	Quartier Niary Taly Kaolack	33 820 96 64	Kaolack	\N	\N	\N	f	\N
952	Hussein Basma	hussein-basma	Commerce/ Mercerie	\N	2	2026-03-02 23:11:12.566	2026-03-02 23:11:12.566	Commerce/ Mercerie	Rue Tolbiac X Paul Holle	33 941 94 55	Dakar	\N	\N	\N	f	\N
953	Happy Land Sarl	happy-land-sarl	Commerce	\N	2	2026-03-02 23:11:12.568	2026-03-02 23:11:12.568	Commerce	Avenue Georges Pompidou 33 821 2773 Dakar Pharmacie Borom Daradji Vente De Produits Pharmaceutiques Grand-Dakar N° 143	33 955 36 56	Dakar	\N	\N	\N	f	\N
954	Forum Suarl	forum-suarl	Vente De Materiel Informatique Et Electronique Km 1, Av Cheikh Anta Diop (Ex Sicap Liberte V Dakar ) 0 Dakar Pbs (Papeterie Burotic & Services Sarl) Commerce	\N	2	2026-03-02 23:11:12.57	2026-03-02 23:11:12.57	Vente De Materiel Informatique Et Electronique Km 1, Av Cheikh Anta Diop (Ex Sicap Liberte V Dakar ) 0 Dakar Pbs (Papeterie Burotic & Services Sarl) Commerce	Rue 17 X 18 Medina	33 824 66 33	Dakar	\N	\N	\N	f	\N
955	Pharmacie Ndiene (Dr Abdou Gueye Dieng)	pharmacie-ndiene-dr-abdou-gueye-dieng	Vente De Produits Pharmaceutiques Corniche Mbour Tef ess 33957 25 67 Dakar Tms Suarl (Touba Mondial Scrabe - Suarl) Vente De Pieces Detachees Automobiles	\N	2	2026-03-02 23:11:12.572	2026-03-02 23:11:12.572	Vente De Produits Pharmaceutiques Corniche Mbour Tef ess 33957 25 67 Dakar Tms Suarl (Touba Mondial Scrabe - Suarl) Vente De Pieces Detachees Automobiles	Rue Dial Diop 0 Guediaw Aye Mamadou Sow Commerce Marche Sham - Guediaw Aye 0 Dakar Gie Latif Commerce Sicap Liberte 2 Villa N° 1688 0 Dakar Siyed H.J.C Et Fils Sarl Commerce Rue Abdou Karim Bourgi Dakar	33 837 61 31	Mbour	\N	\N	\N	f	\N
956	Pharmacie De La Petite Cote	pharmacie-de-la-petite-cote	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.573	2026-03-02 23:11:12.573	Vente De Produits Pharmaceutiques	Mbour,Avenue El Hadji Malick Sy Quartier Escale Mbour	33 822 36 33	Mbour	\N	\N	\N	f	\N
957	La Cle Des Sols (Pro'Hygiene	la-cle-des-sols-pro-hygiene	Services - Suarl) Vente De Produits Et Materiels D'Hygiene - Nettoyage	\N	2	2026-03-02 23:11:12.575	2026-03-02 23:11:12.575	Services - Suarl) Vente De Produits Et Materiels D'Hygiene - Nettoyage	Rue Carnot	33 957 11 45	Dakar	\N	\N	\N	f	\N
958	Casa Fluvial Sarl (Ilven Mendes)	casa-fluvial-sarl-ilven-mendes	Commerce	\N	2	2026-03-02 23:11:12.577	2026-03-02 23:11:12.577	Commerce	Route Des Niayes Grand- Yoff 0 Guediaw Aye Pharmacie Mossane Vente De Produits Pharmaceutiques Rue W Akhinane Nim zath	33 842 57 84	Dakar	\N	\N	\N	f	\N
959	Top Technologie - Suarl	top-technologie-suarl	Commerce General	\N	2	2026-03-02 23:11:12.579	2026-03-02 23:11:12.579	Commerce General	Rue 31 X Bld Blaise Diagne	77 632 10 13	Dakar	\N	\N	\N	f	\N
960	Pharmacie Sp (Sante Plus) Mouhamadou Fadilou Mbacke	pharmacie-sp-sante-plus-mouhamadou-fadilou-mbacke	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.58	2026-03-02 23:11:12.58	Vente De Produits Pharmaceutiques	Quartier Darou Rah mane Rufisque	33 961 65 46	Rufisque	\N	\N	\N	f	\N
961	Pharmacie Thierno Amadou Barro (Dr Abdoulaye Thiaw )	pharmacie-thierno-amadou-barro-dr-abdoulaye-thiaw	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.582	2026-03-02 23:11:12.582	Vente De Produits Pharmaceutiques	Bccd	77 781 05 47	Dakar	\N	\N	\N	f	\N
962	Colis Malick Sy Trans'Actions Sarl Transport Transit	colis-malick-sy-trans-actions-sarl-transport-transit	Commerce	\N	2	2026-03-02 23:11:12.584	2026-03-02 23:11:12.584	Commerce	Rue Marchand X Autoroute Prolongee	33 823 32 19	Dakar	\N	\N	\N	f	\N
963	Cheikh Ball	cheikh-ball	Commerce General Escale - Thies 0 Thies Pharmacie Focus Sante(Dr Auguste Thiam) Vente De Produits Pharmaceutiques Pout 776498599 Dakar	\N	2	2026-03-02 23:11:12.586	2026-03-02 23:11:12.586	Commerce General Escale - Thies 0 Thies Pharmacie Focus Sante(Dr Auguste Thiam) Vente De Produits Pharmaceutiques Pout 776498599 Dakar	Abdourahmane Diaw Ara Commerce General Gibraltar1	33 823 60 34	Thies	\N	\N	\N	f	\N
964	Pharmacie Omar Abdourahmane (Aminata Diouf)	pharmacie-omar-abdourahmane-aminata-diouf	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.588	2026-03-02 23:11:12.588	Vente De Produits Pharmaceutiques	Quartier Ndaldaly - Bargny 0 Dakar Pharmacie Residence Ii (Arame Fall) Vente De Produits Pharmaceutiques Parcelles Assainie s Unite 12 N° 123	33 836 57 88	Rufisque	\N	\N	\N	f	\N
965	Pharmacie Moussante (Pape Alioune Mbaye)	pharmacie-moussante-pape-alioune-mbaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.59	2026-03-02 23:11:12.59	Vente De Produits Pharmaceutiques	Route De Khombole - Thies	33 835 46 46	Thies	\N	\N	\N	f	\N
966	Bara Ndiaye	bara-ndiaye	Commerce General	\N	2	2026-03-02 23:11:12.591	2026-03-02 23:11:12.591	Commerce General	Avenue Lamine Gueye X Autoroute En Face Total N°146	33 951 85 92	Dakar	\N	\N	\N	f	\N
967	Lifsa - Diedhiou Salif / Lifsa	lifsa-diedhiou-salif-lifsa	Commerce Et Prestation De Services	\N	2	2026-03-02 23:11:12.593	2026-03-02 23:11:12.593	Commerce Et Prestation De Services	Rue 08 X 03 Medin a	77 644 41 79	Dakar	\N	\N	\N	f	\N
968	Pharmacie Cheikh Ahmadou Bamba	pharmacie-cheikh-ahmadou-bamba-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.596	2026-03-02 23:11:12.596	Vente De Produits Pharmaceutiques	Avenue Blaise Diag ne	33 823 29 23	Dakar	\N	\N	\N	f	\N
969	Pharmacie Residence (Ndeye Fatoumata Mbaye)	pharmacie-residence-ndeye-fatoumata-mbaye	Vente De Produits Pharmaceutiques Place Caen Carrier e	\N	2	2026-03-02 23:11:12.597	2026-03-02 23:11:12.597	Vente De Produits Pharmaceutiques Place Caen Carrier e	Route De Dakar	33 823 57 65	Thies	\N	\N	\N	f	\N
970	Pharmacie Des Mamelles	pharmacie-des-mamelles	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.599	2026-03-02 23:11:12.599	Vente De Produits Pharmaceutiques	Route De Ngor,Mame lles	33 951 11 70	Dakar	\N	\N	\N	f	\N
971	Mbaye Ndiaye	mbaye-ndiaye	Vente Aliments Volaille Bambylor W Ayembam 0 Dakar Marw Ane Chan Dakar Electricite Commerce	\N	1	2026-03-02 23:11:12.601	2026-03-02 23:11:12.601	Vente Aliments Volaille Bambylor W Ayembam 0 Dakar Marw Ane Chan Dakar Electricite Commerce	Rue Fleurus 0 Dakar Pharmacie Fann Hock (Dr Cathy Ndiaye Gaye) Vente De Produits Pharmaceutiques Rue 55 X 70 Immeub le Mbaye Top Diop	33 820 56 65	Rufisque	\N	\N	\N	f	\N
972	Pharmacie Ama Ndiaye (Dr Fatoumata Ndiaye)	pharmacie-ama-ndiaye-dr-fatoumata-ndiaye	Vente De Produits Pharmaceutiques Ouest Foire Lot N° 21	\N	2	2026-03-02 23:11:12.603	2026-03-02 23:11:12.603	Vente De Produits Pharmaceutiques Ouest Foire Lot N° 21	Immeuble Mor T. Ndiaye	33 822 07 89	Dakar	\N	\N	\N	f	\N
973	Bethio Station Petrodis Oil (Idrissa Badji)	bethio-station-petrodis-oil-idrissa-badji	Commerce De Produits Petroliers	\N	1	2026-03-02 23:11:12.605	2026-03-02 23:11:12.605	Commerce De Produits Petroliers	Route Nationale, Ros s Bethio	77 639 63 17	Ross	\N	\N	\N	f	\N
974	Floridia Afrique	floridia-afrique	Commerce Yoff Virage	\N	2	2026-03-02 23:11:12.607	2026-03-02 23:11:12.607	Commerce Yoff Virage	Route Aeroport	33 867 21 30	Dakar	\N	\N	\N	f	\N
975	Entreprise Activité Adresse Téléphone Dakar Touba Bijouterie (Mamadou Niang)	entreprise-activite-adresse-telephone-dakar-touba-bijouterie-mamadou-niang	Commerce	\N	2	2026-03-02 23:11:12.609	2026-03-02 23:11:12.609	Commerce	Rue 19 X Blaise	33 865 28 33	Ville	\N	\N	\N	f	\N
976	Color Plus Sarl	color-plus-sarl	Commerce De Peinture Auto	\N	2	2026-03-02 23:11:12.61	2026-03-02 23:11:12.61	Commerce De Peinture Auto	Rue Marchand X Lamine Guey e	33 832 20 77	Dakar	\N	\N	\N	f	\N
977	Pharmacie Emmaus (Dr Colette Seck Ndiaye)	pharmacie-emmaus-dr-colette-seck-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.612	2026-03-02 23:11:12.612	Vente De Produits Pharmaceutiques	Bd Du General De G aulle	33 860 07 00	Dakar	\N	\N	\N	f	\N
978	Pharmacie Yoffoise (Babacar Thiam)	pharmacie-yoffoise-babacar-thiam	Vente De Produits Pharmaceutiques Yoff Layenne	\N	2	2026-03-02 23:11:12.614	2026-03-02 23:11:12.614	Vente De Produits Pharmaceutiques Yoff Layenne	Route Du Cimetiere	77 698 42 96	Dakar	\N	\N	\N	f	\N
979	Pharmacie La Pikinoise(Ibrahima Thiam)	pharmacie-la-pikinoise-ibrahima-thiam	Vente De Produits Pharmaceutiques Pikine St Louis Ro ute De Dakar 0 Dakar Pharmacie Nefertiti Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.615	2026-03-02 23:11:12.615	Vente De Produits Pharmaceutiques Pikine St Louis Ro ute De Dakar 0 Dakar Pharmacie Nefertiti Vente De Produits Pharmaceutiques	Bd Dalifort Cite B elvedere	33 957 44 66	Saint-Louis	\N	\N	\N	f	\N
980	G.Sen	g-sen	Distribution Commerce General	\N	2	2026-03-02 23:11:12.617	2026-03-02 23:11:12.617	Distribution Commerce General	Route De Rufisque 0 Dakar Gie Keur Cheikh Ibra Commerce Divers Sicap Sacre Coeur 3	33 820 92 22	Dakar	\N	\N	\N	f	\N
981	Amelle Com - Sarl	amelle-com-sarl	Commerce Produit De Communication Publicite	\N	2	2026-03-02 23:11:12.619	2026-03-02 23:11:12.619	Commerce Produit De Communication Publicite	Rue Amad ou Assane Ndoye	33 827 51 91	Dakar	\N	\N	\N	f	\N
982	Pharmacie Papa Atoumane Ba (Dr Rokhaya Ba)	pharmacie-papa-atoumane-ba-dr-rokhaya-ba	Vente De Produits Pharmaceutiques Mermoz,	\N	2	2026-03-02 23:11:12.621	2026-03-02 23:11:12.621	Vente De Produits Pharmaceutiques Mermoz,	Rue Pyrotechnie X Vdn Villa 23 Cite Comico 2	33 871 34 34	Dakar	\N	\N	\N	f	\N
983	Focus Audit Et Expertise	focus-audit-et-expertise	Vente De Materiel Et Consommables Informatiques	\N	2	2026-03-02 23:11:12.622	2026-03-02 23:11:12.622	Vente De Materiel Et Consommables Informatiques	Rue 2 X Piscine Olympique,Imm. Bour Mahe Point E	33 860 07 49	Dakar	\N	\N	\N	f	\N
984	Paramesw Aran Premanand (Ets Avid Elect)	paramesw-aran-premanand-ets-avid-elect	Commerce (Activites Annexes Aux Btp)	\N	2	2026-03-02 23:11:12.624	2026-03-02 23:11:12.624	Commerce (Activites Annexes Aux Btp)	Rue Ramez Bourg i X Pierre Mill	77 656 29 10	Dakar	\N	\N	\N	f	\N
985	Pharmacie Papa Cheikh Diagne (Dr Yacine Diagne)	pharmacie-papa-cheikh-diagne-dr-yacine-diagne	Vente De Produits Pharmaceutiques Mbour Carrefour Du Relai	\N	2	2026-03-02 23:11:12.626	2026-03-02 23:11:12.626	Vente De Produits Pharmaceutiques Mbour Carrefour Du Relai	Quartier Diamaguene	33 822 23 87	Mbour	\N	\N	\N	f	\N
986	Pharmacie "Abdoul Karim Daff"	pharmacie-abdoul-karim-daff	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.628	2026-03-02 23:11:12.628	Vente De Produits Pharmaceutiques	Quartier Singue Vi llage De Sedo Sebe	33 957 12 12	Matam	\N	\N	\N	f	\N
987	Sides Sarl	sides-sarl	Commerce Hann Maristes 1 Scat Urbam D 14 0 Thiaroye Yakaar - Sarl Commerce	\N	2	2026-03-02 23:11:12.629	2026-03-02 23:11:12.629	Commerce Hann Maristes 1 Scat Urbam D 14 0 Thiaroye Yakaar - Sarl Commerce	Route De Rufisque	77 639 62 73	Dakar	\N	\N	\N	f	\N
988	E.T.I (Equipement Travaux Informatiques	e-t-i-equipement-travaux-informatiques	Commerce De Materiels Informatiques	\N	2	2026-03-02 23:11:12.631	2026-03-02 23:11:12.631	Commerce De Materiels Informatiques	Quartier Darou S alam - Pikine 0 Mbour Pharmacie Maurice Fall (Mouhamed El Bachir Fall) Vente De Produits Pharmaceutiques Quartier Liberte M bour 33957 53 55 Dakar Futurestore Commerce Rue Malenfant	77 360 05 59	Pikine	\N	\N	\N	f	\N
989	Ets Falilou (Etablissements Falilou - Serigne Modou Ndiaye) Travaux D'Installation Et De Finition	ets-falilou-etablissements-falilou-serigne-modou-ndiaye-travaux-d-installation-et-de-finition	Commerces	\N	2	2026-03-02 23:11:12.633	2026-03-02 23:11:12.633	Commerces	Rue Escarfait	33 867 40 95	Dakar	\N	\N	\N	f	\N
990	Pharmacie Serigne Modou Fallilou Fall - Aïssatou Mbene Lô	pharmacie-serigne-modou-fallilou-fall-aissatou-mbene-lo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.635	2026-03-02 23:11:12.635	Vente De Produits Pharmaceutiques	Bd Dial Diop - Fas s Casier	33 822 55 76	Dakar	\N	\N	\N	f	\N
991	Pharmacie Aw A Barry	pharmacie-aw-a-barry	Vente De Produits Pharmaceutiques Kanel Matam 0 Mbour Pharmacie Karim (Dr Aldiouma Sidibe) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.637	2026-03-02 23:11:12.637	Vente De Produits Pharmaceutiques Kanel Matam 0 Mbour Pharmacie Karim (Dr Aldiouma Sidibe) Vente De Produits Pharmaceutiques	Route De Kaolack M bour 33957 26 22 Guediaw Aye Pharmacie Hlm Las Palmas (Dr Codou Sow Lou Ndour Ndiaye) Vente De Produits Pharmaceutiques Hlm Las Palmas - G uediaw Aye	33 822 44 80	Kanel	\N	\N	\N	f	\N
992	Alain Chignara (Ex Ets Sami Chignara	alain-chignara-ex-ets-sami-chignara	Commerce General	\N	2	2026-03-02 23:11:12.639	2026-03-02 23:11:12.639	Commerce General	Rue Robert Brun	33 836 45 14	Dakar	\N	\N	\N	f	\N
993	Pharmacie Adja Rokhaya Seck	pharmacie-adja-rokhaya-seck	Vente De Produits Pharmaceutiques Pikine Guinaw Rai l Sud	\N	2	2026-03-02 23:11:12.64	2026-03-02 23:11:12.64	Vente De Produits Pharmaceutiques Pikine Guinaw Rai l Sud	Quartier Cire Ly	33 827 62 63	Pikine	\N	\N	\N	f	\N
994	Pharmacie Krang (Ousmane Diallo)	pharmacie-krang-ousmane-diallo	Vente De Produits Pharmaceutiques Karang 0 Thies Pharmacie Bount Depot (Michel Daou) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.642	2026-03-02 23:11:12.642	Vente De Produits Pharmaceutiques Karang 0 Thies Pharmacie Bount Depot (Michel Daou) Vente De Produits Pharmaceutiques	Quartier Aiglon Dv f	33 834 34 70	Foundiougne	\N	\N	\N	f	\N
995	Pharmacie Adji Amy Senghor (Samba Sarr Senghor)	pharmacie-adji-amy-senghor-samba-sarr-senghor	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.644	2026-03-02 23:11:12.644	Vente De Produits Pharmaceutiques	Quartier Mbelgor - Foundiougne	33 955 78 51	Foundiougne	\N	\N	\N	f	\N
996	Daouda Gueye	daouda-gueye	Commerce General	\N	2	2026-03-02 23:11:12.646	2026-03-02 23:11:12.646	Commerce General	Quartier Touba Yeumbeul 0 Dakar Scania Senegal Commerce Et Entretien De Vehicules Lourds Blcd Djily Mbaye 0 Dakar Burocom Services - Sarl Commerce Rue Kleber	33 877 95 95	Pikine	\N	\N	\N	f	\N
997	Pharmacie Amina (Dr Gnima Goudiaby Dieme)	pharmacie-amina-dr-gnima-goudiaby-dieme	Vente De Produits Pharmaceutiques Thiaroye Gare	\N	2	2026-03-02 23:11:12.648	2026-03-02 23:11:12.648	Vente De Produits Pharmaceutiques Thiaroye Gare	Route De Sam-Sam Quartier Ainoumany	33 823 47 51	Dakar	\N	\N	\N	f	\N
998	Sayonara (Saleh Zahira)	sayonara-saleh-zahira	Commerce General 106,	\N	2	2026-03-02 23:11:12.65	2026-03-02 23:11:12.65	Commerce General 106,	Avenue P. L. Gueye	77 871 33 75	Dakar	\N	\N	\N	f	\N
999	Pharmacie Victoire (Dr Edw Ige Gomis)	pharmacie-victoire-dr-edw-ige-gomis	Vente De Produits Pharmaceutiques Ouest Foire	\N	2	2026-03-02 23:11:12.651	2026-03-02 23:11:12.651	Vente De Produits Pharmaceutiques Ouest Foire	Rue Yf 563 Villa N° 8	33 821 75 22	Dakar	\N	\N	\N	f	\N
1000	Grande Pharmacie De Tivaouane (Abdoulaye Sow )	grande-pharmacie-de-tivaouane-abdoulaye-sow	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.653	2026-03-02 23:11:12.653	Vente De Produits Pharmaceutiques	Quartier Darou Sal am - Tivaouane 0 Dakar Mobil'Arte Sarl Commerce General Rue Saint Michel X 11 Rue Abdou Kar im Bourgi	33 820 55 44	Tivaouane	\N	\N	\N	f	\N
1001	Albina Senegal	albina-senegal	Commerce General	\N	2	2026-03-02 23:11:12.655	2026-03-02 23:11:12.655	Commerce General	Route Nord Foire Mbal 0 Dakar Pharmacie Nguyen (Salimata Sarr) Vente De Produits Pharmaceutiques Fith Mith	33 832 83 65	Dakar	\N	\N	\N	f	\N
1002	Pharmacie Macha Allah (Hady Dia)	pharmacie-macha-allah-hady-dia	Vente De Produits Pharmaceutiques Bopp	\N	2	2026-03-02 23:11:12.657	2026-03-02 23:11:12.657	Vente De Produits Pharmaceutiques Bopp	Rue 9 X 12 N° 279 Bis	77 637 07 57	Dakar	\N	\N	\N	f	\N
1003	Limpe Sarl (Limpe Equipage Automobile Sarl)	limpe-sarl-limpe-equipage-automobile-sarl	Commerce General	\N	2	2026-03-02 23:11:12.658	2026-03-02 23:11:12.658	Commerce General	Avenue Malick Sy	33 864 36 81	Dakar	\N	\N	\N	f	\N
1004	Pharmacie Mame Diarra Bousso (Niaye Ndiaye)	pharmacie-mame-diarra-bousso-niaye-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.66	2026-03-02 23:11:12.66	Vente De Produits Pharmaceutiques	Quartier Mbour 1 - Rocade Sud X Route De Mbour - Thies	77 639 11 15	Thies	\N	\N	\N	f	\N
1005	Hoballah Sami -Bodego	hoballah-sami-bodego	Commerce	\N	2	2026-03-02 23:11:12.662	2026-03-02 23:11:12.662	Commerce	Route Principale De Saly	33 951 11 65	Dakar	\N	\N	\N	f	\N
1006	Pharmacie Chifaoun (Dr Aissatou Fall Moreau)	pharmacie-chifaoun-dr-aissatou-fall-moreau	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.663	2026-03-02 23:11:12.663	Vente De Produits Pharmaceutiques	Route De Rufisque	33 957 55 72	Dakar	\N	\N	\N	f	\N
1007	Etablissement Goor Yalla	etablissement-goor-yalla	Commerce Km 11	\N	2	2026-03-02 23:11:12.665	2026-03-02 23:11:12.665	Commerce Km 11	Route De Rufisque	33 834 20 24	Pikine	\N	\N	\N	f	\N
1008	Metro - Sarl	metro-sarl	Distribution - Commerce Alimentaire	\N	2	2026-03-02 23:11:12.667	2026-03-02 23:11:12.667	Distribution - Commerce Alimentaire	Avenue Lamine Gu eye	33 855 19 66	Dakar	\N	\N	\N	f	\N
1009	Thalia Afrique Sarl	thalia-afrique-sarl	Vente Promotion, Distribution Logiciel 63,	\N	2	2026-03-02 23:11:12.669	2026-03-02 23:11:12.669	Vente Promotion, Distribution Logiciel 63,	Rue Victo r Hugo	33 967 08 00	Dakar	\N	\N	\N	f	\N
1010	Tony Gabaien	tony-gabaien	Vente De Pieces Detachees	\N	2	2026-03-02 23:11:12.67	2026-03-02 23:11:12.67	Vente De Pieces Detachees	Rue Ousmane Soce Diop X Rue Derbezy Marche De Rufis que 0 Dagana Pharmacie Darou Salam (Docteur Moctar Gueye) Vente De Produits Pharmaceutiques Diamaguene Dagana	33 821 87 49	Rufisque	\N	\N	\N	f	\N
1011	Mgi Sarl (Marbres Granites Italia) Commercce	mgi-sarl-marbres-granites-italia-commercce	Vente De Marbres Et Granites	\N	2	2026-03-02 23:11:12.672	2026-03-02 23:11:12.672	Vente De Marbres Et Granites	Route De L'Ae roport Yoff 0 Dakar M.Thierno Diouf Commerce General Rue Grasland 0 Mbour African Trade And Investment Company Production Et Vente De Glace Carrefour Diamnadio 0 Pikine Pharmacie Baye Issa (Moussa Ndiaye) Vente De Produits Pharmaceutiques Tivaoune Peulh - K eur Massar	33 953 41 66	Dakar	\N	\N	\N	f	\N
1012	Asp (Abdalah	asp-abdalah	Services Prestations -	\N	3	2026-03-02 23:11:12.674	2026-03-02 23:11:12.674	Services Prestations -	Abdallah Fall) Commerce Route De Rufisque 0 Dakar Sono Senegal Commerce General Ave Pasteur	33 820 68 79	Thiaroye	\N	\N	\N	f	\N
1013	Pharmacie Sainte Anne	pharmacie-sainte-anne	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.676	2026-03-02 23:11:12.676	Vente De Produits Pharmaceutiques	Rue Ambroise Mendy X Selle Diop	33 889 72 72	Dakar	\N	\N	\N	f	\N
1014	Pharmacie Thierno Hamet Baba Talla (Abacar Diouf)	pharmacie-thierno-hamet-baba-talla-abacar-diouf	Vente De Produits Pharmaceutiques Dangou Minam Rufis que 0 Dakar Siipa (Ste Industrielle Imprimerie Papeterie) Commerce Papeterie	\N	2	2026-03-02 23:11:12.678	2026-03-02 23:11:12.678	Vente De Produits Pharmaceutiques Dangou Minam Rufis que 0 Dakar Siipa (Ste Industrielle Imprimerie Papeterie) Commerce Papeterie	Rue Felix Eboue	33 867 24 79	Matam	\N	\N	\N	f	\N
1015	Aye Pharmacie Canada (Dr Pinado Ly Sarr)	aye-pharmacie-canada-dr-pinado-ly-sarr	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.679	2026-03-02 23:11:12.679	Vente De Produits Pharmaceutiques	Route Des Niayes Quartier Canada - Guediaw Aye 0 Guediaw Aye Pharmacie Salamareme (Diarietou Sarr) Vente De Produits Pharmaceutiques Cite Fadia N° 110- E Golf Sud	33 877 37 33	Guediaw	\N	\N	\N	f	\N
1016	Pharmacie Al Hamdoulilahi (Dr Singane Ba)	pharmacie-al-hamdoulilahi-dr-singane-ba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.681	2026-03-02 23:11:12.681	Vente De Produits Pharmaceutiques	Route De Rufisque 0 Rufisque Pharmacie El Hadji Amadou Marie Ndiaye (Assyatou Ndiaye) Vente De Produits Pharmaceutiques Diokoul W Ague - F ace Canal Rufisque	33 836 09 33	Dakar	\N	\N	\N	f	\N
1017	Ets Cheikh Cisse	ets-cheikh-cisse	Commerce General	\N	2	2026-03-02 23:11:12.683	2026-03-02 23:11:12.683	Commerce General	Quartier Mboul Ouakam	33 971 21 85	Dakar	\N	\N	\N	f	\N
1018	Pharmacie Oasis - Docteur Abdoulaye Ndiaye	pharmacie-oasis-docteur-abdoulaye-ndiaye	Vente De Produits Pharmaceutiques Koussanar - Tambac ounda 0 Rufisque Pharmacie Satou (Mouhamadou Ndiaye) Vente De Produits Pharmaceutiques Rufisque	\N	2	2026-03-02 23:11:12.685	2026-03-02 23:11:12.685	Vente De Produits Pharmaceutiques Koussanar - Tambac ounda 0 Rufisque Pharmacie Satou (Mouhamadou Ndiaye) Vente De Produits Pharmaceutiques Rufisque	Quartier Ngessou Pont Abdoulaye Nar	77 639 94 86	Tambacounda	\N	\N	\N	f	\N
1019	Pharmacie Les Dunes	pharmacie-les-dunes	Vente De Produits Pharmaceutiques Espace Residence Hann Mariste	\N	2	2026-03-02 23:11:12.686	2026-03-02 23:11:12.686	Vente De Produits Pharmaceutiques Espace Residence Hann Mariste	Immeuble Orange	33 967 88 44	Dakar	\N	\N	\N	f	\N
1020	Pharmacie Mame Mbor (Dr Aw A Gueye Thiamane)	pharmacie-mame-mbor-dr-aw-a-gueye-thiamane	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.689	2026-03-02 23:11:12.689	Vente De Produits Pharmaceutiques	Avenue El Hadji Ma lick Sy Cite Icotaf Villa 3211	33 835 30 91	Pikine	\N	\N	\N	f	\N
1021	Aye Pharmacie Notaire (Tacko W Ague)	aye-pharmacie-notaire-tacko-w-ague	Vente De Produits Pharmaceutiques Guediaw Aye Quarti er Notaire 33 8372200 Dakar Sicor Suarl (Societe Internationale De Coutage Et De Representation Suarl) Commerce Import-Export	\N	2	2026-03-02 23:11:12.691	2026-03-02 23:11:12.691	Vente De Produits Pharmaceutiques Guediaw Aye Quarti er Notaire 33 8372200 Dakar Sicor Suarl (Societe Internationale De Coutage Et De Representation Suarl) Commerce Import-Export	Rue Robert Brun	33 822 24 78	Guediaw	\N	\N	\N	f	\N
1022	Pharmacie Sacre Cœur - Oumou Khaïry Samb Ndiaye	pharmacie-sacre-c-ur-oumou-khairy-samb-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.693	2026-03-02 23:11:12.693	Vente De Produits Pharmaceutiques	Rue P X 8 Sicap Di euppeul Iii	77 638 50 79	Dakar	\N	\N	\N	f	\N
1023	Parcours Bureautique	parcours-bureautique	Commerce	\N	2	2026-03-02 23:11:12.695	2026-03-02 23:11:12.695	Commerce	Rue 17 X Avenue Blaise Diagne 0 Pikine Pharmacie Mame Lena (Dr Khady Lena Sy) Vente De Produits Pharmaceutiques Thiaroye	33 836 19 27	Dakar	\N	\N	\N	f	\N
1024	Ibrahima Abdallah Mohsen	ibrahima-abdallah-mohsen	Vente De Bois Ave Dembe Diop Mbour 0 Mbacke Pharmacie Du Magal (Est Répertoriée Sous Le Cuci N° 029610I) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.696	2026-03-02 23:11:12.696	Vente De Bois Ave Dembe Diop Mbour 0 Mbacke Pharmacie Du Magal (Est Répertoriée Sous Le Cuci N° 029610I) Vente De Produits Pharmaceutiques	Quartier Escale - Mbacke	33 961 61 51	Mbour	\N	\N	\N	f	\N
1025	Pharmacie Boubacar Sy	pharmacie-boubacar-sy	Vente De Produits Pahrmaceutiques Marche Ourossogui 0 Dakar Pharmacie Magatte	\N	2	2026-03-02 23:11:12.698	2026-03-02 23:11:12.698	Vente De Produits Pahrmaceutiques Marche Ourossogui 0 Dakar Pharmacie Magatte	Abdou Dior (Docteur Moussa Dieng) Vente De Produits Pharmaceutiques Quartier Park 0 Dakar Pharmacie Du Theatre Sorano - Suarl Vente De Produits Pharmaceutiques Bd De La Republiqu e	33 975 10 66	Ourossogui	\N	\N	\N	f	\N
1026	Pharmacie Mame Birama Mbaye (Mor Mbaye)	pharmacie-mame-birama-mbaye-mor-mbaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.7	2026-03-02 23:11:12.7	Vente De Produits Pharmaceutiques	Route De La Base A erienne Pepiniere Diakhao	33 836 83 84	Thies	\N	\N	\N	f	\N
1027	Sfd (Senegal Fruitiere De Developpement	sfd-senegal-fruitiere-de-developpement	Production Et Distribution De Produits Agricoles	\N	2	2026-03-02 23:11:12.702	2026-03-02 23:11:12.702	Production Et Distribution De Produits Agricoles	Rue Saint Michel	33 952 33 96	Dakar	\N	\N	\N	f	\N
1028	Ets Li Ning (Etablissement Li Ning)	ets-li-ning-etablissement-li-ning	Commerce De Bibelot Et Divers	\N	2	2026-03-02 23:11:12.703	2026-03-02 23:11:12.703	Commerce De Bibelot Et Divers	Bd General Degaulle	33 822 51 51	Dakar	\N	\N	\N	f	\N
1029	Ets Saidou & Freres (Saidou Dia)	ets-saidou-freres-saidou-dia	Vente Accessoires Vehicules Mbour	\N	2	2026-03-02 23:11:12.705	2026-03-02 23:11:12.705	Vente Accessoires Vehicules Mbour	Route De Joal Face Cbao 33957 23 23 Dakar Societe Lafdar Sarl Commerce General Thiaroye Gare Route Des Niayes	77 644 76 58	Mbour	\N	\N	\N	f	\N
1030	Lcs Technodidac (Les Classiques Du Senegal Technodidac)	lcs-technodidac-les-classiques-du-senegal-technodidac	Commerce General	\N	2	2026-03-02 23:11:12.707	2026-03-02 23:11:12.707	Commerce General	Rue 59 X Medina	33 957 35 49	Dakar	\N	\N	\N	f	\N
1031	Coudou Sarl Recouvrement Et	coudou-sarl-recouvrement-et	Distribution	\N	2	2026-03-02 23:11:12.708	2026-03-02 23:11:12.708	Distribution	Rue Amadou Assane Ndoye	33 823 95 15	Dakar	\N	\N	\N	f	\N
1032	Pharmacie Sidy Bouya (Docteur Maimouna Diouf Fall)	pharmacie-sidy-bouya-docteur-maimouna-diouf-fall	Vente De Produits Pharmaceutiques Ouest Foire 0 Mbour Pharmacie Mohamed (Dr Djibril Ndiaye) Vente De Produits Pharmaceutiques Grand Mbour 0 Thiaroye Pharmacie Bagdad Khar Yalla (Ex Pharmacie Medina 5 Vente De Produits Pharmaceutiques Thiaroye Tally Dia llo	\N	2	2026-03-02 23:11:12.71	2026-03-02 23:11:12.71	Vente De Produits Pharmaceutiques Ouest Foire 0 Mbour Pharmacie Mohamed (Dr Djibril Ndiaye) Vente De Produits Pharmaceutiques Grand Mbour 0 Thiaroye Pharmacie Bagdad Khar Yalla (Ex Pharmacie Medina 5 Vente De Produits Pharmaceutiques Thiaroye Tally Dia llo	Quartier Medina V	33 842 42 06	Dakar	\N	\N	\N	f	\N
1033	Mohamed Ali Zerkot Autres	mohamed-ali-zerkot-autres	Commerces - Textile	\N	2	2026-03-02 23:11:12.712	2026-03-02 23:11:12.712	Commerces - Textile	Rue Galandou Diouf	33 877 73 29	Dakar	\N	\N	\N	f	\N
1034	Mamadou Cire Diall0	mamadou-cire-diall0	Commerce Marche Bignona 0 Dakar Moustapha El Majzoub Commerce	\N	2	2026-03-02 23:11:12.713	2026-03-02 23:11:12.713	Commerce Marche Bignona 0 Dakar Moustapha El Majzoub Commerce	Rue Parc A Mazou 0 Dakar Afriw Att Commerce - Electromecanique & Solaire Bccd	33 821 57 56	Ziguinchor	\N	\N	\N	f	\N
1035	Electroplus (Aya Chaito)	electroplus-aya-chaito	Commerce De Gros De Biens De Consommation Non Alimentaires	\N	2	2026-03-02 23:11:12.715	2026-03-02 23:11:12.715	Commerce De Gros De Biens De Consommation Non Alimentaires	Rue Mousse Diop	33 822 70 90	Dakar	\N	\N	\N	f	\N
1036	El Hadj Magueye W Ade	el-hadj-magueye-w-ade	Revente De Vehicules D'Occasion	\N	2	2026-03-02 23:11:12.717	2026-03-02 23:11:12.717	Revente De Vehicules D'Occasion	Rue 19 X Blaise Diag ne	33 842 24 02	Dakar	\N	\N	\N	f	\N
1037	Gie Le Saloum Diba & Famille	gie-le-saloum-diba-famille	Vente De Marchandises Diverses	\N	2	2026-03-02 23:11:12.719	2026-03-02 23:11:12.719	Vente De Marchandises Diverses	Rue 22 X 29 Dakar	33 825 07 12	Dakar	\N	\N	\N	f	\N
1038	Pharmacie Sophie S.C.F. Diop	pharmacie-sophie-s-c-f-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.721	2026-03-02 23:11:12.721	Vente De Produits Pharmaceutiques	Route De Boune - Y eumbeul	77 633 90 21	Dakar	\N	\N	\N	f	\N
1039	Mbathie Import Sarl	mbathie-import-sarl	Commerce General Km 22	\N	2	2026-03-02 23:11:12.723	2026-03-02 23:11:12.723	Commerce General Km 22	Route De Rufisque	33 837 75 45	Rufisque	\N	\N	\N	f	\N
1040	Aic Sarl Africaine D'Industrie Et De	aic-sarl-africaine-d-industrie-et-de	Commerce Commerce	\N	2	2026-03-02 23:11:12.725	2026-03-02 23:11:12.725	Commerce Commerce	Avenue Lamine Gueye 707009828 Pikine Pharmacie Gouye Salane (Matou Niang Sock) Vente De Produits Pharmaceutiques Quartier Touba Gou ye Salane	33 892 45 03	Dakar	\N	\N	\N	f	\N
1041	Pharmacie Ocean (Khady Cisse)	pharmacie-ocean-khady-cisse	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.727	2026-03-02 23:11:12.727	Vente De Produits Pharmaceutiques	Avenue Cheikh Anta Diop	33 855 55 96	Dakar	\N	\N	\N	f	\N
1042	Its (International Trading Senegal)	its-international-trading-senegal	Commerce De Textiles En Gros Cite Cse Sud Foire 0 Mbour Pharmacie Diass Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.73	2026-03-02 23:11:12.73	Commerce De Textiles En Gros Cite Cse Sud Foire 0 Mbour Pharmacie Diass Vente De Produits Pharmaceutiques	Quartier Escale Di ass	77 649 05 67	Dakar	\N	\N	\N	f	\N
1043	Senso Sarl (Senegal	senso-sarl-senegal	Services Oilfield - Sarl) Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:12.731	2026-03-02 23:11:12.731	Services Oilfield - Sarl) Vente De Produits Petroliers (Station D'Essence)	Avenue Faidherbe	30 101 79 72	Dakar	\N	\N	\N	f	\N
1044	Sodimat Sarl	sodimat-sarl	Commerce Materiels Liberte 5 Villa N° 5682-L 0 Dakar Pharmacie Salomon (Dr Helene Melanie Diouf) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.733	2026-03-02 23:11:12.733	Commerce Materiels Liberte 5 Villa N° 5682-L 0 Dakar Pharmacie Salomon (Dr Helene Melanie Diouf) Vente De Produits Pharmaceutiques	Rue 22 Prolongee F ass Delorme N° 11645	33 855 01 00	Dakar	\N	\N	\N	f	\N
1045	Boubacar Ba	boubacar-ba	Commerce	\N	2	2026-03-02 23:11:12.735	2026-03-02 23:11:12.735	Commerce	Rue 37 X 30 Medina 0 Richard-Toll Pharmacie Harouna (Dr Aisse Kane) Vente De Produits Pharmaceutiques Richard-Toll Gae I i	77 637 75 60	Dakar	\N	\N	\N	f	\N
1046	Les Poulets De Cheikh	les-poulets-de-cheikh	Vente De Poulet Sicap Fann Hock Villa N° 16	\N	2	2026-03-02 23:11:12.738	2026-03-02 23:11:12.738	Vente De Poulet Sicap Fann Hock Villa N° 16	Rue W Or o	33 963 33 22	Dakar	\N	\N	\N	f	\N
1047	Safiex - Ets Sami Faw Az	safiex-ets-sami-faw-az	Commerce Sel Marin Traite	\N	2	2026-03-02 23:11:12.742	2026-03-02 23:11:12.742	Commerce Sel Marin Traite	Rue Raffenel	77 636 78 29	Dakar	\N	\N	\N	f	\N
1048	Fouta Bureautique Informatique (Abdoulaye Ly)	fouta-bureautique-informatique-abdoulaye-ly	Commerce Diamaguene I,	\N	2	2026-03-02 23:11:12.745	2026-03-02 23:11:12.745	Commerce Diamaguene I,	Route Nationale Pres Rond Point Relai s 82 0 Linguere Pharmacie Taw Fekh (Mathiare Fall) Vente De Produits Pharmaceutiques Quartier Ndiayenne Rte De Mbeuleukhe Dahra	33 877 38 62	Mbour	\N	\N	\N	f	\N
1049	Pharmacie Le Coin Sante (Daniel Gabriel Gayky Sarr)	pharmacie-le-coin-sante-daniel-gabriel-gayky-sarr	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.747	2026-03-02 23:11:12.747	Vente De Produits Pharmaceutiques	Quartier Leona Gra nd Yoff	30 119 13 29	Dakar	\N	\N	\N	f	\N
1050	Bonergie Senegal Sarl	bonergie-senegal-sarl	Commerce	\N	2	2026-03-02 23:11:12.749	2026-03-02 23:11:12.749	Commerce	Avenue Cheikh Anta Diop - Media Centre	33 834 57 26	Dakar	\N	\N	\N	f	\N
1051	Pharmacie El Hadji M Seydou Ba	pharmacie-el-hadji-m-seydou-ba	Vente De Produits Pharmaceutiques Bopp	\N	2	2026-03-02 23:11:12.751	2026-03-02 23:11:12.751	Vente De Produits Pharmaceutiques Bopp	Rue Casamance X Diakhao	33 842 55 03	Dakar	\N	\N	\N	f	\N
1052	Pharmacie Thiaroye - Rokhaya W Ade Ka	pharmacie-thiaroye-rokhaya-w-ade-ka	Vente De Produits Pharmaceutiques Thiaroye Gare -	\N	2	2026-03-02 23:11:12.753	2026-03-02 23:11:12.753	Vente De Produits Pharmaceutiques Thiaroye Gare -	Route Des Niayes - Darou Salam 2 - Pikine	33 836 22 52	Dakar	\N	\N	\N	f	\N
1053	Alpha Gueye Prestation De	alpha-gueye-prestation-de	Service Et Commerce General	\N	2	2026-03-02 23:11:12.755	2026-03-02 23:11:12.755	Service Et Commerce General	Quartier E scale Thies 0 Thiaroye Pharmacie Rayhana (Dr Ismaila Barry) Vente De Produits Pharmaceutiques Quartier Nasroulah i N° 533 Diamaguene	33 834 26 12	Dakar	\N	\N	\N	f	\N
1054	Pharmacie Ndeye Fambaye Gaye	pharmacie-ndeye-fambaye-gaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.757	2026-03-02 23:11:12.757	Vente De Produits Pharmaceutiques	Quartier Fass Aino umani Rufisque Nord	33 820 72 90	Rufisque	\N	\N	\N	f	\N
1055	Cst Sarl	cst-sarl	Commerce De Tehnologies	\N	2	2026-03-02 23:11:12.759	2026-03-02 23:11:12.759	Commerce De Tehnologies	Iimmeuble La Rotonde Local Rue St Michel X Assane Ndoye	33 832 24 67	Dakar	\N	\N	\N	f	\N
1056	Pharmacie Sankoun Faty	pharmacie-sankoun-faty	Vente De Produits Pharmaceutiques Cite Gendarmerie K eur Massar 0 Dakar Caprasen Sarl (Centrale D'Achat De Produits Alimentaires Du Senegal Sarl) Vente De Marchandises	\N	2	2026-03-02 23:11:12.761	2026-03-02 23:11:12.761	Vente De Produits Pharmaceutiques Cite Gendarmerie K eur Massar 0 Dakar Caprasen Sarl (Centrale D'Achat De Produits Alimentaires Du Senegal Sarl) Vente De Marchandises	Rue 9 X 16 Medina	33 822 59 98	Pikine	\N	\N	\N	f	\N
1057	Ibrahima Mbodji	ibrahima-mbodji	Commerce	\N	2	2026-03-02 23:11:12.763	2026-03-02 23:11:12.763	Commerce	Rue El Hadji Mbaye Gueye X Sandiniery	33 821 22 06	Dakar	\N	\N	\N	f	\N
1058	Bridge Business International	bridge-business-international	Commerce Derkle Lot 4 Villa N° 06 0 Matam Pharmacie Cheikh Tidiane Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.764	2026-03-02 23:11:12.764	Commerce Derkle Lot 4 Villa N° 06 0 Matam Pharmacie Cheikh Tidiane Vente De Produits Pharmaceutiques	Rue De La Prefectu re Quartier Tantadji	33 369 14 13	Dakar	\N	\N	\N	f	\N
1059	Comptoir Commercial Keur Serigne Saliou	comptoir-commercial-keur-serigne-saliou	Commerce Et Transport Km 11	\N	2	2026-03-02 23:11:12.766	2026-03-02 23:11:12.766	Commerce Et Transport Km 11	Route De Rufisque	33 966 62 79	Pikine	\N	\N	\N	f	\N
1060	Pharmacie Couro	pharmacie-couro	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.768	2026-03-02 23:11:12.768	Vente De Produits Pharmaceutiques	Avenue Cheikh Ahma dou Bamba - Kebemer	33 854 78 12	Kebemer	\N	\N	\N	f	\N
1061	A.D.S. Sarl (Alliance	a-d-s-sarl-alliance	Distribution Services) Commerce General	\N	2	2026-03-02 23:11:12.77	2026-03-02 23:11:12.77	Distribution Services) Commerce General	Avenue Cheikh Anta Diop 776519628 Dakar Pharmacie Du Boulevard (Aby Ndiaye Paye) Vente De Produits Pharmaceutiques Rue 22 X 45 Medina	33 842 86 39	Dakar	\N	\N	\N	f	\N
1062	Zap Industrie Et	zap-industrie-et	Commerce Commerce Et Industrie	\N	2	2026-03-02 23:11:12.771	2026-03-02 23:11:12.771	Commerce Commerce Et Industrie	Rue 25 X 10 Medina 0 Dakar Cib Senegal Sarl (Centrale Informatique Bureautique Senegal) Entreprise De Distribution Rue 9 X Blaise Diagne Med ina	33 836 30 57	Dakar	\N	\N	\N	f	\N
1063	Pharmacie Transmissions (Dr Marieme Ndiaye Sarr)	pharmacie-transmissions-dr-marieme-ndiaye-sarr	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.773	2026-03-02 23:11:12.773	Vente De Produits Pharmaceutiques	Route De Boune Comico 4 Yeumbeul Nord Yeumbeul 0 Rufisque Pharmacie Adji Gnagna Diagne (Docteur Elhadji Moustapha Diaw ) Vente De Produits Pharmaceutiques Colobane Nord 33871 60 60 Dakar Pharmacie Bokiladji ( Mamadou Oumar Sy) Vente De Produits Pahrmaceutiques Quartier Bokiladji	30 104 36 24	Pikine	\N	\N	\N	f	\N
1064	La Casa Italiana	la-casa-italiana	Commerce General	\N	2	2026-03-02 23:11:12.775	2026-03-02 23:11:12.775	Commerce General	Rue Felix Faure	33 960 57 93	Dakar	\N	\N	\N	f	\N
1065	Beye	beye	Transcommerce Sarl Commerce General Medina Fall Thies 0 Dakar Pharmacie Rolland - Francisca Sarr Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.778	2026-03-02 23:11:12.778	Transcommerce Sarl Commerce General Medina Fall Thies 0 Dakar Pharmacie Rolland - Francisca Sarr Vente De Produits Pharmaceutiques	Rue Vincens	33 842 42 92	Thies	\N	\N	\N	f	\N
1066	Pharmacie La Moustarchida Sokhna Assy Sy (Dieynaba Lam)	pharmacie-la-moustarchida-sokhna-assy-sy-dieynaba-lam	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.78	2026-03-02 23:11:12.78	Vente De Produits Pharmaceutiques	Rue 39 X 37 Medina	33 821 78 10	Dakar	\N	\N	\N	f	\N
1067	Pharmacie Touba Kane (Dr Mor Kane)	pharmacie-touba-kane-dr-mor-kane	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.782	2026-03-02 23:11:12.782	Vente De Produits Pharmaceutiques	Quartier Moustapa Djidda Thiaroye	33 842 22 22	Pikine	\N	\N	\N	f	\N
1068	Egetra Zakia Nasr	egetra-zakia-nasr	Commerce De Marchandises	\N	2	2026-03-02 23:11:12.784	2026-03-02 23:11:12.784	Commerce De Marchandises	Route Du Camp Penal Scat Ur ban-N° 07	77 652 40 57	Dakar	\N	\N	\N	f	\N
1069	Office System (Omar Cisse)	office-system-omar-cisse	Commerce General	\N	2	2026-03-02 23:11:12.786	2026-03-02 23:11:12.786	Commerce General	Rue Valmy X Abdou Karim Bourgi	33 827 44 44	Dakar	\N	\N	\N	f	\N
1070	Ets Ibrahima Cisse	ets-ibrahima-cisse	Commerce	\N	2	2026-03-02 23:11:12.789	2026-03-02 23:11:12.789	Commerce	Rue Raffenel 0 Dagana Pharmacie Mame Fatou Bintou(Dr Papa Balla Diop) Vente De Produits Pharmaceutiques Diama Yallar Cr Di ama Saint-Louis	33 849 15 59	Dakar	\N	\N	\N	f	\N
1071	Pharmacie Aynina Fall (Seynabou Gueye)	pharmacie-aynina-fall-seynabou-gueye	Vente De Produits Pharmaceutiques Dvf 33 952 22 5 Dakar Dmci Sarl (Dakar Mecanique Chaudronnerie Industrielle) Commerce	\N	2	2026-03-02 23:11:12.791	2026-03-02 23:11:12.791	Vente De Produits Pharmaceutiques Dvf 33 952 22 5 Dakar Dmci Sarl (Dakar Mecanique Chaudronnerie Industrielle) Commerce	Route De Potou - Bel Air	33 957 66 96	Thies	\N	\N	\N	f	\N
1072	Euro Communication Systeme - Sarl	euro-communication-systeme-sarl	Vente Ouvrages Scolaires	\N	2	2026-03-02 23:11:12.793	2026-03-02 23:11:12.793	Vente Ouvrages Scolaires	Rue Jules Ferry	33 825 01 85	Dakar	\N	\N	\N	f	\N
1073	Connectis House (Mame Nogaye Fall)	connectis-house-mame-nogaye-fall	Vente De Materiels Informatiques Et Electroniques	\N	2	2026-03-02 23:11:12.795	2026-03-02 23:11:12.795	Vente De Materiels Informatiques Et Electroniques	Rue Amadou Assane Ndoye	33 822 62 19	Dakar	\N	\N	\N	f	\N
1074	Aye Pharmacie Saybata Ndiaye	aye-pharmacie-saybata-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.797	2026-03-02 23:11:12.797	Vente De Produits Pharmaceutiques	Route Baye Laye Go lf Nord Guediaw Aye	77 351 73 58	Guediaw	\N	\N	\N	f	\N
1075	Systems Plus - Sarl	systems-plus-sarl	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:12.799	2026-03-02 23:11:12.799	Vente De Materiels Informatiques	Avenue Lamine Gueye	33 878 41 41	Dakar	\N	\N	\N	f	\N
1076	Yacoub Faw Az	yacoub-faw-az	Commerce General	\N	2	2026-03-02 23:11:12.801	2026-03-02 23:11:12.801	Commerce General	Rue Galandou Diouf	33 821 60 45	Dakar	\N	\N	\N	f	\N
1077	Emk Stores Sarl	emk-stores-sarl	Commerce General	\N	2	2026-03-02 23:11:12.803	2026-03-02 23:11:12.803	Commerce General	Rue Escarfait X Robert Brun	33 834 59 32	Dakar	\N	\N	\N	f	\N
1078	Pharmacie Serigne Touba (Seynabou Ndiaye)	pharmacie-serigne-touba-seynabou-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.805	2026-03-02 23:11:12.805	Vente De Produits Pharmaceutiques	Quartier Darou Rah mane Diamaguene	33 823 08 16	Pikine	\N	\N	\N	f	\N
1079	Pharmacie Mingue (Dr Mamadou Diop)	pharmacie-mingue-dr-mamadou-diop	Vente De Produits Pharmaceutiques Keur Massar 0 Dakar Modou Syll Commerce General	\N	2	2026-03-02 23:11:12.808	2026-03-02 23:11:12.808	Vente De Produits Pharmaceutiques Keur Massar 0 Dakar Modou Syll Commerce General	Rue Galandou Diouf	33 834 88 91	Pikine	\N	\N	\N	f	\N
1080	Pharmacie El Hadji Fallou	pharmacie-el-hadji-fallou	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.81	2026-03-02 23:11:12.81	Vente De Produits Pharmaceutiques	Quartier Ainoumady Sam Sam 1 Thiaroye 0 Mbour Pharmacie Al Fattah Vente De Produits Pharmaceutiques Diamaguene 1 N° 95 J	33 822 16 50	Pikine	\N	\N	\N	f	\N
1081	Pharmacie Serigne Momar Diongue (Dr Ousmane Diongue )	pharmacie-serigne-momar-diongue-dr-ousmane-diongue	Vente De Produits Pharmaceutiques Niaga Village Pres Poste De Sante Thierry Sabine 0 Dakar Scpi Sarl (Societe Commerciale Des Produits Internationaux) Commerce	\N	2	2026-03-02 23:11:12.812	2026-03-02 23:11:12.812	Vente De Produits Pharmaceutiques Niaga Village Pres Poste De Sante Thierry Sabine 0 Dakar Scpi Sarl (Societe Commerciale Des Produits Internationaux) Commerce	Rue Alfred Goux	33 957 55 11	Rufisque	\N	\N	\N	f	\N
1082	Entreprise Diamaguene(Abdoulaye Fall)	entreprise-diamaguene-abdoulaye-fall	Commerce General Touba Darou Khoudoss 0 Guediaw Aye Pharmacie Nassiha Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.813	2026-03-02 23:11:12.813	Commerce General Touba Darou Khoudoss 0 Guediaw Aye Pharmacie Nassiha Vente De Produits Pharmaceutiques	Boulevard Serigne Bassirou Mbacke	33 966 86 04	Mbacke	\N	\N	\N	f	\N
1083	Ets Lee (Jong Eun Lee)	ets-lee-jong-eun-lee	Commerce	\N	2	2026-03-02 23:11:12.815	2026-03-02 23:11:12.815	Commerce	Avenue Georges Pompidou 0 Thies Pharmacie Maman Saly (Ndiame Kane) Vente De Produits Pharmaceutiques Route De Kayar Keu r Moussa	33 954 85 69	Dakar	\N	\N	\N	f	\N
1084	Pharmacie Fass	pharmacie-fass	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.817	2026-03-02 23:11:12.817	Vente De Produits Pharmaceutiques	Route De Fass Rufi sque 0 Dakar Exim Voyages Sarl Vente De Billet D'Avion Avenue Lamine Gueye 33823 23 78 Dakar Monsieur Pape Cisse Commerce Rue X Blaise Diagne	33 873 08 28	Rufisque	\N	\N	\N	f	\N
1085	Sets Suarl (Senegalaise D'Equipement De Travaux Et De	sets-suarl-senegalaise-d-equipement-de-travaux-et-de	Services Suarl) Commerce	\N	2	2026-03-02 23:11:12.818	2026-03-02 23:11:12.818	Services Suarl) Commerce	Rue 13 X Cheikh Ahmadou Bamba	77 529 82 10	Dakar	\N	\N	\N	f	\N
1086	Pharmacie Depot(Babacar Diop)	pharmacie-depot-babacar-diop	Vente De Produits Pharmaceutiques Tamba 0 Dakar Akil Telecom Commerce Materiel Informatique Et Accessoires	\N	2	2026-03-02 23:11:12.82	2026-03-02 23:11:12.82	Vente De Produits Pharmaceutiques Tamba 0 Dakar Akil Telecom Commerce Materiel Informatique Et Accessoires	Rue Ja cques Bugnicourt	33 820 49 15	Tambacounda	\N	\N	\N	f	\N
1087	Arsouni Sarl (Articles De Securite Ouvrages Nautiques Et Instruments) Assistance Pour Bateaux	arsouni-sarl-articles-de-securite-ouvrages-nautiques-et-instruments-assistance-pour-bateaux	(Ex-Commerce General)	\N	2	2026-03-02 23:11:12.822	2026-03-02 23:11:12.822	(Ex-Commerce General)	Avenue Felix Eboue Ex Cfao Mole 10	33 842 86 65	Dakar	\N	\N	\N	f	\N
1088	Pharmacie Matlabul Chifai (Alioune Seck)	pharmacie-matlabul-chifai-alioune-seck	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.824	2026-03-02 23:11:12.824	Vente De Produits Pharmaceutiques	Quartier Sara 0 Dakar Pharmacie Cite Millionnaire (Dr Babacar Diop) Vente De Produits Pharmaceutiques Cite Millionnaire	33 821 75 72	Kaolack	\N	\N	\N	f	\N
1089	Alioune Gadiaga	alioune-gadiaga	Commerce Marche Central Tivaouane 0 Mbour Pharmacie Serigne Mbaye Seck (Dr Cheikh Diouf) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.826	2026-03-02 23:11:12.826	Commerce Marche Central Tivaouane 0 Mbour Pharmacie Serigne Mbaye Seck (Dr Cheikh Diouf) Vente De Produits Pharmaceutiques	Quartier Escale Ro ute De Joal Mbour 33957 14 94 Dakar Pharmacie De La Corniche (Madiare Diakhate) Vente De Produits Pharmaceutiques Parcelles Assainie s Unite 19 Camberene	33 823 29 23	Tivaouane	\N	\N	\N	f	\N
1090	Khodia Sales And	khodia-sales-and	Services Sural Commerce General Import- Export Et Prestation De Se rvices	\N	2	2026-03-02 23:11:12.828	2026-03-02 23:11:12.828	Services Sural Commerce General Import- Export Et Prestation De Se rvices	Rue 41 X 22 Medina 0 Dakar W Oodin Senegal Sarl Vente De Textile En Gros Et Detail Sotrac Mermoz	33 820 17 40	Dakar	\N	\N	\N	f	\N
1091	Etablissements Jallow Abdoulie	etablissements-jallow-abdoulie	Commerce Import-Export De Marchandises Colobane Nianghor Cite Police Pikine Plle N° 2112 0 Dakar Pharmacie Aminata Kane (Salamata Kane) Vente De Produits Pharmaceutiques Sacre Cœur 1	\N	2	2026-03-02 23:11:12.83	2026-03-02 23:11:12.83	Commerce Import-Export De Marchandises Colobane Nianghor Cite Police Pikine Plle N° 2112 0 Dakar Pharmacie Aminata Kane (Salamata Kane) Vente De Produits Pharmaceutiques Sacre Cœur 1	Immeu ble Tr- 3	33 860 62 49	Pikine	\N	\N	\N	f	\N
1092	Cosi (Cosi International) Assistance Conseils -	cosi-cosi-international-assistance-conseils	Ventes De Pdts Informatiques	\N	2	2026-03-02 23:11:12.831	2026-03-02 23:11:12.831	Ventes De Pdts Informatiques	Rue Carnot	33 842 67 05	Dakar	\N	\N	\N	f	\N
1093	Sanli Senegal Sarl	sanli-senegal-sarl	Commerce Import-Export De Cyclomoteurs	\N	2	2026-03-02 23:11:12.833	2026-03-02 23:11:12.833	Commerce Import-Export De Cyclomoteurs	Immeuble Mariama Ba - Bld Gueule Tapee X Rue 16 Bis Medina	33 823 69 12	Dakar	\N	\N	\N	f	\N
1094	Ceratech	ceratech	Ventesn De Carreaux	\N	2	2026-03-02 23:11:12.835	2026-03-02 23:11:12.835	Ventesn De Carreaux	Avenue Yacinthe Thiandoum	33 842 83 18	Dakar	\N	\N	\N	f	\N
1095	Astou Diakhate	astou-diakhate	Commerce General	\N	2	2026-03-02 23:11:12.837	2026-03-02 23:11:12.837	Commerce General	Rue Marsat	33 855 33 20	Dakar	\N	\N	\N	f	\N
1096	Dame Seck Ndiaye	dame-seck-ndiaye	Commerce General	\N	2	2026-03-02 23:11:12.839	2026-03-02 23:11:12.839	Commerce General	Bd Du General Degaulle 0 Dakar Phenix Aluminium - Sarl Commerce De Matiere Alumunium Km 11 Route De Rufisqu e	76 584 10 91	Dakar	\N	\N	\N	f	\N
1097	Leharien'S Boutique	leharien-s-boutique	Vente De Vetements	\N	2	2026-03-02 23:11:12.841	2026-03-02 23:11:12.841	Vente De Vetements	Avenue Bourguiba Dieuppeul Villa 2569	33 839 73 09	Dakar	\N	\N	\N	f	\N
1098	Ibe Surl (Informatique Bureautique Electronique)	ibe-surl-informatique-bureautique-electronique	Vente De Materiels Informatiques Et Lectroniques Amitie / Point E -	\N	2	2026-03-02 23:11:12.843	2026-03-02 23:11:12.843	Vente De Materiels Informatiques Et Lectroniques Amitie / Point E -	Immeuble Hajjar	33 832 54 83	Dakar	\N	\N	\N	f	\N
1099	Pharmacie Mere Maty	pharmacie-mere-maty	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.844	2026-03-02 23:11:12.844	Vente De Produits Pharmaceutiques	Quartier Santhie 3 , Joal Fadiou 0 Bakel Pharmacie Yaye Fatou Sy Vente De Produits Pharmaceutiques Moudery 0 Dakar Pharmacie Espace Residence Vente De Produits Pharmaceutiques Hann Maristes Espa ce Residence 3 N° 2102	33 825 75 86	Mbour	\N	\N	\N	f	\N
1100	Etablissements Macha Allah (Mansour Dieye)	etablissements-macha-allah-mansour-dieye	Commerce Escale Gossas 0 Rufisque Pharmacie Acore Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.846	2026-03-02 23:11:12.846	Commerce Escale Gossas 0 Rufisque Pharmacie Acore Vente De Produits Pharmaceutiques	Quartier Diokoul K her	33 870 07 70	Fatick	\N	\N	\N	f	\N
1101	Pharmacie Mame Deffa (Rokhaya Seydou Diallo)	pharmacie-mame-deffa-rokhaya-seydou-diallo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.848	2026-03-02 23:11:12.848	Vente De Produits Pharmaceutiques	Quartier Amadou De guene Ndiareme	33 827 36 31	Dakar	\N	\N	\N	f	\N
1102	Pharmacie De La Paix	pharmacie-de-la-paix	Vente De Produits Pharmaceutiques Sicap Liberte Vi -	\N	2	2026-03-02 23:11:12.85	2026-03-02 23:11:12.85	Vente De Produits Pharmaceutiques Sicap Liberte Vi -	Immeuble A	77 554 77 40	Dakar	\N	\N	\N	f	\N
1103	Pharmacie Djoguoye (Dr Genevieve Ndiaye)	pharmacie-djoguoye-dr-genevieve-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.851	2026-03-02 23:11:12.851	Vente De Produits Pharmaceutiques	Route De Ngor X Ro ute Des Almadies	33 837 21 90	Dakar	\N	\N	\N	f	\N
1104	Pharmacie Des Mamelles (Dr Ndiaw Ndiaye Diouf Ba)	pharmacie-des-mamelles-dr-ndiaw-ndiaye-diouf-ba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.853	2026-03-02 23:11:12.853	Vente De Produits Pharmaceutiques	Route De Ngor	33 820 70 41	Dakar	\N	\N	\N	f	\N
1105	Ndiouga Ndiaye	ndiouga-ndiaye	Commerce D'Appareils Electroniques	\N	2	2026-03-02 23:11:12.855	2026-03-02 23:11:12.855	Commerce D'Appareils Electroniques	Avenue Georges Po mpidou	33 820 56 65	Dakar	\N	\N	\N	f	\N
1106	Saloum Equipements Et	saloum-equipements-et	Services (Babacar Camara) Commerce	\N	2	2026-03-02 23:11:12.857	2026-03-02 23:11:12.857	Services (Babacar Camara) Commerce	Rue 23 X 22 Medina	33 822 14 43	Dakar	\N	\N	\N	f	\N
1107	Sarl Sall Negoce	sarl-sall-negoce	Production Commerce Negoce	\N	2	2026-03-02 23:11:12.858	2026-03-02 23:11:12.858	Production Commerce Negoce	Rue Nxbxn N°4038 0 Dakar Spe Surl (Senegalaise De Prestation Et D'Equipements Surl) Commerce General Liberte 6 Ext Dakar	77 643 42 75	Dakar	\N	\N	\N	f	\N
1108	Produits Regal International	produits-regal-international	Vente De Peintures	\N	2	2026-03-02 23:11:12.86	2026-03-02 23:11:12.86	Vente De Peintures	Route Du Front De Terre N° 21	77 558 31 84	Dakar	\N	\N	\N	f	\N
1109	Pharmacie Badiene Fatou Diop	pharmacie-badiene-fatou-diop	Vente De Produits Pharmaceutiques N° 1570	\N	2	2026-03-02 23:11:12.861	2026-03-02 23:11:12.861	Vente De Produits Pharmaceutiques N° 1570	Quartier M edine Mbour	33 825 40 93	Mbour	\N	\N	\N	f	\N
1110	Pharmacie Mame Maodo Malick	pharmacie-mame-maodo-malick	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.863	2026-03-02 23:11:12.863	Vente De Produits Pharmaceutiques	Quartier Ouakam	33 951 17 48	Dakar	\N	\N	\N	f	\N
1111	Aglodis Sarl(Africa Global	aglodis-sarl-africa-global	Distribution) Commerce General	\N	2	2026-03-02 23:11:12.865	2026-03-02 23:11:12.865	Distribution) Commerce General	Boulevard De La Republique	33 860 66 11	Dakar	\N	\N	\N	f	\N
1112	Pharmacie Yaye Ngoundia (Dr Die Thiam)	pharmacie-yaye-ngoundia-dr-die-thiam	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.867	2026-03-02 23:11:12.867	Vente De Produits Pharmaceutiques	Rue Sam Notaire 0 Dakar Pharmacie Adja Daba Diagne Vente De Produits Pharmaceutiques Villa N° 34 Cite M uh Mamelles Ouakam	77 639 82 08	Pikine	\N	\N	\N	f	\N
1113	Pharmacie De La Poste	pharmacie-de-la-poste	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.869	2026-03-02 23:11:12.869	Vente De Produits Pharmaceutiques	Avenue Blaise Diag ne X Rue 1	33 880 04 06	Dakar	\N	\N	\N	f	\N
1114	Pharmacie Du Stade Lat Dior (Mohamed Moustapha Sarr )	pharmacie-du-stade-lat-dior-mohamed-moustapha-sarr	Vente De Produits Pharmaceutiques Mbour 3 Pres Du St ade Lat Dior 0 Pikine Pharmacie Gainde Fatma (Coumba Tall Dieng) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.871	2026-03-02 23:11:12.871	Vente De Produits Pharmaceutiques Mbour 3 Pres Du St ade Lat Dior 0 Pikine Pharmacie Gainde Fatma (Coumba Tall Dieng) Vente De Produits Pharmaceutiques	Quartier Lansar Vi lla N° 8 Thiaroye	33 954 06 48	Thies	\N	\N	\N	f	\N
1115	Pharmacie Alassane El Fecky	pharmacie-alassane-el-fecky	Vente De Produits Pharmaceutiques Sacre Cœur Ii 0 Dakar Delta Diffusion Commerce De Pieces Detachees	\N	2	2026-03-02 23:11:12.872	2026-03-02 23:11:12.872	Vente De Produits Pharmaceutiques Sacre Cœur Ii 0 Dakar Delta Diffusion Commerce De Pieces Detachees	Rue Docteur Theze	33 961 33 61	Dakar	\N	\N	\N	f	\N
1116	Serigne Mouhamadou Fallou Mbaye "Mbi"	serigne-mouhamadou-fallou-mbaye-mbi	Vente Outils Informatique Consommables Fournitures De Burau	\N	2	2026-03-02 23:11:12.874	2026-03-02 23:11:12.874	Vente Outils Informatique Consommables Fournitures De Burau	Rue 9 X Blaise Diagne	33 827 77 26	Dakar	\N	\N	\N	f	\N
1117	Sr Graffic (Sr Actions - Sarl)	sr-graffic-sr-actions-sarl	Vente De Produits D'Imprimerie Cite Delmas N° 203 Ou est Foire Face Cices 338206877 Pikine Pharmacie Ablaye Gadiaga Mourite Sadikh Vente De Produits Pharmaceutiques Pikine	\N	2	2026-03-02 23:11:12.876	2026-03-02 23:11:12.876	Vente De Produits D'Imprimerie Cite Delmas N° 203 Ou est Foire Face Cices 338206877 Pikine Pharmacie Ablaye Gadiaga Mourite Sadikh Vente De Produits Pharmaceutiques Pikine	Route Des N iayes	33 822 57 40	Dakar	\N	\N	\N	f	\N
1118	Pharmacie Darou Salam 2	pharmacie-darou-salam-2	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.878	2026-03-02 23:11:12.878	Vente De Produits Pharmaceutiques	Route Des Niayes	33 860 69 47	Dakar	\N	\N	\N	f	\N
1119	Maya Abdel Jaoued	maya-abdel-jaoued	Commerce	\N	2	2026-03-02 23:11:12.879	2026-03-02 23:11:12.879	Commerce	Avenue Blaise Diagne 0 Saint-Louis Pharmacie Malang Lyss Vente De Produits Pharmaceutiques Corniche Bar Sor	33 837 02 74	Dakar	\N	\N	\N	f	\N
1120	Dissel	dissel	(Distribution De Systemes De Securite Electronique) - Omar Niasse Distribution De Systemes De Securite Electronique / Batiment Medina	\N	2	2026-03-02 23:11:12.881	2026-03-02 23:11:12.881	(Distribution De Systemes De Securite Electronique) - Omar Niasse Distribution De Systemes De Securite Electronique / Batiment Medina	Rue 13 X Corniche	33 835 25 56	Dakar	\N	\N	\N	f	\N
1121	Pharmacie Yaye Nogaye Seck	pharmacie-yaye-nogaye-seck	Vente De Produits Pharmaceutiques Cite Des Assurance s Dalifort 0 Ziguinchor Pharmacie La Paix ( Pierre Dieng) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.883	2026-03-02 23:11:12.883	Vente De Produits Pharmaceutiques Cite Des Assurance s Dalifort 0 Ziguinchor Pharmacie La Paix ( Pierre Dieng) Vente De Produits Pharmaceutiques	Route De L'Aeropor t Face Hopital La Paix	33 837 13 39	Pikine	\N	\N	\N	f	\N
1122	Gcs (Mme Khady Amar)	gcs-mme-khady-amar	Commerce Colobane	\N	2	2026-03-02 23:11:12.885	2026-03-02 23:11:12.885	Commerce Colobane	Rue 33 X 42	33 991 49 34	Dakar	\N	\N	\N	f	\N
1123	Pharmacie Abdou Aziz Sy	pharmacie-abdou-aziz-sy	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.886	2026-03-02 23:11:12.886	Vente De Produits Pharmaceutiques	Avenue Caen	33 860 18 05	Thies	\N	\N	\N	f	\N
1124	Merdjanopoulos Sarl	merdjanopoulos-sarl	Commerce General Saly Mbour 0 Dakar Pharmacie Du	\N	2	2026-03-02 23:11:12.888	2026-03-02 23:11:12.888	Commerce General Saly Mbour 0 Dakar Pharmacie Du	Boulevard - Arfang Faye Vente De Produits Pharmaceutiques Hann Montagne Vill a N° 16	33 951 48 30	Mbour	\N	\N	\N	f	\N
1125	Adrien Mbaye	adrien-mbaye	Commerce General	\N	2	2026-03-02 23:11:12.889	2026-03-02 23:11:12.889	Commerce General	Rue Sicap Liberte V 0 Dakar Gnt (Gnt International) Commerce Sicap Sacre Cœur Ii Immeuble Sokhna Astou Lo N° 133 33 824 5 940 Dakar Ottinex Senegal - Sa Commerce Les Almadies Zone 12	77 512 72 88	Dakar	\N	\N	\N	f	\N
1126	Pharmacie Macha Allah	pharmacie-macha-allah	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.891	2026-03-02 23:11:12.891	Vente De Produits Pharmaceutiques	Quartier 11 Novemb re Mbour	33 951 39 39	Mbour	\N	\N	\N	f	\N
1127	Grb - Sarl (Groupement Riopele Bourgi) Autres	grb-sarl-groupement-riopele-bourgi-autres	Commerces - Import/Export Tissus	\N	2	2026-03-02 23:11:12.893	2026-03-02 23:11:12.893	Commerces - Import/Export Tissus	Rue Abdou Ka rim Bourgi	33 957 05 00	Dakar	\N	\N	\N	f	\N
1128	Cafijex Suarl (Cabinet D'Accompagnement Fiscal Juridique Et D'Expertise Sarl)	cafijex-suarl-cabinet-d-accompagnement-fiscal-juridique-et-d-expertise-sarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.895	2026-03-02 23:11:12.895	Vente De Produits Pharmaceutiques	Rue Marsat X Autor oute	33 823 37 65	Dakar	\N	\N	\N	f	\N
1129	Abts (Ab Trade And	abts-ab-trade-and	Services) Commerce General Dieuppeul Derkle N° 5658 X	\N	2	2026-03-02 23:11:12.897	2026-03-02 23:11:12.897	Services) Commerce General Dieuppeul Derkle N° 5658 X	Rue 13 P rolongee	77 630 20 65	Dakar	\N	\N	\N	f	\N
1130	Souleymane Diakhate	souleymane-diakhate	Distribution De Materiaux De Construction / Vente De Ciment	\N	2	2026-03-02 23:11:12.899	2026-03-02 23:11:12.899	Distribution De Materiaux De Construction / Vente De Ciment	Rue 4, Bopp	33 864 54 59	Dakar	\N	\N	\N	f	\N
1131	Touba Gouye Mbinde (Khade Gassama)	touba-gouye-mbinde-khade-gassama	Commerce General	\N	2	2026-03-02 23:11:12.901	2026-03-02 23:11:12.901	Commerce General	Route De Rufisque Thiaroye Sur Mer	33 957 25 31	Pikine	\N	\N	\N	f	\N
1132	Ali Meroueh Autres	ali-meroueh-autres	Commerce	\N	2	2026-03-02 23:11:12.903	2026-03-02 23:11:12.903	Commerce	Avenue Blaise Diagne 33822 18 93 Dakar Charbel Bahsa Commerce Ave Pasteur 0 Dakar Gie Touba Khelcom Hann Mariste Commerce General Hann Mariste 2 Villa N°73	33 834 33 85	Dakar	\N	\N	\N	f	\N
1133	Home Design Sarl	home-design-sarl	Vente De Meubles	\N	2	2026-03-02 23:11:12.905	2026-03-02 23:11:12.905	Vente De Meubles	Avenue Hassan 2 X Abdoulaye Fadiga	70 820 73 51	Dakar	\N	\N	\N	f	\N
1134	Tradimer Suarl	tradimer-suarl	Commerce General	\N	2	2026-03-02 23:11:12.907	2026-03-02 23:11:12.907	Commerce General	Quartier Yoff Mbenguene	33 821 17 17	Dakar	\N	\N	\N	f	\N
1135	Pharmacie Binta Junior	pharmacie-binta-junior	Vente De Produits Pharmaceutiques Bvd 54 X	\N	2	2026-03-02 23:11:12.908	2026-03-02 23:11:12.908	Vente De Produits Pharmaceutiques Bvd 54 X	Rue 29 Mo squee Kadior Ziguinchor	33 865 88 00	Ziguinchor	\N	\N	\N	f	\N
1136	Pharmacie Cite Sotiba	pharmacie-cite-sotiba	Vente De Produits Pharmaceutiques Garage Niayes En F ace	\N	2	2026-03-02 23:11:12.91	2026-03-02 23:11:12.91	Vente De Produits Pharmaceutiques Garage Niayes En F ace	Autoroute	33 991 64 96	Pikine	\N	\N	\N	f	\N
1137	Dakaroise D'Equipement	dakaroise-d-equipement	Commerce	\N	2	2026-03-02 23:11:12.912	2026-03-02 23:11:12.912	Commerce	Avenue Malick Sy	33 834 59 20	Dakar	\N	\N	\N	f	\N
1138	Jam International Sarl	jam-international-sarl	Commerce General	\N	2	2026-03-02 23:11:12.914	2026-03-02 23:11:12.914	Commerce General	Rue Malan X Boulevard Djiily Mbaye	33 821 57 28	Dakar	\N	\N	\N	f	\N
1139	Ets Mbacke Traore	ets-mbacke-traore	Commerce General Km 21 X	\N	2	2026-03-02 23:11:12.916	2026-03-02 23:11:12.916	Commerce General Km 21 X	Route De Mbao	33 951 46 13	Pikine	\N	\N	\N	f	\N
1140	Le Darmanco Suarl	le-darmanco-suarl	Commerce Divers	\N	2	2026-03-02 23:11:12.917	2026-03-02 23:11:12.917	Commerce Divers	Avenue Cheikh Anta Diop Sotrac Mermoz Immeuble Rose 0 Dakar Promedicus Engineering Sarl Vente D'Equipements Medicaux Reconditionnes Rue 65 X 78 Mermoz Pyrotechnie Villa N° 46	33 836 85 46	Dakar	\N	\N	\N	f	\N
1141	New Energy W Est Africa Sarl	new-energy-w-est-africa-sarl	Commerce Villa N° 6,	\N	2	2026-03-02 23:11:12.919	2026-03-02 23:11:12.919	Commerce Villa N° 6,	Rue Mz 51, Mermoz	33 835 23 09	Dakar	\N	\N	\N	f	\N
1142	Max Negoce Sarl	max-negoce-sarl	Commerce Import-Export	\N	2	2026-03-02 23:11:12.921	2026-03-02 23:11:12.921	Commerce Import-Export	Avenue Lamine Gueye	33 860 61 10	Dakar	\N	\N	\N	f	\N
1143	Senfish - Sarl (Senegal Fishing) Autres	senfish-sarl-senegal-fishing-autres	Commerce - Poissons	\N	2	2026-03-02 23:11:12.923	2026-03-02 23:11:12.923	Commerce - Poissons	Rue Vincens	33 960 57 93	Dakar	\N	\N	\N	f	\N
1144	Pharmacie Nabil Moustapha (Magatte Mbengue)	pharmacie-nabil-moustapha-magatte-mbengue	Vente De Produits Pharmaceutiques Mbour,	\N	2	2026-03-02 23:11:12.925	2026-03-02 23:11:12.925	Vente De Produits Pharmaceutiques Mbour,	Quartier Th ioce Est	33 872 21 15	Mbour	\N	\N	\N	f	\N
1145	Agros Securite Autres	agros-securite-autres	Commerces	\N	2	2026-03-02 23:11:12.926	2026-03-02 23:11:12.926	Commerces	Avenue Birago Diop,Villa N° 3	33 957 17 14	Dakar	\N	\N	\N	f	\N
1146	Sama Gaal - Sarl Achats Et	sama-gaal-sarl-achats-et	Vente De Meubles Zone 12 Lot 6 Bis	\N	2	2026-03-02 23:11:12.928	2026-03-02 23:11:12.928	Vente De Meubles Zone 12 Lot 6 Bis	Route D e Ngor 33821 18 18 Kaolack Ets Mohamed Lemine Saleck Commerce Kaolack 0 Dakar Car On Quality Commerce Sicap Amitie 2	33 825 31 13	Dakar	\N	\N	\N	f	\N
1147	Aye Logic Plus	aye-logic-plus	Commerce Hamo 2 Villa 31-S 0 Dakar Comdis - Sa (Commerce Et Distribution) Commerce General - Distribution De Pdts Alimentaires	\N	2	2026-03-02 23:11:12.93	2026-03-02 23:11:12.93	Commerce Hamo 2 Villa 31-S 0 Dakar Comdis - Sa (Commerce Et Distribution) Commerce General - Distribution De Pdts Alimentaires	Rue Malan	77 648 57 09	Guediaw	\N	\N	\N	f	\N
1148	Ew Edje Exchange Senegal Sarl	ew-edje-exchange-senegal-sarl	Commerce General Bld Djily Mbaye	\N	2	2026-03-02 23:11:12.932	2026-03-02 23:11:12.932	Commerce General Bld Djily Mbaye	Immeuble Goeland X Robert Denand	33 823 75 49	Dakar	\N	\N	\N	f	\N
1149	Dieynaba Deme	dieynaba-deme	Commerce General Derkle	\N	2	2026-03-02 23:11:12.934	2026-03-02 23:11:12.934	Commerce General Derkle	Rue 4 X P Villa N°15	70 776 45 43	Dakar	\N	\N	\N	f	\N
1150	Abl Sante - Sarl	abl-sante-sarl	Commerce	\N	2	2026-03-02 23:11:12.935	2026-03-02 23:11:12.935	Commerce	Avenue Malick Sy	77 595 44 47	Dakar	\N	\N	\N	f	\N
1151	Pharmacie Du Prophete Mohamed	pharmacie-du-prophete-mohamed	Vente De Produits Pharmaceutiques Southiou Garba Mat al 0 Dakar Khadim Kane Commerce General	\N	2	2026-03-02 23:11:12.938	2026-03-02 23:11:12.938	Vente De Produits Pharmaceutiques Southiou Garba Mat al 0 Dakar Khadim Kane Commerce General	Rue Mousse Diop 0 Dakar Africa My Home - Africa Human Resources Suarl Commerce De Gros De Biens De Consommation Non Alime ntaires Point E Villa N°4326 Rue B 0 Dakar Fimap Suarl Commerce General Rue Jules Ferry	33 842 76 90	Matam	\N	\N	\N	f	\N
1152	Pharmacie Medina Thiaroye Iv (Ibrahima Khaliloulaye Dia)	pharmacie-medina-thiaroye-iv-ibrahima-khaliloulaye-dia	Vente De Produits Pharmaceutiques Djidadah Thiaroye Kao 0 Guediaw Aye Pharmacie Marianne (Mme Mame Penda Fofana Sylla) Vente De Produits Pharmaceutiques Mbode 5 Parcelle 6 66 - Guediaw Aye 0 Kaolack Bene Bounte (Mme Josephine About) Vente De Pieces Detachees Auto Benne Bounte	\N	2	2026-03-02 23:11:12.94	2026-03-02 23:11:12.94	Vente De Produits Pharmaceutiques Djidadah Thiaroye Kao 0 Guediaw Aye Pharmacie Marianne (Mme Mame Penda Fofana Sylla) Vente De Produits Pharmaceutiques Mbode 5 Parcelle 6 66 - Guediaw Aye 0 Kaolack Bene Bounte (Mme Josephine About) Vente De Pieces Detachees Auto Benne Bounte	Avenue J hon Kennedy N° 847	33 835 68 78	Pikine	\N	\N	\N	f	\N
1153	Pharmacie Mere Aminata Sall	pharmacie-mere-aminata-sall	Vente De Produits Pharmaceutiques Kebemer	\N	2	2026-03-02 23:11:12.942	2026-03-02 23:11:12.942	Vente De Produits Pharmaceutiques Kebemer	Route De D akar 0 Dakar Storido (Cham Amne) Commerce Ouvrages En Tissu Rue Galandou Diouf X Vinc ent 77 64 83 98 Pikine Pharmacie Zam Zam (Abdoulaye Diop) Vente De Produits Pharmaceutiques Diamaguene	33 941 28 88	Kebemer	\N	\N	\N	f	\N
1154	Entreprise Activité Adresse Téléphone Dakar Grande Pharmacie Sahm	entreprise-activite-adresse-telephone-dakar-grande-pharmacie-sahm	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.944	2026-03-02 23:11:12.944	Vente De Produits Pharmaceutiques	Avenue Cheikh Anta Diop X Gueule Tapee	33 834 22 51	Ville	\N	\N	\N	f	\N
1155	Pharmacie De L'Etrier (Haw Oly W Ane)	pharmacie-de-l-etrier-haw-oly-w-ane	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.946	2026-03-02 23:11:12.946	Vente De Produits Pharmaceutiques	Rue Mousse Diop	33 822 14 61	Dakar	\N	\N	\N	f	\N
1156	Serigne Gueye (Quincaillerie Senegalise)	serigne-gueye-quincaillerie-senegalise	Commerce General	\N	2	2026-03-02 23:11:12.947	2026-03-02 23:11:12.947	Commerce General	Rue Tolbiac X Faidherbe	33 832 34 98	Dakar	\N	\N	\N	f	\N
1157	Cadic (Comptoir Africain De Developpement Industriel)	cadic-comptoir-africain-de-developpement-industriel	Commerce	\N	2	2026-03-02 23:11:12.949	2026-03-02 23:11:12.949	Commerce	Rue 1 X J Castors Immeuble Dareyni Appt A9 2Eme Etage	77 633 13 57	Dakar	\N	\N	\N	f	\N
1158	Societe Africaine De Representation De Materiel Sarmati (Agricole Et De Techniques D'Irrigation)	societe-africaine-de-representation-de-materiel-sarmati-agricole-et-de-techniques-d-irrigation	Vente Materiels Agricoles	\N	2	2026-03-02 23:11:12.951	2026-03-02 23:11:12.951	Vente Materiels Agricoles	Avenue Bourguiba A Cote De L'Universite B	77 550 48 98	Dakar	\N	\N	\N	f	\N
1159	Khew Eul.Com - Sa	khew-eul-com-sa	Vente De Materiels Informatiques/Heberment De Site Internet	\N	2	2026-03-02 23:11:12.953	2026-03-02 23:11:12.953	Vente De Materiels Informatiques/Heberment De Site Internet	Rue Joseph Gomis	33 966 34 43	Dakar	\N	\N	\N	f	\N
1160	Pharmacie Du Lycee (Ndiouga Diallo)	pharmacie-du-lycee-ndiouga-diallo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.954	2026-03-02 23:11:12.954	Vente De Produits Pharmaceutiques	Avenue Caen Cite E l Hadji Malick Sy - Thies	33 867 97 07	Thies	\N	\N	\N	f	\N
1161	Hussein El Zeim	hussein-el-zeim	Vente D'Equipements Produits Dispositifs Accessoire s Medicaux Ave Lamine Gueye 0 Tivaouane Pharmacie Cheikh Ibrahima Niass(Ousmane Ndiaye) Vente De Produits Pharmaceutiques Taiba Ndiaye 0 Kaolack Pharmacie Inch'Allah (Docteur Dibor Seck ) Vente De Produits Pharmaceutiques Qrt Medina - Nioro Du Rip 0 Dakar Pharmacie Dardannelles Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.956	2026-03-02 23:11:12.956	Vente D'Equipements Produits Dispositifs Accessoire s Medicaux Ave Lamine Gueye 0 Tivaouane Pharmacie Cheikh Ibrahima Niass(Ousmane Ndiaye) Vente De Produits Pharmaceutiques Taiba Ndiaye 0 Kaolack Pharmacie Inch'Allah (Docteur Dibor Seck ) Vente De Produits Pharmaceutiques Qrt Medina - Nioro Du Rip 0 Dakar Pharmacie Dardannelles Vente De Produits Pharmaceutiques	Rue Dardannelles 0 Dakar Lgd (Le Globe Distribution) , Niangue Lo Quincaillerie - Commerce General Rue 22 X 19 Medina / Rond Point Faidherbe X Papa Gueye Fall	33 951 46 50	Dakar	\N	\N	\N	f	\N
1162	Pharmacie Tijjaani Aan (Docteur Harouna Kane)	pharmacie-tijjaani-aan-docteur-harouna-kane	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.958	2026-03-02 23:11:12.958	Vente De Produits Pharmaceutiques	Route De Boune/Quartier Seyni Sane 0 Dakar Pharmacie Ouest Foire (Anne Marie Dasylva) Vente De Produits Pharmaceutiques Ouest Foire Vdn 0 Dakar Pharmacie De L'Etrier (Arifa Baalbaki Kaddoura) Vente De Produits Pharmaceutiques Bccd - Hann	33 822 22 72	Pikine	\N	\N	\N	f	\N
1163	Seynabou Gueye	seynabou-gueye	Commerce	\N	2	2026-03-02 23:11:12.96	2026-03-02 23:11:12.96	Commerce	Quartier Colobane Ii Sud Rufisque	33 855 90 55	Rufisque	\N	\N	\N	f	\N
1164	Dar Al Sakafat	dar-al-sakafat	Commerce General	\N	2	2026-03-02 23:11:12.961	2026-03-02 23:11:12.961	Commerce General	Rue Abdou Karim Bourgi	77 957 74 02	Dakar	\N	\N	\N	f	\N
1165	Pac Sarl (Packaging Assistance Conditionnement)	pac-sarl-packaging-assistance-conditionnement	Vente De Marchandises Et Assistance Techniques	\N	2	2026-03-02 23:11:12.963	2026-03-02 23:11:12.963	Vente De Marchandises Et Assistance Techniques	Route De Ngor Virage 0 Mecke Gie Gandiol Vente De Marchandises Quartier Lebou Ngaye Mekhe	33 835 30 92	Dakar	\N	\N	\N	f	\N
1166	Quincaillerie Generale Mor Thiobane	quincaillerie-generale-mor-thiobane	Commerce De Quincaillerie	\N	2	2026-03-02 23:11:12.965	2026-03-02 23:11:12.965	Commerce De Quincaillerie	Rue Tolbiac X Rue Balley	33 827 43 03	Dakar	\N	\N	\N	f	\N
1167	Lipos Senegal	lipos-senegal	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.966	2026-03-02 23:11:12.966	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e	33 821 68 50	Dakar	\N	\N	\N	f	\N
1168	Gueye Computer	gueye-computer	Services Commerce	\N	2	2026-03-02 23:11:12.968	2026-03-02 23:11:12.968	Services Commerce	Rue 29 X Blaise Diagne	33 822 76 43	Dakar	\N	\N	\N	f	\N
1169	Mohamed Aly Younes	mohamed-aly-younes	Commerce De Vaisselle	\N	2	2026-03-02 23:11:12.97	2026-03-02 23:11:12.97	Commerce De Vaisselle	Rue Abdou Karim Bourgi	33 836 97 08	Dakar	\N	\N	\N	f	\N
1170	Pharmacie Ange De La Mosquee	pharmacie-ange-de-la-mosquee	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.971	2026-03-02 23:11:12.971	Vente De Produits Pharmaceutiques	Route De Front De Terre	33 822 83 04	Dakar	\N	\N	\N	f	\N
1171	Pharmacie M'Bao Concorde	pharmacie-m-bao-concorde	Vente De Produits Pharmaceutiques Medina Mbao Gare D akar 0 Dakar Yacine Production - Sarl Production Film Cinema Distribution	\N	2	2026-03-02 23:11:12.973	2026-03-02 23:11:12.973	Vente De Produits Pharmaceutiques Medina Mbao Gare D akar 0 Dakar Yacine Production - Sarl Production Film Cinema Distribution	Rue G X 9 Lauran t B - Point E 0 Dakar Promvet Sarl (Professionnel Du Medicament Et Du Materiel Veterinaire -Sarl) Vente De Produits Veterinaires Cite Mamelles Aviatio n	33 834 91 52	Dakar	\N	\N	\N	f	\N
1172	Societe D'Etudes Et D'Installations Industrielles - Sarl	societe-d-etudes-et-d-installations-industrielles-sarl	Commerce	\N	2	2026-03-02 23:11:12.975	2026-03-02 23:11:12.975	Commerce	Quartier Bagdad N° 39 Khar Yalla	33 860 25 00	Dakar	\N	\N	\N	f	\N
1173	Animalia	animalia	Production Commerce	\N	2	2026-03-02 23:11:12.976	2026-03-02 23:11:12.976	Production Commerce	Rue 25 X Corniche	33 867 65 86	Dakar	\N	\N	\N	f	\N
1174	Sics International (Societe D'Ingenieries De Constructions &	sics-international-societe-d-ingenieries-de-constructions	Services) Ingegnerie Et Commerce Point E 1	\N	2	2026-03-02 23:11:12.978	2026-03-02 23:11:12.978	Services) Ingegnerie Et Commerce Point E 1	Rue A X 2	77 026 79 09	Dakar	\N	\N	\N	f	\N
1175	Gie Sodic (Societe De	gie-sodic-societe-de	Distribution Pour L'Industrie Et Le Commerce) Vente De Materiels De Plomberie - Quinquaillerie	\N	2	2026-03-02 23:11:12.98	2026-03-02 23:11:12.98	Distribution Pour L'Industrie Et Le Commerce) Vente De Materiels De Plomberie - Quinquaillerie	Rue Fleurus X Escarfait	33 955 77 55	Dakar	\N	\N	\N	f	\N
1176	Rocsen Import Export Sarl	rocsen-import-export-sarl	Commerce De Marchandises Cite Soprim 0 Dakar M.B.I (Master Bureautique Informatique - Souaibou Lo) Commerce	\N	2	2026-03-02 23:11:12.982	2026-03-02 23:11:12.982	Commerce De Marchandises Cite Soprim 0 Dakar M.B.I (Master Bureautique Informatique - Souaibou Lo) Commerce	Rue 9 X Blaise Diagne Medina	33 821 03 37	Dakar	\N	\N	\N	f	\N
1177	Alliance Metal Sarl	alliance-metal-sarl	Commerce General	\N	2	2026-03-02 23:11:12.984	2026-03-02 23:11:12.984	Commerce General	Rue 3 X Bd De L'Est - Point E	33 832 74 30	Dakar	\N	\N	\N	f	\N
1178	Point Presse Participation	point-presse-participation	Vente De Marchandises	\N	2	2026-03-02 23:11:12.986	2026-03-02 23:11:12.986	Vente De Marchandises	Bd De La Gueule Tapee, Galerie Score Sham	33 864 47 44	Dakar	\N	\N	\N	f	\N
1179	Malick Diop	malick-diop	Commerce De Pieces Detachees	\N	2	2026-03-02 23:11:12.987	2026-03-02 23:11:12.987	Commerce De Pieces Detachees	Rue Marsat X Avenue Bla ise Diagne	33 877 60 94	Dakar	\N	\N	\N	f	\N
1180	Ets Modu Mbacke Marr Suarl	ets-modu-mbacke-marr-suarl	Commerce	\N	2	2026-03-02 23:11:12.989	2026-03-02 23:11:12.989	Commerce	Route De Rufisque Bcccd	77 644 94 02	Dakar	\N	\N	\N	f	\N
1181	Ocean Textile	ocean-textile	Commerce Parc A Mazout Colobane Dakar 0 Dakar Slf Suarl Commerce	\N	2	2026-03-02 23:11:12.991	2026-03-02 23:11:12.991	Commerce Parc A Mazout Colobane Dakar 0 Dakar Slf Suarl Commerce	Avenue Bourguiba Immeuble Abc Apt N° 34	33 832 24 75	Dakar	\N	\N	\N	f	\N
1182	Entreprise Activité Adresse Téléphone Dakar Thioune Informatique	entreprise-activite-adresse-telephone-dakar-thioune-informatique	Distribution Commerce	\N	2	2026-03-02 23:11:12.993	2026-03-02 23:11:12.993	Distribution Commerce	Rue 3 X Blaise Diagne	33 824 88 17	Ville	\N	\N	\N	f	\N
1183	W Adene D'Ouvrages & De	w-adene-d-ouvrages-de	Commerce Sarl	\N	2	2026-03-02 23:11:12.994	2026-03-02 23:11:12.994	Commerce Sarl	Immobilier-Commerce Nguehokh	33 823 21 42	Mbour	\N	\N	\N	f	\N
1184	Pharmacie Veterinaire Delta Agroveto	pharmacie-veterinaire-delta-agroveto	Services (Papa Ndene Diouf) Vente De Produits De Betails	\N	2	2026-03-02 23:11:12.996	2026-03-02 23:11:12.996	Services (Papa Ndene Diouf) Vente De Produits De Betails	Quartier Service Elevag e Sor 0 Dakar Condor (El Hadji Abdoulaye Niang) Commerce General Medina Rue 37 X 18	33 957 51 83	Saint-Louis	\N	\N	\N	f	\N
1185	Codis Sarl (Comptoir De	codis-sarl-comptoir-de	Distribution Sarl) Commerce	\N	2	2026-03-02 23:11:12.998	2026-03-02 23:11:12.998	Distribution Sarl) Commerce	Bccd 0 Dakar Ets Yakar Malick Diop (Etablissement Yakar Malick Diop - Malick Diop) Commerce General Route De Rufisque	77 609 91 97	Dakar	\N	\N	\N	f	\N
1186	Gie Dartex	gie-dartex	Commerce Textile	\N	2	2026-03-02 23:11:12.999	2026-03-02 23:11:12.999	Commerce Textile	Rue Emile Badiane	33 851 86 38	Dakar	\N	\N	\N	f	\N
1187	Pharmacie Maimouna Samb	pharmacie-maimouna-samb	Vente De Produits Pharmaceutiques Bargny Mboth En Fa ce	\N	2	2026-03-02 23:11:13.001	2026-03-02 23:11:13.001	Vente De Produits Pharmaceutiques Bargny Mboth En Fa ce	Route Nationale 1	33 966 25 67	Rufisque	\N	\N	\N	f	\N
1188	Gcs - Sarl (Global Computer Solutions)	gcs-sarl-global-computer-solutions	Commerce Et Services Informatiques	\N	2	2026-03-02 23:11:13.003	2026-03-02 23:11:13.003	Commerce Et Services Informatiques	Avenue Lamine Guéye A Cote De Touba Sandaga ( Ex Rue Tolbiac Prolongee X Avenue Faidherbe	33 873 16 51	Dakar	\N	\N	\N	f	\N
1189	Atlantic Import-Export	atlantic-import-export	Commerce	\N	2	2026-03-02 23:11:13.005	2026-03-02 23:11:13.005	Commerce	Bccd	33 878 60 90	Dakar	\N	\N	\N	f	\N
1190	Boubacar Ba	boubacar-ba-1	Commerce General Parcelles Assainies Unite 25 Villa N°395 0 Dakar Ets Fakih -	\N	2	2026-03-02 23:11:13.008	2026-03-02 23:11:13.008	Commerce General Parcelles Assainies Unite 25 Villa N°395 0 Dakar Ets Fakih -	Abdou Khafiz Fakih Autres Commerces - Armurerie Rue Joseph Gomis (Ex - Bayeux)	33 832 88 44	Dakar	\N	\N	\N	f	\N
1191	Fujito Africa Suarl	fujito-africa-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.01	2026-03-02 23:11:13.01	Vente De Produits Pharmaceutiques	Route De L'Aeropor t Derriere Axa	33 822 97 40	Dakar	\N	\N	\N	f	\N
1192	Bnd Trading - Sarl	bnd-trading-sarl	Commerce General	\N	2	2026-03-02 23:11:13.011	2026-03-02 23:11:13.011	Commerce General	Avenue Malick Sy - Central Park N° 3006 / A	33 868 12 13	Dakar	\N	\N	\N	f	\N
1193	Faline Sarl	faline-sarl	Commerce	\N	2	2026-03-02 23:11:13.013	2026-03-02 23:11:13.013	Commerce	Avenue Malick Sy X Autoroute	33 822 48 17	Dakar	\N	\N	\N	f	\N
1194	Pkl Senegal Suarl (Protein Kissee La Senegal - Succursale)	pkl-senegal-suarl-protein-kissee-la-senegal-succursale	Commerce General (Vente De Produits Infantiles) Cite Marguery	\N	2	2026-03-02 23:11:13.015	2026-03-02 23:11:13.015	Commerce General (Vente De Produits Infantiles) Cite Marguery	Rue D19	33 823 90 90	Dakar	\N	\N	\N	f	\N
1195	Diop Auto (Malick Diop)	diop-auto-malick-diop	Commerce De Pieces Detachees	\N	2	2026-03-02 23:11:13.016	2026-03-02 23:11:13.016	Commerce De Pieces Detachees	Rue Mangin X Avenue Bla ise Diagne	76 545 54 44	Dakar	\N	\N	\N	f	\N
1196	Yiw U Cea Sarl	yiw-u-cea-sarl	Commerce	\N	2	2026-03-02 23:11:13.018	2026-03-02 23:11:13.018	Commerce	Rue Non Denommee Ngaparou Mbour	33 823 75 95	Dakar	\N	\N	\N	f	\N
1197	Soprona Sarl	soprona-sarl	Commerce General	\N	2	2026-03-02 23:11:13.02	2026-03-02 23:11:13.02	Commerce General	Avenue President Lamine Gueye	33 832 94 90	Dakar	\N	\N	\N	f	\N
1198	Couronne Sural	couronne-sural	Commerce General	\N	2	2026-03-02 23:11:13.021	2026-03-02 23:11:13.021	Commerce General	Rue Mousse Diop	33 821 63 34	Dakar	\N	\N	\N	f	\N
1199	Ricardo Molina W Est Africa Suarl	ricardo-molina-w-est-africa-suarl	Vente De Produits Pharmaceutiques Domaine Industriel Sodida Lot N°12 0 Dakar Viatique Consultance Sarl Commerce	\N	2	2026-03-02 23:11:13.023	2026-03-02 23:11:13.023	Vente De Produits Pharmaceutiques Domaine Industriel Sodida Lot N°12 0 Dakar Viatique Consultance Sarl Commerce	Bd Du Sud Point E	77 640 04 62	Dakar	\N	\N	\N	f	\N
1200	Ibrahim Saleh Et Cie - Sa	ibrahim-saleh-et-cie-sa	Commerce Import Export Et Location	\N	2	2026-03-02 23:11:13.025	2026-03-02 23:11:13.025	Commerce Import Export Et Location	Immeuble Avenue G eorges Pompidou	33 824 40 44	Dakar	\N	\N	\N	f	\N
1201	Univers De L'Equipement (Mamadou Ndiaye)	univers-de-l-equipement-mamadou-ndiaye	Commerce De Materiels Informatiques	\N	2	2026-03-02 23:11:13.027	2026-03-02 23:11:13.027	Commerce De Materiels Informatiques	Rue 25 X 20 Medi na	33 827 27 78	Dakar	\N	\N	\N	f	\N
1202	Bernasol Sarl Importation Et	bernasol-sarl-importation-et	Vente Ngaparou Diamaguene	\N	2	2026-03-02 23:11:13.028	2026-03-02 23:11:13.028	Vente Ngaparou Diamaguene	Route De Sa ly	33 836 14 90	Mbour	\N	\N	\N	f	\N
1203	Sen Toll - Sarl	sen-toll-sarl	Commerce Materiels Agricole	\N	2	2026-03-02 23:11:13.03	2026-03-02 23:11:13.03	Commerce Materiels Agricole	Avenue Des Grds Hommes S or Ndioloffene	77 143 58 58	Saint-Louis	\N	\N	\N	f	\N
1204	Rls	rls	Distribution (Sayinta Rusen Levent) Commerce	\N	2	2026-03-02 23:11:13.032	2026-03-02 23:11:13.032	Distribution (Sayinta Rusen Levent) Commerce	Rue Raffenel	33 961 52 25	Dakar	\N	\N	\N	f	\N
1205	Abc (Ada Business Center)	abc-ada-business-center	Commerce (Bureautique - Librairie - Cadeaux D'Entreprise - Consommable Informatique)	\N	2	2026-03-02 23:11:13.034	2026-03-02 23:11:13.034	Commerce (Bureautique - Librairie - Cadeaux D'Entreprise - Consommable Informatique)	Rue Carnot X Mohamed V	77 813 84 81	Dakar	\N	\N	\N	f	\N
1206	Pharmacie Mariama Mbacke	pharmacie-mariama-mbacke	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.035	2026-03-02 23:11:13.035	Vente De Produits Pharmaceutiques	Quartier Usine Ben e Tally	77 437 71 17	Dakar	\N	\N	\N	f	\N
1207	W Ater Coo Sarl	w-ater-coo-sarl	Commerce	\N	2	2026-03-02 23:11:13.038	2026-03-02 23:11:13.038	Commerce	Rue El Hadji Malick Sy Mbour 0 Dakar Ngalanka Suarl Commerce De Gros Marchandises Diverses Sodida Lot 42 Zone Industrielle	77 557 89 05	Mbour	\N	\N	\N	f	\N
1208	Papeterie Soleil Sarl	papeterie-soleil-sarl	Commerce Papeterie	\N	2	2026-03-02 23:11:13.04	2026-03-02 23:11:13.04	Commerce Papeterie	Bd De La Republique	33 825 89 12	Dakar	\N	\N	\N	f	\N
1209	Distribat Suarl	distribat-suarl	Commerce	\N	2	2026-03-02 23:11:13.041	2026-03-02 23:11:13.041	Commerce	Route Des Brasseries Proximite Bccd	33 842 65 80	Dakar	\N	\N	\N	f	\N
1210	Ets Oumar Dia	ets-oumar-dia	Commerce	\N	2	2026-03-02 23:11:13.043	2026-03-02 23:11:13.043	Commerce	Route De Rufisque	70 979 98 98	Pikine	\N	\N	\N	f	\N
1211	Top Mountain Sarl Commercialisaton Et	top-mountain-sarl-commercialisaton-et	Distribution De Produits Agricoles	\N	2	2026-03-02 23:11:13.045	2026-03-02 23:11:13.045	Distribution De Produits Agricoles	Route De Rufisque	77 650 02 21	Dakar	\N	\N	\N	f	\N
1212	Pharmacie Sainte Anne Saly	pharmacie-sainte-anne-saly	Vente De Produits Pharmaceutiques Saly	\N	2	2026-03-02 23:11:13.048	2026-03-02 23:11:13.048	Vente De Produits Pharmaceutiques Saly	Route Nationa le 1 33957 08 08 Pikine Pharmacie Environnementale De Zac Mbao (Dr Elimane Ibrahima Kane) Vente De Produits Pharmaceutiques Zac Mbao	33 832 88 16	Mbour	\N	\N	\N	f	\N
1213	Touba Sante Neant	touba-sante-neant	Commerce General Sicap Liberte 1 0 Dakar Pharmacie Saint Pierre (Raymond Pierre Dieme ) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.05	2026-03-02 23:11:13.05	Commerce General Sicap Liberte 1 0 Dakar Pharmacie Saint Pierre (Raymond Pierre Dieme ) Vente De Produits Pharmaceutiques	Rue 10 Prolongee X 12 Face College S.C N° 5 Sacre C œur 0 Dakar Gie Froid Climatisation - Gfc Commerce General 108,Rue 21 X 28 Medina	33 854 44 04	Dakar	\N	\N	\N	f	\N
1214	B.I.R.S (Bureautique Informatique Reseaux Et	b-i-r-s-bureautique-informatique-reseaux-et	Services) Commerce General En Informatique	\N	2	2026-03-02 23:11:13.051	2026-03-02 23:11:13.051	Services) Commerce General En Informatique	Route De L'Aeroport Yoff Tonghor	30 102 49 01	Dakar	\N	\N	\N	f	\N
1215	Afric Droguerie - Raef Hassan Halaoui	afric-droguerie-raef-hassan-halaoui	Commerce General - Droguerie	\N	2	2026-03-02 23:11:13.053	2026-03-02 23:11:13.053	Commerce General - Droguerie	Rue Ramez Bourgi (Ex - Essarts)	33 820 67 97	Dakar	\N	\N	\N	f	\N
1216	Palen'S	palen-s	Vente De Chaussure	\N	2	2026-03-02 23:11:13.055	2026-03-02 23:11:13.055	Vente De Chaussure	Avenue Bourguiba X Rue 13	77 637 56 88	Dakar	\N	\N	\N	f	\N
1217	Infoteck	infoteck	Commerce General	\N	2	2026-03-02 23:11:13.107	2026-03-02 23:11:13.107	Commerce General	Route De Rufisque, Diamaguene 0 Mbour Gie Borom Daradji Commerce General Mbour Route Nationale 0 Dakar Aminata Ba Services Commerce Et Services Sacre Cœur 3 0 Dakar Societe Civile Immobiliere El Hadji Doudou Basse Viabilisation Et Vente De Terrains Medina Rue 11 X 1 2	33 824 59 05	Pikine	\N	\N	\N	f	\N
1218	Marema Sarl	marema-sarl	Commerce General	\N	2	2026-03-02 23:11:13.11	2026-03-02 23:11:13.11	Commerce General	Avenue Georges Pompidou - Immeuble Sokhna Anta 9Eme Etage N°93	33 827 28 12	Dakar	\N	\N	\N	f	\N
1219	Ets Diop & Freres Sarl	ets-diop-freres-sarl	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:13.112	2026-03-02 23:11:13.112	Commerce De Produits Alimentaires	Rue Graland	77 637 79 59	Dakar	\N	\N	\N	f	\N
1220	Tbd Sarl (Touba Bazar	tbd-sarl-touba-bazar	Distribution) Vente De Produits Cosmetiques	\N	2	2026-03-02 23:11:13.113	2026-03-02 23:11:13.113	Distribution) Vente De Produits Cosmetiques	Avenue Lamine Gueye Cc ts Extension N°2619	33 961 84 99	Dakar	\N	\N	\N	f	\N
1221	Aye Pharmacie Yaye Maimouna Diallo (Aminata Marone)	aye-pharmacie-yaye-maimouna-diallo-aminata-marone	Vente De Produits Pharmaceutiques Fith Mith Guediaw Aye 0 Dakar Promodis Sarl Commerce	\N	2	2026-03-02 23:11:13.115	2026-03-02 23:11:13.115	Vente De Produits Pharmaceutiques Fith Mith Guediaw Aye 0 Dakar Promodis Sarl Commerce	Rue Ramez Bourgi Place Kermel	33 822 64 73	Guediaw	\N	\N	\N	f	\N
1222	Au Grenier D'Afrique Suarl	au-grenier-d-afrique-suarl	Commerce Saly Portudal / Mbour 0 Guediaw Aye Pharmacie Maria (Dr Therese Marie Ndong) Vente De Produits Pharmaceutiques Station 10 Golf Su d 0 Dakar Tiw A (Technologies & Industries In W Est Africa) - Sarl Commerce De Quincaillerie	\N	2	2026-03-02 23:11:13.117	2026-03-02 23:11:13.117	Commerce Saly Portudal / Mbour 0 Guediaw Aye Pharmacie Maria (Dr Therese Marie Ndong) Vente De Produits Pharmaceutiques Station 10 Golf Su d 0 Dakar Tiw A (Technologies & Industries In W Est Africa) - Sarl Commerce De Quincaillerie	Boulevard De L'Est - Point E	77 515 25 41	Mbour	\N	\N	\N	f	\N
1223	Menda	menda	Services (Peinda Samb) Commerce General Sicap Liberte 6 0 Dakar Les Floralies Sarl Vente De Fleurs	\N	2	2026-03-02 23:11:13.119	2026-03-02 23:11:13.119	Services (Peinda Samb) Commerce General Sicap Liberte 6 0 Dakar Les Floralies Sarl Vente De Fleurs	Rue Ramez Bourgi	33 825 39 36	Dakar	\N	\N	\N	f	\N
1224	Ets Sakelson (Abdalah Sakheli)	ets-sakelson-abdalah-sakheli	Commerce General	\N	2	2026-03-02 23:11:13.12	2026-03-02 23:11:13.12	Commerce General	Boulevard General Degaulle	33 963 46 46	Dakar	\N	\N	\N	f	\N
1225	Bathie Dit Masse Gueye	bathie-dit-masse-gueye	Commerce General	\N	2	2026-03-02 23:11:13.122	2026-03-02 23:11:13.122	Commerce General	Avenue Lamine Gueye	77 115 42 33	Dakar	\N	\N	\N	f	\N
1226	Sahel Multi	sahel-multi	Services Commerce	\N	2	2026-03-02 23:11:13.126	2026-03-02 23:11:13.126	Services Commerce	Rue 37 X 22 Medina	77 638 53 96	Dakar	\N	\N	\N	f	\N
1227	T And Partners (Thie Gueye)	t-and-partners-thie-gueye	Commerce General	\N	2	2026-03-02 23:11:13.128	2026-03-02 23:11:13.128	Commerce General	Avenue Caen Randoulene Nord Thies 0 Saint-Louis Etablissements Mor Loucoubar Commerce General Avenue General Degaulle Sor	33 823 26 39	Thies	\N	\N	\N	f	\N
1228	Omega (Samy Hannouche	omega-samy-hannouche	Commerce Articles-Jouets Enfants	\N	2	2026-03-02 23:11:13.129	2026-03-02 23:11:13.129	Commerce Articles-Jouets Enfants	Rue Carnot 77 3382030 Rufisque Pharmacie Saint Joseph (Dr Anna Code Dione) Vente De Produits Pharmaceutiques Cite Serigne Manso ur	33 961 41 89	Dakar	\N	\N	\N	f	\N
1229	Hadi Chaito"Electroplus"	hadi-chaito-electroplus	Vente De Produits Electronics	\N	2	2026-03-02 23:11:13.131	2026-03-02 23:11:13.131	Vente De Produits Electronics	Avenue Blaise Diagne	33 865 65 85	Dakar	\N	\N	\N	f	\N
1230	Ibrahima Hadi	ibrahima-hadi	Commerce Materiel Electronique	\N	2	2026-03-02 23:11:13.133	2026-03-02 23:11:13.133	Commerce Materiel Electronique	Rue Galandou Diouf	77 450 49 36	Dakar	\N	\N	\N	f	\N
1231	Ousmane Fall	ousmane-fall	Commerce	\N	2	2026-03-02 23:11:13.134	2026-03-02 23:11:13.134	Commerce	Rue Faidherbe X Adama Lo Rufisque 0 Dakar Proactive Sarl Autre Commerce Avenue Georges Pompidou	77 986 88 06	Rufisque	\N	\N	\N	f	\N
1232	Aye Pharmacie Nabinka O Ptaka	aye-pharmacie-nabinka-o-ptaka	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.136	2026-03-02 23:11:13.136	Vente De Produits Pharmaceutiques	Quartier Samba Dia	30 105 60 09	Guediaw	\N	\N	\N	f	\N
1233	Success & Beaute Suarl	success-beaute-suarl	Commerce General	\N	2	2026-03-02 23:11:13.139	2026-03-02 23:11:13.139	Commerce General	Rue Ramez Bourgi 0 Mbour Equip Froid Somone Suarl Commerce De Gros De Biens De Consommation Non Alimentaires Somone	33 827 63 93	Dakar	\N	\N	\N	f	\N
1234	Malick Diaham	malick-diaham	Vente Et Services Informatique	\N	2	2026-03-02 23:11:13.141	2026-03-02 23:11:13.141	Vente Et Services Informatique	Rue 33 X 16 Medina 0 Dakar Cpad Commerce General Rue Raffenel X Galandou Diouf	33 864 43 30	Dakar	\N	\N	\N	f	\N
1235	Sogicof Sarl (Societe Generale D'Immobilier De Cons truction Et De Fourniture)	sogicof-sarl-societe-generale-d-immobilier-de-cons-truction-et-de-fourniture	Commerce Saly Carrefour 0 Dakar Ets Ya Salam (Adama Diallo) Commerce	\N	2	2026-03-02 23:11:13.143	2026-03-02 23:11:13.143	Commerce Saly Carrefour 0 Dakar Ets Ya Salam (Adama Diallo) Commerce	Rue 35 X 22 Medina 0 Dakar Bomthi Sports Vente De Materiels De Cycles Avenue Peytavin	33 821 62 70	Mbour	\N	\N	\N	f	\N
1236	Les Professionnels Du Meubles	les-professionnels-du-meubles	Vente De Meubles Liberte 6 Ext Lot 34 0 Ville Entreprise Activité Adresse Téléphone Podor Pharmacie Cheikh Oumar Foutiyou Tall(Alpha	\N	2	2026-03-02 23:11:13.146	2026-03-02 23:11:13.146	Vente De Meubles Liberte 6 Ext Lot 34 0 Ville Entreprise Activité Adresse Téléphone Podor Pharmacie Cheikh Oumar Foutiyou Tall(Alpha	Abdoul B a) Vente De Produits Pharmaceutiques Galoya 0 Dakar Arcadia - Suarl Vente De Produits Divers Rue Raffenel 0 Dakar Socotib Sarl (Societe De Commerce Industrie Et Batiment) Construction & Commerce Khar Yalla Villa N° 70	33 822 55 67	Dakar	\N	\N	\N	f	\N
1237	Saicom Suarl	saicom-suarl	Commerce General	\N	2	2026-03-02 23:11:13.147	2026-03-02 23:11:13.147	Commerce General	Boulevard De L'Est X Rue Point E	33 860 29 15	Dakar	\N	\N	\N	f	\N
1238	Mouhamadou Bouya Diallo	mouhamadou-bouya-diallo	Commerce General Medina	\N	2	2026-03-02 23:11:13.149	2026-03-02 23:11:13.149	Commerce General Medina	Rue 29 X 24	33 824 60 05	Dakar	\N	\N	\N	f	\N
1239	Touba Diesel	touba-diesel	Commerce Accessoires Automobile (60,58%), Services Annexes Et Auxilliaires De Transport (39,42%)	\N	2	2026-03-02 23:11:13.151	2026-03-02 23:11:13.151	Commerce Accessoires Automobile (60,58%), Services Annexes Et Auxilliaires De Transport (39,42%)	Bccd	33 823 25 47	Pikine	\N	\N	\N	f	\N
1240	Pharmacie Fanaye(Docteur Sidy Deme)	pharmacie-fanaye-docteur-sidy-deme	Vente De Produits Pharmaceutiques Village De Fanaye 0 Pikine Mac (Machine De Construction Et Equipement) Commerce General - Import Export	\N	2	2026-03-02 23:11:13.153	2026-03-02 23:11:13.153	Vente De Produits Pharmaceutiques Village De Fanaye 0 Pikine Mac (Machine De Construction Et Equipement) Commerce General - Import Export	Route De Rufisque	33 860 18 36	Podor	\N	\N	\N	f	\N
1241	Ezimpex (Ex - Codimex Depuis 1998)	ezimpex-ex-codimex-depuis-1998	Commerce - Import/Export	\N	2	2026-03-02 23:11:13.154	2026-03-02 23:11:13.154	Commerce - Import/Export	Rue Galandou Diouf	77 552 97 30	Dakar	\N	\N	\N	f	\N
1242	Quincaillerie Darou Salam (Khadim Diop)	quincaillerie-darou-salam-khadim-diop	Commerce General Saly Carrefour 0 Dakar Pharmacie Seydi Djamil (Seynabou Sow Dia) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.156	2026-03-02 23:11:13.156	Commerce General Saly Carrefour 0 Dakar Pharmacie Seydi Djamil (Seynabou Sow Dia) Vente De Produits Pharmaceutiques	Rue 22 Bis Fass De lorme N° 9456	33 822 34 19	Mbour	\N	\N	\N	f	\N
1243	Amirak Sarl Achat ,	amirak-sarl-achat	Ventes, Location	\N	2	2026-03-02 23:11:13.158	2026-03-02 23:11:13.158	Ventes, Location	D'Immeuble Lot 6 Mermoz Ext ension	33 827 33 02	Dakar	\N	\N	\N	f	\N
1244	Tiger Photo (Ex - Tiger Industries)	tiger-photo-ex-tiger-industries	Production Photo - Commerce	\N	2	2026-03-02 23:11:13.16	2026-03-02 23:11:13.16	Production Photo - Commerce	Avenue Georges Pompidou	33 825 75 60	Dakar	\N	\N	\N	f	\N
1245	Pharmacie De L'Etrier (Mohamed Ayach)	pharmacie-de-l-etrier-mohamed-ayach	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.162	2026-03-02 23:11:13.162	Vente De Produits Pharmaceutiques	Bccd	33 822 76 26	Dakar	\N	\N	\N	f	\N
1246	Pharmacie Mobbo	pharmacie-mobbo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.164	2026-03-02 23:11:13.164	Vente De Produits Pharmaceutiques	Bayakh,Route De Mb oro	33 842 81 28	Thies	\N	\N	\N	f	\N
1247	Universal Business (Momat Gaye)	universal-business-momat-gaye	Commerce Papeterie	\N	2	2026-03-02 23:11:13.166	2026-03-02 23:11:13.166	Commerce Papeterie	Rue 19 X Blaise Diagne 0 Dakar Solutrad Sarl Vente De Materiels Informatiques Sicap Sacre Cœur 3 Extension	33 836 09 00	Dakar	\N	\N	\N	f	\N
1248	Nortech Senegal Sarl	nortech-senegal-sarl	Commerce- Services Aux Entreprises Ets Brachet	\N	2	2026-03-02 23:11:13.168	2026-03-02 23:11:13.168	Commerce- Services Aux Entreprises Ets Brachet	Rue D ial Diop X Av Faidherbe	33 860 68 00	Dakar	\N	\N	\N	f	\N
1249	Sii Sarl (Soluciones Industriales Internacionales S arl)	sii-sarl-soluciones-industriales-internacionales-s-arl	Commerce Cite Sipress, N°203 -Cap Des Biches 0 Dakar Pharmacie Serigne Mbaye Sy Mansour Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.17	2026-03-02 23:11:13.17	Commerce Cite Sipress, N°203 -Cap Des Biches 0 Dakar Pharmacie Serigne Mbaye Sy Mansour Vente De Produits Pharmaceutiques	Rue 33 X30 Medina	33 821 12 95	Rufisque	\N	\N	\N	f	\N
1250	a Senagro Jullam Afia Transformation Laitiere Et	a-senagro-jullam-afia-transformation-laitiere-et	Distribution De Produits Alimentaires Lot 247	\N	2	2026-03-02 23:11:13.172	2026-03-02 23:11:13.172	Distribution De Produits Alimentaires Lot 247	Quartier Salikenie Tambacounda	33 864 30 06	Tambacound	\N	\N	\N	f	\N
1251	a Bassirou Dieng	a-bassirou-dieng	Commerce Kedegou	\N	2	2026-03-02 23:11:13.174	2026-03-02 23:11:13.174	Commerce Kedegou	Quartier Dinguess 775313110 Dakar Pharmacie Golf Sud - Iba Der Gueye Vente De Produits Pharmaceutiques Cite Hamo 1 - Golf Sud	33 981 50 50	Tambacound	\N	\N	\N	f	\N
1252	Djoloff Etablissements (Ousmane Niang)	djoloff-etablissements-ousmane-niang	Commerce Fass Paillotte	\N	2	2026-03-02 23:11:13.175	2026-03-02 23:11:13.175	Commerce Fass Paillotte	Immeuble Galass 65 - Magasin D	33 837 05 68	Dakar	\N	\N	\N	f	\N
1253	Pharmacie Sokhna Aw A W Arore (Dr Nguirane Ndiaye)	pharmacie-sokhna-aw-a-w-arore-dr-nguirane-ndiaye	Vente De Produits Pharmaceutiques Hlm Lot N° 08 Oref onde 0 Dakar Cheikh Ahmed Tidiane Mboji "Global Computer" Commerce General	\N	2	2026-03-02 23:11:13.177	2026-03-02 23:11:13.177	Vente De Produits Pharmaceutiques Hlm Lot N° 08 Oref onde 0 Dakar Cheikh Ahmed Tidiane Mboji "Global Computer" Commerce General	Avenue Lamine Gueye	77 651 58 17	Dakar	\N	\N	\N	f	\N
1254	Groël Senegal Suarl	groel-senegal-suarl	Commerce General	\N	2	2026-03-02 23:11:13.179	2026-03-02 23:11:13.179	Commerce General	Rue Mbaye Gueye	33 821 71 84	Dakar	\N	\N	\N	f	\N
1255	Bag - Sarl (Bureautique Et Arts Graphiques)	bag-sarl-bureautique-et-arts-graphiques	Vente Et Maintenance Materiels Bureautiques	\N	2	2026-03-02 23:11:13.18	2026-03-02 23:11:13.18	Vente Et Maintenance Materiels Bureautiques	Rue Vinc ens	77 638 96 67	Dakar	\N	\N	\N	f	\N
1256	Pharmacie Esthetis (Coumba Diodio Ndong)	pharmacie-esthetis-coumba-diodio-ndong	Vente De Produits Pharmaceutiques Nema Extension Zig uinchor 0 Fatick Lat Grand Ndiaye Commerce General	\N	2	2026-03-02 23:11:13.182	2026-03-02 23:11:13.182	Vente De Produits Pharmaceutiques Nema Extension Zig uinchor 0 Fatick Lat Grand Ndiaye Commerce General	Quartier Peulga Fatick 0 Pikine El Hadj Abdoulaye Ndiour Thiam Commerce Pikine Tally Boubess Plle N° 4618	77 640 66 70	Ziguinchor	\N	\N	\N	f	\N
1257	W Akeur Khadim Rassoul Malick Dieng	w-akeur-khadim-rassoul-malick-dieng	Commerce Divers	\N	2	2026-03-02 23:11:13.184	2026-03-02 23:11:13.184	Commerce Divers	Rue 13 X 22 Medina	33 867 15 49	Dakar	\N	\N	\N	f	\N
1258	Etoile	etoile	Distribution Modou Toure Vente De Plomberie Et Sanitaire	\N	1	2026-03-02 23:11:13.187	2026-03-02 23:11:13.187	Distribution Modou Toure Vente De Plomberie Et Sanitaire	Rue Fleurus 0 Dakar Demba Kane Commerce Avenue Du Senegal	70 519 19 19	Dakar	\N	\N	\N	f	\N
1259	Ndiaga Mbaye	ndiaga-mbaye	Commerce General	\N	2	2026-03-02 23:11:13.189	2026-03-02 23:11:13.189	Commerce General	Avenue Lamine Gueye	33 821 32 53	Dakar	\N	\N	\N	f	\N
1260	Digital Electronic Sarl	digital-electronic-sarl	Commerce Machine Materiel Et Autre Outillage En Main	\N	2	2026-03-02 23:11:13.191	2026-03-02 23:11:13.191	Commerce Machine Materiel Et Autre Outillage En Main	Route De Rufisque, Diamaguene	33 864 56 54	Dakar	\N	\N	\N	f	\N
1261	Dogado Africa Sarl	dogado-africa-sarl	Commerce	\N	2	2026-03-02 23:11:13.193	2026-03-02 23:11:13.193	Commerce	Avenue Peytavin	33 834 16 96	Dakar	\N	\N	\N	f	\N
1262	Ndiaye Pneus Scs-Egbtp	ndiaye-pneus-scs-egbtp	Commerce Et Prestation De Service	\N	2	2026-03-02 23:11:13.194	2026-03-02 23:11:13.194	Commerce Et Prestation De Service	Rue 7 X Corniche 0 Dakar Ndao Maymouna - Etablissement Technisys Commerce General Sicap Amitie 1 N° 2993 0 Dakar Societe Civile Immobiliere Venezia Immobilier Achat Vente Et Location Immeuble Saphir M ermoz Route De Ouakam	33 864 09 81	Dakar	\N	\N	\N	f	\N
1263	Mmbc - Sarl (Marketing Management & Business Consultancy - Sarl)	mmbc-sarl-marketing-management-business-consultancy-sarl	Commerce General Hann Plage	\N	2	2026-03-02 23:11:13.196	2026-03-02 23:11:13.196	Commerce General Hann Plage	Route Du Cvd	33 825 22 80	Dakar	\N	\N	\N	f	\N
1264	Pharmacie Mouhamadou El Hamid( Kadidiatou Djigo)	pharmacie-mouhamadou-el-hamid-kadidiatou-djigo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.198	2026-03-02 23:11:13.198	Vente De Produits Pharmaceutiques	Route De Meridien Almadies 0 Dakar Atlantic Computing Sarl Commerce Divers Sacre Cœur 3 Immeuble Sokhna Astou L o	33 832 15 48	Dakar	\N	\N	\N	f	\N
1265	Benu Surl	benu-surl	Distribution De Meubles Et De Mobiliers Domestiques Ou Bureaux	\N	2	2026-03-02 23:11:13.199	2026-03-02 23:11:13.199	Distribution De Meubles Et De Mobiliers Domestiques Ou Bureaux	Avenue Lamine Gueye	33 825 72 20	Dakar	\N	\N	\N	f	\N
1266	Visuel Com Plus	visuel-com-plus	Vente D'Objets Publicitaires - Travaux De Serigraphie	\N	2	2026-03-02 23:11:13.201	2026-03-02 23:11:13.201	Vente D'Objets Publicitaires - Travaux De Serigraphie	Avenue Birago Diop Villa N° 13 Point E	33 867 41 45	Dakar	\N	\N	\N	f	\N
1267	Etoile Bureautique	etoile-bureautique	Vente De Fourniture De Bureau Et Materiel Informatique	\N	1	2026-03-02 23:11:13.203	2026-03-02 23:11:13.203	Vente De Fourniture De Bureau Et Materiel Informatique	Immeuble 2F Rond Point Jet D'Eau	33 827 92 92	Dakar	\N	\N	\N	f	\N
1268	Turbotec Plus Sarl	turbotec-plus-sarl	Vente Et Reparation De Turbocompresseur	\N	2	2026-03-02 23:11:13.204	2026-03-02 23:11:13.204	Vente Et Reparation De Turbocompresseur	Route De Rufisque - Thiaroye/Mer En Face Hotel Chez Charly	33 824 37 19	Dakar	\N	\N	\N	f	\N
1269	La Luciole (Marieme Ouattara)	la-luciole-marieme-ouattara	Commerce	\N	2	2026-03-02 23:11:13.206	2026-03-02 23:11:13.206	Commerce	Rue Parent	33 834 42 92	Dakar	\N	\N	\N	f	\N
1270	Ruy Xalel - Sa	ruy-xalel-sa	Fabrication Distribution Autres Produits Alimentaire	\N	2	2026-03-02 23:11:13.208	2026-03-02 23:11:13.208	Fabrication Distribution Autres Produits Alimentaire	Rue Felix Eboue	77 647 85 07	Dakar	\N	\N	\N	f	\N
1271	Abdul Haq Qureshi	abdul-haq-qureshi	Commerce	\N	2	2026-03-02 23:11:13.209	2026-03-02 23:11:13.209	Commerce	Avenue Lamine Gueye	33 821 72 00	Dakar	\N	\N	\N	f	\N
1272	Tapisol (Khalil Chirazi)	tapisol-khalil-chirazi	Commerce	\N	2	2026-03-02 23:11:13.211	2026-03-02 23:11:13.211	Commerce	Avenue Lamine Gueye	33 842 73 86	Dakar	\N	\N	\N	f	\N
1273	Abibou Fall	abibou-fall	Commerce General	\N	2	2026-03-02 23:11:13.213	2026-03-02 23:11:13.213	Commerce General	Rue Medeleine Ngom	33 823 34 68	Dakar	\N	\N	\N	f	\N
1274	Monsieur Mohamed Lahlou	monsieur-mohamed-lahlou	Commerce General	\N	2	2026-03-02 23:11:13.215	2026-03-02 23:11:13.215	Commerce General	Rue De Thiong Et Ave Lamine Gueye	33 824 71 39	Dakar	\N	\N	\N	f	\N
1275	Compagnie Agricole De	compagnie-agricole-de	Distributions Et De Services Vente De Produits Agricols Et Intants Usine Ben Tall y Villa N° 2896 0 Dakar Mohamed Yaddas Commerce	\N	2	2026-03-02 23:11:13.217	2026-03-02 23:11:13.217	Distributions Et De Services Vente De Produits Agricols Et Intants Usine Ben Tall y Villa N° 2896 0 Dakar Mohamed Yaddas Commerce	Rue 13 X Blaise Diagne	33 821 65 30	Dakar	\N	\N	\N	f	\N
1276	Touba Mondial Lectronique Sarl	touba-mondial-lectronique-sarl	Commerce De Produits Cosmetiques	\N	2	2026-03-02 23:11:13.219	2026-03-02 23:11:13.219	Commerce De Produits Cosmetiques	Avenue G. Pompidou	33 837 02 84	Dakar	\N	\N	\N	f	\N
1277	Eurographe	eurographe	Distribution	\N	2	2026-03-02 23:11:13.22	2026-03-02 23:11:13.22	Distribution	(Abdoulaye Fall Diop) Imprimerie - Commerce Hann Maristes Espace Residence Imm. Move Magasin	33 821 72 67	Dakar	\N	\N	\N	f	\N
1278	Copie 2000 - Alain Devallois Plexographe -	copie-2000-alain-devallois-plexographe	Fabrication Et Vente De Tampons - Autres Commerce	\N	2	2026-03-02 23:11:13.223	2026-03-02 23:11:13.223	Fabrication Et Vente De Tampons - Autres Commerce	Rue De Thann	77 342 65 10	Dakar	\N	\N	\N	f	\N
1279	General Vet	general-vet	Distribution De Produits Et Nitritions Animales Et Veterinaires Ngor Almadies	\N	2	2026-03-02 23:11:13.224	2026-03-02 23:11:13.224	Distribution De Produits Et Nitritions Animales Et Veterinaires Ngor Almadies	Immeuble Les Alyzes 0 Dakar Farouh Houdrouge Vente De Prêt A Porter Avenue Georges Pompidou Dakar	33 821 09 99	Dakar	\N	\N	\N	f	\N
1280	Distri Leads Africa Sarl	distri-leads-africa-sarl	Commerce General Central Park 133	\N	2	2026-03-02 23:11:13.226	2026-03-02 23:11:13.226	Commerce General Central Park 133	Avenue Malick Sy X Autoroute 776393423 Dakar Leybar Suarl Commerce General Parcelles Assainies U 8 N°440	33 821 74 69	Dakar	\N	\N	\N	f	\N
1281	Pharmacie Logo ( Dr Amady Sissokho	pharmacie-logo-dr-amady-sissokho	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.228	2026-03-02 23:11:13.228	Vente De Produits Pharmaceutiques	Quartier Kaw Sara - Keur Massar	33 835 61 62	Pikine	\N	\N	\N	f	\N
1282	Dabakh Monde Mobilier Et Commidities - D2Mc	dabakh-monde-mobilier-et-commidities-d2mc	Commerce	\N	2	2026-03-02 23:11:13.23	2026-03-02 23:11:13.23	Commerce	Avenue Faidherbe	77 637 76 95	Dakar	\N	\N	\N	f	\N
1283	Amy Boutique	amy-boutique	Commerce General	\N	2	2026-03-02 23:11:13.232	2026-03-02 23:11:13.232	Commerce General	Avenue Georges Pompidou	33 849 69 34	Dakar	\N	\N	\N	f	\N
1284	Ets Jamal W Ayzani	ets-jamal-w-ayzani	Commerce	\N	2	2026-03-02 23:11:13.234	2026-03-02 23:11:13.234	Commerce	Rue Galandou Diouf	33 823 42 69	Dakar	\N	\N	\N	f	\N
1285	Dune Cosmetiques (Hala Sayegh)	dune-cosmetiques-hala-sayegh	Commerce	\N	2	2026-03-02 23:11:13.236	2026-03-02 23:11:13.236	Commerce	Rue Jules Ferry X Bayeux	33 832 21 65	Dakar	\N	\N	\N	f	\N
1286	Elektron Senegal - Sahide Gaye	elektron-senegal-sahide-gaye	Commerce	\N	2	2026-03-02 23:11:13.238	2026-03-02 23:11:13.238	Commerce	Rue Dodds X Avenue Lamine Gueye 33823 53 80 Dakar Secobat (Services Commerce Et Batiments) Sarl Commerce General Et Construction Sacre Cœur I-Cote C ollege Sacre Cœur	77 644 36 21	Dakar	\N	\N	\N	f	\N
1287	Pharmacie Dianatoul Mahw A	pharmacie-dianatoul-mahw-a	Vente De Produits Pharmaceutiques Dianatoul Mahw A T ouba 702047731 Dakar Gie Informatique Global Système Vente De Materiel Informatique Et Mobilier De Bureau	\N	2	2026-03-02 23:11:13.239	2026-03-02 23:11:13.239	Vente De Produits Pharmaceutiques Dianatoul Mahw A T ouba 702047731 Dakar Gie Informatique Global Système Vente De Materiel Informatique Et Mobilier De Bureau	Rue Abdou Karim Bourgi Dakar	77 644 86 72	Mbacke	\N	\N	\N	f	\N
1288	Diminga Mendy	diminga-mendy	Commerce	\N	2	2026-03-02 23:11:13.241	2026-03-02 23:11:13.241	Commerce	Rue Dial Diop X Reims	33 842 67 37	Dakar	\N	\N	\N	f	\N
1289	Touba Seven Diesel (Mor Beye)	touba-seven-diesel-mor-beye	Vente De Pompes Et Pieces Injection	\N	2	2026-03-02 23:11:13.243	2026-03-02 23:11:13.243	Vente De Pompes Et Pieces Injection	Avenue Cheikh Ah madou Bamba Hlm 1	33 832 91 09	Dakar	\N	\N	\N	f	\N
1290	Kassem El Hussein (Quincaillerie De L'Yser)	kassem-el-hussein-quincaillerie-de-l-yser	Commerce De Quincaillerie	\N	2	2026-03-02 23:11:13.245	2026-03-02 23:11:13.245	Commerce De Quincaillerie	Rue De L'Yser	33 824 53 03	Dakar	\N	\N	\N	f	\N
1291	Pharmacie Mouhamed	pharmacie-mouhamed	Vente De Produits Pharmaceutiques Place Village Gorom 1	\N	2	2026-03-02 23:11:13.247	2026-03-02 23:11:13.247	Vente De Produits Pharmaceutiques Place Village Gorom 1	Quartier Garage Rufisque	33 821 22 39	Rufisque	\N	\N	\N	f	\N
1292	Redat Senegal Sarl	redat-senegal-sarl	Vente Et Reparation De Turbocompresseurs	\N	2	2026-03-02 23:11:13.249	2026-03-02 23:11:13.249	Vente Et Reparation De Turbocompresseurs	Route De Ru fisque Face Chez Charli	33 836 03 63	Pikine	\N	\N	\N	f	\N
1293	Gdci (Generale De	gdci-generale-de	Distribution Pour Le Commerce Et L'Industrie) Commerce Quincaillerie Liberte 3	\N	2	2026-03-02 23:11:13.25	2026-03-02 23:11:13.25	Distribution Pour Le Commerce Et L'Industrie) Commerce Quincaillerie Liberte 3	Immeuble A3 - Rond Point Jet D'Eau	33 827 13 98	Dakar	\N	\N	\N	f	\N
1294	La Maison Du Meuble	la-maison-du-meuble	Commerce	\N	2	2026-03-02 23:11:13.252	2026-03-02 23:11:13.252	Commerce	Rue Mousse Diop (Ex - Blanchot)	33 821 69 70	Dakar	\N	\N	\N	f	\N
1295	Cfs (Compagnie Forestiere Du Senegal)	cfs-compagnie-forestiere-du-senegal	Fabrication Et Commerce De Poteaux	\N	2	2026-03-02 23:11:13.253	2026-03-02 23:11:13.253	Fabrication Et Commerce De Poteaux	Avenue Felix Ebou e Boulevard Maritime	33 822 57 74	Dakar	\N	\N	\N	f	\N
1296	Pharmacie Guelw Ar	pharmacie-guelw-ar	Vente De Produits Pharmaceutiques Ndiakhirate	\N	2	2026-03-02 23:11:13.255	2026-03-02 23:11:13.255	Vente De Produits Pharmaceutiques Ndiakhirate	Route De Sangalkam	33 820 27 26	Rufisque	\N	\N	\N	f	\N
1297	Pc Trade Sarl	pc-trade-sarl	Vente De Produits Informatiques - Prestations De Services Informatiques Hann Plage -	\N	2	2026-03-02 23:11:13.257	2026-03-02 23:11:13.257	Vente De Produits Informatiques - Prestations De Services Informatiques Hann Plage -	Route Du Cvd Impasse Des Cocotiers	77 561 12 28	Dakar	\N	\N	\N	f	\N
1298	Baobab Technologie Import Sarl	baobab-technologie-import-sarl	Vente De Materiels Electrique Et Solaire	\N	2	2026-03-02 23:11:13.259	2026-03-02 23:11:13.259	Vente De Materiels Electrique Et Solaire	Route De Ca brousse - Cap Skirring 0 Rufisque Sen Materiaux Keur Khadim (Aliou Faye) Commerce Quincaillerie Diamaguene - Route De Rufisqu e	33 832 07 78	Cap-Skirring	\N	\N	\N	f	\N
1299	Sogicom (Societe De Gestion Immobiliere Et De	sogicom-societe-de-gestion-immobiliere-et-de	Commerce) Commerce - Transactions	\N	2	2026-03-02 23:11:13.261	2026-03-02 23:11:13.261	Commerce) Commerce - Transactions	Immobilieres Point E - Rue 3 Bis X F	33 939 51 95	Dakar	\N	\N	\N	f	\N
1300	Gestion Epitoge Surl	gestion-epitoge-surl	Vente De Services Administratifs Et De Gestion Liber te 6 Extension	\N	2	2026-03-02 23:11:13.263	2026-03-02 23:11:13.263	Vente De Services Administratifs Et De Gestion Liber te 6 Extension	Rue Lib. N° 4 0 Dakar Pes Group (Prestations Etudes & Fournitures Diverses Aux Entreprises) Prestations De Services - Commerce Parcelles Assaini es Unite 7 N° 261	33 855 67 78	Dakar	\N	\N	\N	f	\N
1301	Diprovet	diprovet	(Distribution Produits Veterinaires) Vente Deproduits Veterinaires	\N	2	2026-03-02 23:11:13.264	2026-03-02 23:11:13.264	(Distribution Produits Veterinaires) Vente Deproduits Veterinaires	Route De Thies - Sebik otane	33 855 83 21	Dakar	\N	\N	\N	f	\N
1302	Station Mobil Rue 9 (El Hadji Ibrahima Solly)	station-mobil-rue-9-el-hadji-ibrahima-solly	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:13.266	2026-03-02 23:11:13.266	Vente De Produits Petroliers (Station D'Essence)	Rue 9 Point E 0 Mbour Nianing Automobiles Commerce De Vehicules Parcelles 31 Et 33 0 Mbour Pharmacie Babilone (Docteur Anne Marie Ndiaye) Vente De Produits Pharmaceutiques Route Nationale Ng uekhokh	33 867 91 45	Dakar	\N	\N	\N	f	\N
1303	L.P.L - Sarl (Librairie Papeterie Le Leybar - Sarl)	l-p-l-sarl-librairie-papeterie-le-leybar-sarl	Vente De Materiels Scolaires Et Bureau	\N	2	2026-03-02 23:11:13.268	2026-03-02 23:11:13.268	Vente De Materiels Scolaires Et Bureau	Rue Abdoulaye Seck M.P. X Blanchot	77 438 76 35	Saint-Louis	\N	\N	\N	f	\N
1304	Entreprise Activité Adresse Téléphone Dakar Mouhamed El Mouhab	entreprise-activite-adresse-telephone-dakar-mouhamed-el-mouhab	Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:13.27	2026-03-02 23:11:13.27	Commerce De Marchandises Diverses	Rue Paul Holle Dak ar 0 Dakar Senegalaise D'Electricite Et De Distribution Suarl Vente De Materiels Electroniques Ave Petersen X Emil e Badiane 0 Dakar Ets Negoce Du Sahel (Massamba Toure) Commerce Rue 1 X B Point E 0 Dakar Sotech Sarl Commerce De Marchandises Diverses Rue Mousse Diop	33 961 28 61	Ville	\N	\N	\N	f	\N
1305	Societe Darou Dienne - Suarl	societe-darou-dienne-suarl	Commerce Sacre Cœur 1 Villa 8501 0 Dakar Ameth Sow Commerce Grand Dakar 0 Dakar Sami W Ayzani Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:13.272	2026-03-02 23:11:13.272	Commerce Sacre Cœur 1 Villa 8501 0 Dakar Ameth Sow Commerce Grand Dakar 0 Dakar Sami W Ayzani Commerce De Marchandises Diverses	Rue Galandou Diouf 0 Djilor Pharmacie Darou Khoudoss Vente De Produits Pharmaceutiques Djilor Saloum Arrt Djilor	77 450 68 58	Dakar	\N	\N	\N	f	\N
1306	W Tc (W Ade Trading Company) - Ex Bit Senegal (Bits]	w-tc-w-ade-trading-company-ex-bit-senegal-bits	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:13.274	2026-03-02 23:11:13.274	Vente De Materiels Informatiques	Rue Felix Faure X M ousse Diop	76 663 13 01	Dakar	\N	\N	\N	f	\N
1307	Gqid Sarl (General Quincaillerie Industrie Divers Sarl)	gqid-sarl-general-quincaillerie-industrie-divers-sarl	Commerce	\N	2	2026-03-02 23:11:13.276	2026-03-02 23:11:13.276	Commerce	Bccd	77 587 23 02	Dakar	\N	\N	\N	f	\N
1308	Faci Sarl (Fallou	faci-sarl-fallou	Commerce International) Commerce	\N	2	2026-03-02 23:11:13.278	2026-03-02 23:11:13.278	Commerce International) Commerce	Avenue Blaise Diagne	33 820 75 58	Dakar	\N	\N	\N	f	\N
1309	Hameth Lo	hameth-lo	Commerce	\N	2	2026-03-02 23:11:13.28	2026-03-02 23:11:13.28	Commerce	Rue Valmy 0 Dakar Seydou Khoule Commerce Avenue Emile Badiane	33 823 47 38	Thiaroye	\N	\N	\N	f	\N
1310	Jappo Liguey Ndiaye Et Freres	jappo-liguey-ndiaye-et-freres	Commerce	\N	2	2026-03-02 23:11:13.282	2026-03-02 23:11:13.282	Commerce	Rue Escarfait X Valmy	77 504 60 38	Dakar	\N	\N	\N	f	\N
1311	Horizon Plus Fallene (Mame Maty Fall)	horizon-plus-fallene-mame-maty-fall	Commerce 125 Grand Dakar 0 Saint-Louis Pharmacie Mame Yacine Bop (Khadissatou Diop) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.284	2026-03-02 23:11:13.284	Commerce 125 Grand Dakar 0 Saint-Louis Pharmacie Mame Yacine Bop (Khadissatou Diop) Vente De Produits Pharmaceutiques	Avenue Mame Raw An e Ngom	33 827 34 73	Dakar	\N	\N	\N	f	\N
1312	Decorama Pro	decorama-pro	Commerce Sacre Cœur Iii Pyrotehnie 0 Dakar Pharmacie Rond Point (Fary Ndiaye) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.286	2026-03-02 23:11:13.286	Commerce Sacre Cœur Iii Pyrotehnie 0 Dakar Pharmacie Rond Point (Fary Ndiaye) Vente De Produits Pharmaceutiques	Avenue Albert Sarr aut	33 961 41 89	Dakar	\N	\N	\N	f	\N
1313	Ets Nabil Hakim Autres	ets-nabil-hakim-autres	Commerces	\N	2	2026-03-02 23:11:13.287	2026-03-02 23:11:13.287	Commerces	Rue Galandou Diouf	77 638 72 60	Dakar	\N	\N	\N	f	\N
1314	Auto Moto Racing Sarl	auto-moto-racing-sarl	Commerce De Vehicules,Pieces Detachees	\N	2	2026-03-02 23:11:13.289	2026-03-02 23:11:13.289	Commerce De Vehicules,Pieces Detachees	Route Du Fron t De Terre	33 822 31 45	Dakar	\N	\N	\N	f	\N
1315	Sosemaic (Societe Senegalo-Malienne D'Import Export Du Cru)	sosemaic-societe-senegalo-malienne-d-import-export-du-cru	Commerce	\N	2	2026-03-02 23:11:13.291	2026-03-02 23:11:13.291	Commerce	Rue Grasland	33 824 60 83	Dakar	\N	\N	\N	f	\N
1316	Gie Cis & Famille	gie-cis-famille	Production Commerce General Medine - Mbour 0 Dakar Edilmoro Senita Sarl Vente De Materiels De Btp Medina	\N	2	2026-03-02 23:11:13.292	2026-03-02 23:11:13.292	Production Commerce General Medine - Mbour 0 Dakar Edilmoro Senita Sarl Vente De Materiels De Btp Medina	Rue 66 X Corniche	77 412 72 70	Mbour	\N	\N	\N	f	\N
1317	Cristabel Diffusion Importations -	cristabel-diffusion-importations	Ventes Point E -	\N	2	2026-03-02 23:11:13.294	2026-03-02 23:11:13.294	Ventes Point E -	Rue 4 Entre A Et B (Ex - Rue 7 X B - Villa N° 4276 - Point E)	77 529 72 99	Dakar	\N	\N	\N	f	\N
1318	433 47 58 Dakar Dimaq (Sidy Diouf)	433-47-58-dakar-dimaq-sidy-diouf	Commerce General	\N	2	2026-03-02 23:11:13.295	2026-03-02 23:11:13.295	Commerce General	Rue Escafait 0 Dakar Gie Lansar Commerce General Sicap Karack N°388/C	76 394 87 58	77	\N	\N	\N	f	\N
1319	Pharmacie Hann Plage	pharmacie-hann-plage	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.297	2026-03-02 23:11:13.297	Vente De Produits Pharmaceutiques	Bccd	78 122 31 64	Dakar	\N	\N	\N	f	\N
1320	Ets Amar Diop Froid	ets-amar-diop-froid	Vente De Marchandises Diverses & Prestation De Services	\N	2	2026-03-02 23:11:13.299	2026-03-02 23:11:13.299	Vente De Marchandises Diverses & Prestation De Services	Rue Marsat X Reims	77 668 79 32	Dakar	\N	\N	\N	f	\N
1321	Pharmacie Mame Fatou Ba	pharmacie-mame-fatou-ba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.3	2026-03-02 23:11:13.3	Vente De Produits Pharmaceutiques	Route Isra Medina Course 0 Matam Gie Diaky Heege Pellital Commerce Commune De Nguidjione Matam 0 Dakar Baol Equipement (Samba Diop) Commerce General Avenue Peytavin Immeuble Gouniang T hiiam	33 957 30 70	Saint-Louis	\N	\N	\N	f	\N
1322	Fg Tours Senegal	fg-tours-senegal	Commerce	\N	2	2026-03-02 23:11:13.302	2026-03-02 23:11:13.302	Commerce	Rue W Agane Diouf 0 Dakar Taj Mahal Prem Roopchanan Commerce General - Vente De Divers Produits - Produits Accessoires Avenue Lamine Gueye	33 822 74 14	Dakar	\N	\N	\N	f	\N
1323	Pharmacie Saikou Oumar Tall	pharmacie-saikou-oumar-tall	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.304	2026-03-02 23:11:13.304	Vente De Produits Pharmaceutiques	Quartier Abdou Ndi aye Diamaguene	33 822 22 14	Pikine	\N	\N	\N	f	\N
1324	Quincallerie Lagane (Basiirou Fall)	quincallerie-lagane-basiirou-fall	Vente De Materiels Electroniques	\N	2	2026-03-02 23:11:13.306	2026-03-02 23:11:13.306	Vente De Materiels Electroniques	Rue Tolbiac	33 867 00 93	Dakar	\N	\N	\N	f	\N
1325	Dpam (Du Pareil Au Meme) - Sarl Sasso	dpam-du-pareil-au-meme-sarl-sasso	Vente D'Habits Pour Enfants	\N	2	2026-03-02 23:11:13.308	2026-03-02 23:11:13.308	Vente D'Habits Pour Enfants	Rue Jules Ferry	33 822 01 60	Dakar	\N	\N	\N	f	\N
1326	Ngordiane Groupe Sarl	ngordiane-groupe-sarl	Commerce General Contigue Cto	\N	2	2026-03-02 23:11:13.309	2026-03-02 23:11:13.309	Commerce General Contigue Cto	Rue Asafin Grand-Yoff 33 8671723 Dakar Amadou W Oury Diallo Commerce General Rue 60 X 66 Gueule Tapee Medina	33 820 49 41	Dakar	\N	\N	\N	f	\N
1327	Sses (Societe Senegalaise Et De	sses-societe-senegalaise-et-de	Services) Sarl Commerce General	\N	2	2026-03-02 23:11:13.311	2026-03-02 23:11:13.311	Services) Sarl Commerce General	Route De Rufisque 0 Dakar Etablissement Khadimou Rassoul Commerce Et Tous Travaux Rue 33 X 26 Medina Dakar	33 823 43 09	Dakar	\N	\N	\N	f	\N
1328	Entreprise Activité Adresse Téléphone Dakar The George Company Sarl	entreprise-activite-adresse-telephone-dakar-the-george-company-sarl	Commerce General	\N	2	2026-03-02 23:11:13.313	2026-03-02 23:11:13.313	Commerce General	Rue Tolbiac X Laperne 2ème Étage 0 Dakar Saloum Multiservice (Khady Fall) Commerce Et Prestation De Services Cite Sacca Senele c 0 Dakar Agence Immobiliere Coumba(Rokhaya Fall) Vente Achat Location Gerance Sacre Cœur 3	77 647 54 03	Ville	\N	\N	\N	f	\N
1329	Pharmacie Emmanuel Ch. Gueye Ngazobil (Jeanne Marie Rose Gueye)	pharmacie-emmanuel-ch-gueye-ngazobil-jeanne-marie-rose-gueye	Vente De Produits Pharmaceutiques Kaw Sara	\N	1	2026-03-02 23:11:13.314	2026-03-02 23:11:13.314	Vente De Produits Pharmaceutiques Kaw Sara	Route De Saint- Louis / Thies	77 634 10 50	Thies	\N	\N	\N	f	\N
1330	J.R.	j-r	Distribution Fruits Et Legumes Suarl Vente De Fruits Fleurs Et Legumes 8,	\N	2	2026-03-02 23:11:13.316	2026-03-02 23:11:13.316	Distribution Fruits Et Legumes Suarl Vente De Fruits Fleurs Et Legumes 8,	Rue Caille Marc he Kermel	33 951 00 20	Dakar	\N	\N	\N	f	\N
1331	Thies Kay Avs (Ndongo Samb)	thies-kay-avs-ndongo-samb	Commerce General Hersent Thies 779193645 Dakar Iso Senegal - Sarl Commerce General	\N	2	2026-03-02 23:11:13.318	2026-03-02 23:11:13.318	Commerce General Hersent Thies 779193645 Dakar Iso Senegal - Sarl Commerce General	Rue Armand Angrand	33 822 40 53	Thies	\N	\N	\N	f	\N
1332	Les Professionnels Du Meuble ( Pro-Meuble)	les-professionnels-du-meuble-pro-meuble	Vente De Meuble Liberte 6 Dakar 0 Dakar Vera Trading Sarl Commerce General 30,	\N	2	2026-03-02 23:11:13.32	2026-03-02 23:11:13.32	Vente De Meuble Liberte 6 Dakar 0 Dakar Vera Trading Sarl Commerce General 30,	Rue Mousse Diop, Dakar 338216713 Dakar Entreprise Yahya (Ismaila Niang) Commerce Et Prestation De Services Ouest Foiire Face Cices	77 639 42 11	Dakar	\N	\N	\N	f	\N
1333	Ets Khodor Mahtoub	ets-khodor-mahtoub	Commerce De Droguerie	\N	2	2026-03-02 23:11:13.322	2026-03-02 23:11:13.322	Commerce De Droguerie	Rue Galandou Diouf	77 538 34 26	Dakar	\N	\N	\N	f	\N
1334	Ets Khew Eul (Serigne Modou Ndiaye)	ets-khew-eul-serigne-modou-ndiaye	Commerce	\N	2	2026-03-02 23:11:13.324	2026-03-02 23:11:13.324	Commerce	Rue 64X51 Gueul Tapee 0 Dakar Kromatik Id Sa Commerce General Usine Bene Tally	33 822 88 95	Dakar	\N	\N	\N	f	\N
1335	Acis Informatique	acis-informatique	Vente D'Outils Informatique Consommables Fournitures De Bureau	\N	2	2026-03-02 23:11:13.326	2026-03-02 23:11:13.326	Vente D'Outils Informatique Consommables Fournitures De Bureau	Rue 09 X Blaise Diagne Medina	33 825 39 91	Dakar	\N	\N	\N	f	\N
1336	Libre	libre-1	Service Monoprix - Souad Saliman Al Reefi Commerce Alimentaire - Epicerie	\N	2	2026-03-02 23:11:13.329	2026-03-02 23:11:13.329	Service Monoprix - Souad Saliman Al Reefi Commerce Alimentaire - Epicerie	Rue Assane Ndoye	33 937 90 46	Dakar	\N	\N	\N	f	\N
1337	Sedec Suarl (Senegalaise De Commercialisation - Suarl)	sedec-suarl-senegalaise-de-commercialisation-suarl	Commerce General	\N	2	2026-03-02 23:11:13.331	2026-03-02 23:11:13.331	Commerce General	Rue Galandou Diouf	33 820 18 75	Dakar	\N	\N	\N	f	\N
1338	Station Solaire Eco Bio Construction Sarl	station-solaire-eco-bio-construction-sarl	Commerce	\N	2	2026-03-02 23:11:13.332	2026-03-02 23:11:13.332	Commerce	Avenue Lamine Gueye 771925997 Dakar Fourniture Express (Ibrahima Toure) Commerce General Parcelles Assainies Unite 19 N° 171	33 821 66 01	Dakar	\N	\N	\N	f	\N
1339	Altess	altess	Commerce	\N	2	2026-03-02 23:11:13.334	2026-03-02 23:11:13.334	Commerce	Rue De Thiong X Vincent 0 Dakar Touba Telephone Portable (Samba Diop) Commerce Telephone Portable Et Accessoires Avenue Ge orges Pompidou	33 855 03 64	Dakar	\N	\N	\N	f	\N
1340	Long Da Suarl	long-da-suarl	Commerce General	\N	2	2026-03-02 23:11:13.336	2026-03-02 23:11:13.336	Commerce General	Rue Abdou Karim Bourgi 0 Dakar Ets Mamoune Gaye (Touba Cuir Mamoune Gaye) Vente Materiaux De Construction Rue 22 X 27 Medina	33 842 74 39	Dakar	\N	\N	\N	f	\N
1341	Touba Materiaux (Amadou Sarr Ndoye) Location	touba-materiaux-amadou-sarr-ndoye-location	Vente De Materiels	\N	2	2026-03-02 23:11:13.337	2026-03-02 23:11:13.337	Vente De Materiels	Rue 39 X 37 Medina	76 280 10 10	Dakar	\N	\N	\N	f	\N
1342	Burinfo (Modou Niang)	burinfo-modou-niang	Commerce	\N	2	2026-03-02 23:11:13.339	2026-03-02 23:11:13.339	Commerce	Rue 31 X Blaise Diagne 0 Dakar King Immobilier Sa Location De Fond De Commerce Saly Portudal	33 827 15 35	Dakar	\N	\N	\N	f	\N
1343	Carrefour Electronics Sarl	carrefour-electronics-sarl	Commerce De Materiels Electronics	\N	2	2026-03-02 23:11:13.341	2026-03-02 23:11:13.341	Commerce De Materiels Electronics	Rue Mousse Diop X Escarfait 0 Mbour Ens Sarl (Energie Naturelle Du Senegal) Commerce De Panneau Solaire Saly	77 635 31 08	Dakar	\N	\N	\N	f	\N
1344	W Eek End Sports - Jamal Houdrouge	w-eek-end-sports-jamal-houdrouge	Distribution Articles De Sports	\N	2	2026-03-02 23:11:13.343	2026-03-02 23:11:13.343	Distribution Articles De Sports	Rue Jules Ferry	33 958 55 56	Dakar	\N	\N	\N	f	\N
1345	Jim Com (Jim Com Global Connexion Sa)	jim-com-jim-com-global-connexion-sa	Commerce	\N	2	2026-03-02 23:11:13.345	2026-03-02 23:11:13.345	Commerce	Rue Emile Zola	33 821 02 22	Dakar	\N	\N	\N	f	\N
1346	Pharmacie Fahd	pharmacie-fahd	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.347	2026-03-02 23:11:13.347	Vente De Produits Pharmaceutiques	Bd El Hadji Djily Mbaye	33 842 90 22	Dakar	\N	\N	\N	f	\N
1347	Touba Meubles	touba-meubles	Vente De Marchandises	\N	2	2026-03-02 23:11:13.349	2026-03-02 23:11:13.349	Vente De Marchandises	Route De Saly En Face Renault Tableau Diacsao	33 821 14 48	Mbour	\N	\N	\N	f	\N
1348	Ate Sarl (Africa De Travaux & D'Equipement)	ate-sarl-africa-de-travaux-d-equipement	Vente De Marchandises Et Divers	\N	2	2026-03-02 23:11:13.351	2026-03-02 23:11:13.351	Vente De Marchandises Et Divers	Route Amitie 3 N° 43 37	77 554 70 99	Dakar	\N	\N	\N	f	\N
1349	Maintenance Pneus Suarl Vulanisateur	maintenance-pneus-suarl-vulanisateur	Vente De Pneus En Occasion	\N	2	2026-03-02 23:11:13.353	2026-03-02 23:11:13.353	Vente De Pneus En Occasion	Avenue Cheik h Anta Diop	77 562 86 82	Dakar	\N	\N	\N	f	\N
1350	Pharmacie Nouvelle Cayor (Alexandre Jean Thomes Syl va)	pharmacie-nouvelle-cayor-alexandre-jean-thomes-syl-va	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.355	2026-03-02 23:11:13.355	Vente De Produits Pharmaceutiques	Avenue Du Presiden t Lamine Gueye Thies 0 Dakar Compagnie Ndiaye Et Freres -Sarl Commerce General Avenue Du Senegal X Blaise Diagne 0 Thies Thioune Visions (Alioune Badara Thioune) Commerce Avenue Ousmane Ngom X Rue 10 Randoulene Nord	77 638 82 00	Thies	\N	\N	\N	f	\N
1351	Fallou Thiam Ndindy Securite	fallou-thiam-ndindy-securite	Commerce General Import- Export	\N	2	2026-03-02 23:11:13.357	2026-03-02 23:11:13.357	Commerce General Import- Export	Rue Fass Casier N°2 0 Thies Bamba 2 (Khabane Gueye) Commerce Avenue Amadou Gnagna Sow	77 635 61 43	Dakar	\N	\N	\N	f	\N
1352	Gie Horizons Equipements &	gie-horizons-equipements	Services Vente De Materiels	\N	2	2026-03-02 23:11:13.359	2026-03-02 23:11:13.359	Services Vente De Materiels	Immobiliers Route Du Front De Ter re	33 951 14 82	Dakar	\N	\N	\N	f	\N
1353	Aye Pharmacie Baye Laye - Dr Amadou Diop	aye-pharmacie-baye-laye-dr-amadou-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.361	2026-03-02 23:11:13.361	Vente De Produits Pharmaceutiques	Quartier Baye Laye - Guediaw Aye - Parcelles N° 802	33 820 47 16	Guediaw	\N	\N	\N	f	\N
1354	Mac Et Pc	mac-et-pc	Services (Carole Marie A Nelson) Vente De Materiels Informatiques-Services Dakar Merm oz 2 Eme Porte	\N	2	2026-03-02 23:11:13.363	2026-03-02 23:11:13.363	Services (Carole Marie A Nelson) Vente De Materiels Informatiques-Services Dakar Merm oz 2 Eme Porte	Immeuble B 0 Dakar Abdou Karim Basma Commerce General Rue Abdou Karim Bourgi 0 Dakar Sagor Diop Commerce Cite Sotiba	33 837 13 04	Dakar	\N	\N	\N	f	\N
1355	Millenium Corporation - Mil,Cor Autres	millenium-corporation-mil-cor-autres	Commerces	\N	2	2026-03-02 23:11:13.365	2026-03-02 23:11:13.365	Commerces	Rue Fleurus X Escarfait 0 Dakar Seydou Mbaye Serdid Commerce Hlm 5 Appt 6/A N 1778	77 644 05 44	Dakar	\N	\N	\N	f	\N
1356	Entreprise Activité Adresse Téléphone Dakar Adam International Trade Sarl	entreprise-activite-adresse-telephone-dakar-adam-international-trade-sarl	Commerce	\N	2	2026-03-02 23:11:13.367	2026-03-02 23:11:13.367	Commerce	Rue 11 X 12 Medina	77 622 21 11	Ville	\N	\N	\N	f	\N
1357	Ahmed Mourad Autres	ahmed-mourad-autres	Commerces - Marchandises Diverses	\N	2	2026-03-02 23:11:13.37	2026-03-02 23:11:13.37	Commerces - Marchandises Diverses	Rue Tolbiac	33 869 74 74	Dakar	\N	\N	\N	f	\N
1358	Andando Laguardia Sarl	andando-laguardia-sarl	Commerce General Yoff	\N	2	2026-03-02 23:11:13.372	2026-03-02 23:11:13.372	Commerce General Yoff	Route De L'Aeroport En Face Ag ence Cbao	33 836 50 50	Dakar	\N	\N	\N	f	\N
1359	Bogoned Sarl	bogoned-sarl	Commerce	\N	2	2026-03-02 23:11:13.375	2026-03-02 23:11:13.375	Commerce	Rue Galandou Diouf	33 820 25 35	Dakar	\N	\N	\N	f	\N
1360	Pharmacie Sandaga - Mme Marie Claude Tokpe Basse	pharmacie-sandaga-mme-marie-claude-tokpe-basse	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.377	2026-03-02 23:11:13.377	Vente De Produits Pharmaceutiques	Avenue Jean Jaures	77 452 29 47	Dakar	\N	\N	\N	f	\N
1361	Ismail Haw Ili (Anabella)	ismail-haw-ili-anabella	Commerce General	\N	2	2026-03-02 23:11:13.379	2026-03-02 23:11:13.379	Commerce General	Rue De Thiong X Rue W Agane Diouf	77 518 28 65	Dakar	\N	\N	\N	f	\N
1362	Cogeco	cogeco	(Commerce General De La Cote) Commerce General	\N	2	2026-03-02 23:11:13.382	2026-03-02 23:11:13.382	(Commerce General De La Cote) Commerce General	Rue Jules Ferry	33 821 53 33	Dakar	\N	\N	\N	f	\N
1363	Premium Senegal Sa	premium-senegal-sa	Commerce Machine Materiel Et Autre Outillage En Main	\N	2	2026-03-02 23:11:13.384	2026-03-02 23:11:13.384	Commerce Machine Materiel Et Autre Outillage En Main	Bccd	33 821 25 73	Dakar	\N	\N	\N	f	\N
1364	Malick Fall	malick-fall	Commerce	\N	2	2026-03-02 23:11:13.386	2026-03-02 23:11:13.386	Commerce	Rue Valmy	33 849 05 00	Dakar	\N	\N	\N	f	\N
1365	Pharmacie Dior (Dr Aita Ndir)	pharmacie-dior-dr-aita-ndir	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.389	2026-03-02 23:11:13.389	Vente De Produits Pharmaceutiques	Quartier Arafat 2 0 Dakar Ced (Consortium D'Entreprises De Dakar - Amadou Makhtar Diagne) Commerce Import-Export Sicap Liberte 5 N° 5388	33 991 66 92	Rufisque	\N	\N	\N	f	\N
1366	Gie I & D	gie-i-d	Services Commerce General	\N	2	2026-03-02 23:11:13.392	2026-03-02 23:11:13.392	Services Commerce General	Rue 17 X 08 Medina	33 824 15 61	Dakar	\N	\N	\N	f	\N
1367	Scie Sa (Societe De Commercialisation D'Info	scie-sa-societe-de-commercialisation-d-info	Commerce D'Informations	\N	2	2026-03-02 23:11:13.395	2026-03-02 23:11:13.395	Commerce D'Informations	Avenue Des Ambassadeurs Fann	30 102 25 74	Dakar	\N	\N	\N	f	\N
1368	Artkitex (Alioune Badara Ba)	artkitex-alioune-badara-ba	Production Film Cinema, Distribution, Projection	\N	2	2026-03-02 23:11:13.398	2026-03-02 23:11:13.398	Production Film Cinema, Distribution, Projection	Rue Vincens	77 639 21 50	Dakar	\N	\N	\N	f	\N
1369	Touba Tissu Keur Sokhna M Dieng	touba-tissu-keur-sokhna-m-dieng	Commerce Sicap Dieupeul 2 N° 2540	\N	2	2026-03-02 23:11:13.401	2026-03-02 23:11:13.401	Commerce Sicap Dieupeul 2 N° 2540	Rue 13	77 633 53 97	Dakar	\N	\N	\N	f	\N
1370	Kazar	kazar	Commerce General	\N	2	2026-03-02 23:11:13.404	2026-03-02 23:11:13.404	Commerce General	Rue Masclary 0 Dakar Siemi Senegal (Societe Import Export Materiel Indust.Senegal - Sarl) Commerce General Rue Joris Dakar	77 637 75 60	Dakar	\N	\N	\N	f	\N
1371	My Pleasure Sa	my-pleasure-sa	Commerce General Sicap Sacre Cœur 1 Villa N°8300 777974743 Dakar Iimpextravaux Negoces Sarl Commerce-Travaux Et Services	\N	2	2026-03-02 23:11:13.407	2026-03-02 23:11:13.407	Commerce General Sicap Sacre Cœur 1 Villa N°8300 777974743 Dakar Iimpextravaux Negoces Sarl Commerce-Travaux Et Services	Avenue Jean Jaures Imm Aicha 5 Eme Etage N°54 Ah	33 821 25 70	Dakar	\N	\N	\N	f	\N
1372	Liu Jinping	liu-jinping	Commerce	\N	2	2026-03-02 23:11:13.41	2026-03-02 23:11:13.41	Commerce	Bd General De Gaulle	77 637 57 69	Dakar	\N	\N	\N	f	\N
1373	Ditef (Gorgui Sene)	ditef-gorgui-sene	Commerce General	\N	2	2026-03-02 23:11:13.413	2026-03-02 23:11:13.413	Commerce General	Route De Rufisque	77 326 20 37	Pikine	\N	\N	\N	f	\N
1374	Global	global	Distribution Commerce	\N	2	2026-03-02 23:11:13.415	2026-03-02 23:11:13.415	Distribution Commerce	Rue Mage X Thiers	77 631 66 23	Dakar	\N	\N	\N	f	\N
1375	Sicos Sarl (Societe D'Industrie Et De	sicos-sarl-societe-d-industrie-et-de	Commerce Du Senegal) Commerce General Yoff Tonghor	\N	2	2026-03-02 23:11:13.418	2026-03-02 23:11:13.418	Commerce Du Senegal) Commerce General Yoff Tonghor	Route De La Place	77 840 99 35	Dakar	\N	\N	\N	f	\N
1376	Ibrahima Toure	ibrahima-toure-2	Commerce General	\N	2	2026-03-02 23:11:13.424	2026-03-02 23:11:13.424	Commerce General	Rue Paul Holle	33 820 63 48	Dakar	\N	\N	\N	f	\N
1377	Adji Mbaye	adji-mbaye	Commerce General Cite Belvedere - Dalifort 0 Dakar El Zein Consulting Prestation De Services Et Vente De Marchandises	\N	2	2026-03-02 23:11:13.427	2026-03-02 23:11:13.427	Commerce General Cite Belvedere - Dalifort 0 Dakar El Zein Consulting Prestation De Services Et Vente De Marchandises	Rue Mousse Diop (Ex = 44, Galandou Diouf)	77 569 61 92	Dakar	\N	\N	\N	f	\N
1378	Mariama	mariama	Services (Saer Badiane) Commerce Villa N° 10043 Sacre Cœur 3 0 Dakar Les Pangols Sarl Mise En Valeur, Vente Ou Location De Biens Meubles Ou	\N	2	2026-03-02 23:11:13.43	2026-03-02 23:11:13.43	Services (Saer Badiane) Commerce Villa N° 10043 Sacre Cœur 3 0 Dakar Les Pangols Sarl Mise En Valeur, Vente Ou Location De Biens Meubles Ou	Immeubles 102, Rue Joseph Gomis X Rue Amadou Assane Ndoye	33 823 43 66	Dakar	\N	\N	\N	f	\N
1379	Mamadou Dia	mamadou-dia	Commercee Et Distribution D'Intrants Agricoles Medin a	\N	2	2026-03-02 23:11:13.433	2026-03-02 23:11:13.433	Commercee Et Distribution D'Intrants Agricoles Medin a	Rue 11 X Blaise Diagne	33 820 26 33	Dakar	\N	\N	\N	f	\N
1380	Pharmacie Abdoulaye Ibrahima Niass	pharmacie-abdoulaye-ibrahima-niass	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.436	2026-03-02 23:11:13.436	Vente De Produits Pharmaceutiques	Quartier Kahone Lo t N° 196 Kk 0 Ville Entreprise Activité Adresse Téléphone Tambacound a Khainou Sy(Ou Kainou) Commerce Quartier Alpha Tambacounda	33 823 87 94	Kahone	\N	\N	\N	f	\N
1381	S.C.S (Senegal Climatisation Suarl) Importations -	s-c-s-senegal-climatisation-suarl-importations	Ventes	\N	2	2026-03-02 23:11:13.439	2026-03-02 23:11:13.439	Ventes	Rue Marchand X Tolbiac 0 Dakar Select Marketing (Ababacar Ndiaye) Commerce De Marchandises Diverses Avenue Andre Petav in X Rue Masse Diokhane	77 634 43 18	Dakar	\N	\N	\N	f	\N
1382	Entreprise	entreprise	Service Plus(Fatoumata Sira Ba) Commerce	\N	2	2026-03-02 23:11:13.442	2026-03-02 23:11:13.442	Service Plus(Fatoumata Sira Ba) Commerce	Rue 13 X 8 Medina 0 Dakar Ilf (Ibra Leon Fedior) Commerce De Materiels Electriques Et Electroniques Medina Rue 43X34	77 675 55 55	Dakar	\N	\N	\N	f	\N
1383	Global Equipement	global-equipement	Commerce	\N	2	2026-03-02 23:11:13.445	2026-03-02 23:11:13.445	Commerce	Rue 01 Prolongee Sodida,Lot N° 2 Hlm 0 Saint-Louis Gie "Ndoka Multi Services" Commerce General- Bureautique-Papeterie Place Abdoul aye W Ade Sor Saint-Louis	77 534 74 00	Dakar	\N	\N	\N	f	\N
1384	Mass Sene "Quincaillerie Bokk Jom"	mass-sene-quincaillerie-bokk-jom	Commerce	\N	2	2026-03-02 23:11:13.447	2026-03-02 23:11:13.447	Commerce	Rue Fleurus - Dakar 0 Dakar Univers De La Technologie Sarl Vente De Materiel Informatique Rue Jules Ferry X Moh amed 5	77 450 02 81	Dakar	\N	\N	\N	f	\N
1385	Djibril Bousso	djibril-bousso	Vente De Marchandises Diverses	\N	2	2026-03-02 23:11:13.45	2026-03-02 23:11:13.45	Vente De Marchandises Diverses	Rue Fleurus 0 Guediaw Aye Zig Trading Co Ltd -Sarl Commerce Cite Abdel Kader Diouf N° 28 Guediaw Aye	77 717 17 42	Dakar	\N	\N	\N	f	\N
1386	M.C.E Sa (Media Com Entreprise)	m-c-e-sa-media-com-entreprise	Commerce	\N	2	2026-03-02 23:11:13.452	2026-03-02 23:11:13.452	Commerce	Immeuble Air France N° 141- Ab	33 837 08 99	Dakar	\N	\N	\N	f	\N
1387	Espace Global (Assane Sene)	espace-global-assane-sene	Commerce Generale	\N	2	2026-03-02 23:11:13.453	2026-03-02 23:11:13.453	Commerce Generale	Rue Mousse Diop	33 842 24 42	Dakar	\N	\N	\N	f	\N
1388	Mamadou Lo	mamadou-lo	Commerce Pieces Detachees	\N	2	2026-03-02 23:11:13.455	2026-03-02 23:11:13.455	Commerce Pieces Detachees	Route De Rufisque 0 Saint-Louis Gie Mondial Stocks Services Commerce Avenue Macodou Ndiaye 0 Dakar Bamby Suarl Vente De D'Artisanat Sipres 2	33 821 95 31	Dakar	\N	\N	\N	f	\N
1389	Sci Adja Seneba Construction-Location-	sci-adja-seneba-construction-location	Vente	\N	2	2026-03-02 23:11:13.458	2026-03-02 23:11:13.458	Vente	Avenue Fahd Ben Abdel Aziz X Autoroute, Echangeur Hann:7894 Dakar	77 637 45 94	Dakar	\N	\N	\N	f	\N
1390	Ets Salim W Ehbe Et Freres - Sarl	ets-salim-w-ehbe-et-freres-sarl	Commerce - Farine (99%)- Autres Marchanise (0,8%) Materiels Informatiques	\N	2	2026-03-02 23:11:13.46	2026-03-02 23:11:13.46	Commerce - Farine (99%)- Autres Marchanise (0,8%) Materiels Informatiques	Route De Rufisque	33 869 04 12	Dakar	\N	\N	\N	f	\N
1391	Spcrs (Societe Pour La Promotion Et La Commercialis ation Du Riz)	spcrs-societe-pour-la-promotion-et-la-commercialis-ation-du-riz	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:13.463	2026-03-02 23:11:13.463	Commerce De Produits Alimentaires	Rue Beranger Ferra ud,Dakar 0 Pikine Smes Sarl Commerce De Marchandises Diverses Route De Rufisque	33 839 82 00	Dakar	\N	\N	\N	f	\N
1392	Adji Coura Thiam/M2M Technologies	adji-coura-thiam-m2m-technologies	Commerce	\N	2	2026-03-02 23:11:13.465	2026-03-02 23:11:13.465	Commerce	Avenue Blaise Diagne X Rue 9	77 559 40 29	Dakar	\N	\N	\N	f	\N
1393	Digitronics (Assane Ezzedine)	digitronics-assane-ezzedine	Commerce	\N	2	2026-03-02 23:11:13.466	2026-03-02 23:11:13.466	Commerce	Avenue Blaise Diagne	33 824 08 08	Dakar	\N	\N	\N	f	\N
1394	Ibrahima Diop (Mondial Contact	ibrahima-diop-mondial-contact	Services) Commerce General	\N	2	2026-03-02 23:11:13.468	2026-03-02 23:11:13.468	Services) Commerce General	Rue 27 X 20 Medina 0 Dakar Moustapha Sakho Vente De Marchandises Diverses Rue Fleurus	33 842 68 18	Dakar	\N	\N	\N	f	\N
1395	Ndeye Marame Thiam	ndeye-marame-thiam	Commerce C	\N	2	2026-03-02 23:11:13.47	2026-03-02 23:11:13.47	Commerce C	Rue Non Denommee, Sicap Amitie 3 0 Dakar Poissonnerie Du Jour (Patricia Sylvie Bernadet) Commerce De Poissons Rue W Agane Diouf	77 578 70 34	Dakar	\N	\N	\N	f	\N
1396	Sosicom Sarl (Ociete Senegalo-Italienne De	sosicom-sarl-ociete-senegalo-italienne-de	Commerce - Sarl) Commerce Divers	\N	2	2026-03-02 23:11:13.472	2026-03-02 23:11:13.472	Commerce - Sarl) Commerce Divers	Route De Rufisque Mbao	33 842 52 29	Pikine	\N	\N	\N	f	\N
1397	V.P.C Senegal Sarl	v-p-c-senegal-sarl	Commerce General	\N	2	2026-03-02 23:11:13.473	2026-03-02 23:11:13.473	Commerce General	Route De Ngor Lot N° 2-B 338207067 Dakar Citrap Commerce Et Prestations De Services Hlm Grand-Yoff V illa N° 448	33 870 09 00	Dakar	\N	\N	\N	f	\N
1398	Touba Taif Quincaillerie Generale - Suarl	touba-taif-quincaillerie-generale-suarl	Commerce De Quincaillerie	\N	2	2026-03-02 23:11:13.475	2026-03-02 23:11:13.475	Commerce De Quincaillerie	Rue Galandou Diouf Valmy 0 Dakar Pharmacie Chamsoul Houda (Mamadou Timera) Vente De Produits Pharmaceutiques Afia 2 Route De Bo une - Yeumbeul 0 Dakar Esd (Entreprise Senegalaise De Distribution) Commerce General Route Du Front De Terre 0 Dakar Somad Sarl Commerce Nord Foire Villa N° 7	77 520 73 73	Dakar	\N	\N	\N	f	\N
1399	Demettere Sarl	demettere-sarl	Commerce W Arang Doamaine Ataya Mbour 707896066 Dakar Copac (Comptoir Du Papier Et Du Carton) Vente De Papiers Et Cartons Hann	\N	2	2026-03-02 23:11:13.477	2026-03-02 23:11:13.477	Commerce W Arang Doamaine Ataya Mbour 707896066 Dakar Copac (Comptoir Du Papier Et Du Carton) Vente De Papiers Et Cartons Hann	Route Du Service Ge ographique	33 961 00 30	Mbour	\N	\N	\N	f	\N
1400	Sene Group Suarl	sene-group-suarl	Commerce Divers	\N	2	2026-03-02 23:11:13.479	2026-03-02 23:11:13.479	Commerce Divers	Avenue Andre Peytavin	33 832 81 60	Dakar	\N	\N	\N	f	\N
1401	Magasin Au Prix Unique - Suarl	magasin-au-prix-unique-suarl	Commerce	\N	2	2026-03-02 23:11:13.483	2026-03-02 23:11:13.483	Commerce	Avenue Lamine Gueye	33 821 94 80	Dakar	\N	\N	\N	f	\N
1402	Bijouterie L'Ecrin D'Or (Cheikh Thiam)	bijouterie-l-ecrin-d-or-cheikh-thiam	Commerce - Bijouterie	\N	2	2026-03-02 23:11:13.485	2026-03-02 23:11:13.485	Commerce - Bijouterie	Rue Amadou Assane Ndoye	33 825 95 99	Dakar	\N	\N	\N	f	\N
1403	Sc Equipement Sa	sc-equipement-sa	Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:13.488	2026-03-02 23:11:13.488	Commerce De Marchandises Diverses	Avenue Lamine Guey e X Montaigne	70 630 75 90	Dakar	\N	\N	\N	f	\N
1404	Techno Reseaux Senegal	techno-reseaux-senegal	Commerce General	\N	2	2026-03-02 23:11:13.489	2026-03-02 23:11:13.489	Commerce General	Route Des Cimetieres Yoff	32 821 63 39	Dakar	\N	\N	\N	f	\N
1405	Senegalaise Prestation Industrielles (Mamadou Seydo u Diallo)	senegalaise-prestation-industrielles-mamadou-seydo-u-diallo	Commerce	\N	2	2026-03-02 23:11:13.491	2026-03-02 23:11:13.491	Commerce	Quartier Cheikh Niang Diamniadio 0 Dakar Ets Mouride Sadikh (Abdou Aziz Diop) Vente De Fournitures De Bureau Rue 22 X 39 Medina 33822 25 16 Dakar Saliou Diouf Commerce General Rue Elimanel Fall X Rue Tolbiac	77 644 51 59	Rufisque	\N	\N	\N	f	\N
1406	Atc - Sarl (Assistance Technique Et Commerciale)	atc-sarl-assistance-technique-et-commerciale	Fabrication, Ventes De Meubliers De Bureau Usine Ben e Tally -	\N	2	2026-03-02 23:11:13.493	2026-03-02 23:11:13.493	Fabrication, Ventes De Meubliers De Bureau Usine Ben e Tally -	Rue 12 - Grand Dakar	33 865 05 41	Dakar	\N	\N	\N	f	\N
1407	Epices Et Delices (Zoher Zeidan)	epices-et-delices-zoher-zeidan	Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:13.494	2026-03-02 23:11:13.494	Commerce De Marchandises Diverses	Rue Ngalandou Diou f 0 Thies Zeine Cheikh Aidara Suarl Commerce Marche Central Thies 0 Dakar W Acom Suarl Commerce Et Services Informatiques Cite Mamelles	33 824 64 03	Dakar	\N	\N	\N	f	\N
1408	Entreprise Activité Adresse Téléphone Saint-Louis Ecopres (Maimouna Fall)	entreprise-activite-adresse-telephone-saint-louis-ecopres-maimouna-fall	Distribution De Carburant Pointe Nord 0 Dakar Yasser Kaddoura Commerce General	\N	2	2026-03-02 23:11:13.496	2026-03-02 23:11:13.496	Distribution De Carburant Pointe Nord 0 Dakar Yasser Kaddoura Commerce General	Rue Saint Miche (Ex Dr Theze)	33 860 53 52	Ville	\N	\N	\N	f	\N
1409	Global Equipement Et Technologie	global-equipement-et-technologie	Commerce General	\N	2	2026-03-02 23:11:13.498	2026-03-02 23:11:13.498	Commerce General	Rue Felix Faure	33 821 63 54	Dakar	\N	\N	\N	f	\N
1410	Mamadou Moctar Diallo	mamadou-moctar-diallo	Commerce 3,	\N	2	2026-03-02 23:11:13.499	2026-03-02 23:11:13.499	Commerce 3,	Rue Du Sgt Malamine	77 222 74 08	Dakar	\N	\N	\N	f	\N
1411	Africa Information De L'Elite Sa	africa-information-de-l-elite-sa	Vente De Cartes Postales (Ex-Edition)	\N	2	2026-03-02 23:11:13.502	2026-03-02 23:11:13.502	Vente De Cartes Postales (Ex-Edition)	Rue Abdou Karim Bourgi X Rue Du Docteur Theze	33 823 48 04	Dakar	\N	\N	\N	f	\N
1412	Groupe Promo Import	groupe-promo-import	Commerce	\N	2	2026-03-02 23:11:13.504	2026-03-02 23:11:13.504	Commerce	Avenue Cheikh Anta Diop	33 835 53 60	Dakar	\N	\N	\N	f	\N
1413	Medix Sarl	medix-sarl	Commerce De Produits Medicaux	\N	2	2026-03-02 23:11:13.506	2026-03-02 23:11:13.506	Commerce De Produits Medicaux	Rue Jean Mermoz X Past eur	33 889 07 29	Dakar	\N	\N	\N	f	\N
1414	Gie Jfk (Gie Jacqueline Fara Kiki)	gie-jfk-gie-jacqueline-fara-kiki	Commerce	\N	2	2026-03-02 23:11:13.507	2026-03-02 23:11:13.507	Commerce	Rue Amadou Assane Ndoye X Mass Diokhane 0 Dakar El Hadji Bounama Fall Commerce Soprin N°361	77 639 64 07	Dakar	\N	\N	\N	f	\N
1415	Amadou Tidiane W Att	amadou-tidiane-w-att	Commerce U18-546 Parcelles Assainies 0 Dakar Bes Senegal (Bouattour Equipements Services Senegal ) Vente De Materiels De Laboratoire Sicap Baobabs 0 Dakar Tmm Suarl Commerce General	\N	2	2026-03-02 23:11:13.509	2026-03-02 23:11:13.509	Commerce U18-546 Parcelles Assainies 0 Dakar Bes Senegal (Bouattour Equipements Services Senegal ) Vente De Materiels De Laboratoire Sicap Baobabs 0 Dakar Tmm Suarl Commerce General	Rue Carnot X Lamine Gueye 0 Dakar Gie Oubass Commerce General Plles Assainies Unite 16 0 Dakar Ngone & Cheikh Commerce General Ouest Foire 0 Dakar Touba Mathlaboul Faw Zani-Suarl Commerce - Services Rendus Aux Entreprises Centre Co mmercial 4 C N° R-057 0 Dakar International Systeme D'Approvisionnement Commerce General Usine Bene Tally	77 637 97 24	Dakar	\N	\N	\N	f	\N
1416	Magforce Senegal Sarl	magforce-senegal-sarl	Commerce Rond Point Lot N° 47 Sacre Cœur 3 0 Dakar Societe Civile	\N	2	2026-03-02 23:11:13.511	2026-03-02 23:11:13.511	Commerce Rond Point Lot N° 47 Sacre Cœur 3 0 Dakar Societe Civile	Immobiliere Al Jamami Achat Vente Et Location Immobilier Rue Raffenel	77 093 83 33	Dakar	\N	\N	\N	f	\N
1417	Momar Diagne	momar-diagne	Commerce - Transport	\N	2	2026-03-02 23:11:13.513	2026-03-02 23:11:13.513	Commerce - Transport	Rue 29 X Blaise Diagne	33 867 58 46	Dakar	\N	\N	\N	f	\N
1418	M Samir Aly Ahmed Haidar	m-samir-aly-ahmed-haidar	Vente De Textile	\N	2	2026-03-02 23:11:13.515	2026-03-02 23:11:13.515	Vente De Textile	Rue De Thiong	33 820 22 88	Dakar	\N	\N	\N	f	\N
1419	Omega International Sa	omega-international-sa	Commerce General (Couches Sleepy)	\N	2	2026-03-02 23:11:13.517	2026-03-02 23:11:13.517	Commerce General (Couches Sleepy)	Bccd	77 634 48 28	Dakar	\N	\N	\N	f	\N
1420	Disproca 26 (Palais De La Beaute)	disproca-26-palais-de-la-beaute	Commerce General	\N	2	2026-03-02 23:11:13.519	2026-03-02 23:11:13.519	Commerce General	Bd De La Republique	77 638 45 15	Dakar	\N	\N	\N	f	\N
1421	Profebat - Sarl (Porte Fenetre Batiment Plus )	profebat-sarl-porte-fenetre-batiment-plus	Commerce General	\N	2	2026-03-02 23:11:13.521	2026-03-02 23:11:13.521	Commerce General	Route De Rufisque	33 823 90 63	Rufisque	\N	\N	\N	f	\N
1422	Mandela Drugstore Sarl	mandela-drugstore-sarl	Commerce General	\N	2	2026-03-02 23:11:13.522	2026-03-02 23:11:13.522	Commerce General	Avenue Nelson Mandela N° 10	77 525 48 21	Dakar	\N	\N	\N	f	\N
1423	Aivc (Agence Internationale De Voyage Et De	aivc-agence-internationale-de-voyage-et-de	Commerce - Snc) Commerce	\N	2	2026-03-02 23:11:13.524	2026-03-02 23:11:13.524	Commerce - Snc) Commerce	Rue Raffenel	33 825 77 31	Dakar	\N	\N	\N	f	\N
1424	Jts Senegal Sarl (Jardins Tropicaux Semences Senegal - Sarl)	jts-senegal-sarl-jardins-tropicaux-semences-senegal-sarl	Commerce De Semences	\N	2	2026-03-02 23:11:13.526	2026-03-02 23:11:13.526	Commerce De Semences	Avenue Du President Lamine Guey e	33 825 07 97	Thies	\N	\N	\N	f	\N
1425	Complexe Ally Suarl	complexe-ally-suarl	Commerce	\N	2	2026-03-02 23:11:13.528	2026-03-02 23:11:13.528	Commerce	Bd De L'Est X Rue 02 Point E Dakar	33 951 13 34	Dakar	\N	\N	\N	f	\N
1426	Mc Toumani Fall	mc-toumani-fall	Commerce	\N	2	2026-03-02 23:11:13.529	2026-03-02 23:11:13.529	Commerce	Route De Rufisque	33 836 36 75	Dakar	\N	\N	\N	f	\N
1427	Senre Africa Sural	senre-africa-sural	Commerce	\N	2	2026-03-02 23:11:13.531	2026-03-02 23:11:13.531	Commerce	Rue Felix Faure	33 821 54 55	Dakar	\N	\N	\N	f	\N
1428	Cocoser Sarl (Societe De Construction De	cocoser-sarl-societe-de-construction-de	Commerce Et De Services) Commerce General	\N	2	2026-03-02 23:11:13.533	2026-03-02 23:11:13.533	Commerce Et De Services) Commerce General	Rue Non Denommee Diamalaye	33 864 30 03	Dakar	\N	\N	\N	f	\N
1429	Byma Properties Sarl	byma-properties-sarl	Commerce De Materiaux De Construction 129	\N	2	2026-03-02 23:11:13.535	2026-03-02 23:11:13.535	Commerce De Materiaux De Construction 129	Rue Joseph Gomis (Ex 18 Rue Kleber)	77 570 49 82	Dakar	\N	\N	\N	f	\N
1430	Ndane Sene Edimecos	ndane-sene-edimecos	Commerce General	\N	2	2026-03-02 23:11:13.537	2026-03-02 23:11:13.537	Commerce General	Rue Robert Brun	33 864 71 40	Dakar	\N	\N	\N	f	\N
1431	Pharmacie Randoulene (Aladji Ba)	pharmacie-randoulene-aladji-ba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.538	2026-03-02 23:11:13.538	Vente De Produits Pharmaceutiques	Avenue Djibril Dia w	33 821 24 25	Thies	\N	\N	\N	f	\N
1432	Li Chao Yu	li-chao-yu	Commerce General	\N	2	2026-03-02 23:11:13.54	2026-03-02 23:11:13.54	Commerce General	Bd General De Gaulle	33 951 56 64	Dakar	\N	\N	\N	f	\N
1433	Pharmacie Besse (Ndeye Rokhaya Ndoye)	pharmacie-besse-ndeye-rokhaya-ndoye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.542	2026-03-02 23:11:13.542	Vente De Produits Pharmaceutiques	Avenue Bourguiba Face Ecole Nationale De Police	77 659 80 01	Dakar	\N	\N	\N	f	\N
1434	Touba Darou W Ahab W Orld Market	touba-darou-w-ahab-w-orld-market	Commerce Import-Export	\N	2	2026-03-02 23:11:13.544	2026-03-02 23:11:13.544	Commerce Import-Export	Rue Felix Faure 0 Dakar Gie Lumiere Commerce Diamalaye 1, 91 Dakar Yoff	33 864 51 36	Dakar	\N	\N	\N	f	\N
1435	Botabio Sarl	botabio-sarl	Commerce Sodida,	\N	2	2026-03-02 23:11:13.546	2026-03-02 23:11:13.546	Commerce Sodida,	Rue 14 Prolongee Immeuble Les Dunes Appartement B43	77 570 49 82	Dakar	\N	\N	\N	f	\N
1436	Senegal Informatique &	senegal-informatique	Service (Moustaph Diop) Commerce Bureautique Informatique 309 Ouagou Niayes 0 Dakar Ismaila Ka Commerce-Proprietaire	\N	2	2026-03-02 23:11:13.547	2026-03-02 23:11:13.547	Service (Moustaph Diop) Commerce Bureautique Informatique 309 Ouagou Niayes 0 Dakar Ismaila Ka Commerce-Proprietaire	Rue Madeleine Ngom 0 Dakar Mina Services Prestation De Services Et Vente De Marchandises Rue Carnot	77 635 64 14	Dakar	\N	\N	\N	f	\N
1437	Pharmacie Khole	pharmacie-khole	Vente De Produits Pharmaceutiques Thiaroye	\N	2	2026-03-02 23:11:13.549	2026-03-02 23:11:13.549	Vente De Produits Pharmaceutiques Thiaroye	-Quartier ,Camp De Thiaroye 0 Dakar Novis Senegal Sarl Commerce Hann Mariste 1 Lot J 81	33 842 57 84	Pikine	\N	\N	\N	f	\N
1438	Noukhba - Sarl	noukhba-sarl	Commerce General	\N	2	2026-03-02 23:11:13.551	2026-03-02 23:11:13.551	Commerce General	Rue Reins X Av Malick Sy .R.P Ndiaye	77 819 52 77	Dakar	\N	\N	\N	f	\N
1439	Gie Alliance	gie-alliance	Commerce 2 Services Commerce	\N	2	2026-03-02 23:11:13.553	2026-03-02 23:11:13.553	Commerce 2 Services Commerce	Avenue Blaise Diagne X Rue 07 0 Dakar Miw Import Export Suarl Commerce General Rue 17 X 18 Medina	33 820 25 00	Dakar	\N	\N	\N	f	\N
1440	Entreprise Activité Adresse Téléphone Dakar Acc (Atlas Commercial Center) Sarl	entreprise-activite-adresse-telephone-dakar-acc-atlas-commercial-center-sarl	Commerce	\N	2	2026-03-02 23:11:13.554	2026-03-02 23:11:13.554	Commerce	Rue 11 X 12 Medina Dakar	77 635 39 89	Ville	\N	\N	\N	f	\N
1441	Africa Frozen Food "A -2- Food"	africa-frozen-food-a-2-food	Commerce General	\N	2	2026-03-02 23:11:13.556	2026-03-02 23:11:13.556	Commerce General	Rue Aristide Le Dantec 0 Dakar Bureautique Informatique Services Suarl Activite De Commerce De Materiels Informatique Rue Castors Villa N° 49	77 322 63 63	Dakar	\N	\N	\N	f	\N
1442	Avantages	avantages	Distributions Commerce General	\N	2	2026-03-02 23:11:13.558	2026-03-02 23:11:13.558	Distributions Commerce General	Rue 67 X 68 Gueule Tapee	77 644 30 26	Dakar	\N	\N	\N	f	\N
1443	Groupe M2D Sarl	groupe-m2d-sarl	Commerce Machines Mat Et Auto. Outil. En Main	\N	2	2026-03-02 23:11:13.56	2026-03-02 23:11:13.56	Commerce Machines Mat Et Auto. Outil. En Main	Rue Victor Hugo	77 633 77 33	Dakar	\N	\N	\N	f	\N
1444	Touba Plaques Sarl	touba-plaques-sarl	Commerce General Rocade Fann Bel Air 0 Dakar Moss Doly (Saer Toure) Vente D'Eau En Sachets Patte D'Oie Builders Villa C 20 0 Dakar Tidiane Diatta Commerce	\N	2	2026-03-02 23:11:13.563	2026-03-02 23:11:13.563	Commerce General Rocade Fann Bel Air 0 Dakar Moss Doly (Saer Toure) Vente D'Eau En Sachets Patte D'Oie Builders Villa C 20 0 Dakar Tidiane Diatta Commerce	Rue Zone B Dakar 0 Dakar Le Ndoucoumane (Fadel Diagne) Commerce Medina Rue 7 X 12	33 820 24 17	Dakar	\N	\N	\N	f	\N
1445	Ets Sopey Serigne Fallou Mbacke (Salimata Faye )	ets-sopey-serigne-fallou-mbacke-salimata-faye	Commerce General	\N	2	2026-03-02 23:11:13.565	2026-03-02 23:11:13.565	Commerce General	Quartier Fass Delorme Plle N° 3 0 Dakar Neosys International Commerce Sicap Mermoz Villa 7283	33 822 65 62	Dakar	\N	\N	\N	f	\N
1446	Mbeyane Entreprises Autres	mbeyane-entreprises-autres	Commerces Sicap Amite Iii Villa N°4480 0 Dakar Prolub Sarl Vente D'Equipements De Garage Et De Lubrifiants	\N	2	2026-03-02 23:11:13.567	2026-03-02 23:11:13.567	Commerces Sicap Amite Iii Villa N°4480 0 Dakar Prolub Sarl Vente D'Equipements De Garage Et De Lubrifiants	Bccd	33 864 22 02	Dakar	\N	\N	\N	f	\N
1447	Pharmacie Sainte Agnes (Dr Mariane Marguerite Dieng )	pharmacie-sainte-agnes-dr-mariane-marguerite-dieng	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.569	2026-03-02 23:11:13.569	Vente De Produits Pharmaceutiques	Quartier Arafat Ro ute De Sococim - Rufisque 0 Dakar All Group Sarl Commerce General Route De L'Aeroport Cite Canada	33 832 64 14	Rufisque	\N	\N	\N	f	\N
1448	Entreprise Sokhna Khady (Malick Gueye)	entreprise-sokhna-khady-malick-gueye	Vente De Gaz	\N	1	2026-03-02 23:11:13.571	2026-03-02 23:11:13.571	Vente De Gaz	Route De Rufisque,Diamaguene Sicap Mbao	33 820 39 46	Dakar	\N	\N	\N	f	\N
1449	Mafopress (Cherif Tall)	mafopress-cherif-tall	Vente Fournitures De Bureau	\N	2	2026-03-02 23:11:13.573	2026-03-02 23:11:13.573	Vente Fournitures De Bureau	Avenue Samba Gueye	77 633 19 21	Dakar	\N	\N	\N	f	\N
1450	Galerie Arte	galerie-arte	Vente De Produits Artistiques	\N	2	2026-03-02 23:11:13.575	2026-03-02 23:11:13.575	Vente De Produits Artistiques	Rue Victor Hugo	33 821 73 11	Dakar	\N	\N	\N	f	\N
1451	Aly Ahmed Berry (Stop 1000 Tex)	aly-ahmed-berry-stop-1000-tex	Vente De Textile	\N	2	2026-03-02 23:11:13.577	2026-03-02 23:11:13.577	Vente De Textile	Rue De Thiong	33 821 95 56	Dakar	\N	\N	\N	f	\N
1452	Univers Import Export (Abdou Karim Sam)	univers-import-export-abdou-karim-sam	Commerce General Cite Hlm 4 N° 2334 0 Dakar Babacar Gueye Epsilon Commerce De Marchandises Diverses Et Automobile Yoff N'Diouffene	\N	2	2026-03-02 23:11:13.578	2026-03-02 23:11:13.578	Commerce General Cite Hlm 4 N° 2334 0 Dakar Babacar Gueye Epsilon Commerce De Marchandises Diverses Et Automobile Yoff N'Diouffene	Route De L'Aeroport	33 823 71 92	Dakar	\N	\N	\N	f	\N
1453	Eurabat Sa (Eurafricaine De Batiment Sa)	eurabat-sa-eurafricaine-de-batiment-sa	Commerce De Materiaux De Construction	\N	2	2026-03-02 23:11:13.58	2026-03-02 23:11:13.58	Commerce De Materiaux De Construction	Rue Felix Ebou e 33822 77 23 Dakar Gie Kaw Ral Commerce General Rue Grasland 0 Dakar Cgmg (Commerce Generale Maintenance Generale ( Yade Papa Gora) Commerce General Ouest Foire En Face Imprimerie Tand ian	77 639 86 89	Dakar	\N	\N	\N	f	\N
1454	Hkw Suarl	hkw-suarl	Commerce	\N	2	2026-03-02 23:11:13.582	2026-03-02 23:11:13.582	Commerce	Route Du Meridien President	77 552 39 34	Dakar	\N	\N	\N	f	\N
1455	Gie Atk	gie-atk	Commerce General	\N	2	2026-03-02 23:11:13.584	2026-03-02 23:11:13.584	Commerce General	Quartier Darou Salam Dalifort 0 Dakar Bt Btp "Baobab Total Batiments & Travaux Publics" (Quincaillerie Baobab) Commerce Quincaillerie Avenue Dial Diop Grand- Dakar	33 832 04 77	Dakar	\N	\N	\N	f	\N
1456	Virage Materiaux Suarl	virage-materiaux-suarl	Commerce	\N	2	2026-03-02 23:11:13.587	2026-03-02 23:11:13.587	Commerce	Route De L'Aeroport Face Hopital Philippe Senghor	33 824 97 99	Dakar	\N	\N	\N	f	\N
1457	Mac 2 Suarl	mac-2-suarl	Commerce General	\N	2	2026-03-02 23:11:13.589	2026-03-02 23:11:13.589	Commerce General	Route Des Abattoirs Seras	33 864 07 40	Pikine	\N	\N	\N	f	\N
1458	Reda Hussein	reda-hussein	Commerce General	\N	2	2026-03-02 23:11:13.591	2026-03-02 23:11:13.591	Commerce General	Abdou Karim Bourgi Dakar	33 825 48 43	Dakar	\N	\N	\N	f	\N
1459	Salam Sarl	salam-sarl	Commerce De Marchandises Diverses Sea Plaza Shopping Mall Corniche Ouest 0 Dakar Ets Inssa Gaye Commercant Commerce	\N	2	2026-03-02 23:11:13.593	2026-03-02 23:11:13.593	Commerce De Marchandises Diverses Sea Plaza Shopping Mall Corniche Ouest 0 Dakar Ets Inssa Gaye Commercant Commerce	Rue Raffenel	77 560 61 41	Dakar	\N	\N	\N	f	\N
1460	Librairie Papeterie Bëg Baye Niasse	librairie-papeterie-beg-baye-niasse	Vente De Fournitures Scolaires	\N	2	2026-03-02 23:11:13.594	2026-03-02 23:11:13.594	Vente De Fournitures Scolaires	Rue 13 En Face Chez M ax Castor 0 Dakar Sial Sarl Commerce Yoff Tonghore Route De L'Aeroport Villa N°5	77 644 89 25	Dakar	\N	\N	\N	f	\N
1461	Kfc (Keur Fatou Carreaux) - Pathe Mboup	kfc-keur-fatou-carreaux-pathe-mboup	Commerce General Sicap Mbao	\N	2	2026-03-02 23:11:13.596	2026-03-02 23:11:13.596	Commerce General Sicap Mbao	Immeuble Adja Fath Dieng	33 820 69 33	Dakar	\N	\N	\N	f	\N
1462	Entreprise F.K. Vitprop (Fatou Diaw )	entreprise-f-k-vitprop-fatou-diaw	Commerce De Produits Alimentaires Rez De Chausee	\N	2	2026-03-02 23:11:13.598	2026-03-02 23:11:13.598	Commerce De Produits Alimentaires Rez De Chausee	Imm euble J Sacre Cœur	33 865 37 31	Dakar	\N	\N	\N	f	\N
1463	Etipam (Bounama Diagne)	etipam-bounama-diagne	Commerce	\N	2	2026-03-02 23:11:13.6	2026-03-02 23:11:13.6	Commerce	Avenue Gnagna Sow Escale Thies	77 512 36 68	Thies	\N	\N	\N	f	\N
1464	Saqara Suarl	saqara-suarl	Commerce	\N	2	2026-03-02 23:11:13.602	2026-03-02 23:11:13.602	Commerce	Route De L'Aeroport	33 951 19 45	Dakar	\N	\N	\N	f	\N
1465	Gie Succes	gie-succes	Commerce General Cite Sabe Villa N°20 Km 16	\N	2	2026-03-02 23:11:13.604	2026-03-02 23:11:13.604	Commerce General Cite Sabe Villa N°20 Km 16	Route De Rufisque	33 820 17 96	Pikine	\N	\N	\N	f	\N
1466	Meissa Niang	meissa-niang	Commerce General	\N	2	2026-03-02 23:11:13.606	2026-03-02 23:11:13.606	Commerce General	Rue 6X23 Medina	77 969 84 22	Dakar	\N	\N	\N	f	\N
1467	Edisen Sarl	edisen-sarl	Commerce General	\N	2	2026-03-02 23:11:13.608	2026-03-02 23:11:13.608	Commerce General	Avenue Lamine Gueye 0 Mbour Gie Keur Mbodiene Commerce Mbodiene 0 Ville Entreprise Activité Adresse Téléphone Dakar Sedil (Senegalaise De Distribution Et De Logistique) Commerce General Nord Foire Azur Villa N°101	77 646 58 63	Dakar	\N	\N	\N	f	\N
1468	Gie Emaf Auto Pieces	gie-emaf-auto-pieces	Commerce Pieces Auto Grand Medine	\N	2	2026-03-02 23:11:13.61	2026-03-02 23:11:13.61	Commerce Pieces Auto Grand Medine	Route Des Parcelle s Assainies	77 265 63 00	Dakar	\N	\N	\N	f	\N
1469	Zeina Saheli	zeina-saheli	Commerce General	\N	2	2026-03-02 23:11:13.612	2026-03-02 23:11:13.612	Commerce General	Rue Mousse Diop 0 Dakar Socoprev Suarl(Societe De Construction De Prestations De Services Et De Vente) Autres Commerce De Deatil Hors Magazin Villa 41/P Sc at Urbam 776387586 Dakar Medika Group Sarl Achat Et Vente De Produits Medicaux Zone B Ballon N° 26	33 835 39 13	Dakar	\N	\N	\N	f	\N
1470	Senegalaise D'Entreprises (Aminata Sakho)	senegalaise-d-entreprises-aminata-sakho	Commerce	\N	2	2026-03-02 23:11:13.614	2026-03-02 23:11:13.614	Commerce	Rue Ousmane Soce Diop Keury Souf	33 832 27 92	Rufisque	\N	\N	\N	f	\N
1471	La Maison Verte Sarl	la-maison-verte-sarl	Commerce Produits Bois	\N	2	2026-03-02 23:11:13.616	2026-03-02 23:11:13.616	Commerce Produits Bois	Rue Victor Hugo	77 636 26 79	Dakar	\N	\N	\N	f	\N
1472	Khew El Gui W Akeur Serigne Fallou	khew-el-gui-w-akeur-serigne-fallou	Commerce General	\N	2	2026-03-02 23:11:13.619	2026-03-02 23:11:13.619	Commerce General	Avenue Blaise Diagne	33 822 35 36	Dakar	\N	\N	\N	f	\N
1473	Transmecom -Sarl (Transport Mecanique	transmecom-sarl-transport-mecanique	Commerce) Commerce - Mecanique	\N	2	2026-03-02 23:11:13.622	2026-03-02 23:11:13.622	Commerce) Commerce - Mecanique	Route De Rufisque	33 860 14 04	Pikine	\N	\N	\N	f	\N
1474	Kar Business Et Trading (Racine Amadou Kane)	kar-business-et-trading-racine-amadou-kane	Commerce Et Prestation De Service	\N	2	2026-03-02 23:11:13.625	2026-03-02 23:11:13.625	Commerce Et Prestation De Service	Route Des Niayes P ikine Dakar	33 837 21 45	Dakar	\N	\N	\N	f	\N
1475	Gie Sunu Keur De Medina	gie-sunu-keur-de-medina	Vente De Textile	\N	2	2026-03-02 23:11:13.627	2026-03-02 23:11:13.627	Vente De Textile	Rue 22 X 33 Medina	77 337 35 70	Dakar	\N	\N	\N	f	\N
1476	Gie Taif Papeterie	gie-taif-papeterie	Vente De Marchandises Diverses	\N	2	2026-03-02 23:11:13.63	2026-03-02 23:11:13.63	Vente De Marchandises Diverses	Rue 19 X 20 Medina 0 Dakar Capd -Suarl(Centre Africain De Pneumatiques Et Dive rs) Vente De Marchandises Route Du Front De Terre Villa N°2 0 Dakar Msl Multiservices Lune (Alioune Badara Diop) Commerce Sicap Liberte Vi Extension	77 559 43 21	Dakar	\N	\N	\N	f	\N
1477	Bip	bip	Distribution (Modou Gaye) Vente De Materiel Informatique - Fournitures Informatiques Et Bureautique	\N	2	2026-03-02 23:11:13.632	2026-03-02 23:11:13.632	Distribution (Modou Gaye) Vente De Materiel Informatique - Fournitures Informatiques Et Bureautique	Rue 17 X 10 Medina	33 867 65 10	Dakar	\N	\N	\N	f	\N
1478	Papeterie Sope Nabi Suarl	papeterie-sope-nabi-suarl	Vente De Demateriels Informatique Et Consommable	\N	2	2026-03-02 23:11:13.634	2026-03-02 23:11:13.634	Vente De Demateriels Informatique Et Consommable	Avenue Blaise Diagne Face Rue 17 Dakar	77 251 38 66	Dakar	\N	\N	\N	f	\N
1479	Ets Babacar Kebe	ets-babacar-kebe	Commerce	\N	2	2026-03-02 23:11:13.636	2026-03-02 23:11:13.636	Commerce	Quartier Santa Yalla Boune Yeumbeul	33 842 86 88	Pikine	\N	\N	\N	f	\N
1480	Quincaillerie Jubo (Amadou Mbengue)	quincaillerie-jubo-amadou-mbengue	Vente De Materiel Electrique	\N	2	2026-03-02 23:11:13.639	2026-03-02 23:11:13.639	Vente De Materiel Electrique	Rue 22 X 25 Medina	78 210 89 45	Dakar	\N	\N	\N	f	\N
1481	Abdoulaye Mbengue	abdoulaye-mbengue	Vente De Marchandises Diverses	\N	2	2026-03-02 23:11:13.641	2026-03-02 23:11:13.641	Vente De Marchandises Diverses	Rue 15 X 22 Medina 0 Pikine Massaroise De Distribution Sarl Commerce De Detail En Magasin Specialise De Produits Alimentaires Route Cite Enseignants Face Senelec	33 821 43 32	Dakar	\N	\N	\N	f	\N
1482	Le Ndar Manco Suarl	le-ndar-manco-suarl	Commerce Sotrac Mermoz	\N	2	2026-03-02 23:11:13.643	2026-03-02 23:11:13.643	Commerce Sotrac Mermoz	Imm Rose 0 Thies Gora Diop Commerce Marche Central Thies 0 Kaolack Pharmacie Malem Hodar Vente De Produits Pharmaceutiques Maleme Hodar 0 Mbour Horta -Sarl Commerce Nationale 1 Quartier Medine	77 550 13 13	Dakar	\N	\N	\N	f	\N
1483	H & M (Hussein & Mahen)	h-m-hussein-mahen	Commerce De Vaisselles	\N	2	2026-03-02 23:11:13.645	2026-03-02 23:11:13.645	Commerce De Vaisselles	Rue Du Liban Ex Tolbiac	33 868 83 86	Dakar	\N	\N	\N	f	\N
1484	Gie Frami	gie-frami	Commerce	\N	2	2026-03-02 23:11:13.648	2026-03-02 23:11:13.648	Commerce	Rue Fleurus 0 Dakar Dimag Suarl Distribution De Materiel Pour L'Art Graphique Sicap Liberte 2 Villa N° 1544	33 822 25 66	Dakar	\N	\N	\N	f	\N
1485	Senett Sarl Nettoyage Et	senett-sarl-nettoyage-et	Vente De Produits D'Entretien	\N	2	2026-03-02 23:11:13.65	2026-03-02 23:11:13.65	Vente De Produits D'Entretien	Rue Hlm G rand Yoff 0 Dakar Laye Sock Commerce Pikine Cite Sotiba N° 50-Bis	33 865 17 65	Dakar	\N	\N	\N	f	\N
1486	Mopad-Groupe Sarl	mopad-groupe-sarl	Commerce	\N	2	2026-03-02 23:11:13.652	2026-03-02 23:11:13.652	Commerce	Rue 37 X 36 Medina 0 Dakar Dm21 (Amadou Sow ) Distribution De Materiels Industriels Et Informatiques (Commerce General Rue Tolbiac X Brassa	33 834 37 03	Dakar	\N	\N	\N	f	\N
1487	Hachem Yazback	hachem-yazback	Vente De Textile	\N	2	2026-03-02 23:11:13.654	2026-03-02 23:11:13.654	Vente De Textile	Rue Galandou Diouf	33 827 69 60	Dakar	\N	\N	\N	f	\N
1488	Gie Sand Automobiles	gie-sand-automobiles	Commerce	\N	2	2026-03-02 23:11:13.656	2026-03-02 23:11:13.656	Commerce	Rue De Denain X Parchappe 33823 33 02 Mbour Gie Prokhane Keur Mame Diarra Bousso Commerce De Gros De Textiles - Habillement Et Chaussures Mbour Escale	33 822 50 40	Dakar	\N	\N	\N	f	\N
1489	Oumar Gning	oumar-gning	Commerce	\N	2	2026-03-02 23:11:13.658	2026-03-02 23:11:13.658	Commerce	Rue Escaffait 0 Dakar Pharmacie Nouvelle Baobab - Pierre Fayemi Adelanw A Vente De Produits Pharmaceutiques Sicap Baobabs - Ru e Ezzo	77 513 99 44	Dakar	\N	\N	\N	f	\N
1490	Darou Salam Import Export	darou-salam-import-export	Commerce Ouagou Niayes	\N	2	2026-03-02 23:11:13.66	2026-03-02 23:11:13.66	Commerce Ouagou Niayes	Rue Denommee 33824 51 23 Dakar Societe Sene Services 3S Sarl Commerce Divers Village De Ngor Almadies En Face Du Marche	33 825 44 57	Dakar	\N	\N	\N	f	\N
1491	Taliacom Sarl	taliacom-sarl	Commerce	\N	2	2026-03-02 23:11:13.662	2026-03-02 23:11:13.662	Commerce	Rue Saint Michel Immeuble Coumba Castel	33 863 15 26	Dakar	\N	\N	\N	f	\N
1492	M.S.C.S (Millienium Securite Construction Et Servic es - Suarl)	m-s-c-s-millienium-securite-construction-et-servic-es-suarl	Commerce Nord Foire Villa N° B-12 0 Dakar	\N	2	2026-03-02 23:11:13.664	2026-03-02 23:11:13.664	Commerce Nord Foire Villa N° B-12 0 Dakar	Abdourahmane Basse "City Appartements" Commerce Rue Victor Hugo 0 Dakar El Hadji Ndiaye Commerce De Marchandises Diverses Rue Fleurus 0 Pikine Djibril Ndiogou Fall Commerce General Route De Rufisque (Oryx Thiaroye Su r Mer)	33 823 02 75	Dakar	\N	\N	\N	f	\N
1493	Dipres Sarl (Duplication - Impression Et Prestation	dipres-sarl-duplication-impression-et-prestation	Commerce General	\N	2	2026-03-02 23:11:13.666	2026-03-02 23:11:13.666	Commerce General	Rue Amadou Assane Ndoye	77 638 93 01	Dakar	\N	\N	\N	f	\N
1494	Shopping Hotel Suarl	shopping-hotel-suarl	Vente De Rpoduits Hoteliers	\N	2	2026-03-02 23:11:13.668	2026-03-02 23:11:13.668	Vente De Rpoduits Hoteliers	Rue Felix Faure	33 822 77 99	Dakar	\N	\N	\N	f	\N
1495	Ladkani Zahra	ladkani-zahra	Commerce Materiaux De Construction	\N	2	2026-03-02 23:11:13.67	2026-03-02 23:11:13.67	Commerce Materiaux De Construction	Avenue Ousmane Soce Diop Quartier Keury Souf	33 842 95 75	Rufisque	\N	\N	\N	f	\N
1496	Mor Ndiaye	mor-ndiaye-1	Vente De Marchandises Diverses	\N	2	2026-03-02 23:11:13.672	2026-03-02 23:11:13.672	Vente De Marchandises Diverses	Rue Fleurus 0 Dakar Badu Technology El Hadji Alioune Cisse Commerce Rue 6X23 Medina	77 559 35 32	Dakar	\N	\N	\N	f	\N
1497	Rms (Regina Multi	rms-regina-multi	Service) Commerce -Librairie - Papeterie	\N	2	2026-03-02 23:11:13.674	2026-03-02 23:11:13.674	Service) Commerce -Librairie - Papeterie	Boulevard General De Gaulle	77 551 05 06	Dakar	\N	\N	\N	f	\N
1498	Omar Gning	omar-gning	Commerce	\N	2	2026-03-02 23:11:13.676	2026-03-02 23:11:13.676	Commerce	Rue Escarfait X Tolbiac	77 224 70 03	Dakar	\N	\N	\N	f	\N
1499	Turkey Senegal	turkey-senegal	Commerce Commerce General	\N	2	2026-03-02 23:11:13.678	2026-03-02 23:11:13.678	Commerce Commerce General	Rue Felix Eboue	77 822 48 18	Dakar	\N	\N	\N	f	\N
1500	Gie Bissik Informatique	gie-bissik-informatique	Vente Materiells Et Consommable D'Ordinateurs,Fournitures Bureautique Yaye Bigue Toure	\N	2	2026-03-02 23:11:13.68	2026-03-02 23:11:13.68	Vente Materiells Et Consommable D'Ordinateurs,Fournitures Bureautique Yaye Bigue Toure	Rue 63X50 Bld De La Geule Tapee-Dakar	77 546 68 55	Dakar	\N	\N	\N	f	\N
1501	Asse Gueye (Diamal Multi	asse-gueye-diamal-multi	Services) Commerce General	\N	2	2026-03-02 23:11:13.682	2026-03-02 23:11:13.682	Services) Commerce General	Rue Madeleine Ngom	33 961 62 38	Dakar	\N	\N	\N	f	\N
1502	Future	future	Service Et Tech (Momath Gaye) Commerce General	\N	2	2026-03-02 23:11:13.684	2026-03-02 23:11:13.684	Service Et Tech (Momath Gaye) Commerce General	Bd Dial Diop X Bd G Tapee	77 541 23 10	Dakar	\N	\N	\N	f	\N
1503	Taysirou Azir	taysirou-azir	Commerce	\N	2	2026-03-02 23:11:13.686	2026-03-02 23:11:13.686	Commerce	Immeuble Ndiaga Diop Colobane	33 855 99 37	Dakar	\N	\N	\N	f	\N
1504	Sup Negoce (Moutie Fatima Zahra)	sup-negoce-moutie-fatima-zahra	Commerce	\N	2	2026-03-02 23:11:13.688	2026-03-02 23:11:13.688	Commerce	Rue Abdou Karim Bourgi	77 511 66 60	Dakar	\N	\N	\N	f	\N
1505	Modou Kasse Lamp Fall Electronic	modou-kasse-lamp-fall-electronic	Commerce	\N	2	2026-03-02 23:11:13.689	2026-03-02 23:11:13.689	Commerce	Avenue Georges Pompidou	77 552 52 82	Dakar	\N	\N	\N	f	\N
1506	Iffs	iffs	Commerce General Mermoz 0 Rufisque Dame Gningue Commerce General Qrt Nguessou Rufisque 0 Dakar Bon Marche Africaine Commerce	\N	2	2026-03-02 23:11:13.691	2026-03-02 23:11:13.691	Commerce General Mermoz 0 Rufisque Dame Gningue Commerce General Qrt Nguessou Rufisque 0 Dakar Bon Marche Africaine Commerce	Rue Fila Fann Hokh	33 942 23 23	Dakar	\N	\N	\N	f	\N
1507	Gie Medina Telecom	gie-medina-telecom	Commerce Materiels Electroniques Et Elec	\N	2	2026-03-02 23:11:13.693	2026-03-02 23:11:13.693	Commerce Materiels Electroniques Et Elec	Rue 10 X 23 Medina	33 822 30 57	Dakar	\N	\N	\N	f	\N
1508	Folou Sarl Activites Informatique	folou-sarl-activites-informatique	(Vente De Logiciels Et Livres) Cite Air France	\N	2	2026-03-02 23:11:13.695	2026-03-02 23:11:13.695	(Vente De Logiciels Et Livres) Cite Air France	Imm. Ndiouk 2 Eme Etage	33 821 50 60	Dakar	\N	\N	\N	f	\N
1509	Dagga Colors Sarl	dagga-colors-sarl	Vente De Peinture Automobile	\N	2	2026-03-02 23:11:13.697	2026-03-02 23:11:13.697	Vente De Peinture Automobile	Rue 39 X 28 Medina	33 872 11 37	Dakar	\N	\N	\N	f	\N
1510	Gie Alu Metal Art De Vivre	gie-alu-metal-art-de-vivre	Commerce Nord Foire N° 31 0 Dakar Aladji Moth Gaye Commerce Marche Tilene 0 Dakar Seas - Sa (Ste Etoile Automobile Du Senegal) Commerce De Vehicule - Entretien Et Reparation Vehicules	\N	1	2026-03-02 23:11:13.699	2026-03-02 23:11:13.699	Commerce Nord Foire N° 31 0 Dakar Aladji Moth Gaye Commerce Marche Tilene 0 Dakar Seas - Sa (Ste Etoile Automobile Du Senegal) Commerce De Vehicule - Entretien Et Reparation Vehicules	Bccd	33 821 14 32	Dakar	\N	\N	\N	f	\N
1511	Scene D'Interieur (Nadia Sayegh)	scene-d-interieur-nadia-sayegh	Commerce	\N	2	2026-03-02 23:11:13.701	2026-03-02 23:11:13.701	Commerce	Rue Mousse Diop 0 Dakar Thiaat Sarl Commerce General Cite Avion Ouakam Villa N°166 33 821 78 02/77 199 83 80 Dakar Food Store And Equipements Commerce De Produits Alimentaire Sacre Cœur 3	33 842 21 67	Dakar	\N	\N	\N	f	\N
1512	Thecogas Senegal Sarl	thecogas-senegal-sarl	Production Et Distribution De Gaz Sogas Km	\N	1	2026-03-02 23:11:13.702	2026-03-02 23:11:13.702	Production Et Distribution De Gaz Sogas Km	Bccd	33 860 22 01	Dakar	\N	\N	\N	f	\N
1513	Abdou Gaye -Qmdb	abdou-gaye-qmdb	Commerce	\N	2	2026-03-02 23:11:13.704	2026-03-02 23:11:13.704	Commerce	Rue Fleurus X Galandou Diouf 0 Mbao W Akeur Serigne Massamba Mbacke Commerce De Vehicules Et Vente De Pieces Detachees Mbao Gare N°38 0 Dakar Makhtar Camara Commerce Sicap Liberte 1 0 Dakar Dakar Multi Services - D.M.S. (Ababacar Diome) Vente De Materiels Electriques Rue Marchand X Lamine Gueye	33 860 73 57	Dakar	\N	\N	\N	f	\N
1514	Talla Fall	talla-fall	Commerce Hlm Fass Villa N° 48 0 Dakar Yahia Hedi Commerce	\N	2	2026-03-02 23:11:13.706	2026-03-02 23:11:13.706	Commerce Hlm Fass Villa N° 48 0 Dakar Yahia Hedi Commerce	Rue Galandou Diouf	33 821 70 40	Dakar	\N	\N	\N	f	\N
1515	Codaipex (Compagnie Dakaroise D'Import - D'Export) Autres	codaipex-compagnie-dakaroise-d-import-d-export-autres	Commerce	\N	2	2026-03-02 23:11:13.708	2026-03-02 23:11:13.708	Commerce	Avenue Felix Eboue	33 822 01 90	Dakar	\N	\N	\N	f	\N
1516	Aye Consult Plus	aye-consult-plus	Commerce & Prestation De Services, Consultance En Genie Civile	\N	2	2026-03-02 23:11:13.71	2026-03-02 23:11:13.71	Commerce & Prestation De Services, Consultance En Genie Civile	Rue Cite Du Golf De Camberene	33 823 84 66	Guediaw	\N	\N	\N	f	\N
1517	Papa Sankhe	papa-sankhe	Commerce	\N	2	2026-03-02 23:11:13.711	2026-03-02 23:11:13.711	Commerce	Rue9009 Sacre Cœur	77 299 31 18	Dakar	\N	\N	\N	f	\N
1518	Mahmoud Hachem	mahmoud-hachem	Commerce General	\N	2	2026-03-02 23:11:13.713	2026-03-02 23:11:13.713	Commerce General	Avenue Jean Jaures	33 827 52 09	Dakar	\N	\N	\N	f	\N
1519	Ecomarche Sarl	ecomarche-sarl	Commerce - Epicerie	\N	2	2026-03-02 23:11:13.715	2026-03-02 23:11:13.715	Commerce - Epicerie	Avenue Cheikh Anta Diop X Canal4	33 821 71 83	Dakar	\N	\N	\N	f	\N
1520	Anays -Suarl	anays-suarl	Commerce General Nord Foire Azur N° 18 0 Ziguinchor Casa Optic Suarl Opticien (Montage Et Vente De Lunettes)	\N	2	2026-03-02 23:11:13.717	2026-03-02 23:11:13.717	Commerce General Nord Foire Azur N° 18 0 Ziguinchor Casa Optic Suarl Opticien (Montage Et Vente De Lunettes)	Avenue Du Do cteur Carvalho	77 546 67 68	Dakar	\N	\N	\N	f	\N
1521	Global Com (Abdou Latif Dipp)	global-com-abdou-latif-dipp	Commerce General	\N	2	2026-03-02 23:11:13.719	2026-03-02 23:11:13.719	Commerce General	Rue Fleurus	77 630 62 65	Dakar	\N	\N	\N	f	\N
1522	Aye 2F . A Consulting (Babacar Drame) Autres	aye-2f-a-consulting-babacar-drame-autres	Commerces Unite 3	\N	2	2026-03-02 23:11:13.721	2026-03-02 23:11:13.721	Commerces Unite 3	Rue 232 Parcelles Assainies 0 Dakar Ets El Amine (Etablissements El Amine) Commerce Hlm Grand-Yoff	77 568 64 68	Guediaw	\N	\N	\N	f	\N
1523	Entreprise Activité Adresse Téléphone Dakar Cheikh Thiam	entreprise-activite-adresse-telephone-dakar-cheikh-thiam	Vente De Marchandises Diverses	\N	2	2026-03-02 23:11:13.723	2026-03-02 23:11:13.723	Vente De Marchandises Diverses	Rue Valmy	77 648 96 75	Ville	\N	\N	\N	f	\N
1524	Librairie Hachem - Mohamed Aly Hachem Autres	librairie-hachem-mohamed-aly-hachem-autres	Commerce - Librairie	\N	2	2026-03-02 23:11:13.724	2026-03-02 23:11:13.724	Commerce - Librairie	Rue Valmy	77 635 50 67	Dakar	\N	\N	\N	f	\N
1525	Ch Plus Sarl	ch-plus-sarl	Vente De Lingettes	\N	2	2026-03-02 23:11:13.726	2026-03-02 23:11:13.726	Vente De Lingettes	Route Des Almadies Lot A 0 Dakar Uprising Group Sarl Vente De Marchandises Rdc Immeuble Sacre Cœur	33 821 01 62	Dakar	\N	\N	\N	f	\N
1526	Salia (Societe Alimentaire Africaine)	salia-societe-alimentaire-africaine	Vente De Produits Alimentaire	\N	2	2026-03-02 23:11:13.728	2026-03-02 23:11:13.728	Vente De Produits Alimentaire	Rue Sandiniery	77 501 58 62	Dakar	\N	\N	\N	f	\N
1527	Jiasen Bao	jiasen-bao	Commerce Bld De La Republique 0 Dakar Gie Agdis (Agence Generale De Distribution) Commerce General	\N	2	2026-03-02 23:11:13.73	2026-03-02 23:11:13.73	Commerce Bld De La Republique 0 Dakar Gie Agdis (Agence Generale De Distribution) Commerce General	Avenue Andre Peytavin	77 638 47 26	Dakar	\N	\N	\N	f	\N
1528	Delicia - Sarl	delicia-sarl	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:13.732	2026-03-02 23:11:13.732	Commerce De Produits Alimentaires	Rue G X Rue Leon Gontran Damas, Fann Residence	77 506 30 27	Dakar	\N	\N	\N	f	\N
1529	Bureatique	bureatique	Services Plus (Tiane Eveline Ndiaye) Commerce	\N	2	2026-03-02 23:11:13.734	2026-03-02 23:11:13.734	Services Plus (Tiane Eveline Ndiaye) Commerce	Rue Jules Ferry	77 639 43 37	Dakar	\N	\N	\N	f	\N
1530	La Cle Du Millionnaire (Mame Fatou Sy)	la-cle-du-millionnaire-mame-fatou-sy	Vente De Billets De Loterie - Vente De Cles	\N	2	2026-03-02 23:11:13.735	2026-03-02 23:11:13.735	Vente De Billets De Loterie - Vente De Cles	Avenue J ean Jaures	76 569 24 02	Dakar	\N	\N	\N	f	\N
1531	Toure Computer Systeme(Abdoulaye Toure)	toure-computer-systeme-abdoulaye-toure	Commerce Informatique	\N	2	2026-03-02 23:11:13.737	2026-03-02 23:11:13.737	Commerce Informatique	Rue 45 X 28 Medina Dakar	77 044 68 51	Dakar	\N	\N	\N	f	\N
1532	Chantal Pimpernelle	chantal-pimpernelle	Commerce Saly Portudal Villa Alize N° 41 0 Dakar Saliou Services Vente De Marchandises Diverses	\N	2	2026-03-02 23:11:13.739	2026-03-02 23:11:13.739	Commerce Saly Portudal Villa Alize N° 41 0 Dakar Saliou Services Vente De Marchandises Diverses	Rue 37 X 18 Medina	77 561 80 45	Mbour	\N	\N	\N	f	\N
1533	Enaf Sarl (Europeenne De Negoce En Afrique - Sarl)	enaf-sarl-europeenne-de-negoce-en-afrique-sarl	Commerce General	\N	2	2026-03-02 23:11:13.741	2026-03-02 23:11:13.741	Commerce General	Rue Alfred Goux	77 632 79 51	Dakar	\N	\N	\N	f	\N
1534	Guinness Cameroun Sa	guinness-cameroun-sa	Commerce De Produits Alimentaires (Bierre)	\N	2	2026-03-02 23:11:13.743	2026-03-02 23:11:13.743	Commerce De Produits Alimentaires (Bierre)	Route De Ngor, Les Almadies	77 644 08 51	Dakar	\N	\N	\N	f	\N
1535	Ets Nemer Sara - Sarl	ets-nemer-sara-sarl	Commerce Alimentaire	\N	2	2026-03-02 23:11:13.745	2026-03-02 23:11:13.745	Commerce Alimentaire	Rue Lemoine	77 638 81 16	Ziguinchor	\N	\N	\N	f	\N
1536	D -	d	Services Sarl Commerce General	\N	2	2026-03-02 23:11:13.748	2026-03-02 23:11:13.748	Services Sarl Commerce General	Immeuble Namora 1Er Etage	77 537 47 70	Dakar	\N	\N	\N	f	\N
1537	Daouda Soumah	daouda-soumah	Commerce Bureautique Informatique	\N	2	2026-03-02 23:11:13.75	2026-03-02 23:11:13.75	Commerce Bureautique Informatique	Rue Non Denommee G rand Yoff 0 Dakar Birahim & Proton Sarl Vente Piece Automobiles, Commerce General Rond Point Liberte 6 - Lot N°23	33 820 69 00	Dakar	\N	\N	\N	f	\N
1538	Ibis (Input Business Informatiques	ibis-input-business-informatiques	Etservices) - Ex Issa Bureautique Informatiques Et Services - Issa Thiam) Commerce	\N	2	2026-03-02 23:11:13.751	2026-03-02 23:11:13.751	Etservices) - Ex Issa Bureautique Informatiques Et Services - Issa Thiam) Commerce	Rue 25 X Blaise Diagne	33 867 31 67	Dakar	\N	\N	\N	f	\N
1539	W In Technologie Suarl Conception Et	w-in-technologie-suarl-conception-et	Vente De Materiel Informatiques Et Ac cessoires	\N	2	2026-03-02 23:11:13.753	2026-03-02 23:11:13.753	Vente De Materiel Informatiques Et Ac cessoires	Rue Huart X Parchappe 0 Dakar Elim Multiservice (Aissatou Diallo) Commerce General 09 Rue Niar Sicap Rue 10	33 948 14 14	Dakar	\N	\N	\N	f	\N
1540	Synergie Suarl	synergie-suarl	Commerce	\N	2	2026-03-02 23:11:13.755	2026-03-02 23:11:13.755	Commerce	Rue Salva X Amadou Assane Ndoye	77 538 90 14	Dakar	\N	\N	\N	f	\N
1541	Oumoul Samb	oumoul-samb	Commerce General	\N	2	2026-03-02 23:11:13.757	2026-03-02 23:11:13.757	Commerce General	Quartier Darou Salam - Fatick 0 Dakar Top Meuble Suarl Vente De Meubles Avenue Bourguiba Immeuble Sifav 0 Dakar Tokyo Trading Senegalsuarl Commerce Avenue Blaise Diagne X Rue 29 Medina 0 Dakar Gie Aw A Ak Birane Vente De Marchandises Hann Mariste 2 Villa R/29	33 860 19 19	Fatick	\N	\N	\N	f	\N
1542	W Elness - Ei (Mme Maimouna Savane)	w-elness-ei-mme-maimouna-savane	Commerce	\N	2	2026-03-02 23:11:13.759	2026-03-02 23:11:13.759	Commerce	Rue Colbert 5E Etage Imm.Air Afrique 0 Dakar Nabila Hoballah Commerce Rue Acrnot	77 337 25 37	Dakar	\N	\N	\N	f	\N
1543	Nabil Hoballah	nabil-hoballah	Commerce General	\N	2	2026-03-02 23:11:13.763	2026-03-02 23:11:13.763	Commerce General	Rue Fleurus 0 Dakar Elhadji Abdou Aziz Beye Commerce En Face Rts Medina 77 6338155 Dakar Tours Auto Senegal Location Et Vente De Voitures Sud Foire Cite Libasse Niang	33 823 13 09	Dakar	\N	\N	\N	f	\N
1544	Amadou Abdoulaye Mbaye	amadou-abdoulaye-mbaye	Commerce	\N	2	2026-03-02 23:11:13.765	2026-03-02 23:11:13.765	Commerce	Avenue Albert Sarraut	33 827 49 10	Dakar	\N	\N	\N	f	\N
1545	Gie Media Store	gie-media-store	Commerce Et Location De Dvd	\N	2	2026-03-02 23:11:13.767	2026-03-02 23:11:13.767	Commerce Et Location De Dvd	Rue W Agane Diouf X Abdo u Karim Bourgi	33 822 02 27	Dakar	\N	\N	\N	f	\N
1546	Issa Afrique	issa-afrique	Commerce Mat. Et Mob. De Bureaux	\N	2	2026-03-02 23:11:13.769	2026-03-02 23:11:13.769	Commerce Mat. Et Mob. De Bureaux	Rue Robert Brun	77 635 46 16	Dakar	\N	\N	\N	f	\N
1547	Thierno Sylla	thierno-sylla	Commerce	\N	2	2026-03-02 23:11:13.771	2026-03-02 23:11:13.771	Commerce	Rue Fleurus	77 694 94 30	Dakar	\N	\N	\N	f	\N
1548	Ibrahima Ba	ibrahima-ba	Commerce General	\N	2	2026-03-02 23:11:13.773	2026-03-02 23:11:13.773	Commerce General	Rue Sandiniery	77 025 95 54	Dakar	\N	\N	\N	f	\N
1549	Etamus (Babacar Khouma)	etamus-babacar-khouma	Commerce General	\N	2	2026-03-02 23:11:13.775	2026-03-02 23:11:13.775	Commerce General	Rue 17 X 18 Medina 0 Dakar Inensus W Est Africa Sarl Production Et Distribution Electricite Avenue Faidhe rbe 33 8360316 Dakar Gie Total Media Commerce General Rue Abdou Karim Bourgie	77 553 16 49	Dakar	\N	\N	\N	f	\N
1550	Ndeye Fall Diop	ndeye-fall-diop	Commerce	\N	2	2026-03-02 23:11:13.777	2026-03-02 23:11:13.777	Commerce	Rue 07 X 16	33 951 45 46	Dakar	\N	\N	\N	f	\N
1551	Darou Miname Negoce (Serigne Tine)	darou-miname-negoce-serigne-tine	Commerce	\N	2	2026-03-02 23:11:13.779	2026-03-02 23:11:13.779	Commerce	Rue Marchand X Jallabert 0 Pikine Sedicomi (Senegalaise De Distribution Et Commerce Pour L'Industrie - Ndiaw Ar Paye) Commerce De Fournitures Diverses Route Des Niayes Pi kine	77 510 67 29	Dakar	\N	\N	\N	f	\N
1552	Scp Sakka Conseils	scp-sakka-conseils	Commerce Saly Station 0 Dakar David'S Cycles Suarl Commerce General	\N	2	2026-03-02 23:11:13.782	2026-03-02 23:11:13.782	Commerce Saly Station 0 Dakar David'S Cycles Suarl Commerce General	Rue Mohamed V X Jules Ferry	77 549 08 63	Mbour	\N	\N	\N	f	\N
1553	W In Graphic Sarl	w-in-graphic-sarl	Commerce	\N	2	2026-03-02 23:11:13.784	2026-03-02 23:11:13.784	Commerce	Rue Aristide Le Dantec 33822 28 88 Dakar Bbs (Better Busness Solution) Abdou Diagne Commerce General 67 / B Rue Fass Paillote	33 827 46 70	Dakar	\N	\N	\N	f	\N
1554	Mohamed Ndiaye Kaire	mohamed-ndiaye-kaire	Commerce Medina 33 X 16 0 Dakar Michael Christophe Sassine Commerce	\N	2	2026-03-02 23:11:13.786	2026-03-02 23:11:13.786	Commerce Medina 33 X 16 0 Dakar Michael Christophe Sassine Commerce	Rue Reims 0 Dakar Ets Ibrahima Diongue (Ibrahima Diongue) Commerce Rue Raffenel	77 573 09 10	Dakar	\N	\N	\N	f	\N
1555	Sia Sarl (Senegalaise D'Importation D'Automobiles)	sia-sarl-senegalaise-d-importation-d-automobiles	Commerce	\N	2	2026-03-02 23:11:13.788	2026-03-02 23:11:13.788	Commerce	Route De Saly	77 403 89 05	Mbour	\N	\N	\N	f	\N
1556	E.B.S (Entreprise Bara	e-b-s-entreprise-bara	Services Commerce	\N	2	2026-03-02 23:11:13.79	2026-03-02 23:11:13.79	Services Commerce	Rue 33 X 28 Medina	77 595 36 45	Dakar	\N	\N	\N	f	\N
1557	Gie Njaw Ar S.W	gie-njaw-ar-s-w	Commerce	\N	2	2026-03-02 23:11:13.793	2026-03-02 23:11:13.793	Commerce	Route De L'Hydrobase 0 Pikine Gie Groupe Boulangerie Darou Khoudoss Boulangerie (Production Et Distribution De Pain) Pik ine Tally Boumack	77 634 00 91	Saint-Louis	\N	\N	\N	f	\N
1558	Gie Khadim Rassoul Immobilier Location &	gie-khadim-rassoul-immobilier-location	Vente	\N	2	2026-03-02 23:11:13.795	2026-03-02 23:11:13.795	Vente	Immobiliers Plles Assainies U22 N°2 47 0 Dakar Jpa - Nca Vente De Vetements Point E Allees Seydou Nourou Tall 0 Dakar Delta Express (Senegalaise De Prestation Et D'Equipement Surl) Commerce / Prestation De Services Liberte 6 Extensio n Dakar	33 835 94 84	Dakar	\N	\N	\N	f	\N
1559	Mamadou Selou Diallo	mamadou-selou-diallo	Commerce Fatick 0 Mbour Sodaves Sarl Vente D'Equipements Sportifs	\N	2	2026-03-02 23:11:13.798	2026-03-02 23:11:13.798	Commerce Fatick 0 Mbour Sodaves Sarl Vente D'Equipements Sportifs	Route Complxe Keur Madi or Mbour 0 Dakar Etablissements Khar Yalla (Ndeye Penda Ndiaye) Commerce General, Prestation De Service 18 Cite Comi co (Ex_Cite Sipres 4)	33 867 92 55	Fatick	\N	\N	\N	f	\N
1560	Ablaye Gaye (Gaye Technologies	ablaye-gaye-gaye-technologies	Services) Commerce De Materiels Bureutiques	\N	2	2026-03-02 23:11:13.801	2026-03-02 23:11:13.801	Services) Commerce De Materiels Bureutiques	Rue 25 X Blaise Di agne Medina	33 868 51 10	Dakar	\N	\N	\N	f	\N
1561	Gie Xorom Si International Tourisme - Voyage -	gie-xorom-si-international-tourisme-voyage	Commerce	\N	2	2026-03-02 23:11:13.803	2026-03-02 23:11:13.803	Commerce	Quartier Mbelgor - Foun diougne 0 Dakar It Consulting Services - Sarl Ingenierie - Ventes De Materiels Informatiques Rue E l Hadji Mass Diokhane	33 820 08 80	Foundiougne	\N	\N	\N	f	\N
1562	Entreprise Issa Dieye	entreprise-issa-dieye	Commerce	\N	2	2026-03-02 23:11:13.806	2026-03-02 23:11:13.806	Commerce	Quartier Peuga Fatick	33 842 71 63	Fatick	\N	\N	\N	f	\N
1563	Etablissements Doudou Et Astou (Balla W Ari Diop)	etablissements-doudou-et-astou-balla-w-ari-diop	Commerce Et Prestations De Services	\N	2	2026-03-02 23:11:13.81	2026-03-02 23:11:13.81	Commerce Et Prestations De Services	Rue 33 X Blaise Diagne	77 650 25 21	Dakar	\N	\N	\N	f	\N
1564	Ers Sarl (Equipements Et Realisation Senegal Sarl)	ers-sarl-equipements-et-realisation-senegal-sarl	Commerce	\N	2	2026-03-02 23:11:13.813	2026-03-02 23:11:13.813	Commerce	Rue Mohamed 5	77 353 20 73	Dakar	\N	\N	\N	f	\N
1565	Gie Presta Fet	gie-presta-fet	Vente Et Fourniture De Materiel	\N	2	2026-03-02 23:11:13.816	2026-03-02 23:11:13.816	Vente Et Fourniture De Materiel	Avenue Jean Jaures P lateau Dakar Senegal 0 Dakar Momar Diagne Commerce Rue Jules Ferry Thiokho	33 842 89 60	Dakar	\N	\N	\N	f	\N
1566	Baal Baki Nasser	baal-baki-nasser	Commerce De Tissus	\N	2	2026-03-02 23:11:13.818	2026-03-02 23:11:13.818	Commerce De Tissus	Rue Ngalandou Diouf X Ave Lamine Gueye	77 368 46 48	Dakar	\N	\N	\N	f	\N
1567	Cheikh Abdoul Ahad Mbacke Sarr (Samser)	cheikh-abdoul-ahad-mbacke-sarr-samser	Commerce General	\N	2	2026-03-02 23:11:13.821	2026-03-02 23:11:13.821	Commerce General	Rue El H. Mbaye Gueye Prolongee	33 821 06 65	Dakar	\N	\N	\N	f	\N
1568	Senepresco (Gie Senegalaise De Nettoiement Et De Pr estations Commerciale)	senepresco-gie-senegalaise-de-nettoiement-et-de-pr-estations-commerciale	Commerce General Parcelles Assainies Unite 1 N° 388 0 Fatick	\N	2	2026-03-02 23:11:13.824	2026-03-02 23:11:13.824	Commerce General Parcelles Assainies Unite 1 N° 388 0 Fatick	Abdou Lahad Ndao Commerce General Ndouck	33 842 24 33	Dakar	\N	\N	\N	f	\N
1569	Delta Express	delta-express	Commerce General	\N	2	2026-03-02 23:11:13.827	2026-03-02 23:11:13.827	Commerce General	Route Du Camp Penal Liberte 6 Exten sion	77 286 56 86	Dakar	\N	\N	\N	f	\N
1570	Amadou Ndiaye	amadou-ndiaye	Vente De Fournitures De Bureau Ouagou Niayes Villa N ° 112 0 Dakar Agence Toure	\N	2	2026-03-02 23:11:13.83	2026-03-02 23:11:13.83	Vente De Fournitures De Bureau Ouagou Niayes Villa N ° 112 0 Dakar Agence Toure	Immobilier Location, Vente De Biens Immobiliers 179 Cite Millio nnaire Grand Yoff	77 536 10 64	Dakar	\N	\N	\N	f	\N
1571	Etablissement Modou Biscam Diop	etablissement-modou-biscam-diop	Commerce	\N	2	2026-03-02 23:11:13.833	2026-03-02 23:11:13.833	Commerce	Rue 39 X 44 Dakar	33 827 86 90	Dakar	\N	\N	\N	f	\N
1572	Cosmos Polyte (Abdourahim Niang)	cosmos-polyte-abdourahim-niang	Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:13.835	2026-03-02 23:11:13.835	Commerce De Marchandises Diverses	Rue De Thiong	77 435 04 04	Dakar	\N	\N	\N	f	\N
1573	Gie Les Freres Amis	gie-les-freres-amis	Commerce Cite Port	\N	2	2026-03-02 23:11:13.838	2026-03-02 23:11:13.838	Commerce Cite Port	Avenue Cheikh Ahmadou Bamba 0 Pikine Horizon Iten Commerce Zac Mbao Lot 15	77 633 15 98	Dakar	\N	\N	\N	f	\N
1574	Assem Hachem	assem-hachem	Commerce Au Detail	\N	2	2026-03-02 23:11:13.841	2026-03-02 23:11:13.841	Commerce Au Detail	Rue Felix Faure 0 Dakar Minka Sarl Commerce General Plles Assainies Unite 11	77 402 09 21	Dakar	\N	\N	\N	f	\N
1575	Cogecom S/C Gueye Babacar (Compagnie Generale De	cogecom-s-c-gueye-babacar-compagnie-generale-de	Commerce) Commerce General - Import -Export	\N	2	2026-03-02 23:11:13.844	2026-03-02 23:11:13.844	Commerce) Commerce General - Import -Export	Rue Raffenel	77 523 54 85	Dakar	\N	\N	\N	f	\N
1576	Rougui Diallo	rougui-diallo	Commerce Ouest Foire Villa N°10 0 Dakar Papeterie Inter (Boury Sarr) Vente De Materiels De Bureau - Papeterie - Tous Commerces	\N	2	2026-03-02 23:11:13.847	2026-03-02 23:11:13.847	Commerce Ouest Foire Villa N°10 0 Dakar Papeterie Inter (Boury Sarr) Vente De Materiels De Bureau - Papeterie - Tous Commerces	Rue Grasland X Mousse Diop	33 949 12 90	Dakar	\N	\N	\N	f	\N
1577	Agrodis - Boubou Ndiaye Representation Commerciale -	agrodis-boubou-ndiaye-representation-commerciale	Commerce - Vente Moustiquaires	\N	2	2026-03-02 23:11:13.85	2026-03-02 23:11:13.85	Commerce - Vente Moustiquaires	Rue Alfred Goux	33 822 28 47	Dakar	\N	\N	\N	f	\N
1578	Abdoulaye Seck	abdoulaye-seck	Vente Pieces Detachees	\N	2	2026-03-02 23:11:13.853	2026-03-02 23:11:13.853	Vente Pieces Detachees	Route De Rufisque 0 Dakar Coseni Sarl Commerce Import-Export Avenue Blaise Diagne	33 868 88 48	Pikine	\N	\N	\N	f	\N
1579	Assane Gaye	assane-gaye	Commerce General	\N	2	2026-03-02 23:11:13.855	2026-03-02 23:11:13.855	Commerce General	Rue 17 X 18 Medina	77 639 63 16	Dakar	\N	\N	\N	f	\N
1580	Alfi Suarl Conseil En Force De	alfi-suarl-conseil-en-force-de	Vente Marchandising	\N	2	2026-03-02 23:11:13.858	2026-03-02 23:11:13.858	Vente Marchandising	Rue Abdou Ka rim Bourgi 0 Dakar Pyramide Business Senegal Commerce Cite Assemblee	33 822 34 40	Dakar	\N	\N	\N	f	\N
1581	Amt	amt	Services Sarl Commerce General Cite Gorgui Sacre Cœur Pyrotehcnie Dakar 0 Dakar Babacar Drame Vente De Materiel Informatique	\N	2	2026-03-02 23:11:13.861	2026-03-02 23:11:13.861	Services Sarl Commerce General Cite Gorgui Sacre Cœur Pyrotehcnie Dakar 0 Dakar Babacar Drame Vente De Materiel Informatique	Rue 31 X Blaise Diagn e 0 Dakar Semsa Sarl Commerce General Scat Urbam Cite Khadim 2 Villa N° C k 63 776412109 Dakar Linea Casa Sarl Commerce Sacre Cœur 3 ,10023 / B	33 860 96 96	Dakar	\N	\N	\N	f	\N
1582	Diakite Djeneba	diakite-djeneba	Commerce General	\N	2	2026-03-02 23:11:13.864	2026-03-02 23:11:13.864	Commerce General	Rue Kleber 0 Dakar Oumou Khairy Gueye Commerce General Rue Joseph Gomis	77 345 28 41	Dakar	\N	\N	\N	f	\N
1583	H.I.B (Harambe Informatique & Business - Arona Dial lo)	h-i-b-harambe-informatique-business-arona-dial-lo	Commerce	\N	2	2026-03-02 23:11:13.868	2026-03-02 23:11:13.868	Commerce	Rue 13 X Blaise Diagne 0 Dakar Eams (Amadou Moustapha Sall) Vente De Materiels Et Consommables Informatique Rue 11 X Blaise Diagne 0 Dakar B2Sk (Inthie Sangare) Commerce General Rue Marsat	33 834 43 43	Dakar	\N	\N	\N	f	\N
1584	Madis Sarl (Maty	madis-sarl-maty	Distribution Et Services - Sarl) Commerce -Prestation De Services	\N	2	2026-03-02 23:11:13.871	2026-03-02 23:11:13.871	Distribution Et Services - Sarl) Commerce -Prestation De Services	Avenue Faidherbe	33 821 70 32	Dakar	\N	\N	\N	f	\N
1585	Daniel Richarte	daniel-richarte	Commerce	\N	2	2026-03-02 23:11:13.874	2026-03-02 23:11:13.874	Commerce	Rue Non Denommee, Hlm Grand Yoff Shelter	77 637 98 19	Dakar	\N	\N	\N	f	\N
1586	Aliou Ndour	aliou-ndour	Commerce General	\N	2	2026-03-02 23:11:13.878	2026-03-02 23:11:13.878	Commerce General	Quartier Ndiaye Ndiaye 1	77 374 02 29	Fatick	\N	\N	\N	f	\N
1587	Salam Computer	salam-computer	Vente Outils Informatique Consommables Et Fournitures De Bureau	\N	2	2026-03-02 23:11:13.881	2026-03-02 23:11:13.881	Vente Outils Informatique Consommables Et Fournitures De Bureau	Rue 9 X Blaise Diagne	77 696 33 83	Dakar	\N	\N	\N	f	\N
1588	Fume Bou Senegal	fume-bou-senegal	Vente De Produits Pesticides	\N	2	2026-03-02 23:11:13.884	2026-03-02 23:11:13.884	Vente De Produits Pesticides	Route La Yousse Rufisqu e 0 Foundiougne Babacar Gaye Commerce General Passy Fatick 0 Dakar Ubo-Universal Bisiness Office Commerce Grand Dakar 33 82519 49 Dakar Aai (Afrogazons Afrosports International) Construction D'Insfrastructure Sportif & Commerce 24 A Cite Soprim	33 867 54 97	Rufisque	\N	\N	\N	f	\N
1589	Thiampos	thiampos	Polyservices Prestation De Services Et Commerce	\N	2	2026-03-02 23:11:13.886	2026-03-02 23:11:13.886	Polyservices Prestation De Services Et Commerce	Rue Marsat Allee Papa Gueye Fall	33 825 65 92	Dakar	\N	\N	\N	f	\N
1590	3 Md'Action Rapite	3-md-action-rapite	Commerce 2515	\N	2	2026-03-02 23:11:13.888	2026-03-02 23:11:13.888	Commerce 2515	Rue Non Denomee 77 5679490 Dakar Michel Zarka "Gentleman" - Uniformes - (Ex - Georges Zarka) Commerce Textile - Tailleur Chemisier Rue Vincens	77 012 98 75	Ziguinchor	\N	\N	\N	f	\N
1591	Joubally Hassan	joubally-hassan	Commerce Generalcommerce General	\N	2	2026-03-02 23:11:13.89	2026-03-02 23:11:13.89	Commerce Generalcommerce General	Rue Galandou Diouf	33 821 47 93	Dakar	\N	\N	\N	f	\N
1592	Station Total Gare Routiere Kaolack Gerance Station De	station-total-gare-routiere-kaolack-gerance-station-de	Vente Hudrocarbure En Face	\N	1	2026-03-02 23:11:13.892	2026-03-02 23:11:13.892	Vente Hudrocarbure En Face	Route Nationale	33 860 23 31	Kaolack	\N	\N	\N	f	\N
1593	Total Boucotte(Salif Fall)	total-boucotte-salif-fall	Vente De Carburant	\N	1	2026-03-02 23:11:13.894	2026-03-02 23:11:13.894	Vente De Carburant	Avenue Ibou Diallo Ziguinchor	77 637 02 04	Ziguinchor	\N	\N	\N	f	\N
1594	Station Total Birane Ndiaye	station-total-birane-ndiaye	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:13.897	2026-03-02 23:11:13.897	Vente De Produits Petroliers	Route De Potou Louga	77 618 48 72	Louga	\N	\N	\N	f	\N
1595	3S Commodities	3s-commodities	Commerce De Produits Agricoles	\N	2	2026-03-02 23:11:13.898	2026-03-02 23:11:13.898	Commerce De Produits Agricoles	Rue Parent	77 650 18 66	Dakar	\N	\N	\N	f	\N
1596	Netcom Sa (Netw Ork Energie Et Communication)	netcom-sa-netw-ork-energie-et-communication	Vente De Materiels Telecommunications - Prestations Services Informatiques	\N	1	2026-03-02 23:11:13.9	2026-03-02 23:11:13.9	Vente De Materiels Telecommunications - Prestations Services Informatiques	Rue Carnot X Mass Diokhane	33 823 36 84	Dakar	\N	\N	\N	f	\N
1597	Entreprise Activité Adresse Téléphone Dakar W Orld Digitech Systems Suarl	entreprise-activite-adresse-telephone-dakar-w-orld-digitech-systems-suarl	Commerce Materiel Informatique Point E	\N	2	2026-03-02 23:11:13.903	2026-03-02 23:11:13.903	Commerce Materiel Informatique Point E	Rue A X 1	33 849 06 16	Ville	\N	\N	\N	f	\N
1598	Malika Hage Ali - Parfumerie Grain De Beaute - Institut De Soint Esthetique -	malika-hage-ali-parfumerie-grain-de-beaute-institut-de-soint-esthetique	Commerce -	\N	2	2026-03-02 23:11:13.905	2026-03-02 23:11:13.905	Commerce -	Avenue Lam ine Gueye	33 864 69 27	Dakar	\N	\N	\N	f	\N
1599	Agc (Globum Company Sarl)	agc-globum-company-sarl	Commerce	\N	2	2026-03-02 23:11:13.908	2026-03-02 23:11:13.908	Commerce	Rue De Thiong	33 825 88 92	Dakar	\N	\N	\N	f	\N
1600	Senefrip (La Senegalaise De Friperie)	senefrip-la-senegalaise-de-friperie	Commerce Fann Hock	\N	2	2026-03-02 23:11:13.91	2026-03-02 23:11:13.91	Commerce Fann Hock	Rue Loulou Villa N° 6 0 Dakar Soxna'S Sarl Commerce Sacre Cœur 1 Villa N° 8292	33 821 01 80	Dakar	\N	\N	\N	f	\N
1601	Groupe Lak'S Sarl Importation Et	groupe-lak-s-sarl-importation-et	Distribution De Produits Alimentaires	\N	2	2026-03-02 23:11:13.912	2026-03-02 23:11:13.912	Distribution De Produits Alimentaires	Avenue Lamine Gueye	33 821 39 95	Dakar	\N	\N	\N	f	\N
1602	Said Korrich	said-korrich	Commerce General	\N	2	2026-03-02 23:11:13.915	2026-03-02 23:11:13.915	Commerce General	Rue Raffenel 0 Dakar Vic Sarl (Immobilier Et Commerce ) Vente De Boissons Ouest Foire Route Aeroport N° 3 0 Dakar Gie Bati Metal Commerce Marchandises Diverses Bccd 0 Dakar En.Co.Ser.(Entreprise De Commerce Et De Services) - Suarl Commerce General Hann Mariste 2 N°228/Y	33 842 92 93	Dakar	\N	\N	\N	f	\N
1603	Gesercom Sarl (Generale	gesercom-sarl-generale	Multiservices Et Commerciales - Sarl) Commerce General Nord Foire Azur N° 39 338203532 Dakar El Hadji Ndary Niang Commerce General	\N	2	2026-03-02 23:11:13.917	2026-03-02 23:11:13.917	Multiservices Et Commerciales - Sarl) Commerce General Nord Foire Azur N° 39 338203532 Dakar El Hadji Ndary Niang Commerce General	Avenue Lamine Gueye	33 827 19 89	Dakar	\N	\N	\N	f	\N
1604	Pharmacie Adji Gnagna Diagne	pharmacie-adji-gnagna-diagne	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.919	2026-03-02 23:11:13.919	Vente De Produits Pharmaceutiques	Quartier Colobane Nord Rufisque	33 835 79 85	Rufisque	\N	\N	\N	f	\N
1605	Ets Mbacke Gueye	ets-mbacke-gueye	Commerce General	\N	2	2026-03-02 23:11:13.921	2026-03-02 23:11:13.921	Commerce General	Quartier Cheikh Seck - Yeumbeul	33 871 60 60	Pikine	\N	\N	\N	f	\N
1606	Ks2A Suarl	ks2a-suarl	Commerce Km 5	\N	2	2026-03-02 23:11:13.924	2026-03-02 23:11:13.924	Commerce Km 5	Boulevard Du Centenaire De La Commune De Dakar	33 834 34 79	Dakar	\N	\N	\N	f	\N
1607	Amadou Malani Diallo	amadou-malani-diallo	Commerce	\N	2	2026-03-02 23:11:13.926	2026-03-02 23:11:13.926	Commerce	Rue 29 X 24 Medina 0 Dakar Bmi (Borom Madina International (Serigne Moustapha Mbengue) Commerce Scat Urbam Grand Yoff 338279488 Dakar Petit Jean W Est Africa - Pw A Commerce Route De Ouakam Immeuble Saphir Mermoz	77 385 73 70	Dakar	\N	\N	\N	f	\N
1608	Mamadou Ndiaye - Keur Ndiaye Effet /K.N.E/Individuelle	mamadou-ndiaye-keur-ndiaye-effet-k-n-e-individuelle	Commerce De Parfun	\N	2	2026-03-02 23:11:13.928	2026-03-02 23:11:13.928	Commerce De Parfun	Rue 55 X 60 Gueule Tapee	33 824 44 00	Dakar	\N	\N	\N	f	\N
1609	Pharmacie Stade Suarl	pharmacie-stade-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.931	2026-03-02 23:11:13.931	Vente De Produits Pharmaceutiques	Route Des Hlm, Fac e Stade Municipal Rufisque	33 820 95 92	Rufisque	\N	\N	\N	f	\N
1610	Saphir-Co (Raad Brahim)	saphir-co-raad-brahim	Commerce General	\N	2	2026-03-02 23:11:13.933	2026-03-02 23:11:13.933	Commerce General	Rue De Thiong 0 Rufisque Global Import Export Sarl Commerce General Route De Mbour Diamniadio	33 866 78 65	Dakar	\N	\N	\N	f	\N
1611	Seah Sarl (Societe D'Equipement Agricole Et Hydraulique)	seah-sarl-societe-d-equipement-agricole-et-hydraulique	Commerce Materiels Agricole Et Hydraulique Rurale	\N	2	2026-03-02 23:11:13.935	2026-03-02 23:11:13.935	Commerce Materiels Agricole Et Hydraulique Rurale	Avenue Bourguiba Immeuble Ymca Lot N°06	77 579 69 17	Dakar	\N	\N	\N	f	\N
1612	Sn Devel	sn-devel	Commerce Cite Des Magistrats N°431 776 442 352 Dakar Afrique Prestige (Birame Sene) Commerce	\N	2	2026-03-02 23:11:13.938	2026-03-02 23:11:13.938	Commerce Cite Des Magistrats N°431 776 442 352 Dakar Afrique Prestige (Birame Sene) Commerce	Rue Mangin X Ave Blaise Diagne	77 780 65 49	Dakar	\N	\N	\N	f	\N
1613	Cosec (Conseil Senegalaise Chargeurs)	cosec-conseil-senegalaise-chargeurs	Commerce	\N	2	2026-03-02 23:11:13.94	2026-03-02 23:11:13.94	Commerce	Avenue Malick Sy X Autoroute 0 Dakar Pama Multiservices (Babou Faye) Commerce General Parcelles Assainies Unite 12 N°13 D akar 0 Thies Taïba - Taïba (Moussa Diop) Commerce Escale - Thies	77 546 93 39	Dakar	\N	\N	\N	f	\N
1614	Pharmacie Colobane(Jeanne Tavarez Gueye)	pharmacie-colobane-jeanne-tavarez-gueye	Vente De Produits Pharmaceutiques Lindiane Bvd Alpha Zig 0 Ziguinchor Pharmacie Alexandre (Raymond Nunez) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.943	2026-03-02 23:11:13.943	Vente De Produits Pharmaceutiques Lindiane Bvd Alpha Zig 0 Ziguinchor Pharmacie Alexandre (Raymond Nunez) Vente De Produits Pharmaceutiques	Avenue Emille Badi ane 0 Dakar Ayw Ards Cosmetics Commerce General Rue Galandou Diouf 776382912 Dakar Medi Sene (Adel Halaoui) Commerce General Rue Joseph Gomis 0 Ziguinchor Gie Casa General Tech Services Commerce Boucotte Ziguinchor	33 993 53 55	Ziguinchor	\N	\N	\N	f	\N
1615	Pharmacie Mouridoulahie(Moustapha Senghor)	pharmacie-mouridoulahie-moustapha-senghor	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.945	2026-03-02 23:11:13.945	Vente De Produits Pharmaceutiques	Route De Kael Mbac ke	33 825 78 49	Mbacke	\N	\N	\N	f	\N
1616	Pharmacie Baol (Djibril Diallo)	pharmacie-baol-djibril-diallo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.947	2026-03-02 23:11:13.947	Vente De Produits Pharmaceutiques	Avenue Malick Sy T hevenot	33 875 18 09	Diourbel	\N	\N	\N	f	\N
1617	Enam Etablissement Ndeye Aw A Mbaye	enam-etablissement-ndeye-aw-a-mbaye	Commerce	\N	2	2026-03-02 23:11:13.95	2026-03-02 23:11:13.95	Commerce	Rue Sandiniery 0 Kebemer Seck & Freres Suarl Commerce Quartier Escale Kebemer	33 973 61 30	Dakar	\N	\N	\N	f	\N
1618	Abdou Lakhat Mbaye	abdou-lakhat-mbaye-1	Commerce Marche Central Bakel 0 Bakel Pharmacie Diaw Ara (Docteur Lamine Sankhare) Vente De Produits Pharmaceutiques Diaw Are Bakel 0 Bakel Sega Kante Commerce General	\N	2	2026-03-02 23:11:13.953	2026-03-02 23:11:13.953	Commerce Marche Central Bakel 0 Bakel Pharmacie Diaw Ara (Docteur Lamine Sankhare) Vente De Produits Pharmaceutiques Diaw Are Bakel 0 Bakel Sega Kante Commerce General	Route De Bakel Kidira 0 Bakel Pharmacie Yaye Fatou Sy Vente De Produits Pharmaceutiques Moudery 0 Bamako Transrail Sa Transport Ferroviaire Immeuble Le Babemba	33 965 72 80	Bakel	\N	\N	\N	f	\N
1619	Pharmacie Bargny - Mme Gueye Ndiaye	pharmacie-bargny-mme-gueye-ndiaye-1	Vente De Produits Pharmaceutiques Bargny -	\N	2	2026-03-02 23:11:13.956	2026-03-02 23:11:13.956	Vente De Produits Pharmaceutiques Bargny -	Quartier Darou I	33 836 82 40	Bargny	\N	\N	\N	f	\N
1620	Baobab Technologie Import Sarl	baobab-technologie-import-sarl-1	Vente De Materiels Electrique Et Solaire	\N	2	2026-03-02 23:11:13.96	2026-03-02 23:11:13.96	Vente De Materiels Electrique Et Solaire	Route De Cabrousse - Cap Skirring 0 Cap-Skirring Case Bambou - Suarl Bar - Restaurant Route Principale - Cap Skirring	33 993 52 88	Cap-Skirring	\N	\N	\N	f	\N
1621	Pharmacie Djadine Suarl	pharmacie-djadine-suarl-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.963	2026-03-02 23:11:13.963	Vente De Produits Pharmaceutiques	Avenue Sidya Ndatte Yalla - Dagana	33 821 66 72	Dagana	\N	\N	\N	f	\N
1622	Ets Cheikh Diagne	ets-cheikh-diagne-1	Commerce General Touba Mosquee Pres De La Corniche 773606213 Diourbel Epshtn (Etablissemnt Pulbic De Sante Hospitalier Touba Ndamatou Activite Pour La Sante Des Hommes	\N	2	2026-03-02 23:11:13.966	2026-03-02 23:11:13.966	Commerce General Touba Mosquee Pres De La Corniche 773606213 Diourbel Epshtn (Etablissemnt Pulbic De Sante Hospitalier Touba Ndamatou Activite Pour La Sante Des Hommes	Quartier Ndamatou Touba Diourbel	33 974 05 47	Diourbel	\N	\N	\N	f	\N
1623	Station D'Essence (Bassirou Gueye)	station-d-essence-bassirou-gueye-1	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:13.97	2026-03-02 23:11:13.97	Vente De Produits Petroliers	Route Nationale Diourbel	33 978 27 91	Diourbel	\N	\N	\N	f	\N
1624	Pharmacie Centrale - Aliou Camara - Diourbel	pharmacie-centrale-aliou-camara-diourbel-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.974	2026-03-02 23:11:13.974	Vente De Produits Pharmaceutiques	Quartier Thierno Kandji, Rue D'Avignon	76 683 38 29	Diourbel	\N	\N	\N	f	\N
1625	Gie Diapo Prestation De	gie-diapo-prestation-de-1	Service & Commerce	\N	2	2026-03-02 23:11:13.978	2026-03-02 23:11:13.978	Service & Commerce	Quartier Thierno Kandji N°1659 775557581 Diourbel W Ater-Sarl (W Est Africa Textile Recyclers) Recyclage Et Vente De Fripperie Diourbel	33 971 11 20	Diourbel	\N	\N	\N	f	\N
1626	Pharmacie Mouminine	pharmacie-mouminine-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.982	2026-03-02 23:11:13.982	Vente De Produits Pharmaceutiques	Rue Max Berthet X Dispensaire (Ex = Rue El Hadj Sylla)	33 971 56 66	Diourbel	\N	\N	\N	f	\N
1627	Pharmacie Cheikh Ibra Fall	pharmacie-cheikh-ibra-fall	Vente De Produits Pharmaceutiques Diourbel 0 Diourbel G2Sy Suarl(Groupe Synergies Systems) Construction De Batiments Complets	\N	2	2026-03-02 23:11:13.985	2026-03-02 23:11:13.985	Vente De Produits Pharmaceutiques Diourbel 0 Diourbel G2Sy Suarl(Groupe Synergies Systems) Construction De Batiments Complets	Quartier Thierno Kandj 0 Diourbel Gie Touba Italia Flex Production De Matelas A L'Etranger Route De Darou Mouhty Touba	77 520 69 82	Diourbel	\N	\N	\N	f	\N
1628	Pharmacie Mame Diarra Bousso(Yero Diouma Dian)	pharmacie-mame-diarra-bousso-yero-diouma-dian-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.989	2026-03-02 23:11:13.989	Vente De Produits Pharmaceutiques	Rue Felix Eboue	77 360 05 59	Diourbel	\N	\N	\N	f	\N
1629	Pharmacie Baol (Djibril Diallo)	pharmacie-baol-djibril-diallo-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:13.993	2026-03-02 23:11:13.993	Vente De Produits Pharmaceutiques	Avenue Malick Sy Thevenot	33 971 38 37	Diourbel	\N	\N	\N	f	\N
1630	Station Essence Ndangane (Ibrahima Thiare)	station-essence-ndangane-ibrahima-thiare	Vente De Produits Petroliers (Station D'Essence) Ndangane 0 Fatick Station Essence Fimela (Papa Diop) Vente De Produits Petroliers (Station D'Essence) Fimela 0 Fatick Station Al Azhar Diatta Senghor Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:13.996	2026-03-02 23:11:13.996	Vente De Produits Petroliers (Station D'Essence) Ndangane 0 Fatick Station Essence Fimela (Papa Diop) Vente De Produits Petroliers (Station D'Essence) Fimela 0 Fatick Station Al Azhar Diatta Senghor Vente De Produits Petroliers (Station D'Essence)	Route Nationale 0 Fatick Sarl Royal Lodge Tourisme Et Agence De Voyage Palmarin (Region De Fatick) 0 Fatick Station Total Katime Toure Commerce De Produits Petroliers Fimela	33 831 06 20	Fatick	\N	\N	\N	f	\N
1631	Pharmacie Boury (Aly Cotto Ndiaye)	pharmacie-boury-aly-cotto-ndiaye-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14	2026-03-02 23:11:14	Vente De Produits Pharmaceutiques	Quartier Escale - Place Du Marche	33 949 13 68	Fatick	\N	\N	\N	f	\N
1632	Lat Grand Ndiaye	lat-grand-ndiaye	Commerce General	\N	2	2026-03-02 23:11:14.004	2026-03-02 23:11:14.004	Commerce General	Quartier Peulga Fatick 0 Fatick Librairie Papeterie Francoise Daba Youme (Francoise Daba Youme) Commerce Librairie Papeterie Fatick 0 Fatick W Elcome Senegal Sarl Peche Sportive - Hotellerie - Transport - Location De Vehicule Toubacouta 0 Fatick Ecas Sarl (Etablissement Commerce Construction Assainissement Et Services) Commerce General Escale	33 949 16 03	Fatick	\N	\N	\N	f	\N
1633	Sci Les Lodges De L'Afrique De L'Ouest Societe Civile Immobiliere Village De Palmarin 0 Fatick	sci-les-lodges-de-l-afrique-de-l-ouest-societe-civile-immobiliere-village-de-palmarin-0-fatick	Commerce Fatick 0 Fatick Gie Segre Education Commerce Fatick 0 Fatick Ataya Sarl Hotel - Bar-Restaurant Ndangane 0 Fatick Djidjack	\N	2	2026-03-02 23:11:14.007	2026-03-02 23:11:14.007	Commerce Fatick 0 Fatick Gie Segre Education Commerce Fatick 0 Fatick Ataya Sarl Hotel - Bar-Restaurant Ndangane 0 Fatick Djidjack	Immo Sarl Activites Immobilieres Palmarin Facao	77 902 54 55	Fatick	\N	\N	\N	f	\N
1634	Campement Le Bazouk Du Saloum Campement Touristique Marlothie Ndangane 0 Fatick Lorraine Niombato	campement-le-bazouk-du-saloum-campement-touristique-marlothie-ndangane-0-fatick-lorraine-niombato	Commerce Escale Fatick 0 Fatick Societe Alla Suarl Btp	\N	2	2026-03-02 23:11:14.01	2026-03-02 23:11:14.01	Commerce Escale Fatick 0 Fatick Societe Alla Suarl Btp	Quartier Ndouck - Fatick 0 Fatick And Senegal Prestations De Services Village De Ndangane Sambou	33 949 96 19	Fatick	\N	\N	\N	f	\N
1635	Oumoul Samb	oumoul-samb-1	Commerce General	\N	2	2026-03-02 23:11:14.014	2026-03-02 23:11:14.014	Commerce General	Quartier Darou Salam - Fatick 0 Fatick Gie Sine Cyber Prestations De Services Escale Fatick	33 949 93 25	Fatick	\N	\N	\N	f	\N
1636	Feline	feline	Distribution & Services (Saibou Diallo Thioub) Btp Et Services	\N	2	2026-03-02 23:11:14.016	2026-03-02 23:11:14.016	Distribution & Services (Saibou Diallo Thioub) Btp Et Services	Quartier Ndiaye Ndiaye	33 949 12 93	Fatick	\N	\N	\N	f	\N
1637	Auberge Baobab (Anne Marie Ndong) Auberge Fatick 0 Fatick Mamadou Selou Diallo	auberge-baobab-anne-marie-ndong-auberge-fatick-0-fatick-mamadou-selou-diallo	Commerce Fatick 0 Fatick Entreprise Issa Dieye Commerce	\N	2	2026-03-02 23:11:14.019	2026-03-02 23:11:14.019	Commerce Fatick 0 Fatick Entreprise Issa Dieye Commerce	Quartier Peuga Fatick	33 941 47 57	Fatick	\N	\N	\N	f	\N
1638	Brasserie De Toubacouta Tourisme Toubacouta 0 Fatick Gie Mar Setal Prestations De	brasserie-de-toubacouta-tourisme-toubacouta-0-fatick-gie-mar-setal-prestations-de	Services Marlothie 0 Fatick David Dione Restauration	\N	3	2026-03-02 23:11:14.024	2026-03-02 23:11:14.024	Services Marlothie 0 Fatick David Dione Restauration	Quartier Medina Sokone 0 Fatick Campement Nouvelle Vague Campement Touristique Ile De Mar Lothie 0 Fatick Gie Tamarko Hotel - Bar-Restaurant Ndangane 0 Fatick Gie African Ranch Ferme Equestre Ndangane 0 Fatick Aliou Ndour Commerce General Quartier Ndiaye Ndiaye 1	77 575 37 15	Fatick	\N	\N	\N	f	\N
1639	Restaurant La Maroise (Marie Augustine Diobaye) Restaurant Ndangane 0 Fatick Auberge Chez Fatima	restaurant-la-maroise-marie-augustine-diobaye-restaurant-ndangane-0-fatick-auberge-chez-fatima	Services Escale Lot N°85	\N	4	2026-03-02 23:11:14.027	2026-03-02 23:11:14.027	Services Escale Lot N°85	Rue Tafs D Ciss 0 Fimela Ndeye Fatou Faye Restaurant Et Debits De Boissons Ndangane-Fimela	77 696 33 83	Fatick	\N	\N	\N	f	\N
1640	El Hadji Malick Sy	el-hadji-malick-sy	Commerce	\N	2	2026-03-02 23:11:14.03	2026-03-02 23:11:14.03	Commerce	Rue Quai Thiamene - Foundiougne	33 945 85 35	Foundiougne	\N	\N	\N	f	\N
1641	Pharmacie Krang (Ousmane Diallo)	pharmacie-krang-ousmane-diallo-1	Vente De Produits Pharmaceutiques Karang 0 Foundiougne Pharmacie Adji Amy Senghor (Samba Sarr Senghor) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.035	2026-03-02 23:11:14.035	Vente De Produits Pharmaceutiques Karang 0 Foundiougne Pharmacie Adji Amy Senghor (Samba Sarr Senghor) Vente De Produits Pharmaceutiques	Quartier Mbelgor - Foundiougne	77 637 80 98	Foundiougne	\N	\N	\N	f	\N
1642	Gie Xorom Si International Tourisme - Voyage -	gie-xorom-si-international-tourisme-voyage-1	Commerce	\N	2	2026-03-02 23:11:14.043	2026-03-02 23:11:14.043	Commerce	Quartier Mbelgor - Foundiougne 0 Foundiougne Babacar Gaye Commerce General Passy Fatick 0 Foundiougne Bassirou Mbodji Commerce General Commune De Djilor	77 514 61 87	Foundiougne	\N	\N	\N	f	\N
1643	Pharmacie Mama Nguedj	pharmacie-mama-nguedj-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.049	2026-03-02 23:11:14.049	Vente De Produits Pharmaceutiques	Quartier Afdaye - Joal	33 957 88 02	Joal	\N	\N	\N	f	\N
1644	Fadiouth Gie Diamo Pecheurs Mareyeurs Peche De Poissons Joal Fadiouth-Quaie De Peche 339576071	fadiouth-gie-diamo-pecheurs-mareyeurs-peche-de-poissons-joal-fadiouth-quaie-de-peche-339576071	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.052	2026-03-02 23:11:14.052	Vente De Produits Pharmaceutiques	Quartier Escale	77 599 52 52	Joal	\N	\N	\N	f	\N
1645	Gie Santa Yalla De Diakhao Saloum	gie-santa-yalla-de-diakhao-saloum	Commerce Diakhao Saloum 0 Kahone Pharmacie	\N	2	2026-03-02 23:11:14.057	2026-03-02 23:11:14.057	Commerce Diakhao Saloum 0 Kahone Pharmacie	Abdoulaye Ibrahima Niass Vente De Produits Pharmaceutiques Quartier Kahone Lot N° 196 Kk 0 Kanel Station Total Hounare Commerce De Produits Petroliers Hounare	33 994 85 25	Kafrine	\N	\N	\N	f	\N
1646	Pharmacie Ndiouga Marame	pharmacie-ndiouga-marame-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.062	2026-03-02 23:11:14.062	Vente De Produits Pharmaceutiques	Quartier Thielol Kanel	33 966 84 09	Kanel	\N	\N	\N	f	\N
1647	Entreprise Activité Adresse Téléphone Kaolack Ccmn (Comptoir Commercial Mandiaye Ndiaye)	entreprise-activite-adresse-telephone-kaolack-ccmn-comptoir-commercial-mandiaye-ndiaye	Commerce Import-Export	\N	2	2026-03-02 23:11:14.065	2026-03-02 23:11:14.065	Commerce Import-Export	Rue Daloa	33 966 86 04	Ville	\N	\N	\N	f	\N
1648	Distri Mat Sarl	distri-mat-sarl-1	(Distribution De Materiels De Construction - Sarl) Commerce	\N	2	2026-03-02 23:11:14.07	2026-03-02 23:11:14.07	(Distribution De Materiels De Construction - Sarl) Commerce	Rue Daloa Leona 0 Kaolack Baba Gueye Vente De Produits Petroliers Leona Kaolack	33 941 19 04	Kaolack	\N	\N	\N	f	\N
1649	Modou Dieng	modou-dieng	Commerce Ngane 775468851 Kaolack Etablissement Diallo Et Freres Sarl Commerce General	\N	2	2026-03-02 23:11:14.073	2026-03-02 23:11:14.073	Commerce Ngane 775468851 Kaolack Etablissement Diallo Et Freres Sarl Commerce General	Rue Daloi Leona	33 941 23 22	Kaolack	\N	\N	\N	f	\N
1650	El Hadj Ousmane Diongue	el-hadj-ousmane-diongue	Commerce	\N	2	2026-03-02 23:11:14.076	2026-03-02 23:11:14.076	Commerce	Rue Daloa Leona Kaolack 776370957 Kaolack Medinatoul Mounaw Ara - Sarl Commerce En Face Marche Zinc Leona 0 Kaolack Cheikh Dieng Commerce Ngane Saer 0 Kaolack Egmbtv Seyni Seck Btp Quartier Kasnack - Kaolack	33 942 15 86	Kaolack	\N	\N	\N	f	\N
1651	Ets Ndiaye & Freres	ets-ndiaye-freres-1	Commerce	\N	2	2026-03-02 23:11:14.08	2026-03-02 23:11:14.08	Commerce	Rue Daloa	33 941 75 08	Kaolack	\N	\N	\N	f	\N
1652	Ets Babacar Samb & Fils	ets-babacar-samb-fils-1	Commerce	\N	2	2026-03-02 23:11:14.085	2026-03-02 23:11:14.085	Commerce	Avenue Cheikh Ahmadou Bamba	33 941 21 84	Kaolack	\N	\N	\N	f	\N
1653	Etablissement El Hadji Ousmane Diongue - Sarl	etablissement-el-hadji-ousmane-diongue-sarl	Commerce	\N	2	2026-03-02 23:11:14.089	2026-03-02 23:11:14.089	Commerce	Rue Marechal Bugeau Leona	33 941 24 04	Kaolack	\N	\N	\N	f	\N
1654	Ets Loum & Freres	ets-loum-freres-1	Commerce	\N	2	2026-03-02 23:11:14.095	2026-03-02 23:11:14.095	Commerce	Rue Paul Seugnet	77 518 29 73	Kaolack	\N	\N	\N	f	\N
1655	Station D'Essence Semou Diouf	station-d-essence-semou-diouf	Commerce De Produits Petroliers	\N	1	2026-03-02 23:11:14.098	2026-03-02 23:11:14.098	Commerce De Produits Petroliers	Route De Gossas 0 Kaolack Station Ex Garage Nioro (Pape Diop Vente De Produits Petroliers (Station D'Essence) Station Ex Garage Nioro 0 Kaolack Station Total Route De Gossass (Ousmane Badiane ) Vente De Produits Petroliers (Station D'Essence) Quartier Passoire	33 941 41 83	Kaolack	\N	\N	\N	f	\N
1656	Etablissement Dame Samb Et Freres Sarl	etablissement-dame-samb-et-freres-sarl-1	Commerce	\N	2	2026-03-02 23:11:14.103	2026-03-02 23:11:14.103	Commerce	Quartier Leona	33 941 28 99	Kaolack	\N	\N	\N	f	\N
1657	Ets Jean Karim Aoun	ets-jean-karim-aoun-1	Commerce	\N	2	2026-03-02 23:11:14.107	2026-03-02 23:11:14.107	Commerce	Rue Ernest Renan	33 941 19 04	Kaolack	\N	\N	\N	f	\N
1658	Gie Prestagaz Saloum	gie-prestagaz-saloum-1	Commerce De Gaz	\N	1	2026-03-02 23:11:14.112	2026-03-02 23:11:14.112	Commerce De Gaz	Quartier Leona Rue Des Ecoles 0 Kaolack Exo Sarl (Mamadou Lamine Gueye) Vente De Produits Petroliers (Station D'Essence) Exo Sarl Rue De France	33 941 17 37	Kaolack	\N	\N	\N	f	\N
1659	Station	station-5	Service Touba Kahone (Ibra Gueye) Vente De Produits Petroliers Passoir Ndorong 0 Kaolack Setabllissements Alaska Sarl Commerce	\N	1	2026-03-02 23:11:14.123	2026-03-02 23:11:14.123	Service Touba Kahone (Ibra Gueye) Vente De Produits Petroliers Passoir Ndorong 0 Kaolack Setabllissements Alaska Sarl Commerce	Quartier Leona	33 941 47 57	Kaolack	\N	\N	\N	f	\N
1660	Super	super-1	Services Sine Saloum Sarl Commerce	\N	2	2026-03-02 23:11:14.127	2026-03-02 23:11:14.127	Services Sine Saloum Sarl Commerce	Avenue John F Kennedy N° 791	33 941 18 78	Kaolack	\N	\N	\N	f	\N
1661	Etablissement Camara Et Freres - Sarl	etablissement-camara-et-freres-sarl-1	Commerce Leona	\N	2	2026-03-02 23:11:14.132	2026-03-02 23:11:14.132	Commerce Leona	Rue Ababacar Sy N° 1037	33 941 22 66	Kaolack	\N	\N	\N	f	\N
1662	Arsene Lattouf	arsene-lattouf-1	Commerce	\N	2	2026-03-02 23:11:14.137	2026-03-02 23:11:14.137	Commerce	Rue Paul Seugnet 776458147 Kaolack Bassirou Ndiaye Commerce Rue Daloa Leona Kaolack 0 Kaolack Pharmacie Boubakh Vente De Produits Pharmaceutiques Avenue Cheikh Ibra Fall - Kaolack	33 941 18 86	Kaolack	\N	\N	\N	f	\N
1663	Station Papa Ndao	station-papa-ndao	Commerce De Carburant	\N	2	2026-03-02 23:11:14.14	2026-03-02 23:11:14.14	Commerce De Carburant	Avenue John Fkennedy	33 941 28 29	Kaolack	\N	\N	\N	f	\N
1664	Ccss Sarl (Compagnie Commercial Du Sine Saloum - Sarl)	ccss-sarl-compagnie-commercial-du-sine-saloum-sarl	Commerce	\N	2	2026-03-02 23:11:14.143	2026-03-02 23:11:14.143	Commerce	Rue John F.Kennedy X Amilcar 0 Kaolack Station Total Africom (Mame Aly Gueye) Vente De Produits Petroliers (Station D'Essence) Avenue John F. Kennedy	33 941 10 32	Kaolack	\N	\N	\N	f	\N
1665	Etablissement Modou Cheikh Babou Sarl	etablissement-modou-cheikh-babou-sarl-1	Commerce General	\N	2	2026-03-02 23:11:14.149	2026-03-02 23:11:14.149	Commerce General	Rue Daloi Leona 0 Kaolack Gie Jappo Commerce Dialegne 0 Kaolack Etablissement Diacksao Suarl Commerce Rue Daloi N° 588	77 532 97 90	Kaolack	\N	\N	\N	f	\N
1666	Sami Dagher	sami-dagher	Commerce General	\N	2	2026-03-02 23:11:14.152	2026-03-02 23:11:14.152	Commerce General	Quartier Leona	33 941 34 57	Kaolack	\N	\N	\N	f	\N
1667	Pharmacie Nouvelle (Dr El Hadji Abdoulaye Dieng Pharmacien)	pharmacie-nouvelle-dr-el-hadji-abdoulaye-dieng-pharmacien	Vente De Produits Pharmaceutiques Leona Kaolack 0 Kaolack Sel Du Saloum Suarl Exploitation De Sel Marin Village De Ngane	\N	2	2026-03-02 23:11:14.155	2026-03-02 23:11:14.155	Vente De Produits Pharmaceutiques Leona Kaolack 0 Kaolack Sel Du Saloum Suarl Exploitation De Sel Marin Village De Ngane	Route Nationalr 0 Kaolack Ibrahima Sylla Commerce Leona Kaolack 0 Kaolack Station Yaya Ndiaye Vente De Produits Petroliers Kahone	33 941 10 00	Kaolack	\N	\N	\N	f	\N
1668	Serigne Abdoulaye W Ade Suarl	serigne-abdoulaye-w-ade-suarl-1	Commerce	\N	2	2026-03-02 23:11:14.16	2026-03-02 23:11:14.16	Commerce	Rue Daloa Leona Kaolack	33 944 74 36	Kaolack	\N	\N	\N	f	\N
1669	Pharmacie Du Saloum - Dame Mboup Seck	pharmacie-du-saloum-dame-mboup-seck-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.164	2026-03-02 23:11:14.164	Vente De Produits Pharmaceutiques	Avenue John F. Kennedy - Kaolack	33 941 14 48	Kaolack	\N	\N	\N	f	\N
1670	Boulangerie Serigne Fallou Mbacke (Assane Karaki) Boulangerie Ndorong 0 Kaolack Gie L'Espoir De La	boulangerie-serigne-fallou-mbacke-assane-karaki-boulangerie-ndorong-0-kaolack-gie-l-espoir-de-la	Commerce	\N	2	2026-03-02 23:11:14.169	2026-03-02 23:11:14.169	Commerce	Quartier Leona 0 Kaolack Pharmacie Coumba Ndoffene Diouf (Khar Diouf) Vente De Produits Pharmaceutiques Quartier Boustane - Lot N° 1961	33 941 17 11	Kaolack	\N	\N	\N	f	\N
1671	Boulangerie Bongre (Riad Roze) Boulangerie Bongre Kaolack 0 Kaolack Pharmacie Du Boulevard (Mamadou	boulangerie-bongre-riad-roze-boulangerie-bongre-kaolack-0-kaolack-pharmacie-du-boulevard-mamadou	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.173	2026-03-02 23:11:14.173	Vente De Produits Pharmaceutiques	Boulevard Cheikh Ibrahima Niass	33 941 19 74	Kaolack	\N	\N	\N	f	\N
1672	Mame Balla Seck	mame-balla-seck-1	Commerce	\N	2	2026-03-02 23:11:14.178	2026-03-02 23:11:14.178	Commerce	Rue Buggeaud Leona Kaolack	33 941 39 79	Kaolack	\N	\N	\N	f	\N
1673	Pharmacie Medina Baye (Fatou Samb Cisse )	pharmacie-medina-baye-fatou-samb-cisse-1	Vente De Produits Pharmaceutiques Medina Baye 0 Kaolack Gie Jappo Ligueye Jarignu Commerce General	\N	2	2026-03-02 23:11:14.184	2026-03-02 23:11:14.184	Vente De Produits Pharmaceutiques Medina Baye 0 Kaolack Gie Jappo Ligueye Jarignu Commerce General	Quartier Leona 0 Kaolack Pharmacie Du Sine (Alassane W Attara) Vente De Produits Pharmaceutiques Quartier Kasnack	33 941 20 20	Kaolack	\N	\N	\N	f	\N
1674	Pharmacie De La Passoire	pharmacie-de-la-passoire	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.187	2026-03-02 23:11:14.187	Vente De Produits Pharmaceutiques	Quartier Taba Ngoye Ii - N° 158 B - Kaolack	33 941 47 57	Kaolack	\N	\N	\N	f	\N
1675	Gie Mafatioul Bisri	gie-mafatioul-bisri-1	Commerce - Prestation De Service	\N	2	2026-03-02 23:11:14.192	2026-03-02 23:11:14.192	Commerce - Prestation De Service	Avenue John F.Kennedy Kaolack 0 Kaolack Pharmacie Kaolackoise (Mbaye Gueye) Vente De Produits Pharmaceutiques Bongre (Ex Rte Nationale N° 07, Ex Gare Routiere)	33 941 46 06	Kaolack	\N	\N	\N	f	\N
1676	Pharmacie El Hadj Abdoulaye Niasse	pharmacie-el-hadj-abdoulaye-niasse-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.197	2026-03-02 23:11:14.197	Vente De Produits Pharmaceutiques	Rue Doloa X Faidherbe - Lot N° 96 - Leona	33 941 20 81	Kaolack	\N	\N	\N	f	\N
1677	Pharmacie Noirot	pharmacie-noirot-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.202	2026-03-02 23:11:14.202	Vente De Produits Pharmaceutiques	Quartier Abattoirs Face Garage Koutal	33 942 11 92	Kaolack	\N	\N	\N	f	\N
1678	2Ck Suarl (Comptoir Commerciale De Kaolack - Suarl)	2ck-suarl-comptoir-commerciale-de-kaolack-suarl	Commerce	\N	2	2026-03-02 23:11:14.206	2026-03-02 23:11:14.206	Commerce	Rue Ernest Renan	33 941 19 74	Kaolack	\N	\N	\N	f	\N
1679	Pharmacie Carrefour Ocass (Michel Diouf)	pharmacie-carrefour-ocass-michel-diouf-1	Vente De Produits Pharmaceutiques Qrt Ndorong 0 Kaolack Nadim Yacoub Boulanger Boulangerie	\N	2	2026-03-02 23:11:14.211	2026-03-02 23:11:14.211	Vente De Produits Pharmaceutiques Qrt Ndorong 0 Kaolack Nadim Yacoub Boulanger Boulangerie	Rue El Malick Sy	33 944 40 15	Kaolack	\N	\N	\N	f	\N
1680	Caddell Consulting Prestations De	caddell-consulting-prestations-de	Services	\N	3	2026-03-02 23:11:14.214	2026-03-02 23:11:14.214	Services	Quartier Kasnack Ii Lots N°96	33 825 28 01	Kaolack	\N	\N	\N	f	\N
1681	Pharmacie Au Lycee (Docteur Alioune Badara Ndiaye)	pharmacie-au-lycee-docteur-alioune-badara-ndiaye-1	Vente De Produits Pharmaceutiques Av Cheikh Ahmadou Bamba Taba Ngoye	\N	2	2026-03-02 23:11:14.218	2026-03-02 23:11:14.218	Vente De Produits Pharmaceutiques Av Cheikh Ahmadou Bamba Taba Ngoye	Quartier Niary Taly Kaolack	33 941 40 84	Kaolack	\N	\N	\N	f	\N
1682	Pharmacie Matlabul Chifai (Alioune Seck)	pharmacie-matlabul-chifai-alioune-seck-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.223	2026-03-02 23:11:14.223	Vente De Produits Pharmaceutiques	Quartier Sara 0 Kaolack Baytaine Ba (Ebeps) Services Fournis Aux Entreprises Quartier Leona Rue Elh Abdou Kane 0 Kaolack Pharmacie Des Parcelles Assainies (Khalyl Cheibane Mara) Vente De Produits Pharmaceutiques Parcelles Assainies 0 Kaolack Gie Massylla Services Services Fournis Aux Entreprises Quartier Boustane 0 Kaolack Ets Mohamed Lemine Saleck Commerce Kaolack 0 Kaolack Bene Bounte (Mme Josephine About) Vente De Pieces Detachees Auto Benne Bounte Avenue Jhon Kennedy N° 847	33 941 70 68	Kaolack	\N	\N	\N	f	\N
1683	Kaicedras Sarl	kaicedras-sarl	Services Fournis Aux Entreprises 0 Kaolack Entreprise Amadou Lamine Ndao Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:14.227	2026-03-02 23:11:14.227	Services Fournis Aux Entreprises 0 Kaolack Entreprise Amadou Lamine Ndao Services Fournis Aux Entreprises	Quartier Leona 0 Kaolack Docteur Augustin Tine Activites Pour La Sante Des Hommes (Medecin) Leona Kaolack 0 Kaolack Pharmacie Malem Hodar Vente De Produits Pharmaceutiques Maleme Hodar 0 Kaolack Gestion Expertise Comptable (Geco) Prestation De Services Rue Marechal Bugeau Leona 0 Kaolack Pharmacie Sidy Karachi (Dr Male Diagne) Vente De Produits Pharmaceutiques Boustane Kaolack	33 941 24 04	Kaolack	\N	\N	\N	f	\N
1684	Alioune Diaw	alioune-diaw	Services Fournis Aux Entreprises Camp Des Gardes 0 Kaolack Sofrestal Sarl Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:14.23	2026-03-02 23:11:14.23	Services Fournis Aux Entreprises Camp Des Gardes 0 Kaolack Sofrestal Sarl Services Fournis Aux Entreprises	Rue Paul Seignet Leona 0 Kaolack Entreprise Emb (Mamadou Ndiaye) Services Fournis Aux Entreprises Sam Lot N°79 0 Kaolack Boulangerie Xew Eulgui (Emad Dagher) Boulangerie Kaolack 0 Kaolack Station Total Gare Routiere Kaolack Gerance Station De Vente Hudrocarbure En Face Route Nationale	33 941 97 77	Kaolack	\N	\N	\N	f	\N
1685	Gie Cheikh Al Islam Prestation De	gie-cheikh-al-islam-prestation-de	Service Leona Kaolack 0 Kaolack Gie Takku Ligueye Malick Seck Prestation De Service Medina 2 Kaolack 0 Kayar Boulangerie Gortil Ndoye (Mamour Ndaw ) Boulangerie	\N	4	2026-03-02 23:11:14.232	2026-03-02 23:11:14.232	Service Leona Kaolack 0 Kaolack Gie Takku Ligueye Malick Seck Prestation De Service Medina 2 Kaolack 0 Kayar Boulangerie Gortil Ndoye (Mamour Ndaw ) Boulangerie	Quartier Rond Point - Kayar 0 Kayar Pagel Industries -Sarl Activites Annexes A La Peche Kayar	33 942 14 62	Kaolack	\N	\N	\N	f	\N
1686	Pharmacie Couro	pharmacie-couro-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.237	2026-03-02 23:11:14.237	Vente De Produits Pharmaceutiques	Avenue Cheikh Ahmadou Bamba - Kebemer	77 631 63 35	Kebemer	\N	\N	\N	f	\N
1687	Gie Transport Dieng Et Ibou Transport Routier Passagers Ndande Kebemer 775335166 Kebemer Pharmacie	gie-transport-dieng-et-ibou-transport-routier-passagers-ndande-kebemer-775335166-kebemer-pharmacie	Vente De Produits Pharmaceutiques Kebemer	\N	2	2026-03-02 23:11:14.24	2026-03-02 23:11:14.24	Vente De Produits Pharmaceutiques Kebemer	Route De Dakar 0 Kebemer Seck & Freres Suarl Commerce Quartier Escale Kebemer	33 969 10 76	Kebemer	\N	\N	\N	f	\N
1688	Diao Team Sarl	diao-team-sarl-1	Commerce Kedougou (30,	\N	2	2026-03-02 23:11:14.245	2026-03-02 23:11:14.245	Commerce Kedougou (30,	Rue Victor Hugo) 0 Kedougou Niokolo Transports Sa Transport De Passagers Quartier Compagnie, Route De Saraya 0 Kedougou Galaxy Distribution - Suarl Distribution De Boissons Kedougou	77 688 50 35	Kedougou	\N	\N	\N	f	\N
1689	Station Total Mamadou Lamine Badji	station-total-mamadou-lamine-badji-1	Vente De Produits Petroliers Koungheul 0 Linguere Station Total Linguere(Fode Kamissokho) Vente De Produits Petroliers (Station D'Essence) Allee Linguere 775241837 Linguere Pharmacie Taw Fekh (Mathiare Fall) Vente De Produits Pharmaceutiques	\N	1	2026-03-02 23:11:14.25	2026-03-02 23:11:14.25	Vente De Produits Petroliers Koungheul 0 Linguere Station Total Linguere(Fode Kamissokho) Vente De Produits Petroliers (Station D'Essence) Allee Linguere 775241837 Linguere Pharmacie Taw Fekh (Mathiare Fall) Vente De Produits Pharmaceutiques	Quartier Ndiayenne Rte De Mbeuleukhe Dahra	33 982 21 60	Koungheul	\N	\N	\N	f	\N
1690	El Hadj Abdou Aziz Diagne	el-hadj-abdou-aziz-diagne-1	Commerce General	\N	2	2026-03-02 23:11:14.255	2026-03-02 23:11:14.255	Commerce General	Quartier Montagne, Pres Des Sapeurs Pompiers Louga	30 119 13 29	Louga	\N	\N	\N	f	\N
1691	Mor Mbaye Sylla	mor-mbaye-sylla-1	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:14.26	2026-03-02 23:11:14.26	Commerce De Produits Alimentaires	Rue Escale Quartier Thikhna Louga	33 967 02 22	Louga	\N	\N	\N	f	\N
1692	Societe Dabakh Malick Suarl	societe-dabakh-malick-suarl	Commerce General Marche Central Dahra Djoloff Louga 0 Louga Shell Louga	\N	1	2026-03-02 23:11:14.265	2026-03-02 23:11:14.265	Commerce General Marche Central Dahra Djoloff Louga 0 Louga Shell Louga	Abdoulaye Diagne Vente De Produits Petroliers (Station D'Essence) Allee Thoikhna En Face Sde Louga	77 569 02 22	Louga	\N	\N	\N	f	\N
1693	Societe Thethier Lo Suarl	societe-thethier-lo-suarl-1	Commerce General Medina Dahra Djolof 0 Louga Gie Touba Taif Commerce General	\N	2	2026-03-02 23:11:14.271	2026-03-02 23:11:14.271	Commerce General Medina Dahra Djolof 0 Louga Gie Touba Taif Commerce General	Route De Koki	33 967 11 07	Louga	\N	\N	\N	f	\N
1694	Pharmacie Du Ndiambour - Dr Amadou Sall Ndao	pharmacie-du-ndiambour-dr-amadou-sall-ndao-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.276	2026-03-02 23:11:14.276	Vente De Produits Pharmaceutiques	Rue Du Commerce - Louga	33 967 22 53	Louga	\N	\N	\N	f	\N
1695	Pharmacie Serigne Bara Mbacke	pharmacie-serigne-bara-mbacke	Vente De Produits Pharmaceutiques Louga 0 Louga Pharmacie Amadou Ba Malal(Papa Boubacar Ba) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.28	2026-03-02 23:11:14.28	Vente De Produits Pharmaceutiques Louga 0 Louga Pharmacie Amadou Ba Malal(Papa Boubacar Ba) Vente De Produits Pharmaceutiques	Avenue El Hadji Samba Khary Cisse	33 967 10 62	Louga	\N	\N	\N	f	\N
1696	Pharmacie El Hadji Djily Mbaye (Seynabou Faye Coulibaly)	pharmacie-el-hadji-djily-mbaye-seynabou-faye-coulibaly-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.286	2026-03-02 23:11:14.286	Vente De Produits Pharmaceutiques	Avenue Bouna Alboury Ndiaye - Quartier Keur Kabas	33 967 09 67	Louga	\N	\N	\N	f	\N
1697	Pharmacie W Agane Diouf (Expharmacie Amadou Sakhir Mbaye - Hussein Saiel	pharmacie-w-agane-diouf-expharmacie-amadou-sakhir-mbaye-hussein-saiel-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.291	2026-03-02 23:11:14.291	Vente De Produits Pharmaceutiques	Avenue Lamine Gueye	33 967 05 92	Louga	\N	\N	\N	f	\N
1698	Station Total Birane Ndiaye	station-total-birane-ndiaye-1	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:14.296	2026-03-02 23:11:14.296	Vente De Produits Petroliers	Route De Potou Louga	33 967 14 01	Louga	\N	\N	\N	f	\N
1699	Pharmacie "Abdoul Karim Daff"	pharmacie-abdoul-karim-daff-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.3	2026-03-02 23:11:14.3	Vente De Produits Pharmaceutiques	Quartier Singue Village De Sedo Sebe	33 966 37 30	Matam	\N	\N	\N	f	\N
1700	Pharmacie Thierno Hamet Baba Talla (Abacar Diouf)	pharmacie-thierno-hamet-baba-talla-abacar-diouf-1	Vente De Produits Pharmaceutiques Dangou Minam Rufisque 0 Matam Pharmacie Cheikh Tidiane Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.305	2026-03-02 23:11:14.305	Vente De Produits Pharmaceutiques Dangou Minam Rufisque 0 Matam Pharmacie Cheikh Tidiane Vente De Produits Pharmaceutiques	Rue De La Prefecture Quartier Tantadji	33 966 31 31	Matam	\N	\N	\N	f	\N
1701	Gie Diaky Heege Pellital	gie-diaky-heege-pellital	Commerce Commune De Nguidjione Matam 0 Mbacke Complexe Agro Industriel De Touba Commercialisation Oleaginaux	\N	2	2026-03-02 23:11:14.309	2026-03-02 23:11:14.309	Commerce Commune De Nguidjione Matam 0 Mbacke Complexe Agro Industriel De Touba Commercialisation Oleaginaux	Route De Ndindy Touba	33 962 98 54	Matam	\N	\N	\N	f	\N
1702	Kheweul Sarl	kheweul-sarl-1	Commerce General	\N	2	2026-03-02 23:11:14.315	2026-03-02 23:11:14.315	Commerce General	Rue 25 Marche Ocass Touba 0 Mbacke Touba Distribution Produits Alimentaires(Ousmane Boudib) Commerce General Touba Darou Khoudoss 0 Mbacke Ets Cheikh Gaw Ane Ka Commerce General Touba Darou Khoudoss	33 975 15 88	Mbacke	\N	\N	\N	f	\N
1703	Darou Minam Batiment Sarl Construction Touba Darou Minam 0 Mbacke Pharmacie Skhna Oumy Diop	darou-minam-batiment-sarl-construction-touba-darou-minam-0-mbacke-pharmacie-skhna-oumy-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.318	2026-03-02 23:11:14.318	Vente De Produits Pharmaceutiques	Quartier Darou Khoudoss Touba	33 976 11 46	Mbacke	\N	\N	\N	f	\N
1704	Boulangerie Lamp Fall Boulangerie Quartier Escale Diourbel 0 Mbacke Pharmacie Du Magal (Est	boulangerie-lamp-fall-boulangerie-quartier-escale-diourbel-0-mbacke-pharmacie-du-magal-est	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.321	2026-03-02 23:11:14.321	Vente De Produits Pharmaceutiques	Quartier Escale - Mbacke	77 551 54 88	Mbacke	\N	\N	\N	f	\N
1705	Pharmacie DarouMarnane(Serigne Cheikh Lo Thiam)	pharmacie-daroumarnane-serigne-cheikh-lo-thiam	Vente De Produits Pharmaceutiques Touba Darou Marnane 0 Mbacke Ayssa Ak Sadio Cordes Fabrication De Cables, Cordes, Ficelles, Filets	\N	2	2026-03-02 23:11:14.324	2026-03-02 23:11:14.324	Vente De Produits Pharmaceutiques Touba Darou Marnane 0 Mbacke Ayssa Ak Sadio Cordes Fabrication De Cables, Cordes, Ficelles, Filets	Quartier Touba Boufel Cr De Touba Mosquee	77 540 32 22	Mbacke	\N	\N	\N	f	\N
1706	Pharmacie Dianatoul Mahw A	pharmacie-dianatoul-mahw-a-1	Vente De Produits Pharmaceutiques Dianatoul Mahw A Touba 702047731 Mbacke Cabinet Madical Baklin Cabinet Medical Touba Khaira 0 Mbacke Gie Houda Système Batiment Et Travaux Publics Ex Garage De Dakar En Face Keur Serigne Modou Kara 0 Mbacke Pharmacie Mouridoulahie(Moustapha Senghor) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.329	2026-03-02 23:11:14.329	Vente De Produits Pharmaceutiques Dianatoul Mahw A Touba 702047731 Mbacke Cabinet Madical Baklin Cabinet Medical Touba Khaira 0 Mbacke Gie Houda Système Batiment Et Travaux Publics Ex Garage De Dakar En Face Keur Serigne Modou Kara 0 Mbacke Pharmacie Mouridoulahie(Moustapha Senghor) Vente De Produits Pharmaceutiques	Route De Kael Mbacke	77 550 06 26	Mbacke	\N	\N	\N	f	\N
1707	W Akeur Serigne Massamba Mbacke	w-akeur-serigne-massamba-mbacke	Commerce De Vehicules Et Vente De Pieces Detachees Mbao Gare N°38 0 Mbao Logimat Sarl Transport Routier Mbao Cite Diagne Nar N°7 0 Mboro Pharmacie Diamaguene (Mohamadou Diop) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.331	2026-03-02 23:11:14.331	Commerce De Vehicules Et Vente De Pieces Detachees Mbao Gare N°38 0 Mbao Logimat Sarl Transport Routier Mbao Cite Diagne Nar N°7 0 Mboro Pharmacie Diamaguene (Mohamadou Diop) Vente De Produits Pharmaceutiques	Quartier Diamaguene - Mboro 33 955 43 8 Mboro Pharmacie Mboro Escale (Abdoulaye Dieng) Vente De Produits Pharmaceutiques Escale Mboro 0 Mboro Pharmacie Abdourahmane Mbacke (Seynabou Niang) Vente De Produits Pharmaceutiques Darou Khoudoss - Mboro	33 871 51 15	Mbao	\N	\N	\N	f	\N
1708	Societe Mboro Pharma Autres	societe-mboro-pharma-autres	Services Connexes Fournis A La Collectivite	\N	3	2026-03-02 23:11:14.334	2026-03-02 23:11:14.334	Services Connexes Fournis A La Collectivite	Quartier Escale - Mboro 0 Mbour Ikagel Exotic Sea Food - Sa Negoce Et Traitement Des Pdts De La Mer Mballing Route De Joal	33 855 77 88	Mboro	\N	\N	\N	f	\N
2125	Sodemed Sarl (Societe D'Equipements Medicaux)	sodemed-sarl-societe-d-equipements-medicaux	Vente De Materiel Medical, Produits Medicaux Et De Laboratoire Point E -	\N	2	2026-03-02 23:11:15.613	2026-03-02 23:11:15.613	Vente De Materiel Medical, Produits Medicaux Et De Laboratoire Point E -	Bd De L'Est X Rue 2 -	77 638 62 60	Dakar	\N	\N	\N	f	\N
2126	Stmm (Societe Trading Et De Materiel Medical)	stmm-societe-trading-et-de-materiel-medical	Vente De Materiel Medical	\N	2	2026-03-02 23:11:15.616	2026-03-02 23:11:15.616	Vente De Materiel Medical	Rue B X 6 Point E Keur Mbagnick, Immeuble Hajar	33 825 90 53	Dakar	\N	\N	\N	f	\N
2127	Keur Baax Suarl Activites Pour La Sante Des Hommes	keur-baax-suarl-activites-pour-la-sante-des-hommes	(Services De Sante Fournis A Domicile - Soins Infirmiers)	\N	5	2026-03-02 23:11:15.619	2026-03-02 23:11:15.619	(Services De Sante Fournis A Domicile - Soins Infirmiers)	Route Du Front De Terre Vers Camp Leclerc	33 978 98 51	Dakar	\N	\N	\N	f	\N
2128	Lynn Sarl Activites Pour La Sante Des Hommes (Clinique Ophtalmologie Corniche Est Ancien Palais De	lynn-sarl-activites-pour-la-sante-des-hommes-clinique-ophtalmologie-corniche-est-ancien-palais-de	(Service Medical) Yoff Ocean	\N	5	2026-03-02 23:11:15.621	2026-03-02 23:11:15.621	(Service Medical) Yoff Ocean	Rue 199 0 Thies Clinique De La Conception (Christiane Lahoud Daou) Activites Pour La Sante Des Hommes (Clinique) Rue Birane Yacine Boubou- Escale	33 855 33 20	Dakar	\N	\N	\N	f	\N
1724	Etablissement Souleymane Cisse	etablissement-souleymane-cisse	Commerce Grand Mbour 0 Mbour Pharmacie La Somone (Mamadou Lamine Sane) Vente De Produits Pharmaceutiques Somone 33957 75 06 Mbour Alinea Sarl Commerce Saly Carrefour	\N	2	2026-03-02 23:11:14.396	2026-03-02 23:11:14.396	Commerce Grand Mbour 0 Mbour Pharmacie La Somone (Mamadou Lamine Sane) Vente De Produits Pharmaceutiques Somone 33957 75 06 Mbour Alinea Sarl Commerce Saly Carrefour	Route De Saly	33 957 07 24	Mbour	\N	\N	\N	f	\N
1725	Bodego (Sami Hoballah)	bodego-sami-hoballah-1	Commerce General	\N	2	2026-03-02 23:11:14.399	2026-03-02 23:11:14.399	Commerce General	Route Principale De Saly	33 957 51 83	Mbour	\N	\N	\N	f	\N
1726	Senestar Sarl	senestar-sarl	Commerce General Saly Portudal 33957 55 78 Mbour Frigosen Fabrication D'Autres Produits Alimentaire Mbour	\N	2	2026-03-02 23:11:14.401	2026-03-02 23:11:14.401	Commerce General Saly Portudal 33957 55 78 Mbour Frigosen Fabrication D'Autres Produits Alimentaire Mbour	Rue S.N Tall X Tamsir .D.Sall	33 957 36 63	Mbour	\N	\N	\N	f	\N
1727	Pharmacie Serigne Saliou Mbacke (Dr Serigne Sougou Gueye)	pharmacie-serigne-saliou-mbacke-dr-serigne-sougou-gueye-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.405	2026-03-02 23:11:14.405	Vente De Produits Pharmaceutiques	Quartier Thioce Est 33957 13 85 Mbour Pharmacie Sindia (Mamadou Ciss) Vente De Produits Pharmaceutiques Route De Mbour Sindia	33 957 03 67	Mbour	\N	\N	\N	f	\N
1728	Pharmacie Ndiene (Dr Abdou Gueye Dieng)	pharmacie-ndiene-dr-abdou-gueye-dieng-1	Vente De Produits Pharmaceutiques Corniche Mbour Tefess 33957 25 67 Mbour Pharmacie De La Petite Cote Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.408	2026-03-02 23:11:14.408	Vente De Produits Pharmaceutiques Corniche Mbour Tefess 33957 25 67 Mbour Pharmacie De La Petite Cote Vente De Produits Pharmaceutiques	Mbour,Avenue El Hadji Malick Sy Quartier Escale Mbour	33 957 80 00	Mbour	\N	\N	\N	f	\N
1729	Pharmacie Papa Cheikh Diagne (Dr Yacine Diagne)	pharmacie-papa-cheikh-diagne-dr-yacine-diagne-1	Vente De Produits Pharmaceutiques Mbour Carrefour Du Relai	\N	2	2026-03-02 23:11:14.412	2026-03-02 23:11:14.412	Vente De Produits Pharmaceutiques Mbour Carrefour Du Relai	Quartier Diamaguene	77 644 80 08	Mbour	\N	\N	\N	f	\N
1730	Pharmacie Maurice Fall (Mouhamed El Bachir Fall)	pharmacie-maurice-fall-mouhamed-el-bachir-fall	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.415	2026-03-02 23:11:14.415	Vente De Produits Pharmaceutiques	Quartier Liberte Mbour 33957 53 55 Mbour Pharmacie Karim (Dr Aldiouma Sidibe) Vente De Produits Pharmaceutiques Route De Kaolack Mbour 33957 26 22 Mbour Pharmacie Khadidiatou Vente De Produits Pahrmaceutiques Mbour Serere	33 957 24 90	Mbour	\N	\N	\N	f	\N
1731	Chez Antoinette (Antoinette Ndebane Faye) Alimentation Generale Santhie Joal Fadiouth 0 Mbour	chez-antoinette-antoinette-ndebane-faye-alimentation-generale-santhie-joal-fadiouth-0-mbour	Fabrication De Glace En Ecaille Joal Fadiouth Quai De Pehce 0 Mbour Rovic Group Sa Transport Saly Carrefour 0 Mbour African Trade And Investment Company Production Et Vente De Glace Carrefour Diamnadio 0 Mbour Pallene De Commerce De Construction Et De Batiment - Pcb Btp Mbour 1 Thies 0 Mbour Ibrahima	\N	2	2026-03-02 23:11:14.418	2026-03-02 23:11:14.418	Fabrication De Glace En Ecaille Joal Fadiouth Quai De Pehce 0 Mbour Rovic Group Sa Transport Saly Carrefour 0 Mbour African Trade And Investment Company Production Et Vente De Glace Carrefour Diamnadio 0 Mbour Pallene De Commerce De Construction Et De Batiment - Pcb Btp Mbour 1 Thies 0 Mbour Ibrahima	Abdallah Mohsen Vente De Bois Ave Dembe Diop Mbour 0 Mbour Pharmacie Coulange Vente De Produits Pharmaceutiques Niang	77 534 15 73	Mbour	\N	\N	\N	f	\N
1732	Nouvelle Entreprise Generale De	nouvelle-entreprise-generale-de	Services Mecanique Generale Villa N°424	\N	3	2026-03-02 23:11:14.42	2026-03-02 23:11:14.42	Services Mecanique Generale Villa N°424	Quartier Mbour 3 Thies	33 957 52 63	Mbour	\N	\N	\N	f	\N
1733	Ets Saidou & Freres (Saidou Dia)	ets-saidou-freres-saidou-dia-1	Vente Accessoires Vehicules Mbour	\N	2	2026-03-02 23:11:14.423	2026-03-02 23:11:14.423	Vente Accessoires Vehicules Mbour	Route De Joal Face Cbao 33957 23 23 Mbour Pharmacie Thierno Mansour Barro Vente De Produits Pharmaceutiques Château D'Eau Mbour	77 637 45 67	Mbour	\N	\N	\N	f	\N
1734	Pharmacie Diass	pharmacie-diass	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.425	2026-03-02 23:11:14.425	Vente De Produits Pharmaceutiques	Quartier Escale Diass	77 649 05 67	Mbour	\N	\N	\N	f	\N
1735	Fouta Bureautique Informatique (Abdoulaye Ly)	fouta-bureautique-informatique-abdoulaye-ly-1	Commerce Diamaguene I,	\N	2	2026-03-02 23:11:14.428	2026-03-02 23:11:14.428	Commerce Diamaguene I,	Route Nationale Pres Rond Point Relais 82 0 Mbour Pharmacie Fraternite Vente De Produits Pharmaceutiques Joal Fadiouth	77 528 17 91	Mbour	\N	\N	\N	f	\N
1736	Pharmacie Nabil Moustapha (Abdoulaye Faye)	pharmacie-nabil-moustapha-abdoulaye-faye	Vente De Produits Pharmaceutiques Grand Mbour	\N	2	2026-03-02 23:11:14.43	2026-03-02 23:11:14.43	Vente De Produits Pharmaceutiques Grand Mbour	,Avenue Seydou N Tall Villa 328	33 957 55 11	Mbour	\N	\N	\N	f	\N
1737	King Karaoke Sarl Discotheque Place Bougainvillees Saly -Immeuble King Karaoke Sarl 0 Mbour	king-karaoke-sarl-discotheque-place-bougainvillees-saly-immeuble-king-karaoke-sarl-0-mbour	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.432	2026-03-02 23:11:14.432	Vente De Produits Pharmaceutiques	Quartier Escale Route De Joal Mbour 33957 14 94 Mbour Sarl Club Safari Hotel ,Bars Mbour Maure	33 957 28 28	Mbour	\N	\N	\N	f	\N
1738	Sci Les Prestiges Du Golf Affaires Immobilieres Villa N°5 Residences Les Villas Du Golf, Saly	sci-les-prestiges-du-golf-affaires-immobilieres-villa-n-5-residences-les-villas-du-golf-saly	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.434	2026-03-02 23:11:14.434	Vente De Produits Pharmaceutiques	Quartier Santhie 3 , Joal Fadiou 0 Ville Entreprise Activité Adresse Téléphone Mbour Gsep (Groupe Scolaire Education Plus) Enseignement Privee Quartier Santassou Mbour	33 957 19 91	Mbour	\N	\N	\N	f	\N
1739	Rabih Kazoun Fabrique De Glace Nguekhokh 0 Mbour Pharmacie Badiene Fatou Diop	rabih-kazoun-fabrique-de-glace-nguekhokh-0-mbour-pharmacie-badiene-fatou-diop	Vente De Produits Pharmaceutiques N° 1570	\N	2	2026-03-02 23:11:14.436	2026-03-02 23:11:14.436	Vente De Produits Pharmaceutiques N° 1570	Quartier Medine Mbour	33 957 34 74	Mbour	\N	\N	\N	f	\N
1740	Entreprise Senegalaise De Prefarbication	entreprise-senegalaise-de-prefarbication	Fabrication De Materiaux Mbour 0 Mbour Gie Senegal Loisirs Activites Touristiques Saly Portudal Mbour 0 Mbour Ali Jaber Artiste Musicien Animation Hotel Palm Beach 0 Mbour Cabinet Medical Docteur Mbargou Sow Activites Pour La Sante Des Hommes (Cabinet Medical) Cabinet Medical Mbour 33957 10 53 Mbour Sonevert (Societe Ndao Espaces Verts -Sarl) Services Fournis Aux Entreprises Nationale 1	\N	6	2026-03-02 23:11:14.438	2026-03-02 23:11:14.438	Fabrication De Materiaux Mbour 0 Mbour Gie Senegal Loisirs Activites Touristiques Saly Portudal Mbour 0 Mbour Ali Jaber Artiste Musicien Animation Hotel Palm Beach 0 Mbour Cabinet Medical Docteur Mbargou Sow Activites Pour La Sante Des Hommes (Cabinet Medical) Cabinet Medical Mbour 33957 10 53 Mbour Sonevert (Societe Ndao Espaces Verts -Sarl) Services Fournis Aux Entreprises Nationale 1	Quartier Medine 0 Mbour Merdjanopoulos Sarl Commerce General Saly Mbour 0 Mbour Quincaillerie "Mame Kene" (Talla Niang) Commerce General Mbour Iii Thies	33 957 55 45	Mbour	\N	\N	\N	f	\N
1741	Pharmacie Macha Allah	pharmacie-macha-allah-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.441	2026-03-02 23:11:14.441	Vente De Produits Pharmaceutiques	Quartier 11 Novembre Mbour	33 951 39 39	Mbour	\N	\N	\N	f	\N
1742	Suarl Tama Lodge Auberge Restaurant Mbour Zone Residentielle 0 Mbour Presta	suarl-tama-lodge-auberge-restaurant-mbour-zone-residentielle-0-mbour-presta	Service Senegal Services Et Conseils	\N	4	2026-03-02 23:11:14.443	2026-03-02 23:11:14.443	Service Senegal Services Et Conseils	Immeuble City Square Route Ppal De Saly Mbour	33 957 05 00	Mbour	\N	\N	\N	f	\N
1743	Pharmacie Nabil Moustapha (Magatte Mbengue)	pharmacie-nabil-moustapha-magatte-mbengue-1	Vente De Produits Pharmaceutiques Mbour,	\N	2	2026-03-02 23:11:14.446	2026-03-02 23:11:14.446	Vente De Produits Pharmaceutiques Mbour,	Quartier Thioce Est	33 957 45 10	Mbour	\N	\N	\N	f	\N
1744	Academica Sarl Enseignement Prive Route De Kaolack,Immeuble Moustapha Dabo / 2400 0 Mbour W Adene	academica-sarl-enseignement-prive-route-de-kaolack-immeuble-moustapha-dabo-2400-0-mbour-w-adene	Commerce Sarl	\N	2	2026-03-02 23:11:14.448	2026-03-02 23:11:14.448	Commerce Sarl	Immobilier-Commerce Nguehokh	33 957 25 31	Mbour	\N	\N	\N	f	\N
1745	Bernasol Sarl Importation Et	bernasol-sarl-importation-et-1	Vente Ngaparou Diamaguene	\N	2	2026-03-02 23:11:14.451	2026-03-02 23:11:14.451	Vente Ngaparou Diamaguene	Route De Saly	33 957 39 45	Mbour	\N	\N	\N	f	\N
1746	W Ater Coo Sarl	w-ater-coo-sarl-1	Commerce	\N	2	2026-03-02 23:11:14.454	2026-03-02 23:11:14.454	Commerce	Rue El Hadji Malick Sy Mbour 0 Mbour Pharmacie Sainte Anne Saly Vente De Produits Pharmaceutiques Saly Route Nationale 1 33957 08 08 Mbour Penning Nianing Suarl (Casa Coco) Hebergement Et Restaurant Nianing Suarl	77 143 58 58	Mbour	\N	\N	\N	f	\N
1747	Gie Borom Daradji	gie-borom-daradji	Commerce General Mbour	\N	2	2026-03-02 23:11:14.456	2026-03-02 23:11:14.456	Commerce General Mbour	Route Nationale 0 Mbour Gie Saly Nautisme Aventure Activites Recreatives Residence Du Port Saly Portudal 0 Mbour Au Grenier D'Afrique Suarl Commerce Saly Portudal / Mbour 0 Mbour Mat Vet Sarl Activites Veterinaires 82, Relais Mbour 0 Mbour Pharmacie Francisco Brain Vente De Produits Pharmaceutiques Escale Thiadiaye Mbour 0 Mbour Les Manguiers De Guereo Suarl Hotelerie Village De Guereo 0 Mbour Touba Sar Sara (Mamadou Thiam) Vente De Fournitures Et Materiels Santhe 1 Joal	77 634 26 10	Mbour	\N	\N	\N	f	\N
1748	Bic (Bureau D'Ingenierie Et De Contrôle) Btp Mbour Iii Thies 0 Mbour Sicosen	bic-bureau-d-ingenierie-et-de-controle-btp-mbour-iii-thies-0-mbour-sicosen	Distribution Sarl Tourisme Et Agences De Voyages	\N	2	2026-03-02 23:11:14.458	2026-03-02 23:11:14.458	Distribution Sarl Tourisme Et Agences De Voyages	Mballing,Route De Joal En Face Case Beaute Mbour 0 Mbour Afiledio Sarl - Hotel Hacienda Hotel Bar Restaurant Saly Coulang Saly Portudal Mbour 0 Mbour Visiomax Sarl Opticien - Lumetierie Centre Commercial Saly Center Route De Ngaparou Mbour	33 957 00 00	Mbour	\N	\N	\N	f	\N
1749	Nianing Automobiles	nianing-automobiles	Commerce De Vehicules Parcelles 31 Et 33 0 Mbour Pharmacie Babilone (Docteur Anne Marie Ndiaye) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.462	2026-03-02 23:11:14.462	Commerce De Vehicules Parcelles 31 Et 33 0 Mbour Pharmacie Babilone (Docteur Anne Marie Ndiaye) Vente De Produits Pharmaceutiques	Route Nationale Nguekhokh	77 605 56 04	Mbour	\N	\N	\N	f	\N
1750	Gie Cis & Famille	gie-cis-famille-1	Production Commerce General Medine - Mbour 0 Mbour Groupe Scolaire Future Education Nianing,	\N	2	2026-03-02 23:11:14.465	2026-03-02 23:11:14.465	Production Commerce General Medine - Mbour 0 Mbour Groupe Scolaire Future Education Nianing,	Quartier Diamaguene	33 957 45 00	Mbour	\N	\N	\N	f	\N
1751	Touba Meubles	touba-meubles-1	Vente De Marchandises	\N	2	2026-03-02 23:11:14.468	2026-03-02 23:11:14.468	Vente De Marchandises	Route De Saly En Face Renault Tableau Diacsao	33 958 55 56	Mbour	\N	\N	\N	f	\N
1752	Entreprise D'Interim Et De	entreprise-d-interim-et-de	Services Prestation De Services Mbour	\N	3	2026-03-02 23:11:14.47	2026-03-02 23:11:14.47	Services Prestation De Services Mbour	Quartier Medine 0 Mbour Keur Sekh-Yi - Sarl (Takana) Hotel Rpnd Point Ngaparou	33 957 55 56	Mbour	\N	\N	\N	f	\N
1753	Chouette Mama Sarl	chouette-mama-sarl	Fabrication De Savons - Detergents Et Produits D'Entretien Popenguine 2Eme Plage Falaise / 44 0 Mbour Sepromi Sarl Promotion	\N	7	2026-03-02 23:11:14.472	2026-03-02 23:11:14.472	Fabrication De Savons - Detergents Et Produits D'Entretien Popenguine 2Eme Plage Falaise / 44 0 Mbour Sepromi Sarl Promotion	Immobiliere & Amenagement Foncier Saly Carrefour 0 Mbour Cabinet Dentaire Docteur Alain Marie Gaston Rahis Activites Pour La Sante Des Hommes (Cabinet Dentaire) Mbour - Quartier Escale En Face Mairie	77 643 73 99	Mbour	\N	\N	\N	f	\N
1754	Revac - Regis Des Vacances De Reves Autres	revac-regis-des-vacances-de-reves-autres	Services	\N	3	2026-03-02 23:11:14.474	2026-03-02 23:11:14.474	Services	Immobiliers Residence Popenguine Lot N° 92 Saly	33 957 13 84	Mbour	\N	\N	\N	f	\N
1755	Horta -Sarl	horta-sarl	Commerce Nationale 1	\N	2	2026-03-02 23:11:14.476	2026-03-02 23:11:14.476	Commerce Nationale 1	Quartier Medine	77 638 70 80	Mbour	\N	\N	\N	f	\N
1756	Cafe Greole Bar Restauration Rond Point Ngaparou 0 Mbour Cabinet Dentaire Alice (Oumar Sow )	cafe-greole-bar-restauration-rond-point-ngaparou-0-mbour-cabinet-dentaire-alice-oumar-sow	Services	\N	4	2026-03-02 23:11:14.478	2026-03-02 23:11:14.478	Services	Immobiliers Route Centrale Somone	33 957 37 66	Mbour	\N	\N	\N	f	\N
1757	Onno Van Burren Gerard	onno-van-burren-gerard	Commerce De Vehicule Et Accessoirs Saly Carrefour 0 Mbour Gie Meunier Bar - Restaurant Saly	\N	2	2026-03-02 23:11:14.481	2026-03-02 23:11:14.481	Commerce De Vehicule Et Accessoirs Saly Carrefour 0 Mbour Gie Meunier Bar - Restaurant Saly	Tapee,Route De Ngaparou 0 Mbour Mikado Quad Aventure - Sarl Activites De Soutien Aux Entreprises N.C.A Carroussel Saly Portudal	76 689 36 34	Mbour	\N	\N	\N	f	\N
1758	Chantal Pimpernelle	chantal-pimpernelle-1	Commerce Saly Portudal Villa Alize N° 41 0 Mbour Pp Khady	\N	2	2026-03-02 23:11:14.485	2026-03-02 23:11:14.485	Commerce Saly Portudal Villa Alize N° 41 0 Mbour Pp Khady	Immo (Khadidiatou Kane) Gestion Immobiliere Saly Portudal	33 957 74 40	Mbour	\N	\N	\N	f	\N
1759	Sci Happy Center	sci-happy-center	Services	\N	3	2026-03-02 23:11:14.487	2026-03-02 23:11:14.487	Services	Immobiliers Route De Saly Face Elton Mbour	33 957 06 43	Mbour	\N	\N	\N	f	\N
1760	Crm Sen Sarl Prestations De	crm-sen-sarl-prestations-de	Services	\N	3	2026-03-02 23:11:14.489	2026-03-02 23:11:14.489	Services	Immeuble Sa Mbacke Saly Portudal 0 Mbour Chez Paolo Bar - Restaurant Mbour Quartier 11 Novembre 0 Mbour Maison Couleur Passion (Adeline Marcadier Nathalie Jerome) Hebergement - Restaurant Nianing Santhie	77 639 18 74	Mbour	\N	\N	\N	f	\N
1761	Allo Immo -Sarl	allo-immo-sarl	Service	\N	3	2026-03-02 23:11:14.491	2026-03-02 23:11:14.491	Service	Immobilier Route De Ngaparou Saly Centre	33 957 75 30	Mbour	\N	\N	\N	f	\N
1762	Sci Les Baobabs De Ngaparou Immobilier Ngaparou Plage 0 Mbour Gie Cotiga	sci-les-baobabs-de-ngaparou-immobilier-ngaparou-plage-0-mbour-gie-cotiga	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:14.493	2026-03-02 23:11:14.493	Services Fournis Aux Entreprises	Route De Dakar - Avenue Seydou Nourou Tall /Mbour	33 957 51 83	Mbour	\N	\N	\N	f	\N
1763	Sia Sarl (Senegalaise D'Importation D'Automobiles)	sia-sarl-senegalaise-d-importation-d-automobiles-1	Commerce	\N	2	2026-03-02 23:11:14.496	2026-03-02 23:11:14.496	Commerce	Route De Saly	33 957 26 17	Mbour	\N	\N	\N	f	\N
1764	Agence De La Plage Agence Immobiliere Saly Portudal 0 Mbour Mahedia	agence-de-la-plage-agence-immobiliere-saly-portudal-0-mbour-mahedia	Services (Marie Helene Khodia Ndiaye) Activites Juridiques	\N	3	2026-03-02 23:11:14.498	2026-03-02 23:11:14.498	Services (Marie Helene Khodia Ndiaye) Activites Juridiques	Route De Saly	77 595 36 45	Mbour	\N	\N	\N	f	\N
1765	Sodaves Sarl	sodaves-sarl	Vente D'Equipements Sportifs	\N	2	2026-03-02 23:11:14.501	2026-03-02 23:11:14.501	Vente D'Equipements Sportifs	Route Complxe Keur Madior Mbour 0 Mbour Gie You Construction Construction Et Batiment Quartier Ndiouffene	77 529 84 94	Mbour	\N	\N	\N	f	\N
1766	Look Immo M ( Meurville Marie Rose Anne Lucienne) Gestion Immobiliere Somone 0 Mbour Le Parc	look-immo-m-meurville-marie-rose-anne-lucienne-gestion-immobiliere-somone-0-mbour-le-parc	Services Quai De Peche Joal 0 Mbour Sci Santhie Gestion	\N	4	2026-03-02 23:11:14.504	2026-03-02 23:11:14.504	Services Quai De Peche Joal 0 Mbour Sci Santhie Gestion	Immobiliere Santhie Ii Extention 0 Mbour Vetohorizon Sarl Veterinaires Croisement Saly Mbour	33 957 40 08	Mbour	\N	\N	\N	f	\N
1767	Sen Leg Sa	sen-leg-sa	Production Agricole Saly Carrefour 0 Mbour Centre National De Formation Professionnelle "Les Mains Ouvertes" Sarl Formation Professionnelle W Arang Soce 774064013 Mbour Gie Alize Hebergement Et Restauration Somone 0 Mbour Gie Les Cases De Saly Hebergement Saly Portudal 0 Mbour Sci Pelican Gestion	\N	4	2026-03-02 23:11:14.506	2026-03-02 23:11:14.506	Production Agricole Saly Carrefour 0 Mbour Centre National De Formation Professionnelle "Les Mains Ouvertes" Sarl Formation Professionnelle W Arang Soce 774064013 Mbour Gie Alize Hebergement Et Restauration Somone 0 Mbour Gie Les Cases De Saly Hebergement Saly Portudal 0 Mbour Sci Pelican Gestion	Immobiliere Saly Portudal	33 954 97 46	Mbour	\N	\N	\N	f	\N
1768	Sw Eet Senegal Sarl	sw-eet-senegal-sarl	Services	\N	3	2026-03-02 23:11:14.508	2026-03-02 23:11:14.508	Services	Immobilers Saly Portudal 0 Mbour Societe Civile Immobiliere "Sci Les Villas Blanches" Societe Immobiliere Et Affaires Immobilieres Gagnabougou - Nianing - Mbour	77 636 75 32	Mbour	\N	\N	\N	f	\N
1769	Gie Consept Plan Activites De Soutien Aux Entreprises Ngaparou 0 Mecke Gie Gandiol	gie-consept-plan-activites-de-soutien-aux-entreprises-ngaparou-0-mecke-gie-gandiol	Vente De Marchandises	\N	2	2026-03-02 23:11:14.51	2026-03-02 23:11:14.51	Vente De Marchandises	Quartier Lebou Ngaye Mekhe	33 957 44 44	Mbour-Saly	\N	\N	\N	f	\N
1770	Afric'Art Sarl Autres	afric-art-sarl-autres	Commerces Mekhe	\N	2	2026-03-02 23:11:14.512	2026-03-02 23:11:14.512	Commerces Mekhe	Route De Pekesse	33 955 51 50	Meckhe	\N	\N	\N	f	\N
1771	Pharmacie Yelitare	pharmacie-yelitare-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.515	2026-03-02 23:11:14.515	Vente De Produits Pharmaceutiques	Route Nationale Ndioum	33 955 55 88	Ndioum	\N	\N	\N	f	\N
1772	Pharmacie Ndoffane	pharmacie-ndoffane	Vente De Produits Pharmaceutiques Ndoffane 0 Ngaparou Trans Inter Transports Hydrocarbures Garage	\N	1	2026-03-02 23:11:14.517	2026-03-02 23:11:14.517	Vente De Produits Pharmaceutiques Ndoffane 0 Ngaparou Trans Inter Transports Hydrocarbures Garage	Route De Yenne - Dougar	33 965 30 32	Ndoffane	\N	\N	\N	f	\N
1773	Entreprise Activité Adresse Téléphone Ourosogui W Akeur Elh Serigne Ousseynou Sylla Diw Ane	entreprise-activite-adresse-telephone-ourosogui-w-akeur-elh-serigne-ousseynou-sylla-diw-ane	Commerce	\N	2	2026-03-02 23:11:14.52	2026-03-02 23:11:14.52	Commerce	Route Ogo Carrefour Ourossogui	77 656 56 06	Ville	\N	\N	\N	f	\N
1774	Mbacke & Freres Surl	mbacke-freres-surl-1	Commerce Produits Alimentaires Et Transport	\N	2	2026-03-02 23:11:14.523	2026-03-02 23:11:14.523	Commerce Produits Alimentaires Et Transport	Route De L'Hopital - Marche Ourossogui	77 371 25 63	Ourossogui	\N	\N	\N	f	\N
1775	Pharmacie Cheikh Oumar Foutiyou Tall(Alpha Abdoul Ba)	pharmacie-cheikh-oumar-foutiyou-tall-alpha-abdoul-ba	Vente De Produits Pharmaceutiques Galoya 0 Podor Pharmacie Fanaye(Docteur Sidy Deme) Vente De Produits Pharmaceutiques Village De Fanaye 0 Podor Cabinet Veterinaire Bon Berger (Gerome Sambou) Sante Et Reproduction Animales (Cabinet Veterinaire) Thille Boubacar En Face Marche	\N	2	2026-03-02 23:11:14.525	2026-03-02 23:11:14.525	Vente De Produits Pharmaceutiques Galoya 0 Podor Pharmacie Fanaye(Docteur Sidy Deme) Vente De Produits Pharmaceutiques Village De Fanaye 0 Podor Cabinet Veterinaire Bon Berger (Gerome Sambou) Sante Et Reproduction Animales (Cabinet Veterinaire) Thille Boubacar En Face Marche	Hebdomadaire	30 102 49 01	Podor	\N	\N	\N	f	\N
1776	Entreprise Jappo Suarl Btp Thiekene 0 Richard Toll Cct	entreprise-jappo-suarl-btp-thiekene-0-richard-toll-cct	(Commerce Et Transport Tirera) Commerce General	\N	2	2026-03-02 23:11:14.527	2026-03-02 23:11:14.527	(Commerce Et Transport Tirera) Commerce General	Route Nationale Quatier Escale	33 953 41 47	Pout	\N	\N	\N	f	\N
1777	Etablissements Tirera Et Fils Sarl	etablissements-tirera-et-fils-sarl-1	Commerce	\N	2	2026-03-02 23:11:14.53	2026-03-02 23:11:14.53	Commerce	Route Nationale N°1 Richard-Toll	33 963 33 20	Richard-Toll	\N	\N	\N	f	\N
1778	Bethio Station Petrodis Oil (Idrissa Badji)	bethio-station-petrodis-oil-idrissa-badji-1	Commerce De Produits Petroliers	\N	1	2026-03-02 23:11:14.533	2026-03-02 23:11:14.533	Commerce De Produits Petroliers	Route Nationale, Ross Bethio	77 535 45 72	Ross	\N	\N	\N	f	\N
1779	Oleosen Sa	oleosen-sa	Production Et Conditionnement Huile	\N	7	2026-03-02 23:11:14.535	2026-03-02 23:11:14.535	Production Et Conditionnement Huile	Bccd	33 836 22 40	Rufisque	\N	\N	\N	f	\N
1780	Comptoir Commercial Maamarah Sarl	comptoir-commercial-maamarah-sarl-1	Commerce Rufisque	\N	2	2026-03-02 23:11:14.538	2026-03-02 23:11:14.538	Commerce Rufisque	Rue Ousmane Soce Diop N°468	33 859 01 40	Rufisque	\N	\N	\N	f	\N
1781	Rufsac - Sa (Rufisquoise De	rufsac-sa-rufisquoise-de	Fabrication De Sacs) Fabrication De Sacs En Papiers Kraft	\N	7	2026-03-02 23:11:14.54	2026-03-02 23:11:14.54	Fabrication De Sacs) Fabrication De Sacs En Papiers Kraft	Route De Rufisque * Cap Des Biches	33 836 01 64	Rufisque	\N	\N	\N	f	\N
1782	Gfl - Sa (Groupe Fauzie Layousse - Ex Ets) Transport -	gfl-sa-groupe-fauzie-layousse-ex-ets-transport-1	Commerce Import/Export	\N	2	2026-03-02 23:11:14.544	2026-03-02 23:11:14.544	Commerce Import/Export	Route De Rufisque	33 836 58 40	Rufisque	\N	\N	\N	f	\N
1783	Maha	maha	Distribution Sarl Services Hydrocarbure	\N	1	2026-03-02 23:11:14.546	2026-03-02 23:11:14.546	Distribution Sarl Services Hydrocarbure	Boulevard Maurice Gueye Rufisque	33 836 33 51	Rufisque	\N	\N	\N	f	\N
1784	Sosecar Sa (Ste Senegalaise D'Exploitation De Carriere)	sosecar-sa-ste-senegalaise-d-exploitation-de-carriere	Fabrication De Produits Mineraux Pour La Construction	\N	6	2026-03-02 23:11:14.548	2026-03-02 23:11:14.548	Fabrication De Produits Mineraux Pour La Construction	Avenue Ousmane Soce Diop - Rufisque	77 556 45 75	Rufisque	\N	\N	\N	f	\N
1785	Station Shell Rufisque 2 (Mr Hathiramani Suresh)	station-shell-rufisque-2-mr-hathiramani-suresh-1	Vente De Produits Petroliers Guendel,	\N	1	2026-03-02 23:11:14.551	2026-03-02 23:11:14.551	Vente De Produits Petroliers Guendel,	Bd Maurice Gueye - Rufisque	33 836 33 51	Rufisque	\N	\N	\N	f	\N
1786	Station Total Diamniadio (Mouhamadou W Adj)	station-total-diamniadio-mouhamadou-w-adj-1	Vente De Produits Petroliers (Station D'Essence) Entree Diamniadio 0 Rufisque Sepam - Sa (Ste D'Exploitation Des Produits Agricoles Et Maraichers) Production Et Exportation De Produits Maraîchers Et Agricoles	\N	1	2026-03-02 23:11:14.555	2026-03-02 23:11:14.555	Vente De Produits Petroliers (Station D'Essence) Entree Diamniadio 0 Rufisque Sepam - Sa (Ste D'Exploitation Des Produits Agricoles Et Maraichers) Production Et Exportation De Produits Maraîchers Et Agricoles	Avenue Ousmane Soce Diop - Rufisque	33 828 36 03	Rufisque	\N	\N	\N	f	\N
1787	Cstp Sa (Compagnie Senegalaise De Tubes En Plastiques)	cstp-sa-compagnie-senegalaise-de-tubes-en-plastiques	Fabrication De Tubes Pvc	\N	7	2026-03-02 23:11:14.557	2026-03-02 23:11:14.557	Fabrication De Tubes Pvc	Quartier Thiaw Lene - Ex Icotaf	33 836 11 81	Rufisque	\N	\N	\N	f	\N
1788	Station Total Keury Kao (Nakhass Sene)	station-total-keury-kao-nakhass-sene-1	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:14.56	2026-03-02 23:11:14.56	Vente De Produits Petroliers (Station D'Essence)	Bd Maurice Gueye Keury Kao	33 836 04 06	Rufisque	\N	\N	\N	f	\N
1789	Senarh Sa	senarh-sa	Production Et Conditionnement Huile	\N	7	2026-03-02 23:11:14.562	2026-03-02 23:11:14.562	Production Et Conditionnement Huile	Route Nationale 1 Keury Kao - Rufisque	77 658 03 28	Rufisque	\N	\N	\N	f	\N
1790	Ets Ndiaye Et Freres	ets-ndiaye-et-freres	Commerce	\N	2	2026-03-02 23:11:14.565	2026-03-02 23:11:14.565	Commerce	Rue Adama Lo X Thinck	33 839 87 39	Rufisque	\N	\N	\N	f	\N
1791	Entreprise Activité Adresse Téléphone Rufisque Caa - Sarl (Compagnie Africaine Des Accumulateurs -	entreprise-activite-adresse-telephone-rufisque-caa-sarl-compagnie-africaine-des-accumulateurs	Commerce (Ex_Fabrique D'Accumulateur Automobile)	\N	2	2026-03-02 23:11:14.567	2026-03-02 23:11:14.567	Commerce (Ex_Fabrique D'Accumulateur Automobile)	Bccd	77 231 31 91	Ville	\N	\N	\N	f	\N
1792	Postoudiokoul - Sa	postoudiokoul-sa	Production D'Electricite P/C De Tiers Et Gestion De Portefeuille	\N	1	2026-03-02 23:11:14.569	2026-03-02 23:11:14.569	Production D'Electricite P/C De Tiers Et Gestion De Portefeuille	Rue Du Phare De Dioukol - Rufisque	33 836 33 73	Rufisque	\N	\N	\N	f	\N
1793	Ngs (Nouvelles Galeries Du Senegal)	ngs-nouvelles-galeries-du-senegal	Services Rendus Aux Entreprises	\N	3	2026-03-02 23:11:14.572	2026-03-02 23:11:14.572	Services Rendus Aux Entreprises	Route De Rufisque 0 Rufisque Boulangerie Moderne Ibrahima Ndao (Djibril Ndao) Boulangerie Quartier Arafat - Rufisque	33 873 01 52	Rufisque	\N	\N	\N	f	\N
1794	Mcb (Materiaux De Construction & Boiseries)	mcb-materiaux-de-construction-boiseries-1	Vente De Bois, Ciment Et Fer	\N	2	2026-03-02 23:11:14.576	2026-03-02 23:11:14.576	Vente De Bois, Ciment Et Fer	Rue Derbezy	77 638 71 45	Rufisque	\N	\N	\N	f	\N
1795	Station	station-6	Service Oilibya Diacksao (Karba Traore) Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:14.587	2026-03-02 23:11:14.587	Service Oilibya Diacksao (Karba Traore) Vente De Produits Petroliers (Station D'Essence)	Route De Rufisque Diacksao	77 746 60 46	Rufisque	\N	\N	\N	f	\N
1796	Pharmacie Moderne - Farid Boulos Chami	pharmacie-moderne-farid-boulos-chami-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.59	2026-03-02 23:11:14.59	Vente De Produits Pharmaceutiques	Rue Ousmane Soce Diop - Keury Souf - Rufisque	33 839 88 40	Rufisque	\N	\N	\N	f	\N
1797	Ets Deggo	ets-deggo-1	Multiservices - Mamadou Kane Vente D'Aliments De Betail Et Produits Boulangerie	\N	2	2026-03-02 23:11:14.594	2026-03-02 23:11:14.594	Multiservices - Mamadou Kane Vente D'Aliments De Betail Et Produits Boulangerie	Quartier Santa Yalla N°16 Rufisque	33 836 22 98	Rufisque	\N	\N	\N	f	\N
1798	Balla Kebe	balla-kebe-1	Vente De Produits Finis Bambilor	\N	2	2026-03-02 23:11:14.597	2026-03-02 23:11:14.597	Vente De Produits Finis Bambilor	Quartier Ndiassane	33 836 89 20	Rufisque	\N	\N	\N	f	\N
1799	Aziz Seck	aziz-seck-1	Vente De Marchandises	\N	2	2026-03-02 23:11:14.601	2026-03-02 23:11:14.601	Vente De Marchandises	Rue Faidherbe - Rufisque	77 421 53 34	Rufisque	\N	\N	\N	f	\N
1800	Pharmacie Centrale - Genevieve Haddad - Rufisque	pharmacie-centrale-genevieve-haddad-rufisque	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.603	2026-03-02 23:11:14.603	Vente De Produits Pharmaceutiques	Rue Ousmane Soce Diop - Rufisque	33 836 59 59	Rufisque	\N	\N	\N	f	\N
1801	Pharmacie Astele	pharmacie-astele	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.606	2026-03-02 23:11:14.606	Vente De Produits Pharmaceutiques	Boulevard Maurice Gueye	33 821 54 94	Rufisque	\N	\N	\N	f	\N
1802	Helios Industries Suarl	helios-industries-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.608	2026-03-02 23:11:14.608	Vente De Produits Pharmaceutiques	Route De Rufisque	77 639 37 86	Rufisque	\N	\N	\N	f	\N
1803	Gie Germe Prestation De	gie-germe-prestation-de	Services	\N	3	2026-03-02 23:11:14.61	2026-03-02 23:11:14.61	Services	Rue Adama Lo Prolongee Guendel 1 Rufisque	33 832 92 96	Rufisque	\N	\N	\N	f	\N
1804	Ibrahima Gueye Autres	ibrahima-gueye-autres-1	Commerces De Details	\N	2	2026-03-02 23:11:14.613	2026-03-02 23:11:14.613	Commerces De Details	Rue Ousmane Soce Diop- Rufisque 0 Rufisque Boulangerie Patisserie "Au Prestige" (Joseph Dit Toufic Abourizk) Boulangerie Patisserie Bd Maurice Gueye - Rufisque	77 511 98 75	Rufisque	\N	\N	\N	f	\N
1805	Pharmacie Mame Sophie Ndiaye (Souleyemane Gning)	pharmacie-mame-sophie-ndiaye-souleyemane-gning-1	Vente De Produits Pharmaceutiques Rufisque Extension 2	\N	2	2026-03-02 23:11:14.617	2026-03-02 23:11:14.617	Vente De Produits Pharmaceutiques Rufisque Extension 2	Quartier Santa Yalla	33 836 01 80	Rufisque	\N	\N	\N	f	\N
1806	La Brousse Suarl	la-brousse-suarl-1	Commerce	\N	2	2026-03-02 23:11:14.621	2026-03-02 23:11:14.621	Commerce	Route De Yenne X Todd	33 863 12 43	Rufisque	\N	\N	\N	f	\N
1807	Pharmacie Du Stade Suarl	pharmacie-du-stade-suarl-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.625	2026-03-02 23:11:14.625	Vente De Produits Pharmaceutiques	Route Des Hlm Face Stade Municipal De Rufisque	77 521 60 70	Rufisque	\N	\N	\N	f	\N
1808	Corak Senegal Sarl	corak-senegal-sarl	Fabrication De Cloture Maraicher	\N	7	2026-03-02 23:11:14.627	2026-03-02 23:11:14.627	Fabrication De Cloture Maraicher	Route De Rufisque	33 836 78 65	Rufisque	\N	\N	\N	f	\N
1809	Entreprise Activité Adresse Téléphone Rufisque Quincaillerie Le President Sarl	entreprise-activite-adresse-telephone-rufisque-quincaillerie-le-president-sarl	Commerce Quincaillerie	\N	2	2026-03-02 23:11:14.629	2026-03-02 23:11:14.629	Commerce Quincaillerie	Bd Maurice Gueye En Face Clinique Rada - Rufisque 0 Rufisque Gie Secur - Plus Activites De Soutien Aux Entreprises Bargny Cite 1 0 Rufisque Clinique Rada (Dr Joseph Layousse) Activites Pour La Sante Des Hommes ( Cabinet Medical) Rufisque	33 836 82 55	Ville	\N	\N	\N	f	\N
1810	Ets Serigne Abdou Lahat Mbacke	ets-serigne-abdou-lahat-mbacke-1	Commerce	\N	2	2026-03-02 23:11:14.634	2026-03-02 23:11:14.634	Commerce	Quartier Keury Souf Bambilor 0 Rufisque Pharmacie Mamadou Ngom (Sara Ngom) Vente De Produits Pharmaceutiques Mbambilor Ndiassane 0 Rufisque Pharmacie Mame Ale Sylla Vente De Produits Pharmaceutiques Rufisque Ouest, N°515 Quartier Serigne Koki	33 836 35 34	Rufisque	\N	\N	\N	f	\N
1811	Pharmacie Marietou Seck (Aminata Diop)	pharmacie-marietou-seck-aminata-diop-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.638	2026-03-02 23:11:14.638	Vente De Produits Pharmaceutiques	Quartier Dangou	77 566 68 86	Rufisque	\N	\N	\N	f	\N
1812	Pharmacie Sp (Sante Plus) Mouhamadou Fadilou Mbacke	pharmacie-sp-sante-plus-mouhamadou-fadilou-mbacke-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.642	2026-03-02 23:11:14.642	Vente De Produits Pharmaceutiques	Quartier Darou Rahmane Rufisque	33 836 74 70	Rufisque	\N	\N	\N	f	\N
1813	Pharmacie Omar Abdourahmane (Aminata Diouf)	pharmacie-omar-abdourahmane-aminata-diouf-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.646	2026-03-02 23:11:14.646	Vente De Produits Pharmaceutiques	Quartier Ndaldaly - Bargny 0 Rufisque Boulangerie La Bargnoise (Marlane Labuschagne) Boulangerie Patisserie Bargny Sur Mer	77 957 74 02	Rufisque	\N	\N	\N	f	\N
1814	Tony Gabaien	tony-gabaien-1	Vente De Pieces Detachees	\N	2	2026-03-02 23:11:14.65	2026-03-02 23:11:14.65	Vente De Pieces Detachees	Rue Ousmane Soce Diop X Rue Derbezy Marche De Rufisque 0 Rufisque Gie Etat (Entreprise Travaux Agriculture Transports) Agriculture - Horticulture - Maraichage Village Bambylor Medina 3 0 Rufisque Pharmacie Sangalkam (Dr Aliou Gadiaga) Vente De Produits Pharmaceutiques Sangalkam	77 650 79 79	Rufisque	\N	\N	\N	f	\N
1815	Pharmacie Satou (Mouhamadou Ndiaye)	pharmacie-satou-mouhamadou-ndiaye	Vente De Produits Pharmaceutiques Rufisque	\N	2	2026-03-02 23:11:14.652	2026-03-02 23:11:14.652	Vente De Produits Pharmaceutiques Rufisque	Quartier Ngessou Pont Abdoulaye Nar	77 652 45 77	Rufisque	\N	\N	\N	f	\N
1816	Mbathie Import Sarl	mbathie-import-sarl-1	Commerce General Km 22	\N	2	2026-03-02 23:11:14.656	2026-03-02 23:11:14.656	Commerce General Km 22	Route De Rufisque	33 836 23 92	Rufisque	\N	\N	\N	f	\N
1817	Pharmacie Ndeye Fambaye Gaye	pharmacie-ndeye-fambaye-gaye-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.659	2026-03-02 23:11:14.659	Vente De Produits Pharmaceutiques	Quartier Fass Ainoumani Rufisque Nord	33 836 22 52	Rufisque	\N	\N	\N	f	\N
1818	Pharmacie Fass	pharmacie-fass-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.663	2026-03-02 23:11:14.663	Vente De Produits Pharmaceutiques	Route De Fass Rufisque 0 Rufisque Hortica Senegal Sarl Arboriculture Rue De Garonnne	33 873 08 28	Rufisque	\N	\N	\N	f	\N
1819	Pharmacie Acore	pharmacie-acore	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.665	2026-03-02 23:11:14.665	Vente De Produits Pharmaceutiques	Quartier Diokoul Kher	33 836 22 22	Rufisque	\N	\N	\N	f	\N
1820	Seynabou Gueye	seynabou-gueye-1	Commerce	\N	2	2026-03-02 23:11:14.67	2026-03-02 23:11:14.67	Commerce	Quartier Colobane Ii Sud Rufisque	33 836 06 32	Rufisque	\N	\N	\N	f	\N
1821	Pharmacie Maimouna Samb	pharmacie-maimouna-samb-1	Vente De Produits Pharmaceutiques Bargny Mboth En Face	\N	2	2026-03-02 23:11:14.674	2026-03-02 23:11:14.674	Vente De Produits Pharmaceutiques Bargny Mboth En Face	Route Nationale 1	33 836 29 29	Rufisque	\N	\N	\N	f	\N
1822	Ousmane Fall	ousmane-fall-1	Commerce	\N	2	2026-03-02 23:11:14.678	2026-03-02 23:11:14.678	Commerce	Rue Faidherbe X Adama Lo Rufisque 0 Rufisque Techno Services De Rufisque Fabrication D'Ouvrages Divers En Metaux Colobane 2 Nord Rufisque	33 836 38 70	Rufisque	\N	\N	\N	f	\N
1823	Papa Abdoulaye Ndiaye Prestations De	papa-abdoulaye-ndiaye-prestations-de	Services	\N	3	2026-03-02 23:11:14.681	2026-03-02 23:11:14.681	Services	Bd Maurice Gueye X Rue Kaolack 0 Ville Entreprise Activité Adresse Téléphone Rufisque Ibrahima Dabo Prestation De Services Keury Souf Rufisque 0 Rufisque Sii Sarl (Soluciones Industriales Internacionales Sarl) Commerce Cite Sipress, N°203 -Cap Des Biches 0 Rufisque Gie Lamo Pub Prestations De Services Keur Ndiaye Lo	33 836 44 18	Rufisque	\N	\N	\N	f	\N
1824	Pharmacie Mouhamed	pharmacie-mouhamed-1	Vente De Produits Pharmaceutiques Place Village Gorom 1	\N	2	2026-03-02 23:11:14.685	2026-03-02 23:11:14.685	Vente De Produits Pharmaceutiques Place Village Gorom 1	Quartier Garage Rufisque	77 633 15 09	Rufisque	\N	\N	\N	f	\N
1825	Pharmacie Guelw Ar	pharmacie-guelw-ar-1	Vente De Produits Pharmaceutiques Ndiakhirate	\N	2	2026-03-02 23:11:14.689	2026-03-02 23:11:14.689	Vente De Produits Pharmaceutiques Ndiakhirate	Route De Sangalkam	33 836 03 63	Rufisque	\N	\N	\N	f	\N
1826	Sen Materiaux Keur Khadim (Aliou Faye)	sen-materiaux-keur-khadim-aliou-faye	Commerce Quincaillerie Diamaguene -	\N	2	2026-03-02 23:11:14.691	2026-03-02 23:11:14.691	Commerce Quincaillerie Diamaguene -	Route De Rufisque	77 561 12 28	Rufisque	\N	\N	\N	f	\N
1827	Pharmacie Dior (Dr Aita Ndir)	pharmacie-dior-dr-aita-ndir-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.695	2026-03-02 23:11:14.695	Vente De Produits Pharmaceutiques	Quartier Arafat 2 0 Rufisque Groupe Scolaire Generation 2000 Enseignement Prive Bargny 0 Rufisque Pharmacie Sebi-Ponty Vente De Produits Pharmaceutiques Sebiponty	33 836 45 50	Rufisque	\N	\N	\N	f	\N
1828	Senegalaise Prestation Industrielles (Mamadou Seydou Diallo)	senegalaise-prestation-industrielles-mamadou-seydou-diallo	Commerce	\N	2	2026-03-02 23:11:14.698	2026-03-02 23:11:14.698	Commerce	Quartier Cheikh Niang Diamniadio 0 Rufisque Cabinet Medical Docteur Moustapha Ba Cabinet Medical Rue Pascal-Keury Souf Rufisque 0 Rufisque Clinique Nabou (Aicha Mbodji Ndoye) Activites Pour La Sante Des Hommes (Clinique) Keury Kao, Rue Demoby	33 849 27 77	Rufisque	\N	\N	\N	f	\N
1829	Profebat - Sarl (Porte Fenetre Batiment Plus )	profebat-sarl-porte-fenetre-batiment-plus-1	Commerce General	\N	2	2026-03-02 23:11:14.702	2026-03-02 23:11:14.702	Commerce General	Route De Rufisque	33 836 00 04	Rufisque	\N	\N	\N	f	\N
1830	Omar Diene Prestations De	omar-diene-prestations-de	Services	\N	3	2026-03-02 23:11:14.705	2026-03-02 23:11:14.705	Services	Quartier Sante Yalla Rufisque	77 650 14 07	Rufisque	\N	\N	\N	f	\N
1831	Assane Ndiaye Btp Santa Yalla Rufisque 0 Rufisque Pharmacie Sainte Agnes (Dr Mariane Marguerite	assane-ndiaye-btp-santa-yalla-rufisque-0-rufisque-pharmacie-sainte-agnes-dr-mariane-marguerite	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.707	2026-03-02 23:11:14.707	Vente De Produits Pharmaceutiques	Quartier Arafat Route De Sococim - Rufisque 0 Rufisque Gie El Hadji Abibou Diagne (Ecole Keur Mame Loly) Education Dangou Sud Rufisque	33 836 05 39	Rufisque	\N	\N	\N	f	\N
1832	Cheikh Tidiane Ndoye Prestation De	cheikh-tidiane-ndoye-prestation-de	Services Diokoul Kao Rufisque 0 Rufisque Adam Sarl Location De Biens	\N	3	2026-03-02 23:11:14.709	2026-03-02 23:11:14.709	Services Diokoul Kao Rufisque 0 Rufisque Adam Sarl Location De Biens	Immobiliers Cite Asecna - Hlm Rufisque	77 648 15 70	Rufisque	\N	\N	\N	f	\N
1833	Genedis (Babacar Mbengue) Prestations De	genedis-babacar-mbengue-prestations-de	Services	\N	3	2026-03-02 23:11:14.712	2026-03-02 23:11:14.712	Services	Quartier Diokoul Ndiourene 0 Rufisque Eti (Entreprise De Travaux Industriels ) Travaux Industriels Quartier Ndiandia Bargny	33 836 78 62	Rufisque	\N	\N	\N	f	\N
1834	Senegalaise D'Entreprises (Aminata Sakho)	senegalaise-d-entreprises-aminata-sakho-1	Commerce	\N	2	2026-03-02 23:11:14.715	2026-03-02 23:11:14.715	Commerce	Rue Ousmane Soce Diop Keury Souf	77 553 08 95	Rufisque	\N	\N	\N	f	\N
1835	Ecole Privee Safietou Thiala (Diale Sambou) Education Arafat 4 - Rufisque 0 Rufisque Ladkani Zahra	ecole-privee-safietou-thiala-diale-sambou-education-arafat-4-rufisque-0-rufisque-ladkani-zahra	Commerce Materiaux De Construction	\N	2	2026-03-02 23:11:14.717	2026-03-02 23:11:14.717	Commerce Materiaux De Construction	Avenue Ousmane Soce Diop Quartier Keury Souf	33 836 71 36	Rufisque	\N	\N	\N	f	\N
1836	Sen Setal Sarl	sen-setal-sarl	Commerce Villa N°11 Cite Millionnaire Rufisque 0 Rufisque Dame Gningue Commerce General Qrt Nguessou Rufisque 0 Rufisque Lebougui Voyages Tours Servces Annexes Et Auxilliaires De Tranport	\N	2	2026-03-02 23:11:14.719	2026-03-02 23:11:14.719	Commerce Villa N°11 Cite Millionnaire Rufisque 0 Rufisque Dame Gningue Commerce General Qrt Nguessou Rufisque 0 Rufisque Lebougui Voyages Tours Servces Annexes Et Auxilliaires De Tranport	Route Des Hlm Face Gare Routiere	33 836 22 76	Rufisque	\N	\N	\N	f	\N
1837	Gie Sene Techno Realisation Industrielle Diokoul Cite Gabon Rufisque 0 Rufisque Srfi	gie-sene-techno-realisation-industrielle-diokoul-cite-gabon-rufisque-0-rufisque-srfi	(Service Rebobinage Froid Et Industriel) Autres Service De Reparations	\N	8	2026-03-02 23:11:14.721	2026-03-02 23:11:14.721	(Service Rebobinage Froid Et Industriel) Autres Service De Reparations	Route De Rufisque	33 839 20 66	Rufisque	\N	\N	\N	f	\N
1838	Le Chamama (Robert Chanu) Campement Niague Peul Lac Rose 0 Rufisque Moussa Faye	le-chamama-robert-chanu-campement-niague-peul-lac-rose-0-rufisque-moussa-faye	Commerce General Sebikotane Tonghor Rufisque 0 Rufisque Ets Ndiourenne (El Hadji Malick Lo Ndiour) Prestations De Services	\N	2	2026-03-02 23:11:14.723	2026-03-02 23:11:14.723	Commerce General Sebikotane Tonghor Rufisque 0 Rufisque Ets Ndiourenne (El Hadji Malick Lo Ndiour) Prestations De Services	Quartier Keury Souf - Rufisque	77 926 58 58	Rufisque	\N	\N	\N	f	\N
1839	Papa Code Ndoye	papa-code-ndoye	Commerce Hlm Rufisque Villa N°132 0 Rufisque Fume Bou Senegal Vente De Produits Pesticides	\N	2	2026-03-02 23:11:14.726	2026-03-02 23:11:14.726	Commerce Hlm Rufisque Villa N°132 0 Rufisque Fume Bou Senegal Vente De Produits Pesticides	Route La Yousse Rufisque 0 Rufisque Bouks Baticom Btp Quartier Dangou Nord- Rufisque	77 623 41 70	Rufisque	\N	\N	\N	f	\N
1840	Pharmacie Adji Gnagna Diagne	pharmacie-adji-gnagna-diagne-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.73	2026-03-02 23:11:14.73	Vente De Produits Pharmaceutiques	Quartier Colobane Nord Rufisque	77 503 83 47	Rufisque	\N	\N	\N	f	\N
1841	Pharmacie Stade Suarl	pharmacie-stade-suarl-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.733	2026-03-02 23:11:14.733	Vente De Produits Pharmaceutiques	Route Des Hlm, Face Stade Municipal Rufisque	33 871 60 60	Rufisque	\N	\N	\N	f	\N
1842	Global Import Export Sarl	global-import-export-sarl	Commerce General	\N	2	2026-03-02 23:11:14.736	2026-03-02 23:11:14.736	Commerce General	Route De Mbour Diamniadio	33 866 78 65	Rufisque	\N	\N	\N	f	\N
1843	Boulangerie Sow Puigvert Sarl Boulangerie Quartier 909 Rue Denommee Zone B Rufisque 0 Saint Louis	boulangerie-sow-puigvert-sarl-boulangerie-quartier-909-rue-denommee-zone-b-rufisque-0-saint-louis	Vente De Produits Petroliers Ndioum 0 Saint Louis Boulangerie Mouhamadou Rassoulilah Boulangerie Pikine Sor 0 Saint Louis Boulangerie Modou Diop Boulangerie Tassinere Gandiole 0 Saint Louis Boulangerie El Hadji Malick Sy (Masseck Seck) Boulangerie	\N	1	2026-03-02 23:11:14.738	2026-03-02 23:11:14.738	Vente De Produits Petroliers Ndioum 0 Saint Louis Boulangerie Mouhamadou Rassoulilah Boulangerie Pikine Sor 0 Saint Louis Boulangerie Modou Diop Boulangerie Tassinere Gandiole 0 Saint Louis Boulangerie El Hadji Malick Sy (Masseck Seck) Boulangerie	Route De Dakar, Sor Daga	33 872 07 89	Rusfisque	\N	\N	\N	f	\N
1844	Louis Gie Maratai Prestation De	louis-gie-maratai-prestation-de	Services	\N	3	2026-03-02 23:11:14.74	2026-03-02 23:11:14.74	Services	Rue Leybar Ndiolofene Sor	77 443 47 65	Saint	\N	\N	\N	f	\N
1845	Scl (Societe De Cultures Legumieres) Culture De Mais Doux Residence Elisa - Sor - Saint-Louis 33	scl-societe-de-cultures-legumieres-culture-de-mais-doux-residence-elisa-sor-saint-louis-33	Fabrication De Corps Gras	\N	4	2026-03-02 23:11:14.743	2026-03-02 23:11:14.743	Fabrication De Corps Gras	Rue Abdoulaye Marie Parsine Nord Saint-Louis 0 Saint-Louis Rodrigues & Camacho Construccoes Senegal Batiment Et Travaux Publics Route De Khor	33 961 00 53	Saint-Louis	\N	\N	\N	f	\N
1846	Station Oilibya (Babacar Dieye)	station-oilibya-babacar-dieye	Commerce De Produits Petroliers En Face Dispensaire	\N	1	2026-03-02 23:11:14.745	2026-03-02 23:11:14.745	Commerce De Produits Petroliers En Face Dispensaire	Route De Khor - Sor	33 961 29 91	Saint-Louis	\N	\N	\N	f	\N
1847	Pikine Materiaux Suarl	pikine-materiaux-suarl-1	Commerce Quincaillerie Pikine	\N	2	2026-03-02 23:11:14.749	2026-03-02 23:11:14.749	Commerce Quincaillerie Pikine	Route De Dakar Sor	33 961 00 89	Saint-Louis	\N	\N	\N	f	\N
1848	Station	station-7	Service Total (Pierre Poggio) Commerce De Produits Petroliers Total Charles De Gaulle 0 Saint-Louis Gie Saint-Louissienne De La Restauration Restauration Saint Louis 0 Saint-Louis Hometech Sa (Home Technologie Sa) Commerce General	\N	1	2026-03-02 23:11:14.76	2026-03-02 23:11:14.76	Service Total (Pierre Poggio) Commerce De Produits Petroliers Total Charles De Gaulle 0 Saint-Louis Gie Saint-Louissienne De La Restauration Restauration Saint Louis 0 Saint-Louis Hometech Sa (Home Technologie Sa) Commerce General	Bccd Rue N° 2	33 961 25 26	Saint-Louis	\N	\N	\N	f	\N
1849	Alimentation Khalifa Ababacar Sy (Oumar Diop)	alimentation-khalifa-ababacar-sy-oumar-diop-1	Commerce-Alimentation Marche Sor 0 Saint-Louis Ka & Freres - Sarl Commerce General	\N	2	2026-03-02 23:11:14.765	2026-03-02 23:11:14.765	Commerce-Alimentation Marche Sor 0 Saint-Louis Ka & Freres - Sarl Commerce General	Rue Poudriere Face Place De L4Ibdependance Sor	33 832 10 90	Saint-Louis	\N	\N	\N	f	\N
1850	Ndogal (Makhtar Fall)	ndogal-makhtar-fall-1	Commerce General Marche De Mpal 0 Saint-Louis Socosti Sarl (Societe Commerciale Souleymane Tirera -Sarl) Commerce General	\N	2	2026-03-02 23:11:14.769	2026-03-02 23:11:14.769	Commerce General Marche De Mpal 0 Saint-Louis Socosti Sarl (Societe Commerciale Souleymane Tirera -Sarl) Commerce General	Route Nationale N°1 Richard Toll	33 961 28 37	Saint-Louis	\N	\N	\N	f	\N
1851	Aeneas International Securite - Sarl	aeneas-international-securite-sarl	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:14.771	2026-03-02 23:11:14.771	Services Fournis Aux Entreprises	Quartier Nord Richard Toll 0 Saint-Louis Gie Taif De Ross Bethio Agriculture, Horticulture, Maraichage Ross Bethio	33 961 22 73	Saint-Louis	\N	\N	\N	f	\N
1852	Station Total Charles Degaulle (Sidy Moctar Dieng)	station-total-charles-degaulle-sidy-moctar-dieng-1	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:14.775	2026-03-02 23:11:14.775	Vente De Produits Petroliers (Station D'Essence)	Avenue Charles Degaulle	77 540 19 24	Saint-Louis	\N	\N	\N	f	\N
1853	Ets Yelitaare Sarl (Amadou Sow )	ets-yelitaare-sarl-amadou-sow-1	Vente En Gros De Marchandises Marche Sor,	\N	2	2026-03-02 23:11:14.778	2026-03-02 23:11:14.778	Vente En Gros De Marchandises Marche Sor,	Rue Ex Sonadis	33 961 41 05	Saint-Louis	\N	\N	\N	f	\N
1854	Sarl Ndiaye & Freres Autres	sarl-ndiaye-freres-autres-1	Commerce	\N	2	2026-03-02 23:11:14.782	2026-03-02 23:11:14.782	Commerce	Avenue Du General Degaulle 33964 12 49 Saint-Louis Semis - Sarl (Service De L'Energie En Milieu Sahelien - Sarl) Bereau D'Etudes Pete Dept. Podor	33 961 12 60	Saint-Louis	\N	\N	\N	f	\N
1855	Station Total Renovation (Abdoulaye Ndiaye)	station-total-renovation-abdoulaye-ndiaye-1	Commerce De Produits Petroliers	\N	1	2026-03-02 23:11:14.786	2026-03-02 23:11:14.786	Commerce De Produits Petroliers	Route De Dakar En Face Lycee Charles Degaulle 775763148 Saint-Louis Sahel Decouverte - Sa Agence De Voyage / Tourisme Rue Blaise Diagne Nord - St-Louis	33 832 73 97	Saint-Louis	\N	\N	\N	f	\N
1856	Station Total Sor (Daour Dieye)	station-total-sor-daour-dieye-1	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:14.79	2026-03-02 23:11:14.79	Vente De Produits Petroliers (Station D'Essence)	Avenue Gerneral Degaulle	33 961 52 58	Saint-Louis	\N	\N	\N	f	\N
1857	Tas Sarl (Travaux Agricoles Du Fleuve (Ex Tp Besson Senegal Sarl) Travaux D'Amenagement &	tas-sarl-travaux-agricoles-du-fleuve-ex-tp-besson-senegal-sarl-travaux-d-amenagement-1	Services (73%) , Vente De Riz Paddy (7%)	\N	2	2026-03-02 23:11:14.794	2026-03-02 23:11:14.794	Services (73%) , Vente De Riz Paddy (7%)	Route Nationale 2, Saed, Ross Bethio	33 961 19 96	Saint-Louis	\N	\N	\N	f	\N
1858	Ndar Ice	ndar-ice	Production De Glace Support Energetique Hydrobase 0 Saint-Louis Pharmacie Mame Madia Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.797	2026-03-02 23:11:14.797	Production De Glace Support Energetique Hydrobase 0 Saint-Louis Pharmacie Mame Madia Vente De Produits Pharmaceutiques	Avenue General Degaulle	33 961 27 71	Saint-Louis	\N	\N	\N	f	\N
1859	Etablissement Niang Et Fils	etablissement-niang-et-fils	Commerce General	\N	2	2026-03-02 23:11:14.8	2026-03-02 23:11:14.8	Commerce General	Rue Ex Sonadis Marche Sor	77 540 19 24	Saint-Louis	\N	\N	\N	f	\N
1860	Pharmacie Du Boulevard Du Sud (Amadou Mamadou Alpha Dia)	pharmacie-du-boulevard-du-sud-amadou-mamadou-alpha-dia-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.804	2026-03-02 23:11:14.804	Vente De Produits Pharmaceutiques	Boulevard Abdoulaye Mar Diop	33 961 41 57	Saint-Louis	\N	\N	\N	f	\N
1861	Pharmacie Centrale (Ousmane Bao)	pharmacie-centrale-ousmane-bao-1	Vente De Produits Pharmaceutiques Nord	\N	2	2026-03-02 23:11:14.808	2026-03-02 23:11:14.808	Vente De Produits Pharmaceutiques Nord	Rue Khalifa Ababacar Sy	33 961 52 37	Saint-Louis	\N	\N	\N	f	\N
1862	Boulangerie Adja Magatte Diagne Boulangerie Guet Ndar Saint-Louis 0 Saint-Louis Mfk Glace (Kayere	boulangerie-adja-magatte-diagne-boulangerie-guet-ndar-saint-louis-0-saint-louis-mfk-glace-kayere	Commerce De Glace	\N	2	2026-03-02 23:11:14.811	2026-03-02 23:11:14.811	Commerce De Glace	Avenue Dodds Bar Ndar Toute	33 961 99 98	Saint-Louis	\N	\N	\N	f	\N
1863	Ahmadou Ka	ahmadou-ka-1	Vente De Marchandises	\N	2	2026-03-02 23:11:14.814	2026-03-02 23:11:14.814	Vente De Marchandises	Rue Poudriere Sor Saint Louis 0 Saint-Louis Pharmacie Du Fleuve - Odile W Ehbe Vente De Produits Pharmaceutiques Avenue Moustapha Malick Gaye (Ex Route De Leybar) - Quartier Sor	33 961 81 69	Saint-Louis	\N	\N	\N	f	\N
1864	Ets Narimane Hachem	ets-narimane-hachem-1	Commerce	\N	2	2026-03-02 23:11:14.817	2026-03-02 23:11:14.817	Commerce	Rue Quai Henry Jay Sud Saintt Louis 0 Saint-Louis Pharmacie Yaye Diabou Vente De Produits Pharmaceutiques Sor Isra Avenue Macodou Ndiaye	33 961 23 32	Saint-Louis	\N	\N	\N	f	\N
1865	Etablissements Dioko	etablissements-dioko-1	Commerce	\N	2	2026-03-02 23:11:14.819	2026-03-02 23:11:14.819	Commerce	Avenue General Degaulle Sor	33 961 36 69	Saint-Louis	\N	\N	\N	f	\N
1866	Quincallerie Touba Ndienne-Keur Songoma Tall	quincallerie-touba-ndienne-keur-songoma-tall-1	Commerce General	\N	2	2026-03-02 23:11:14.822	2026-03-02 23:11:14.822	Commerce General	Rue De Paris X Ave General Degaulle Sor Saint Louis	33 961 11 48	Saint-Louis	\N	\N	\N	f	\N
1867	Pharmacie Château D'Eau	pharmacie-chateau-d-eau-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.825	2026-03-02 23:11:14.825	Vente De Produits Pharmaceutiques	Rue Macodou Ndiaye Leona Sor	33 961 00 10	Saint-Louis	\N	\N	\N	f	\N
1868	Saed (Societe D'Amenagement Et D'Exploitation Du Delta)	saed-societe-d-amenagement-et-d-exploitation-du-delta	Services Annexes A L'Agriculture Et A L'Elev	\N	4	2026-03-02 23:11:14.827	2026-03-02 23:11:14.827	Services Annexes A L'Agriculture Et A L'Elev	Avenue Insa Coulibaly - Saint Louis	33 961 11 09	Saint-Louis	\N	\N	\N	f	\N
1869	Pharmacie Khadimou Rassoul (Ousseynou Seck)	pharmacie-khadimou-rassoul-ousseynou-seck-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.83	2026-03-02 23:11:14.83	Vente De Produits Pharmaceutiques	Avenue Du General De Gaulle - Saint-Louis	33 961 14 61	Saint-Louis	\N	\N	\N	f	\N
1870	Ste Boye Et Fils Sarl	ste-boye-et-fils-sarl-1	Commerce Quaincaillerie	\N	2	2026-03-02 23:11:14.833	2026-03-02 23:11:14.833	Commerce Quaincaillerie	Avenue De Gaule Saint Louis	77 645 47 55	Saint-Louis	\N	\N	\N	f	\N
1871	Pharmacie Almamy (Alassane Ndiaye)	pharmacie-almamy-alassane-ndiaye-1	Vente De Produits Pharmaceutiques Marche Ndioum 0 Saint-Louis La Maison Rose Hotel (Maison D'Hotel)	\N	2	2026-03-02 23:11:14.836	2026-03-02 23:11:14.836	Vente De Produits Pharmaceutiques Marche Ndioum 0 Saint-Louis La Maison Rose Hotel (Maison D'Hotel)	Rue Potin X Blaise	33 961 57 00	Saint-Louis	\N	\N	\N	f	\N
1872	Supermache U (Thiery Martinet)	supermache-u-thiery-martinet-1	Commerce Alimentaires Diverses	\N	2	2026-03-02 23:11:14.838	2026-03-02 23:11:14.838	Commerce Alimentaires Diverses	Rue A. Seck Marie Parsine	33 938 22 22	Saint-Louis	\N	\N	\N	f	\N
1873	Pharmacie Escale	pharmacie-escale-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.841	2026-03-02 23:11:14.841	Vente De Produits Pharmaceutiques	Route De Matam En Face De La Gendarme Richard Toll	33 961 12 63	Saint-Louis	\N	\N	\N	f	\N
1874	Pharmacie Alhamdoulilah (Khoudia Tabane)	pharmacie-alhamdoulilah-khoudia-tabane-1	Vente De Produits Pharmaceutiques Pikine	\N	2	2026-03-02 23:11:14.845	2026-03-02 23:11:14.845	Vente De Produits Pharmaceutiques Pikine	Route Nationale	33 961 23 90	Saint-Louis	\N	\N	\N	f	\N
1875	Pharmacie Abdoul Aziz Sy (Paas ) - Dr Tabara Kane	pharmacie-abdoul-aziz-sy-paas-dr-tabara-kane-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.847	2026-03-02 23:11:14.847	Vente De Produits Pharmaceutiques	Rue Bourmeister, Quartier Sud - Saint Louis	33 961 51 89	Saint-Louis	\N	\N	\N	f	\N
1876	La Superette Exotica Market	la-superette-exotica-market-1	Commerce Genera- Fournitures Diverses	\N	2	2026-03-02 23:11:14.85	2026-03-02 23:11:14.85	Commerce Genera- Fournitures Diverses	Route De Khor Sor Saint Louis	33 961 51 52	Saint-Louis	\N	\N	\N	f	\N
1877	Station Total Fleuve (Becaye Guindo)	station-total-fleuve-becaye-guindo-1	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:14.853	2026-03-02 23:11:14.853	Vente De Produits Petroliers (Station D'Essence)	Route De Dakar - St-Louis	33 961 01 10	Saint-Louis	\N	\N	\N	f	\N
1878	Pharmacie Guy Seddele	pharmacie-guy-seddele-1	Vente De Produits Pharmaceutiques Pikine	\N	2	2026-03-02 23:11:14.856	2026-03-02 23:11:14.856	Vente De Produits Pharmaceutiques Pikine	Route Nationale	33 961 54 64	Saint-Louis	\N	\N	\N	f	\N
1879	Pharmacie Bineta Diagne (Ndeye Aw A Diagne )	pharmacie-bineta-diagne-ndeye-aw-a-diagne-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.858	2026-03-02 23:11:14.858	Vente De Produits Pharmaceutiques	Avenue Dodds - Ndar Toute	33 961 12 60	Saint-Louis	\N	\N	\N	f	\N
1880	Tp Bat Solutions - Sarl Btp (Ex	tp-bat-solutions-sarl-btp-ex-1	Commerce)	\N	2	2026-03-02 23:11:14.861	2026-03-02 23:11:14.861	Commerce)	Avenue De Gaulle - Saint- Louis	33 961 55 04	Saint-Louis	\N	\N	\N	f	\N
1881	Pharmacie Amadou	pharmacie-amadou-1	Vente De Produits Pharmaceutiques Ngallele Sor	\N	2	2026-03-02 23:11:14.866	2026-03-02 23:11:14.866	Vente De Produits Pharmaceutiques Ngallele Sor	Route De L'Ugb	77 634 38 48	Saint-Louis	\N	\N	\N	f	\N
1882	Pharmacie La Pikinoise(Ibrahima Thiam)	pharmacie-la-pikinoise-ibrahima-thiam-1	Vente De Produits Pharmaceutiques Pikine St Louis	\N	2	2026-03-02 23:11:14.869	2026-03-02 23:11:14.869	Vente De Produits Pharmaceutiques Pikine St Louis	Route De Dakar 0 Saint-Louis Ism Saint Louis (Instut Superieur De Management De Saint Louis) Education Quai Giraud X Galandou Diouf Nord Saint- Louis	33 961 54 64	Saint-Louis	\N	\N	\N	f	\N
1883	Comasel Sa (Compagnie Marocco Senegalaise D'Electricite)	comasel-sa-compagnie-marocco-senegalaise-d-electricite	Production, Transport Et Dietribution D'Electricite Ngallele	\N	1	2026-03-02 23:11:14.871	2026-03-02 23:11:14.871	Production, Transport Et Dietribution D'Electricite Ngallele	Route De L'Ugb	33 961 61 51	Saint-Louis	\N	\N	\N	f	\N
1884	Pharmacie Veterinaire Delta Agroveto	pharmacie-veterinaire-delta-agroveto-1	Services (Papa Ndene Diouf) Vente De Produits De Betails	\N	2	2026-03-02 23:11:14.874	2026-03-02 23:11:14.874	Services (Papa Ndene Diouf) Vente De Produits De Betails	Quartier Service Elevage Sor 0 Saint-Louis Boulangerie Alpha Amadou Tapsir Sy Boulangerie Sinthane Bango, Saint- Louis	33 961 57 57	Saint-Louis	\N	\N	\N	f	\N
1885	Sen Toll - Sarl	sen-toll-sarl-1	Commerce Materiels Agricole	\N	2	2026-03-02 23:11:14.876	2026-03-02 23:11:14.876	Commerce Materiels Agricole	Avenue Des Grds Hommes Sor Ndioloffene	33 961 53 98	Saint-Louis	\N	\N	\N	f	\N
1886	Etablissements Mor Loucoubar	etablissements-mor-loucoubar	Commerce General	\N	2	2026-03-02 23:11:14.878	2026-03-02 23:11:14.878	Commerce General	Avenue General Degaulle Sor	77 515 25 41	Saint-Louis	\N	\N	\N	f	\N
1887	2 Stp - Sarl (Societe De	2-stp-sarl-societe-de	Service Et De Travaux Publics - Sarl) Nettoyage De Batiment	\N	6	2026-03-02 23:11:14.88	2026-03-02 23:11:14.88	Service Et De Travaux Publics - Sarl) Nettoyage De Batiment	Rue Dure (Sud Pres Tresor)	33 961 49 49	Saint-Louis	\N	\N	\N	f	\N
1888	Gie Sant Yalla Macha Allah Fournitures Et Prestations De	gie-sant-yalla-macha-allah-fournitures-et-prestations-de	Services Diverses	\N	3	2026-03-02 23:11:14.882	2026-03-02 23:11:14.882	Services Diverses	Rue P. Chimere - Ndar Toute	33 961 31 18	Saint-Louis	\N	\N	\N	f	\N
1889	Compagnie Agricole De Saint-Louis	compagnie-agricole-de-saint-louis	Productions Agricoles Pointe Nord De L'Île Saint Louis 0 Saint-Louis W Ade Fara (Cabinet Medinet Medical Dr W Ade) Activites Pour La Sante Des Hommes (Cabinet Medical) Ave General Degaulle X	\N	5	2026-03-02 23:11:14.884	2026-03-02 23:11:14.884	Productions Agricoles Pointe Nord De L'Île Saint Louis 0 Saint-Louis W Ade Fara (Cabinet Medinet Medical Dr W Ade) Activites Pour La Sante Des Hommes (Cabinet Medical) Ave General Degaulle X	Rue Khalifa Ababacar Sy	33 961 17 72	Saint-Louis	\N	\N	\N	f	\N
1890	L.P.L - Sarl (Librairie Papeterie Le Leybar - Sarl)	l-p-l-sarl-librairie-papeterie-le-leybar-sarl-1	Vente De Materiels Scolaires Et Bureau	\N	2	2026-03-02 23:11:14.887	2026-03-02 23:11:14.887	Vente De Materiels Scolaires Et Bureau	Rue Abdoulaye Seck M.P. X Blanchot	33 961 88 66	Saint-Louis	\N	\N	\N	f	\N
1891	Pharmacie Mame Yacine Bop (Khadissatou Diop)	pharmacie-mame-yacine-bop-khadissatou-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.889	2026-03-02 23:11:14.889	Vente De Produits Pharmaceutiques	Avenue Mame Raw Ane Ngom	33 961 67 67	Saint-Louis	\N	\N	\N	f	\N
1892	Pharmacie Mame Fatou Ba	pharmacie-mame-fatou-ba-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.892	2026-03-02 23:11:14.892	Vente De Produits Pharmaceutiques	Route Isra Medina Course 0 Saint-Louis Pharmacie Baro (Mamadou Mamoudou Baro) Vente De Produits Pharmaceutiques Guede Chantier 0 Saint-Louis Cabinet Mohamadou Makhtar Diop Avocat A La Cour Rue Andre Guillabert, Saint-Louis	33 961 41 89	Saint-Louis	\N	\N	\N	f	\N
1893	Cabinet Imhotep Naby Prestation De	cabinet-imhotep-naby-prestation-de	Services Saint Louis 0 Saint-Louis Gie Agritech Constructions Metalliques	\N	6	2026-03-02 23:11:14.894	2026-03-02 23:11:14.894	Services Saint Louis 0 Saint-Louis Gie Agritech Constructions Metalliques	Route De Khor Sor	77 550 63 18	Saint-Louis	\N	\N	\N	f	\N
1894	Gie "Ndoka Multi	gie-ndoka-multi	Services" Commerce General- Bureautique-Papeterie Place	\N	2	2026-03-02 23:11:14.896	2026-03-02 23:11:14.896	Services" Commerce General- Bureautique-Papeterie Place	Abdoulaye W Ade Sor Saint-Louis	33 941 21 60	Saint-Louis	\N	\N	\N	f	\N
1895	Gie Mondial Stocks	gie-mondial-stocks	Services Commerce	\N	2	2026-03-02 23:11:14.897	2026-03-02 23:11:14.897	Services Commerce	Avenue Macodou Ndiaye 0 Saint-Louis Cabinet Dentaire Horizon 2050 Activites Pour La Sante Des Hommes (Cabinet Dentaire) Rue De France Nord Saint Louis	33 961 82 53	Saint-Louis	\N	\N	\N	f	\N
1896	Sunukeur Hotel Hotel Saint-Louis 0 Saint-Louis Ecopres (Maimouna Fall)	sunukeur-hotel-hotel-saint-louis-0-saint-louis-ecopres-maimouna-fall	Distribution De Carburant Pointe Nord 0 Saint-Louis Cabinet Medical Docteur Charles E. Joseph Venn Activites Pour La Sante Des Hommes	\N	2	2026-03-02 23:11:14.899	2026-03-02 23:11:14.899	Distribution De Carburant Pointe Nord 0 Saint-Louis Cabinet Medical Docteur Charles E. Joseph Venn Activites Pour La Sante Des Hommes	Rue Paul Holle X Blaise Diagne - Nord	33 961 31 34	Saint-Louis	\N	\N	\N	f	\N
1897	Gie Infelec (Gie Informatique Electronique)	gie-infelec-gie-informatique-electronique	Services Informatiques Km 3	\N	3	2026-03-02 23:11:14.901	2026-03-02 23:11:14.901	Services Informatiques Km 3	Route De Dakar Pikine Sor	77 567 86 59	Saint-Louis	\N	\N	\N	f	\N
1898	Gie Njaw Ar S.W	gie-njaw-ar-s-w-1	Commerce	\N	2	2026-03-02 23:11:14.904	2026-03-02 23:11:14.904	Commerce	Route De L'Hydrobase 0 Saint-Louis Auberge Du Pelican (Mame Adama Diakhate) Hebergement Hydrobase Saint-Louis 0 Saint-Louis Residence La Solidarite (Temgbait Chimoun Francois) Auberge Cite Vauvert Route De Khor	77 181 88 35	Saint-Louis	\N	\N	\N	f	\N
1899	Soleil Vert Sarl	soleil-vert-sarl-1	Commerce De Fruits Et Legumes Reconditionnes	\N	2	2026-03-02 23:11:14.907	2026-03-02 23:11:14.907	Commerce De Fruits Et Legumes Reconditionnes	Route De Sangalkam - Gorom I	77 552 98 68	Sangalkam	\N	\N	\N	f	\N
1900	Pharmacie Saraya (Abdoul Adjidiou Barry)	pharmacie-saraya-abdoul-adjidiou-barry	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.909	2026-03-02 23:11:14.909	Vente De Produits Pharmaceutiques	Quartier Mosquee, Saraya 0 Saraya Abdoulaye Dione Diop Service Medical K/62 Hamo 3 0 Sebikotane Safina - Sa (Ex - Safina Agrocap) Agriculture - Papaye - Mangue - Tomate - Haricot - Avocat Perimetre Baobab - Sebikotane - Ranch Filfili	33 820 38 31	Saraya	\N	\N	\N	f	\N
1901	Boulangerie La Case Sokone Boulangerie Quartier Leona Face Dpv Sokone 0 Sokone Sopreef	boulangerie-la-case-sokone-boulangerie-quartier-leona-face-dpv-sokone-0-sokone-sopreef	Services Rendus Aux Entreprises Felane - Cr De Djilor 0 Sokone Hotel Les Barracudas - Sarl Hotellerie	\N	4	2026-03-02 23:11:14.911	2026-03-02 23:11:14.911	Services Rendus Aux Entreprises Felane - Cr De Djilor 0 Sokone Hotel Les Barracudas - Sarl Hotellerie	Quartier Bambougar El Hadji - Sokone	33 836 00 52	Sokone	\N	\N	\N	f	\N
1902	Claude Sambou Restauration Sokone 0 Tamba Pharmacie Thiaala (Dr Salif Samba Diallo)	claude-sambou-restauration-sokone-0-tamba-pharmacie-thiaala-dr-salif-samba-diallo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.913	2026-03-02 23:11:14.913	Vente De Produits Pharmaceutiques	Avenue Leopold S. Senghor - Tambacounda	33 948 31 29	Sokone	\N	\N	\N	f	\N
1903	Pharmacie Du Marche - Mamadou W Aly Zoumarou	pharmacie-du-marche-mamadou-w-aly-zoumarou-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.916	2026-03-02 23:11:14.916	Vente De Produits Pharmaceutiques	Quartier Nord - Tambacounda 0 Tamba Boubacar Sidy Diallo Commerce En Face Cbao Tambacounda 0 Ville Entreprise Activité Adresse Téléphone Tamba Ste Exploition Cynegetique De Mayel Dibi - Sarl Chasse - Activites Recreatives Mayel Dibi - Tambacounda	33 981 13 23	Tamba	\N	\N	\N	f	\N
1904	Pharmacie Serigne Moustapha Bassirou Mbacke(Ndongo Diop)	pharmacie-serigne-moustapha-bassirou-mbacke-ndongo-diop	Vente De Produits Pharmaceutiques Medinatoul Diourbel 0 Tambacouna da Boulangerie Patisserie	\N	2	2026-03-02 23:11:14.918	2026-03-02 23:11:14.918	Vente De Produits Pharmaceutiques Medinatoul Diourbel 0 Tambacouna da Boulangerie Patisserie	Abdou Aziz Fall Boulangerie Patisserie Quartier Salekenie Tambacouda	33 981 12 18	Tambacounada	\N	\N	\N	f	\N
1905	a Lamarana Diallo	a-lamarana-diallo-1	Commerce Tamba 339812797 Tambacounda Cosetap Suarl Btp	\N	2	2026-03-02 23:11:14.92	2026-03-02 23:11:14.92	Commerce Tamba 339812797 Tambacounda Cosetap Suarl Btp	Rue Ainina Fall Tambacounda 0 Tambacounda Gie Al Gassimou Et Fils Commerce Rue Anina Fall Tamba 0 Tambacound a Pharmacie Providence(Anne Marie Diouf) Vente De Produits Pharmaceutiques Tamba	33 981 03 57	Tambacound	\N	\N	\N	f	\N
1906	Demba Mbow	demba-mbow	Commerce	\N	2	2026-03-02 23:11:14.922	2026-03-02 23:11:14.922	Commerce	Rue Ainina Fall Tambacounda 0 Tambacound a Pharmacie Al Hamdoulilah( El Hadji Sarr) Vente De Produits Pharmaceutiques Qrt Camp Navetane 766930404 Tambacound a Pharmacie Moumassa (Kassoumou Sidibe) Vente De Produits Pharmaceutiques Tamba	33 981 32 20	Tambacounda	\N	\N	\N	f	\N
1907	a Pharmacie Kothiary(Coumakh Faye)	a-pharmacie-kothiary-coumakh-faye	Vente De Produits Pharmaceutiques Qrt Guinaw Rails Kothiary 775212594 Tambacound a Senagro Jullam Afia Transformation Laitiere Et Distribution De Produits Alimentaires Lot 247	\N	2	2026-03-02 23:11:14.924	2026-03-02 23:11:14.924	Vente De Produits Pharmaceutiques Qrt Guinaw Rails Kothiary 775212594 Tambacound a Senagro Jullam Afia Transformation Laitiere Et Distribution De Produits Alimentaires Lot 247	Quartier Salikenie Tambacounda	77 512 72 88	Tambacound	\N	\N	\N	f	\N
1908	a Bassirou Dieng	a-bassirou-dieng-1	Commerce Kedegou	\N	2	2026-03-02 23:11:14.927	2026-03-02 23:11:14.927	Commerce Kedegou	Quartier Dinguess 775313110 Tambacound a Esentp(Mamadou Ly) Btp Quartier Liberte Tambacounda 77 6846128 Tambacound a Bah Dieng Commerce Bakel	33 981 50 50	Tambacound	\N	\N	\N	f	\N
1909	a Khainou Sy(Ou Kainou)	a-khainou-sy-ou-kainou	Commerce	\N	2	2026-03-02 23:11:14.929	2026-03-02 23:11:14.929	Commerce	Quartier Alpha Tambacounda	33 937 90 46	Tambacound	\N	\N	\N	f	\N
1910	a Maxi Propre	a-maxi-propre	Services(Cherif M. Mouctar Ndiaye) Service Fournis Aux Entreprises Tambacounda 776511581 Tambacound a Diakhaby Taye Medecine Veterinaire	\N	3	2026-03-02 23:11:14.931	2026-03-02 23:11:14.931	Services(Cherif M. Mouctar Ndiaye) Service Fournis Aux Entreprises Tambacounda 776511581 Tambacound a Diakhaby Taye Medecine Veterinaire	Quartier Liberte Tambacounda	33 981 10 10	Tambacound	\N	\N	\N	f	\N
1911	Diagonal-Sa	diagonal-sa-1	Distribution	\N	2	2026-03-02 23:11:14.934	2026-03-02 23:11:14.934	Distribution	Route De Rufisque	77 842 06 23	Thiaroye	\N	\N	\N	f	\N
1912	Sylla Logistique Et	sylla-logistique-et-1	Commerce Sarl Commerce Hydro Carbures	\N	2	2026-03-02 23:11:14.937	2026-03-02 23:11:14.937	Commerce Sarl Commerce Hydro Carbures	Route De Rufisque 0 Thiaroye C.Cmb (Compagnie Commerciale Mbaakhene Sarl) Commerce Marche Thiaroye Cantine A-57	33 834 11 63	Thiaroye	\N	\N	\N	f	\N
1913	Oxy Sen Sarl (L'Oxygene Du Senegal - Sarl)	oxy-sen-sarl-l-oxygene-du-senegal-sarl-1	Production Et Distribution De Gaz	\N	1	2026-03-02 23:11:14.94	2026-03-02 23:11:14.94	Production Et Distribution De Gaz	Route Oceanographique Quai De Peche Thiaroye 33823 48 69 Thiaroye W Akeur Borom Darou - Suarl Commerce Thiaroye Hamdallah 1	33 834 09 28	Thiaroye	\N	\N	\N	f	\N
1914	Baleine Export Sarl Traitement Et Exportation De Produits De Mer -	baleine-export-sarl-traitement-et-exportation-de-produits-de-mer-1	Vente De Produits Alimentaires	\N	2	2026-03-02 23:11:14.943	2026-03-02 23:11:14.943	Vente De Produits Alimentaires	Route De Rufisque - Zone Industrielle Sonepi	33 834 14 73	Thiaroye	\N	\N	\N	f	\N
1915	Pharmacie Taw Feex (Dr Serigne Samb)	pharmacie-taw-feex-dr-serigne-samb-1	Vente De Produits Pharmaceutiques Thiaroye Tally Diallo Pinthie 0 Thiaroye Boulangerie Serigne Cheikh Gueye (Samba Gueye) Boulangerie	\N	2	2026-03-02 23:11:14.946	2026-03-02 23:11:14.946	Vente De Produits Pharmaceutiques Thiaroye Tally Diallo Pinthie 0 Thiaroye Boulangerie Serigne Cheikh Gueye (Samba Gueye) Boulangerie	Quartier Ndaw Ene - Thiaroye Gare	33 836 93 32	Thiaroye	\N	\N	\N	f	\N
1916	Yakaar - Sarl	yakaar-sarl	Commerce	\N	2	2026-03-02 23:11:14.948	2026-03-02 23:11:14.948	Commerce	Route De Rufisque	33 837 95 76	Thiaroye	\N	\N	\N	f	\N
1917	Asp (Abdalah	asp-abdalah-1	Services Prestations -	\N	3	2026-03-02 23:11:14.952	2026-03-02 23:11:14.952	Services Prestations -	Abdallah Fall) Commerce Route De Rufisque 0 Thiaroye Pharmacie Bagdad Khar Yalla (Ex Pharmacie Medina 5 Vente De Produits Pharmaceutiques Thiaroye Tally Diallo Quartier Medina V	33 834 01 92	Thiaroye	\N	\N	\N	f	\N
1918	Pharmacie Rayhana (Dr Ismaila Barry)	pharmacie-rayhana-dr-ismaila-barry	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:14.954	2026-03-02 23:11:14.954	Vente De Produits Pharmaceutiques	Quartier Nasroulahi N° 533 Diamaguene	33 854 65 51	Thiaroye	\N	\N	\N	f	\N
1919	Hameth Lo	hameth-lo-1	Commerce	\N	2	2026-03-02 23:11:14.957	2026-03-02 23:11:14.957	Commerce	Rue Valmy 0 Thiaroye Edf (Entreprise Diop & Freres) - Mamadou Diop Vente De Pieces Detachees Poste Thiaroye	33 832 79 59	Thiaroye	\N	\N	\N	f	\N
1920	Station Oilibya(Lamine Mbodj	station-oilibya-lamine-mbodj	Vente De Produits Petroliers (Station D'Essence) Thies None	\N	1	2026-03-02 23:11:14.96	2026-03-02 23:11:14.96	Vente De Produits Petroliers (Station D'Essence) Thies None	Route De Polytechnique De Thies	33 939 54 20	Thies	\N	\N	\N	f	\N
1921	Etablissement Touba Darou Salam(Thierno Diop)	etablissement-touba-darou-salam-thierno-diop-1	Commerce General Marche Central De Thies 776398790 Thies Td Sarl (Transports Dieye Sarl) Transport	\N	2	2026-03-02 23:11:14.963	2026-03-02 23:11:14.963	Commerce General Marche Central De Thies 776398790 Thies Td Sarl (Transports Dieye Sarl) Transport	Route De Dakar - Thies	33 951 02 90	Thies	\N	\N	\N	f	\N
1922	Entreprise Activité Adresse Téléphone Thies Stap Sarl (Societe De Transformation D'Alcools Purs	entreprise-activite-adresse-telephone-thies-stap-sarl-societe-de-transformation-d-alcools-purs	Fabrication Boissons Alcoolisees	\N	4	2026-03-02 23:11:14.965	2026-03-02 23:11:14.965	Fabrication Boissons Alcoolisees	Rue Yacine Boubou	33 951 94 98	Ville	\N	\N	\N	f	\N
1923	Fall Et Aidara Sarl	fall-et-aidara-sarl-1	Commerce	\N	2	2026-03-02 23:11:14.968	2026-03-02 23:11:14.968	Commerce	Avenue Amamdou Gnagna Sow 0 Thies Al Youmoune Commerce Avenue Amadou Gnagna Sow Thies 0 Thies Sotrava Sarl Construction Travaux Electriques Villa N° 429 Grand Standing	33 952 05 45	Thies	\N	\N	\N	f	\N
1924	Cct (Compagnie Commerciale Thiam Suarl)	cct-compagnie-commerciale-thiam-suarl-1	Commerce	\N	2	2026-03-02 23:11:14.97	2026-03-02 23:11:14.97	Commerce	Avenue Adrien Senghor 0 Thies Moustapha Leye Commerce General Marche Central Thies 0 Thies Total Pout Garage (Ousseynou Ndiaye) Vente De Produits Petroliers (Station D'Essence) Garage Pout	33 954 00 00	Thies	\N	\N	\N	f	\N
1925	Touba Niambour	touba-niambour-1	Commerce	\N	2	2026-03-02 23:11:14.973	2026-03-02 23:11:14.973	Commerce	Avenue Amadou Barro Ndieguene 0 Thies Abdou Karim Fall Commerce De Carburant Mekhe	33 953 40 04	Thies	\N	\N	\N	f	\N
1926	Station Total Route De Saint-Louis Thies (Mamadou Sarr)	station-total-route-de-saint-louis-thies-mamadou-sarr-1	Vente De Produits Petroliers Total	\N	1	2026-03-02 23:11:14.976	2026-03-02 23:11:14.976	Vente De Produits Petroliers Total	Route De Saint- Louis Thies	33 955 51 50	Thies	\N	\N	\N	f	\N
1927	Espace Sope Naby	espace-sope-naby-1	Commerce	\N	2	2026-03-02 23:11:14.979	2026-03-02 23:11:14.979	Commerce	Avenue Leopold Sedar Senghor	33 952 12 13	Thies	\N	\N	\N	f	\N
1928	Station	station-8	Services Total(Pierre Sano Badji) Vente De Produits Petroliers(Station D'Essence)	\N	1	2026-03-02 23:11:14.989	2026-03-02 23:11:14.989	Services Total(Pierre Sano Badji) Vente De Produits Petroliers(Station D'Essence)	Route De Dakar Thies	70 100 54 80	Thies	\N	\N	\N	f	\N
1929	Madeleine Diagne	madeleine-diagne-1	Commerce	\N	2	2026-03-02 23:11:14.993	2026-03-02 23:11:14.993	Commerce	Rue Dr Guillet Aiglon 0 Thies Prest'Interim Sarl Services Fournis Aux Entreprises Grand Standing Imm, Assana Ndiaye Thies 775698025 Thies Transat Sarl Prestation De Service (Transport) Rue Yacine Boubou	33 951 30 71	Thies	\N	\N	\N	f	\N
1930	Scaf Sarl (Societe Commerciale Aidara Aidara Et Freres)	scaf-sarl-societe-commerciale-aidara-aidara-et-freres-1	Commerce	\N	2	2026-03-02 23:11:14.996	2026-03-02 23:11:14.996	Commerce	Avenue Amadou Gnagna Sow	33 952 05 45	Thies	\N	\N	\N	f	\N
1931	Sarl Moctar Sarr	sarl-moctar-sarr-1	Commerce	\N	2	2026-03-02 23:11:15	2026-03-02 23:11:15	Commerce	Avenue Amadou Gnagna Sow - Thies 0 Thies Sarl Keur Khadim N°1 Souare & Fils Commerce Quincaillerie Marche Grand Thies	33 952 27 52	Thies	\N	\N	\N	f	\N
1932	Al Houda - Sarl	al-houda-sarl-1	Commerce	\N	2	2026-03-02 23:11:15.003	2026-03-02 23:11:15.003	Commerce	Quartier Thialy 0 Thies Station Total Gare Routiere Thies Vente De Produits Petroliers Gare Routiere Thies	77 523 47 16	Thies	\N	\N	\N	f	\N
1933	Mouride Sadikh -Sarl	mouride-sadikh-sarl-1	Commerce Mbour 3 0 Thies Promegal (Producteurs De Melon Du Senegal -Sarl) Production Et Exportation De Melons Bayakh	\N	2	2026-03-02 23:11:15.007	2026-03-02 23:11:15.007	Commerce Mbour 3 0 Thies Promegal (Producteurs De Melon Du Senegal -Sarl) Production Et Exportation De Melons Bayakh	Route De Sangalkam	33 951 18 14	Thies	\N	\N	\N	f	\N
1934	Dioubo -Sarl	dioubo-sarl-1	Commerce Thor Djender - Thies 0 Thies Sorem Sa (Societe De Reparation Electromecanique) Maintenance Industrielle	\N	2	2026-03-02 23:11:15.01	2026-03-02 23:11:15.01	Commerce Thor Djender - Thies 0 Thies Sorem Sa (Societe De Reparation Electromecanique) Maintenance Industrielle	Avenue De Caen - Thies	33 951 21 17	Thies	\N	\N	\N	f	\N
1935	Michel Nicolas	michel-nicolas-1	Commerce Escale Sud 0 Thies Sodevco Sa Exploitation De Carrieres	\N	2	2026-03-02 23:11:15.013	2026-03-02 23:11:15.013	Commerce Escale Sud 0 Thies Sodevco Sa Exploitation De Carrieres	Quartier Carriere Thies	33 867 25 01	Thies	\N	\N	\N	f	\N
1936	La Senegalaise Electromenager	la-senegalaise-electromenager	Commerce General Marche Central De Thies 0 Thies Gora Dia Transport Routier Passagers	\N	2	2026-03-02 23:11:15.016	2026-03-02 23:11:15.016	Commerce General Marche Central De Thies 0 Thies Gora Dia Transport Routier Passagers	Quartier Som 0 Thies Groupe Vetagropharma International (Michel Sabbagh) Pharmacie Et Clinique Veterinaire Aiglon - Thies 0 Thies Entreprise Senegalaise De Construction Et D'Assainissement (Esca) Btp 199 Randoulene Sud Thies	33 952 23 59	Thies	\N	\N	\N	f	\N
1937	Pharmacie De L'Hopital (El Hadji Malick Diop)	pharmacie-de-l-hopital-el-hadji-malick-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.018	2026-03-02 23:11:15.018	Vente De Produits Pharmaceutiques	Avenue El Hadji Malick Sy	77 501 29 70	Thies	\N	\N	\N	f	\N
1938	Aly Meroueh Boulangerie Thies Commercial Tivaouane 0 Thies Pharmacie Du Cayor	aly-meroueh-boulangerie-thies-commercial-tivaouane-0-thies-pharmacie-du-cayor	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.02	2026-03-02 23:11:15.02	Vente De Produits Pharmaceutiques	Avenue Lamine Gueye 0 Thies Station Total Route De Dakar (Mamadou Ndieme Fall) Vente De Produits Petroliers Total Route De Dakar	33 951 44 53	Thies	\N	\N	\N	f	\N
1939	Ndiaye & Freres Sarl	ndiaye-freres-sarl-1	Commerce	\N	2	2026-03-02 23:11:15.024	2026-03-02 23:11:15.024	Commerce	Avenue De La Gare Marche Central 0 Thies Trans Distribution Sarl Commerce General Boulevard Francois Xavier Ndione	33 951 10 04	Thies	\N	\N	\N	f	\N
1940	Cisse Entreprise Sarl	cisse-entreprise-sarl-1	Commerce	\N	2	2026-03-02 23:11:15.028	2026-03-02 23:11:15.028	Commerce	Avenue El Hadji Barro Ndieguene - Diakhao Souf 0 Thies Ibra Badiane Commerce Avenue Amadou Gnagna Sow Thies	77 638 95 91	Thies	\N	\N	\N	f	\N
1941	Societe Dabo Sarl	societe-dabo-sarl-1	Commerce Escale	\N	2	2026-03-02 23:11:15.032	2026-03-02 23:11:15.032	Commerce Escale	Avenue General Degaulle	33 951 30 61	Thies	\N	\N	\N	f	\N
1942	Station Total Eladji Kalado Maiga	station-total-eladji-kalado-maiga-1	Vente De Produits Petroliers (Station D'Essence) Total	\N	1	2026-03-02 23:11:15.036	2026-03-02 23:11:15.036	Vente De Produits Petroliers (Station D'Essence) Total	Rue De Paris	33 959 57 00	Thies	\N	\N	\N	f	\N
1943	Le Tigre -Sarl	le-tigre-sarl-1	Commerce Escale	\N	2	2026-03-02 23:11:15.04	2026-03-02 23:11:15.04	Commerce Escale	Rue Birane Yacine Boubou	77 267 62 51	Thies	\N	\N	\N	f	\N
1944	Hussein Meroueh Boulangerie Thies 0 Thies Surl Au Bon Marche (Alain Consol)	hussein-meroueh-boulangerie-thies-0-thies-surl-au-bon-marche-alain-consol	Commerce	\N	2	2026-03-02 23:11:15.042	2026-03-02 23:11:15.042	Commerce	Avenue General Degaulle - Thies	33 951 63 80	Thies	\N	\N	\N	f	\N
1945	Islam - Suarl	islam-suarl	Commerce	\N	2	2026-03-02 23:11:15.045	2026-03-02 23:11:15.045	Commerce	Quartier Som 0 Thies Leila Boudib Boulangerie Quartier Grand Standing Thies 0 Thies Serigne Diop Commerce Marche Central	33 951 15 72	Thies	\N	\N	\N	f	\N
1946	Egc (Entreprise Generale De	egc-entreprise-generale-de-1	Commerce - Papa Amadou Diop) Commerce General	\N	2	2026-03-02 23:11:15.049	2026-03-02 23:11:15.049	Commerce - Papa Amadou Diop) Commerce General	Quartier Takhikao	33 951 85 92	Thies	\N	\N	\N	f	\N
1947	Csi Keur Madior (Complexe Scolaire International Ker Madior Education Château D'Eau Nord 0 Thies	csi-keur-madior-complexe-scolaire-international-ker-madior-education-chateau-d-eau-nord-0-thies	Fabrication De Meubles Thies None	\N	7	2026-03-02 23:11:15.052	2026-03-02 23:11:15.052	Fabrication De Meubles Thies None	Route De Dakar - Thies	33 952 22 52	Thies	\N	\N	\N	f	\N
1948	Bassirou Kane	bassirou-kane	Commerce Marche Escale Thies 0 Thies Smt (Senegalaise Des Mine Et Transports) Transport	\N	2	2026-03-02 23:11:15.055	2026-03-02 23:11:15.055	Commerce Marche Escale Thies 0 Thies Smt (Senegalaise Des Mine Et Transports) Transport	Rue Yacine Boubou - Thies	33 951 14 37	Thies	\N	\N	\N	f	\N
1949	Etablissement Mohamed Ali Meroueh	etablissement-mohamed-ali-meroueh	Commerce	\N	2	2026-03-02 23:11:15.057	2026-03-02 23:11:15.057	Commerce	Rue Du Docteur Guillet - Thies	33 952 05 45	Thies	\N	\N	\N	f	\N
1950	Rouda Meroueh Boulangerie Avenue Ousmane Ngom 0 Thies Complexe Bidew Bi (Enriette Attal) Auberge -	rouda-meroueh-boulangerie-avenue-ousmane-ngom-0-thies-complexe-bidew-bi-enriette-attal-auberge	Vente De Produits Pharmaceutiques	\N	1	2026-03-02 23:11:15.06	2026-03-02 23:11:15.06	Vente De Produits Pharmaceutiques	Avenue Leopold Sedar Senghor	33 951 10 20	Thies	\N	\N	\N	f	\N
1951	Pharmacie Khadim Rassoul	pharmacie-khadim-rassoul	Vente De Produits Pharmaceutiques Thies 0 Thies Etude Me Khady Sosseh Niang Cabinet Notaire	\N	2	2026-03-02 23:11:15.063	2026-03-02 23:11:15.063	Vente De Produits Pharmaceutiques Thies 0 Thies Etude Me Khady Sosseh Niang Cabinet Notaire	Quartier Carriere N° 27 0 Thies Total Clemenceau Thies (Catherine Gomis) Vente De Produits Petroliers Aiglon - Thies	33 951 10 71	Thies	\N	\N	\N	f	\N
1952	Epicerie Libre	epicerie-libre-2	Service (Habib Nahme) Commerce	\N	2	2026-03-02 23:11:15.068	2026-03-02 23:11:15.068	Service (Habib Nahme) Commerce	Rue De La Gare	77 552 44 93	Thies	\N	\N	\N	f	\N
1953	Pharmacie La Thiessoise - Suarl	pharmacie-la-thiessoise-suarl-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.072	2026-03-02 23:11:15.072	Vente De Produits Pharmaceutiques	Bd Colin 0 Thies Elias Khalil (Boulangerie 10Eme) Boulangerie Ex 10Eme Riaom Derriere Musee	33 951 48 37	Thies	\N	\N	\N	f	\N
1954	Boulangerie Seydi Jamil Et Hussein Boulangerie	boulangerie-seydi-jamil-et-hussein-boulangerie-1	(Production Et Distribution De Pain) Thies	\N	2	2026-03-02 23:11:15.077	2026-03-02 23:11:15.077	(Production Et Distribution De Pain) Thies	Rue Verdun X Lyon 0 Thies Pharmacie Des Niayes (Sokhna Diagne) Vente De Produits Pharmaceutiques En Face Hlm Mboro	33 951 45 45	Thies	\N	\N	\N	f	\N
1955	Boulangerie De La Cite(Gie Marone Et Freres) Boulangerie Cite Malick Sy 0 Thies Sarl W Est Point	boulangerie-de-la-cite-gie-marone-et-freres-boulangerie-cite-malick-sy-0-thies-sarl-w-est-point	Services Grand Standing 0 Thies Boulangerie Georges Baka Boulangerie	\N	4	2026-03-02 23:11:15.08	2026-03-02 23:11:15.08	Services Grand Standing 0 Thies Boulangerie Georges Baka Boulangerie	Avenue Ousmane Ngom Thies	77 633 87 88	Thies	\N	\N	\N	f	\N
1956	Pharmacie Du Camp (Mohamed Affif Yactine)	pharmacie-du-camp-mohamed-affif-yactine-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.084	2026-03-02 23:11:15.084	Vente De Produits Pharmaceutiques	Avenue El Hadji Omar Route De Khombole	33 952 12 92	Thies	\N	\N	\N	f	\N
1957	Gie Performance Afrique Bureau D' Etude, D'Appui Et De Prestation De	gie-performance-afrique-bureau-d-etude-d-appui-et-de-prestation-de	Service	\N	3	2026-03-02 23:11:15.087	2026-03-02 23:11:15.087	Service	Quartier Garnd Standing	33 952 15 92	Thies	\N	\N	\N	f	\N
1958	Escdp (Papa Mabaye Fall)	escdp-papa-mabaye-fall-1	Commerce Derriere La Gare Routiere	\N	2	2026-03-02 23:11:15.092	2026-03-02 23:11:15.092	Commerce Derriere La Gare Routiere	(Avenue Leopold Sedar Senghor) 0 Thies Pharmacie Thierno Amadou Moctar Sakho Vente De Produits Pharmaceutiques Cite Senghor 0 Thies Boulangerie Khadim Rassoul Boulangerie Industrielle Sampathe	33 951 95 50	Thies	\N	\N	\N	f	\N
1959	Boulangerie Serigne Mansour Sy Boulangerie Thies 0 Thies Pharmacie Hersent (Cheikh Ibrahima Faye)	boulangerie-serigne-mansour-sy-boulangerie-thies-0-thies-pharmacie-hersent-cheikh-ibrahima-faye	Vente De Produits Pharmaceutiques Hersent	\N	2	2026-03-02 23:11:15.095	2026-03-02 23:11:15.095	Vente De Produits Pharmaceutiques Hersent	Route De Khombole	33 951 21 97	Thies	\N	\N	\N	f	\N
1960	Pharmacie Du Rond Point Nguinth(Maxime Marone Theodore Toupane)	pharmacie-du-rond-point-nguinth-maxime-marone-theodore-toupane-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.1	2026-03-02 23:11:15.1	Vente De Produits Pharmaceutiques	Quartier Nguinth Thies	33 951 32 19	Thies	\N	\N	\N	f	\N
1961	Mamadou Boye Fall Btp Parcelles Assainies Thies 0 Thies Pharmacie De La Teranga (Mamadou Badara	mamadou-boye-fall-btp-parcelles-assainies-thies-0-thies-pharmacie-de-la-teranga-mamadou-badara	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.104	2026-03-02 23:11:15.104	Vente De Produits Pharmaceutiques	Rue Felix Houphouet	33 954 06 48	Thies	\N	\N	\N	f	\N
1962	Gie Platinium Import	gie-platinium-import-1	Commerce De Quincaillerie	\N	2	2026-03-02 23:11:15.108	2026-03-02 23:11:15.108	Commerce De Quincaillerie	Rue Elhadji Malick Sy - Mbour	33 951 26 27	Thies	\N	\N	\N	f	\N
1963	Sen Marche Suarl (Societe Senegalaise D'Importation Et D'Exportation Marchandises)	sen-marche-suarl-societe-senegalaise-d-importation-et-d-exportation-marchandises-1	Commerce	\N	2	2026-03-02 23:11:15.114	2026-03-02 23:11:15.114	Commerce	Avenue De Caen En Face De La Poste 0 Thies Pharmacie Mame Boucar (Souleymane Djigo) Vente De Produits Pharmaceutiques Mbour 1 Thies	33 952 09 39	Thies	\N	\N	\N	f	\N
1964	Pharmacie Principale - Thies (Cheikh Ahmed Tidiane Gning)	pharmacie-principale-thies-cheikh-ahmed-tidiane-gning	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.117	2026-03-02 23:11:15.117	Vente De Produits Pharmaceutiques	Rue De La Gare Escale Nord Pres Cinema Agora 0 Thies Modou Mbaye Transport Zone Industrielle Thies	33 952 04 14	Thies	\N	\N	\N	f	\N
1965	Pharmacie Moussante (Pape Alioune Mbaye)	pharmacie-moussante-pape-alioune-mbaye-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.122	2026-03-02 23:11:15.122	Vente De Produits Pharmaceutiques	Route De Khombole - Thies	33 836 57 88	Thies	\N	\N	\N	f	\N
1966	Pharmacie Residence (Ndeye Fatoumata Mbaye)	pharmacie-residence-ndeye-fatoumata-mbaye-1	Vente De Produits Pharmaceutiques Place Caen Carriere	\N	2	2026-03-02 23:11:15.127	2026-03-02 23:11:15.127	Vente De Produits Pharmaceutiques Place Caen Carriere	Route De Dakar	33 951 85 92	Thies	\N	\N	\N	f	\N
1967	Boulangerie Laziza Pout Boulangerie	boulangerie-laziza-pout-boulangerie	(Production Et Distribution De Pain)	\N	2	2026-03-02 23:11:15.131	2026-03-02 23:11:15.131	(Production Et Distribution De Pain)	Quartier Thiekene Pout 0 Thies El Hadji Diagne Commerce Marche Central Mekhe	33 955 91 50	Thies	\N	\N	\N	f	\N
1968	Pharmacie Bount Depot (Michel Daou)	pharmacie-bount-depot-michel-daou	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.134	2026-03-02 23:11:15.134	Vente De Produits Pharmaceutiques	Quartier Aiglon Dvf	77 443 53 91	Thies	\N	\N	\N	f	\N
1969	Esips (Ecole Superieure Internationale Des Praticiens De La Sante) Formation Mbour I Route Du Stade	esips-ecole-superieure-internationale-des-praticiens-de-la-sante-formation-mbour-i-route-du-stade	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.138	2026-03-02 23:11:15.138	Vente De Produits Pharmaceutiques	Quartier Mbour 1 - Rocade Sud X Route De Mbour - Thies	33 951 39 16	Thies	\N	\N	\N	f	\N
1970	Pharmacie Mame Birama Mbaye (Mor Mbaye)	pharmacie-mame-birama-mbaye-mor-mbaye-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.143	2026-03-02 23:11:15.143	Vente De Produits Pharmaceutiques	Route De La Base Aerienne Pepiniere Diakhao	33 952 12 44	Thies	\N	\N	\N	f	\N
1971	Alassane Diagne Boulangerie Avenue Coumba Ndoffene Diouf 774277975 Thies Veto Vision (Papa Aly	alassane-diagne-boulangerie-avenue-coumba-ndoffene-diouf-774277975-thies-veto-vision-papa-aly	Services Veterinaires Randoulene Nord - Thies 0 Thies Laboratopire Sa (Marie Diallo) Activites Pour La Sante Des Hommes (Cabinet Medical)	\N	4	2026-03-02 23:11:15.146	2026-03-02 23:11:15.146	Services Veterinaires Randoulene Nord - Thies 0 Thies Laboratopire Sa (Marie Diallo) Activites Pour La Sante Des Hommes (Cabinet Medical)	Quartier 10Eme	33 952 33 96	Thies	\N	\N	\N	f	\N
1972	Touba Glace (Hussein Fakhredine) Fabrique De Glace Zone Industrielle Thies 0 Thies Pharmacie Maman	touba-glace-hussein-fakhredine-fabrique-de-glace-zone-industrielle-thies-0-thies-pharmacie-maman	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.151	2026-03-02 23:11:15.151	Vente De Produits Pharmaceutiques	Route De Kayar Keur Moussa	77 538 56 50	Thies	\N	\N	\N	f	\N
1973	Pharmacie Du Stade Lat Dior (Mohamed Moustapha Sarr)	pharmacie-du-stade-lat-dior-mohamed-moustapha-sarr-1	Vente De Produits Pharmaceutiques Mbour 3 Pres Du Stade Lat Dior 0 Thies Clinique De La Conception (Christiane Lahoud Daou) Activites Pour La Sante Des Hommes (Clinique)	\N	2	2026-03-02 23:11:15.155	2026-03-02 23:11:15.155	Vente De Produits Pharmaceutiques Mbour 3 Pres Du Stade Lat Dior 0 Thies Clinique De La Conception (Christiane Lahoud Daou) Activites Pour La Sante Des Hommes (Clinique)	Rue Birane Yacine Boubou - Escale	33 951 17 48	Thies	\N	\N	\N	f	\N
1974	Pharmacie Abdou Aziz Sy	pharmacie-abdou-aziz-sy-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.159	2026-03-02 23:11:15.159	Vente De Produits Pharmaceutiques	Avenue Caen	77 529 50 37	Thies	\N	\N	\N	f	\N
1975	Pharmacie Du Lycee (Ndiouga Diallo)	pharmacie-du-lycee-ndiouga-diallo-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.163	2026-03-02 23:11:15.163	Vente De Produits Pharmaceutiques	Avenue Caen Cite El Hadji Malick Sy - Thies	33 951 13 83	Thies	\N	\N	\N	f	\N
1976	Big Faim (Enriette Attal) Restaurant Avenue Leopold Sedar Senghor 0 Thies T And Partners (Thie	big-faim-enriette-attal-restaurant-avenue-leopold-sedar-senghor-0-thies-t-and-partners-thie	Commerce General	\N	2	2026-03-02 23:11:15.166	2026-03-02 23:11:15.166	Commerce General	Avenue Caen Randoulene Nord Thies 0 Thies Pharmacie Lamp Fall (Souleymane Bocoum) Vente De Produits Pharmaceutiques Medina Fall Pres Ecole Don Bosco 0 Thies Aita (Africaine D'Ingenierie De Travaux Et D'Approvisionnements - Alpha Kane) Ingenierie Approvisionnements Avenue Caen Face Lycee Malick Sy Thies	33 952 32 06	Thies	\N	\N	\N	f	\N
1977	Pharmacie Mobbo	pharmacie-mobbo-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.171	2026-03-02 23:11:15.171	Vente De Produits Pharmaceutiques	Bayakh,Route De Mboro	33 952 31 54	Thies	\N	\N	\N	f	\N
1978	Pharmacie Emmanuel Ch. Gueye Ngazobil (Jeanne Marie Rose Gueye)	pharmacie-emmanuel-ch-gueye-ngazobil-jeanne-marie-rose-gueye-1	Vente De Produits Pharmaceutiques Kaw Sara	\N	1	2026-03-02 23:11:15.175	2026-03-02 23:11:15.175	Vente De Produits Pharmaceutiques Kaw Sara	Route De Saint- Louis / Thies	77 633 51 84	Thies	\N	\N	\N	f	\N
1979	Thies Kay Avs (Ndongo Samb)	thies-kay-avs-ndongo-samb-1	Commerce General Hersent Thies 779193645 Thies Pharmacie Nouvelle Cayor (Alexandre Jean Thomes Sylva) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.179	2026-03-02 23:11:15.179	Commerce General Hersent Thies 779193645 Thies Pharmacie Nouvelle Cayor (Alexandre Jean Thomes Sylva) Vente De Produits Pharmaceutiques	Avenue Du President Lamine Gueye Thies 0 Thies Thioune Visions (Alioune Badara Thioune) Commerce Avenue Ousmane Ngom X Rue 10 Randoulene Nord	33 951 00 20	Thies	\N	\N	\N	f	\N
1980	Bamba 2 (Khabane Gueye)	bamba-2-khabane-gueye	Commerce	\N	2	2026-03-02 23:11:15.182	2026-03-02 23:11:15.182	Commerce	Avenue Amadou Gnagna Sow	77 440 17 58	Thies	\N	\N	\N	f	\N
1981	Assurance Et Gestion De Patrimoine Assurance Avenue Du President Lamine Gueye Thies 0 Thies Jts	assurance-et-gestion-de-patrimoine-assurance-avenue-du-president-lamine-gueye-thies-0-thies-jts	Commerce De Semences	\N	2	2026-03-02 23:11:15.185	2026-03-02 23:11:15.185	Commerce De Semences	Avenue Du President Lamine Gueye	77 277 88 93	Thies	\N	\N	\N	f	\N
1982	Pharmacie Randoulene (Aladji Ba)	pharmacie-randoulene-aladji-ba-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.189	2026-03-02 23:11:15.189	Vente De Produits Pharmaceutiques	Avenue Djibril Diaw	33 951 13 34	Thies	\N	\N	\N	f	\N
1983	Etipam (Bounama Diagne)	etipam-bounama-diagne-1	Commerce	\N	2	2026-03-02 23:11:15.192	2026-03-02 23:11:15.192	Commerce	Avenue Gnagna Sow Escale Thies	33 952 12 75	Thies	\N	\N	\N	f	\N
1984	Sanna Btp Suarl	sanna-btp-suarl	Services Rendus Aux Entreprises	\N	6	2026-03-02 23:11:15.195	2026-03-02 23:11:15.195	Services Rendus Aux Entreprises	Quartier Mbour I, Villa N°17 Rue 06 Thies	77 319 69 41	Thies	\N	\N	\N	f	\N
1985	Gora Diop	gora-diop	Commerce Marche Central Thies 0 Thies Cabinet Medical Dr Bassirou Sarr Activites Pour La Sante Des Hommes Escale	\N	2	2026-03-02 23:11:15.198	2026-03-02 23:11:15.198	Commerce Marche Central Thies 0 Thies Cabinet Medical Dr Bassirou Sarr Activites Pour La Sante Des Hommes Escale	Rue De Paris - Thies	77 733 06 60	Thies	\N	\N	\N	f	\N
1986	Jean Paul Denis Frederick Akl Reparation - Prestations De	jean-paul-denis-frederick-akl-reparation-prestations-de	Services (Garage Mecanique)	\N	8	2026-03-02 23:11:15.201	2026-03-02 23:11:15.201	Services (Garage Mecanique)	Rue De Verdun - Thies 0 Thies Thiam Camara Activites Pour La Sante Des Hommes Avenue Houphouet Boigny - Thies 0 Ville Entreprise Activité Adresse Téléphone Thies Family Scolaire Commerce Cite Lamy Thies 0 Thies Auberge Le Figuier Suarl Auberge Quatier St Benoit, Keur Moussa 0 Thies Auberge "Chez Manjula" (Veronique Manjola Decroix) Hotelerie Et Services Analogues Cite El Hadji Malick Sy Thies 777972828 Thies Ferme Du Champ De Tir De Thies Suarl Agriculture, Horticulture, Commercialisation Thies, Vcs En Face Du Champ De Tir	33 951 39 74	Thies	\N	\N	\N	f	\N
1987	Cabinet Abdoulaye Diop Consult	cabinet-abdoulaye-diop-consult	Services	\N	3	2026-03-02 23:11:15.203	2026-03-02 23:11:15.203	Services	(Abdoulaye Diop) Cabinet D'Expertise Comptable Mbour 1 Thies	33 951 50 50	Thies	\N	\N	\N	f	\N
1988	Secap (Gie Senegalaise D'Equipement De	secap-gie-senegalaise-d-equipement-de	Commerce Et D'Appro) Btp	\N	2	2026-03-02 23:11:15.206	2026-03-02 23:11:15.206	Commerce Et D'Appro) Btp	Avenue Cheikh Ahmadou Bamba Angle Serigne Fallou	33 821 70 32	Thies	\N	\N	\N	f	\N
1989	Soma Sarl	soma-sarl-1	Commerce General	\N	2	2026-03-02 23:11:15.21	2026-03-02 23:11:15.21	Commerce General	Quartier Commercial Tivaouane 0 Tivaouane Station Total Carrefour Tivaoune (Fallou Sene) Vente De Produits Petroliers Total Carrefour Tivaoune	77 647 43 22	Tivaouane	\N	\N	\N	f	\N
1990	Pharmacie Khalifa Ababacar Sy - Sarl	pharmacie-khalifa-ababacar-sy-sarl-1	Vente De Produits Pharmaceutiques Lieudit Keur Mass,	\N	2	2026-03-02 23:11:15.214	2026-03-02 23:11:15.214	Vente De Produits Pharmaceutiques Lieudit Keur Mass,	Route Nationale N°2 - Tivaouane	33 955 50 87	Tivaouane	\N	\N	\N	f	\N
1991	Pharmacie El Hadji Malick Sy - Maimouna Sy Diaw	pharmacie-el-hadji-malick-sy-maimouna-sy-diaw-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.218	2026-03-02 23:11:15.218	Vente De Produits Pharmaceutiques	Quartier Commercial - Tivaouane	33 955 20 25	Tivaouane	\N	\N	\N	f	\N
1992	Pharmacie Serigne Mansour Sy (Dr Oumar Barro)	pharmacie-serigne-mansour-sy-dr-oumar-barro-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.222	2026-03-02 23:11:15.222	Vente De Produits Pharmaceutiques	Route De L'Hopital - Tivaouane	33 955 19 49	Tivaouane	\N	\N	\N	f	\N
1993	Grande Pharmacie De Tivaouane (Abdoulaye Sow )	grande-pharmacie-de-tivaouane-abdoulaye-sow-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.232	2026-03-02 23:11:15.232	Vente De Produits Pharmaceutiques	Quartier Darou Salam - Tivaouane 0 Tivaouane Salam Construction Btp Quartier Ngaye Diagne Villa N° 262 - Mekhe 0 Tivaouane Kene Diop Commerce Marche Central Tivaouane 0 Tivaouane Alioune Gadiaga Commerce Marche Central Tivaouane 0 Tivaouane Technique 2000 (Ngouda Hanne) Menuiserie Bois Keur Cheikh Aw A Balla Mbacke - Tivaouane	33 955 36 56	Tivaouane	\N	\N	\N	f	\N
1994	Katyvet (Aliou Ndao) Sante Animale (Cabinet Veterinaire) Ndouth 0 Toglou Ferme Agro Avicole	katyvet-aliou-ndao-sante-animale-cabinet-veterinaire-ndouth-0-toglou-ferme-agro-avicole	Commerce	\N	2	2026-03-02 23:11:15.235	2026-03-02 23:11:15.235	Commerce	Quartier Darou Minam Corniche Ndiouga Kebe - Touba	33 864 18 70	Tivaouane	\N	\N	\N	f	\N
1995	Societe Sant Yalla Borom Bi Sarl	societe-sant-yalla-borom-bi-sarl-1	Commerce - Btp	\N	2	2026-03-02 23:11:15.239	2026-03-02 23:11:15.239	Commerce - Btp	Quartier Touba Corniche Face Usine Glace - Touba	33 974 15 17	Touba	\N	\N	\N	f	\N
1996	Pharmacie Touba Mosquee	pharmacie-touba-mosquee-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.243	2026-03-02 23:11:15.243	Vente De Produits Pharmaceutiques	Route De Niouga Kebe X Keur Souhaïbaou Mbacke	33 978 07 57	Touba	\N	\N	\N	f	\N
1997	Toll Mame Cheikh Issa Suarl	toll-mame-cheikh-issa-suarl-1	Commerce	\N	2	2026-03-02 23:11:15.248	2026-03-02 23:11:15.248	Commerce	Quartier Darou Khoudoss - Touba	33 974 89 74	Touba	\N	\N	\N	f	\N
1998	Pharmacie Mame Diarra (Arona Diakhate)	pharmacie-mame-diarra-arona-diakhate-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.252	2026-03-02 23:11:15.252	Vente De Produits Pharmaceutiques	Route De Dara Djolof Gouye Mbinde - Touba 0 Touba Societe Touba Quincaillerie Generale Sarl Commerce General Quartier Darou Minam - Touba	77 569 82 82	Touba	\N	\N	\N	f	\N
1999	Campement Keur Thierry Hebergement Hotelier Toubacouta 0 Velingara Pharmacie Hafia - Ahmeth Diop	campement-keur-thierry-hebergement-hotelier-toubacouta-0-velingara-pharmacie-hafia-ahmeth-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.255	2026-03-02 23:11:15.255	Vente De Produits Pharmaceutiques	Quartier Sinthia Houlata - Velingara	77 593 77 29	Toubacouta	\N	\N	\N	f	\N
2000	Pharmacie Amadou (Mamadou Dieye)	pharmacie-amadou-mamadou-dieye-1	Vente De Produits Pharmaceutiques Cite Comico 4 N° 282	\N	2	2026-03-02 23:11:15.26	2026-03-02 23:11:15.26	Vente De Produits Pharmaceutiques Cite Comico 4 N° 282	Route De Boune	33 960 57 93	Yeumbeul	\N	\N	\N	f	\N
2001	Pharmacie Afia 5	pharmacie-afia-5-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.263	2026-03-02 23:11:15.263	Vente De Produits Pharmaceutiques	Route De Boune - Villa N° 135 - Yeumbeul	33 878 11 95	Yeumbeul	\N	\N	\N	f	\N
2002	Mamadou Barry	mamadou-barry	Commerce Santhiaba Ziguinchor 776325512 Ziguinchor Complexe Senefand Suarl Activites Annexes A La Peche	\N	2	2026-03-02 23:11:15.266	2026-03-02 23:11:15.266	Commerce Santhiaba Ziguinchor 776325512 Ziguinchor Complexe Senefand Suarl Activites Annexes A La Peche	Rue 2 Goumel Zodezi	33 837 95 64	Ziguinchor	\N	\N	\N	f	\N
2003	Entreprise Activité Adresse Téléphone Ziguinchor Etablissements Sara Sarl	entreprise-activite-adresse-telephone-ziguinchor-etablissements-sara-sarl	Commerce Marchandises Diverses	\N	2	2026-03-02 23:11:15.268	2026-03-02 23:11:15.268	Commerce Marchandises Diverses	Rue Lieutenant Lemoine Escale Ziguinchor	33 991 54 68	Ville	\N	\N	\N	f	\N
2004	Entreprise Da Rosa Suarl	entreprise-da-rosa-suarl-1	Btp-Transport-Commerce	\N	2	2026-03-02 23:11:15.273	2026-03-02 23:11:15.273	Btp-Transport-Commerce	Quartier Santhiaba	33 991 13 98	Ziguinchor	\N	\N	\N	f	\N
2005	Gie Cpas (Centre De Promotion Agricole Et Sociale De Diembering)	gie-cpas-centre-de-promotion-agricole-et-sociale-de-diembering-1	Production Et Vente De Produits Elevage	\N	2	2026-03-02 23:11:15.276	2026-03-02 23:11:15.276	Production Et Vente De Produits Elevage	Route De Bouyouye Cr De Diembering	33 991 46 46	Ziguinchor	\N	\N	\N	f	\N
2006	Regal Commidities Suarl Exportation De Noix De Cajou Goumel Ziguinchor 0 Ziguinchor 3F Senegal Suarl	regal-commidities-suarl-exportation-de-noix-de-cajou-goumel-ziguinchor-0-ziguinchor-3f-senegal-suarl	Vente De Produits Alimentaires	\N	2	2026-03-02 23:11:15.279	2026-03-02 23:11:15.279	Vente De Produits Alimentaires	Quartier Boucotte Sud	33 993 53 37	Ziguinchor	\N	\N	\N	f	\N
2007	Pharmacie Aline Sitoe Diatta (Madiamba Niabaly)	pharmacie-aline-sitoe-diatta-madiamba-niabaly-1	Vente De Produits Pharmaceutiques Boucotte Sud	\N	2	2026-03-02 23:11:15.283	2026-03-02 23:11:15.283	Vente De Produits Pharmaceutiques Boucotte Sud	Route De L'Hopital Regional De Ziguinchor 0 Ziguinchor Essamai Suarl Vente De Produits Petroliers, Restaurant, Boutique Shell Javelier Rond Point Jean Paul 2	33 991 65 97	Ziguinchor	\N	\N	\N	f	\N
2008	Superette Sara (Mohamar Soraya Sara)	superette-sara-mohamar-soraya-sara-1	Commerce General (Superette)	\N	2	2026-03-02 23:11:15.287	2026-03-02 23:11:15.287	Commerce General (Superette)	Rue Lieutenant Lemoine Escale Ziguinchor	33 991 65 90	Ziguinchor	\N	\N	\N	f	\N
2009	Mamadou Cire Diall0	mamadou-cire-diall0-1	Commerce Marche Bignona 0 Ziguinchor Pharmacie Du Stade(Malick Diedhiou) Vente De Produits Pharmaceutiques Leona Ziguinchor 0 Ziguinchor Pharmacie La Paix ( Pierre Dieng) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.291	2026-03-02 23:11:15.291	Commerce Marche Bignona 0 Ziguinchor Pharmacie Du Stade(Malick Diedhiou) Vente De Produits Pharmaceutiques Leona Ziguinchor 0 Ziguinchor Pharmacie La Paix ( Pierre Dieng) Vente De Produits Pharmaceutiques	Route De L'Aeroport Face Hopital La Paix	33 993 52 80	Ziguinchor	\N	\N	\N	f	\N
2010	Entreprise Nader Dagher Btp Bat Escale Face Impot Et Domaines Ziguinchor 0 Ziguinchor Pharmacie	entreprise-nader-dagher-btp-bat-escale-face-impot-et-domaines-ziguinchor-0-ziguinchor-pharmacie	Vente De Produits Pharmaceutiques Bvd 54 X	\N	2	2026-03-02 23:11:15.293	2026-03-02 23:11:15.293	Vente De Produits Pharmaceutiques Bvd 54 X	Rue 29 Mosquee Kadior Ziguinchor	33 991 49 34	Ziguinchor	\N	\N	\N	f	\N
2011	Pharmacie Esthetis (Coumba Diodio Ndong)	pharmacie-esthetis-coumba-diodio-ndong-1	Vente De Produits Pharmaceutiques Nema Extension Ziguinchor 0 Ziguinchor Siaka Doumbia Notariat	\N	2	2026-03-02 23:11:15.297	2026-03-02 23:11:15.297	Vente De Produits Pharmaceutiques Nema Extension Ziguinchor 0 Ziguinchor Siaka Doumbia Notariat	Rue Lemoine Ziguinchor 0 Ziguinchor Tse (Travaux Et Services Electriques) - Francois Bampoky Electricite Grand-Yoff Scat Urbam N° 165	33 633 06 07	Ziguinchor	\N	\N	\N	f	\N
2012	Oasis Suarl Adduction D'Eau Boucotte Diembering 0 Ziguinchor Tahiti Hotel Ii Sarl Hotelerie	oasis-suarl-adduction-d-eau-boucotte-diembering-0-ziguinchor-tahiti-hotel-ii-sarl-hotelerie	Vente De Lunettes)	\N	2	2026-03-02 23:11:15.299	2026-03-02 23:11:15.299	Vente De Lunettes)	Avenue Du Docteur Carvalho	33 993 52 19	Ziguinchor	\N	\N	\N	f	\N
2013	Ets Nemer Sara - Sarl	ets-nemer-sara-sarl-1	Commerce Alimentaire	\N	2	2026-03-02 23:11:15.303	2026-03-02 23:11:15.303	Commerce Alimentaire	Rue Lemoine	33 991 63 43	Ziguinchor	\N	\N	\N	f	\N
2014	Gie Oasis Maraichages Boucotte Diembering 0 Ziguinchor 3 Md'Action Rapite	gie-oasis-maraichages-boucotte-diembering-0-ziguinchor-3-md-action-rapite	Commerce 2515	\N	2	2026-03-02 23:11:15.306	2026-03-02 23:11:15.306	Commerce 2515	Rue Non Denomee 77 5679490 Ziguinchor Azibrint Senegal Sarl Ziguinchor Btp Escale Face Lonase Ziguinchor	77 402 04 77	Ziguinchor	\N	\N	\N	f	\N
2015	Total Boucotte(Salif Fall)	total-boucotte-salif-fall-1	Vente De Carburant	\N	1	2026-03-02 23:11:15.31	2026-03-02 23:11:15.31	Vente De Carburant	Avenue Ibou Diallo Ziguinchor	77 550 63 01	Ziguinchor	\N	\N	\N	f	\N
2016	Pharmacie Colobane(Jeanne Tavarez Gueye)	pharmacie-colobane-jeanne-tavarez-gueye-1	Vente De Produits Pharmaceutiques Lindiane Bvd Alpha Zig 0 Ziguinchor Pharmacie Alexandre (Raymond Nunez) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.314	2026-03-02 23:11:15.314	Vente De Produits Pharmaceutiques Lindiane Bvd Alpha Zig 0 Ziguinchor Pharmacie Alexandre (Raymond Nunez) Vente De Produits Pharmaceutiques	Avenue Emille Badiane 0 Ziguinchor Gie Casa General Tech Services Commerce Boucotte Ziguinchor	33 991 74 05	Ziguinchor	\N	\N	\N	f	\N
2017	Sanofi Aventis Senegal (Ex Sanofi Synthelabo Afo)	sanofi-aventis-senegal-ex-sanofi-synthelabo-afo	Fabrication De Produit Pharmaceutique (Promotion Pharmaceutique) Point E	\N	5	2026-03-02 23:11:15.316	2026-03-02 23:11:15.316	Fabrication De Produit Pharmaceutique (Promotion Pharmaceutique) Point E	Immeuble Epi	33 834 68 87	Dakar	\N	\N	\N	f	\N
2018	Winthrop Pharma Senegal (Ex Africasoins	winthrop-pharma-senegal-ex-africasoins	Production (Ex Aventis Pharma - Sa Industrie Pharmaceutique	\N	5	2026-03-02 23:11:15.318	2026-03-02 23:11:15.318	Production (Ex Aventis Pharma - Sa Industrie Pharmaceutique	Route De Rufisque	33 865 02 02	Dakar	\N	\N	\N	f	\N
2019	Valdafrique - Labo Canonne - Sa Industries Pharmaceutiques - Autres	valdafrique-labo-canonne-sa-industries-pharmaceutiques-autres-1	Commerces - Services Rendus Auf Entreprises	\N	2	2026-03-02 23:11:15.322	2026-03-02 23:11:15.322	Commerces - Services Rendus Auf Entreprises	Route De Diokoul - Rufisque	33 879 13 50	Dakar	\N	\N	\N	f	\N
2020	Aye Jean Pierre Mendy	aye-jean-pierre-mendy-1	Vente De Produits Pharmaceutiques Nimzatt	\N	2	2026-03-02 23:11:15.326	2026-03-02 23:11:15.326	Vente De Produits Pharmaceutiques Nimzatt	Quartier Mbaye Fall Guediaw Aye	33 839 87 80	Guediaw	\N	\N	\N	f	\N
2021	Pharmacie Guigon (Bernard Henrie Guigon)	pharmacie-guigon-bernard-henrie-guigon-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.329	2026-03-02 23:11:15.329	Vente De Produits Pharmaceutiques	Avenue Lamine Gueye	77 306 58 60	Dakar	\N	\N	\N	f	\N
2022	Senevet - Sarl	senevet-sarl	Distribution De Pdts Pharmaceutiques Veterinaires Derkle	\N	2	2026-03-02 23:11:15.331	2026-03-02 23:11:15.331	Distribution De Pdts Pharmaceutiques Veterinaires Derkle	Rue 3 * Z - Villa N° 1	33 889 57 07	Dakar	\N	\N	\N	f	\N
2023	Pharmacie Du Plateau - Sau	pharmacie-du-plateau-sau-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.336	2026-03-02 23:11:15.336	Vente De Produits Pharmaceutiques	Avenue Lamine Gueye	33 824 70 87	Dakar	\N	\N	\N	f	\N
2024	Pharmacie De La Mosquee	pharmacie-de-la-mosquee-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.341	2026-03-02 23:11:15.341	Vente De Produits Pharmaceutiques	Rue Mohamed V X Rue Carnot	33 821 10 68	Dakar	\N	\N	\N	f	\N
2025	Ecopharm Senegal	ecopharm-senegal-1	Distribution De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.345	2026-03-02 23:11:15.345	Distribution De Produits Pharmaceutiques	Route De L'Aeroport L .Sedar Senghor Face Hangar Pelerien	33 822 88 01	Dakar	\N	\N	\N	f	\N
2026	Pharmacie Gambetta "Khoury"	pharmacie-gambetta-khoury-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.348	2026-03-02 23:11:15.348	Vente De Produits Pharmaceutiques	Avenue Lamine Gueye	33 842 44 55	Dakar	\N	\N	\N	f	\N
2027	Pharmacie Signara (Oumar Mbaye)	pharmacie-signara-oumar-mbaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.351	2026-03-02 23:11:15.351	Vente De Produits Pharmaceutiques	Avenue Cheikh Anta Diop	33 821 08 18	Dakar	\N	\N	\N	f	\N
2028	Pharmacie Ponty Thiong	pharmacie-ponty-thiong-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.359	2026-03-02 23:11:15.359	Vente De Produits Pharmaceutiques	Rue De Thiong X W Agane Diouf	33 864 02 50	Dakar	\N	\N	\N	f	\N
2029	Pharmacie Pasteur	pharmacie-pasteur	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.362	2026-03-02 23:11:15.362	Vente De Produits Pharmaceutiques	Avenue Pasteur - Station Shell	33 822 47 78	Dakar	\N	\N	\N	f	\N
2030	Pharmacie Teranga (Raif Kfoury)	pharmacie-teranga-raif-kfoury-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.367	2026-03-02 23:11:15.367	Vente De Produits Pharmaceutiques	Rue Dr Theze X Felix Faure	33 821 70 35	Dakar	\N	\N	\N	f	\N
2031	Pharmacie Touba Mosquee	pharmacie-touba-mosquee-2	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.373	2026-03-02 23:11:15.373	Vente De Produits Pharmaceutiques	Route De Niouga Kebe X Keur Souhaïbaou Mbacke	33 827 49 64	Touba	\N	\N	\N	f	\N
2032	Pharmacie De La Republique - Sokhna Diagne	pharmacie-de-la-republique-sokhna-diagne	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.376	2026-03-02 23:11:15.376	Vente De Produits Pharmaceutiques	Bd De La Republique	33 834 52 46	Dakar	\N	\N	\N	f	\N
2033	Pharmacie De L'Islam - Ifafe Attye	pharmacie-de-l-islam-ifafe-attye-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.38	2026-03-02 23:11:15.38	Vente De Produits Pharmaceutiques	Avenue Emile Badiane	33 821 16 63	Dakar	\N	\N	\N	f	\N
2034	Pharmacie Medina (Adel Attye)	pharmacie-medina-adel-attye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.383	2026-03-02 23:11:15.383	Vente De Produits Pharmaceutiques	Avenue Blaise Diagne X Rue 29 Medina	33 827 48 49	Dakar	\N	\N	\N	f	\N
2035	Pharmacie Stella - Suarl	pharmacie-stella-suarl-1	Vente De Produits Pharmaceutiques Stele Mermoz	\N	2	2026-03-02 23:11:15.387	2026-03-02 23:11:15.387	Vente De Produits Pharmaceutiques Stele Mermoz	Route De Ouakam	33 823 94 01	Dakar	\N	\N	\N	f	\N
2036	Pharmacie Soumbedioune (Ex Pharmacie Du Secours)	pharmacie-soumbedioune-ex-pharmacie-du-secours	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.389	2026-03-02 23:11:15.389	Vente De Produits Pharmaceutiques	Rue 51 X 60 Marche Gueule Tapee	33 860 32 32	Dakar	\N	\N	\N	f	\N
2037	Pharmacie De L'Hopital (El Hadji Malick Diop)	pharmacie-de-l-hopital-el-hadji-malick-diop-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.393	2026-03-02 23:11:15.393	Vente De Produits Pharmaceutiques	Avenue El Hadji Malick Sy	33 947 11 40	Thies	\N	\N	\N	f	\N
2038	Pharmacie Tally Icotaf - Youssef Aidibe	pharmacie-tally-icotaf-youssef-aidibe-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.398	2026-03-02 23:11:15.398	Vente De Produits Pharmaceutiques	Avenue El Hadj Malick Sy, Tally Icotaf - Pikine	33 822 41 74	Dakar	\N	\N	\N	f	\N
2039	Pharmacie El Hadji Malick Sy - Suarl	pharmacie-el-hadji-malick-sy-suarl-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.402	2026-03-02 23:11:15.402	Vente De Produits Pharmaceutiques	Avenue Malick Sy 338222013 Dakar Pharmacie Cheikh Issa Aw Vente De Produits Pharmaceutiques Grand Medine N° 601	33 834 92 02	Dakar	\N	\N	\N	f	\N
2040	Pharmacie Nelson Mandela- Mamadou Omar Dia	pharmacie-nelson-mandela-mamadou-omar-dia-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.406	2026-03-02 23:11:15.406	Vente De Produits Pharmaceutiques	Avenue Nelson Mandela	33 835 09 52	Dakar	\N	\N	\N	f	\N
2041	Entreprise Activité Adresse Téléphone Dakar Pharmacie Soumbedioune	entreprise-activite-adresse-telephone-dakar-pharmacie-soumbedioune	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.409	2026-03-02 23:11:15.409	Vente De Produits Pharmaceutiques	Bd De La Gueule Tapee	33 821 21 72	Ville	\N	\N	\N	f	\N
2042	Pharmacie Africaine (Mohamed Nissr)	pharmacie-africaine-mohamed-nissr-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.412	2026-03-02 23:11:15.412	Vente De Produits Pharmaceutiques	Avenue Lamine Gueye	77 917 77 37	Dakar	\N	\N	\N	f	\N
2043	Pharmacie Thiaroye S/Mer	pharmacie-thiaroye-s-mer	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.414	2026-03-02 23:11:15.414	Vente De Produits Pharmaceutiques	Route De Rufisque	33 823 44 68	Dakar	\N	\N	\N	f	\N
2044	Pharmacie Boubakh	pharmacie-boubakh	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.417	2026-03-02 23:11:15.417	Vente De Produits Pharmaceutiques	Avenue Cheikh Ibra Fall - Kaolack	33 835 78 58	Kaolack	\N	\N	\N	f	\N
2045	Pharmacie Gorom Suarl	pharmacie-gorom-suarl-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.42	2026-03-02 23:11:15.42	Vente De Produits Pharmaceutiques	Avenue Jean Jaures	33 941 28 29	Dakar	\N	\N	\N	f	\N
2046	Pharmacie Du Ndiambour - Dr Amadou Sall Ndao	pharmacie-du-ndiambour-dr-amadou-sall-ndao-2	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.424	2026-03-02 23:11:15.424	Vente De Produits Pharmaceutiques	Rue Du Commerce - Louga	33 842 54 64	Louga	\N	\N	\N	f	\N
2047	Pharmacie - Saly (Mme Diouf Amy Ndiaye)	pharmacie-saly-mme-diouf-amy-ndiaye	Vente De Produits Pharmaceutiques Saly Portudal -Station Touristique De Saly 33 95712 05 Saint-Louis Pharmacie Mame Madia Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.427	2026-03-02 23:11:15.427	Vente De Produits Pharmaceutiques Saly Portudal -Station Touristique De Saly 33 95712 05 Saint-Louis Pharmacie Mame Madia Vente De Produits Pharmaceutiques	Avenue General Degaulle	76 520 98 18	Mbour	\N	\N	\N	f	\N
2048	Pharmacie Avicenne - Fatme Nazzal	pharmacie-avicenne-fatme-nazzal	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.429	2026-03-02 23:11:15.429	Vente De Produits Pharmaceutiques	Rue Mousse Diop	33 961 12 72	Dakar	\N	\N	\N	f	\N
2049	Pharmacie Du Guet - Mohamed Ghandour (Ex - Khady Bao)	pharmacie-du-guet-mohamed-ghandour-ex-khady-bao-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.431	2026-03-02 23:11:15.431	Vente De Produits Pharmaceutiques	Rue Huart - Immeuble Faycal	33 823 54 93	Dakar	\N	\N	\N	f	\N
2050	Pharmacie Du Boulevard Du Sud (Amadou Mamadou Alpha Dia)	pharmacie-du-boulevard-du-sud-amadou-mamadou-alpha-dia-2	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.435	2026-03-02 23:11:15.435	Vente De Produits Pharmaceutiques	Boulevard Abdoulaye Mar Diop	33 827 49 34	Saint-Louis	\N	\N	\N	f	\N
2051	Pharmacie Patte D'Oie - Mme Marie Laure Sy Nee Konate	pharmacie-patte-d-oie-mme-marie-laure-sy-nee-konate	Vente De Produits Pharmaceutiques Ancienne	\N	2	2026-03-02 23:11:15.437	2026-03-02 23:11:15.437	Vente De Produits Pharmaceutiques Ancienne	Route Des Niayes - Grand Yoff	33 821 10 64	Dakar	\N	\N	\N	f	\N
2052	Pharmacie Diamalaye	pharmacie-diamalaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.439	2026-03-02 23:11:15.439	Vente De Produits Pharmaceutiques	Route De Rufisque	33 824 34 06	Dakar	\N	\N	\N	f	\N
2053	Pharmacie De L'Emmanuel (Risque Germaine Ch. Sagbo)	pharmacie-de-l-emmanuel-risque-germaine-ch-sagbo-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.442	2026-03-02 23:11:15.442	Vente De Produits Pharmaceutiques	Rue A X Abebe Bikila Grand Dakar	33 834 37 21	Dakar	\N	\N	\N	f	\N
2054	Pharmacie Boisson - Mohamed Farhat	pharmacie-boisson-mohamed-farhat-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.444	2026-03-02 23:11:15.444	Vente De Produits Pharmaceutiques	Rue Parent	33 864 44 03	Dakar	\N	\N	\N	f	\N
2055	Pharmacie Djadine Suarl	pharmacie-djadine-suarl-2	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.448	2026-03-02 23:11:15.448	Vente De Produits Pharmaceutiques	Avenue Sidya Ndatte Yalla - Dagana	33 820 04 16	Dagana	\N	\N	\N	f	\N
2056	Pharmacie Du Centenaire - Magatte Mbaye Fall	pharmacie-du-centenaire-magatte-mbaye-fall-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.45	2026-03-02 23:11:15.45	Vente De Produits Pharmaceutiques	Bd Du General De Gaulle	33 963 11 09	Dakar	\N	\N	\N	f	\N
2057	Pharmacie Du Port	pharmacie-du-port-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.453	2026-03-02 23:11:15.453	Vente De Produits Pharmaceutiques	Bd De L'Arsenal X Bccd - Face Grande Gare	33 822 99 07	Dakar	\N	\N	\N	f	\N
2058	Pharmacie Mame Anta Sy	pharmacie-mame-anta-sy	Vente De Produits Pharmaceutiques Nord Foire Cite Dakar Marine 33820 80 77 Tamba Pharmacie Thiaala (Dr Salif Samba Diallo) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.455	2026-03-02 23:11:15.455	Vente De Produits Pharmaceutiques Nord Foire Cite Dakar Marine 33820 80 77 Tamba Pharmacie Thiaala (Dr Salif Samba Diallo) Vente De Produits Pharmaceutiques	Avenue Leopold S. Senghor - Tambacounda	33 821 83 99	Dakar	\N	\N	\N	f	\N
2059	Pharmacie Ndoucoumane (Moustapha Diop)	pharmacie-ndoucoumane-moustapha-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.457	2026-03-02 23:11:15.457	Vente De Produits Pharmaceutiques	Quartier Escale	33 867 07 01	Kaffrine	\N	\N	\N	f	\N
2060	Pharmacie Du Point E - Dieynaba Diaka Bocoum Soumare	pharmacie-du-point-e-dieynaba-diaka-bocoum-soumare-1	Vente De Produits Pharmaceutiques Point E -	\N	2	2026-03-02 23:11:15.46	2026-03-02 23:11:15.46	Vente De Produits Pharmaceutiques Point E -	Bd De L'Est	33 855 31 90	Dakar	\N	\N	\N	f	\N
2061	Pharmacie Drugstore - Solange Decupper	pharmacie-drugstore-solange-decupper-1	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.463	2026-03-02 23:11:15.463	Vente De Produits Pharmaceutiques	Avenue Georges Pompidou	33 821 56 04	Dakar	\N	\N	\N	f	\N
2062	Pharmacie Centrale - Aliou Camara - Diourbel	pharmacie-centrale-aliou-camara-diourbel-2	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.467	2026-03-02 23:11:15.467	Vente De Produits Pharmaceutiques	Quartier Thierno Kandji, Rue D'Avignon	33 832 40 00	Diourbel	\N	\N	\N	f	\N
2063	Pharmacie Ndeye Ngatou Ba (Mme Sara El Ali Nee Boumoujheid)	pharmacie-ndeye-ngatou-ba-mme-sara-el-ali-nee-boumoujheid	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:15.469	2026-03-02 23:11:15.469	Vente De Produits Pharmaceutiques	Route De Yeumbel - Thiaroye	33 860 24 24	Dakar	\N	\N	\N	f	\N
2064	Pad - Sa (Port Autonome De Dakar)	pad-sa-port-autonome-de-dakar	Services Annexes Et Auxilliaires De Transport	\N	8	2026-03-02 23:11:15.471	2026-03-02 23:11:15.471	Services Annexes Et Auxilliaires De Transport	Bd De La Liberation	33 889 09 20	Dakar	\N	\N	\N	f	\N
2065	Gfl - Sa (Groupe Fauzie Layousse - Ex Ets) Transport -	gfl-sa-groupe-fauzie-layousse-ex-ets-transport-2	Commerce Import/Export	\N	2	2026-03-02 23:11:15.475	2026-03-02 23:11:15.475	Commerce Import/Export	Route De Rufisque	33 820 92 12	Rufisque	\N	\N	\N	f	\N
2066	Dhf - Sa (Daniel Haddad Et Fils) Transport D'Hydrocarbures -	dhf-sa-daniel-haddad-et-fils-transport-d-hydrocarbures	Commerce - Culture Cerealiere	\N	1	2026-03-02 23:11:15.477	2026-03-02 23:11:15.477	Commerce - Culture Cerealiere	Bccd X Rue 2	33 869 40 00	Dakar	\N	\N	\N	f	\N
2067	Sorubatic - Sarl (Societe Rufisquoise Et Bargnoise De Transport D'Industrie Et De	sorubatic-sarl-societe-rufisquoise-et-bargnoise-de-transport-d-industrie-et-de	Commerce - Sarl) Transport Routier	\N	2	2026-03-02 23:11:15.479	2026-03-02 23:11:15.479	Commerce - Sarl) Transport Routier	Avenue Ousmane Soce Diop Prolongee Thiokho	33 849 92 00	Dakar	\N	\N	\N	f	\N
2068	Transat Sarl Prestation De	transat-sarl-prestation-de	Service (Transport)	\N	3	2026-03-02 23:11:15.481	2026-03-02 23:11:15.481	Service (Transport)	Rue Yacine Boubou	33 821 58 23	Thies	\N	\N	\N	f	\N
2069	Stc - Sarl (Ste De Transport Et De	stc-sarl-ste-de-transport-et-de	Commerce) Transports Routiers	\N	2	2026-03-02 23:11:15.483	2026-03-02 23:11:15.483	Commerce) Transports Routiers	Bccd - Rue 2 Prolongee - Zi	33 879 21 43	Dakar	\N	\N	\N	f	\N
2070	Ineo Export Energie	ineo-export-energie-1	Production Et Distribution D'Energie Blvd Djily Mbaye	\N	1	2026-03-02 23:11:15.485	2026-03-02 23:11:15.485	Production Et Distribution D'Energie Blvd Djily Mbaye	Imm Pinet Laprade Dakar Senegal Tours (Ex - Sentranscars) Agence De Voyage Et De Tourisme Place De L'Independance	33 834 74 69	Dakar	\N	\N	\N	f	\N
2071	Postoudiokoul - Sa	postoudiokoul-sa-1	Production D'Electricite P/C De Tiers Et Gestion De Portefeuille	\N	1	2026-03-02 23:11:15.488	2026-03-02 23:11:15.488	Production D'Electricite P/C De Tiers Et Gestion De Portefeuille	Rue Du Phare De Dioukol - Rufisque	33 889 48 48	Rufisque	\N	\N	\N	f	\N
2072	Tacv Sa (Transport Aerien Du Cap-Vert Sa) Transports Aeriens Rue Mousse Diop X Joseph Gomis Dakar	tacv-sa-transport-aerien-du-cap-vert-sa-transports-aeriens-rue-mousse-diop-x-joseph-gomis-dakar	Services) Carenage Bateaux	\N	3	2026-03-02 23:11:15.49	2026-03-02 23:11:15.49	Services) Carenage Bateaux	Bd Felix Eboue Bel-Air	33 820 99 00	Dakar	\N	\N	\N	f	\N
2073	Global Air	global-air	Service Service Fret Zone Fret Aeroport Yoff Dakar Trans-Sene - Sa (Societe De Transit Senegalais) Service De Transit Et Commisionnaire En Douane	\N	3	2026-03-02 23:11:15.492	2026-03-02 23:11:15.492	Service Service Fret Zone Fret Aeroport Yoff Dakar Trans-Sene - Sa (Societe De Transit Senegalais) Service De Transit Et Commisionnaire En Douane	Bd De L'Arsenal - Face Gare Ferroviaire De Dakar	33 832 31 57	Dakar	\N	\N	\N	f	\N
2074	Kab Gueye	kab-gueye-1	Commerce - Transport	\N	2	2026-03-02 23:11:15.495	2026-03-02 23:11:15.495	Commerce - Transport	Rue Mangin X Avenue Blaise Diagne	33 821 13 82	Dakar	\N	\N	\N	f	\N
2075	Logisen	logisen	Services Sa Transit - Transport	\N	3	2026-03-02 23:11:15.497	2026-03-02 23:11:15.497	Services Sa Transit - Transport	Avenue Abdoulaye Fadiga Immeuble Lahad Mbacke	33 822 51 25	Dakar	\N	\N	\N	f	\N
2076	W Ilhelmsen Ships	w-ilhelmsen-ships	Service Senegal Suarl Agence Maritime	\N	3	2026-03-02 23:11:15.499	2026-03-02 23:11:15.499	Service Senegal Suarl Agence Maritime	Immeuble Claiafrique 9 Etage	33 832 04 77	Dakar	\N	\N	\N	f	\N
2077	Ecomar Senegal Sarl	ecomar-senegal-sarl-1	Commerce Place Enceinte Ex Veolia Dakar Semport Entrepots	\N	2	2026-03-02 23:11:15.503	2026-03-02 23:11:15.503	Commerce Place Enceinte Ex Veolia Dakar Semport Entrepots	Route De Rufisque	33 823 91 50	Dakar	\N	\N	\N	f	\N
2078	Diamond Shipping	diamond-shipping	Services Sarl Shipping, Logistics, Transportation, Storage, Fow Arding, Clearing	\N	3	2026-03-02 23:11:15.505	2026-03-02 23:11:15.505	Services Sarl Shipping, Logistics, Transportation, Storage, Fow Arding, Clearing	Rue Jean Mermoz 9 Eme Etage Immeuble Jean Mermoz	33 889 51 91	Dakar	\N	\N	\N	f	\N
2079	Sentransco Sarl Gestion Gare Routiere Et	sentransco-sarl-gestion-gare-routiere-et	Services Connexes Almadies 17	\N	3	2026-03-02 23:11:15.507	2026-03-02 23:11:15.507	Services Connexes Almadies 17	Route De Ngor	33 821 16 91	Dakar	\N	\N	\N	f	\N
2080	Thocomar Shipping Agency & Cie Shipchandler -	thocomar-shipping-agency-cie-shipchandler-1	Commerce Maritme - Avitaillement Navires	\N	2	2026-03-02 23:11:15.509	2026-03-02 23:11:15.509	Commerce Maritme - Avitaillement Navires	Rue Mage X Parchappe	77 546 50 52	Dakar	\N	\N	\N	f	\N
2081	Gt & S Sa (Global Transit &	gt-s-sa-global-transit	Services) Transit Fret	\N	3	2026-03-02 23:11:15.511	2026-03-02 23:11:15.511	Services) Transit Fret	Rue Felix Faure	33 821 06 56	Dakar	\N	\N	\N	f	\N
2082	Emtt (Etablissement Mbaye Transit Et Transport) Transit Et Transport Bld Djily Mbaye Dakar Emc	emtt-etablissement-mbaye-transit-et-transport-transit-et-transport-bld-djily-mbaye-dakar-emc	Commerce General Camberene Croisement X	\N	2	2026-03-02 23:11:15.513	2026-03-02 23:11:15.513	Commerce General Camberene Croisement X	Autoroute	33 859 33 99	Dakar	\N	\N	\N	f	\N
2083	Sts - Sa (Senegal Travel	sts-sa-senegal-travel	Services) Agence De Voyage - Location - Transport Touristique	\N	3	2026-03-02 23:11:15.515	2026-03-02 23:11:15.515	Services) Agence De Voyage - Location - Transport Touristique	Avenue Albert Sarraut	33 835 24 16	Dakar	\N	\N	\N	f	\N
2084	Sen Sicass (Ste Internat. De Contrôle Aeroportuaire & De	sen-sicass-ste-internat-de-controle-aeroportuaire-de	Service De Surete) Contrôle Aeroportuaire/Tourisme/Ag Ence De Voyage Cite Lobatt Fall Tondoup Rya 338203481 Dakar El Hadji	\N	3	2026-03-02 23:11:15.517	2026-03-02 23:11:15.517	Service De Surete) Contrôle Aeroportuaire/Tourisme/Ag Ence De Voyage Cite Lobatt Fall Tondoup Rya 338203481 Dakar El Hadji	Abdoulaye Gueye Transport Public De Voyageurs Thiaroye Sur Mer	33 824 19 22	Dakar	\N	\N	\N	f	\N
2085	Planete Tours Voyages - Sarl Agence De Voyage -	planete-tours-voyages-sarl-agence-de-voyage-1	Vente De Billets D'Avion	\N	2	2026-03-02 23:11:15.519	2026-03-02 23:11:15.519	Vente De Billets D'Avion	Avenue Georges Pompidou - Dakar	33 822 14 16	Dakar	\N	\N	\N	f	\N
2086	Africa Alliance Senegal - Sarl Agence De Voyages & Tourisme -	africa-alliance-senegal-sarl-agence-de-voyages-tourisme	Vente Billets D'Avion	\N	2	2026-03-02 23:11:15.523	2026-03-02 23:11:15.523	Vente Billets D'Avion	Avenue Albert Sarraut	33 823 70 47	Dakar	\N	\N	\N	f	\N
2087	Ideal Transit Sarl	ideal-transit-sarl	Services Annexes Et Auxilliaires De Transport Ave Lamine Gueye X Paul Holle	\N	3	2026-03-02 23:11:15.525	2026-03-02 23:11:15.525	Services Annexes Et Auxilliaires De Transport Ave Lamine Gueye X Paul Holle	Immeuble Touba Darou Salam 6Eme Etage	33 832 75 00	Dakar	\N	\N	\N	f	\N
2088	Ihsen - Sarl (Imex Handling Senegal Colimex) Commissionnaire Transit	ihsen-sarl-imex-handling-senegal-colimex-commissionnaire-transit	(Service Annexe Et Auxilliaire De Transport) Jean Mermoz (Ex 38	\N	3	2026-03-02 23:11:15.527	2026-03-02 23:11:15.527	(Service Annexe Et Auxilliaire De Transport) Jean Mermoz (Ex 38	Rue Assane Ndoye	33 961 51 52	Dakar	\N	\N	\N	f	\N
2089	Colis Malick Sy Trans'Actions Sarl Transport Transit	colis-malick-sy-trans-actions-sarl-transport-transit-1	Commerce	\N	2	2026-03-02 23:11:15.529	2026-03-02 23:11:15.529	Commerce	Rue Marchand X Autoroute Prolongee	33 822 33 33	Dakar	\N	\N	\N	f	\N
2090	Socotra (Ste De Conditionnement De Transformation Et Representation Commerciale)	socotra-ste-de-conditionnement-de-transformation-et-representation-commerciale	Commerce Grand-Dakar Plle N° 549 33821 41 99 Dakar Transport Saikhou Omar Gueye Trnasport Routier Lansar	\N	2	2026-03-02 23:11:15.531	2026-03-02 23:11:15.531	Commerce Grand-Dakar Plle N° 549 33821 41 99 Dakar Transport Saikhou Omar Gueye Trnasport Routier Lansar	Route De Rufisque	33 823 60 34	Dakar	\N	\N	\N	f	\N
2091	Tb Tours Prestation De	tb-tours-prestation-de	Services Place Independance	\N	3	2026-03-02 23:11:15.533	2026-03-02 23:11:15.533	Services Place Independance	Immeuble Sdih 7E Etage	33 823 77 67	Dakar	\N	\N	\N	f	\N
2092	Comasel Sa (Compagnie Marocco Senegalaise D'Electricite)	comasel-sa-compagnie-marocco-senegalaise-d-electricite-1	Production, Transport Et Dietribution D'Electricite Ngallele	\N	1	2026-03-02 23:11:15.536	2026-03-02 23:11:15.536	Production, Transport Et Dietribution D'Electricite Ngallele	Route De L'Ugb	33 868 83 55	Saint-Louis	\N	\N	\N	f	\N
2093	Transit Le Saloum Sa	transit-le-saloum-sa	Services Annexes Et Auxilliaires De Transport - Commisionnaire Agree En Douane	\N	3	2026-03-02 23:11:15.538	2026-03-02 23:11:15.538	Services Annexes Et Auxilliaires De Transport - Commisionnaire Agree En Douane	Bd Djily Mbaye - Residence Al Zahra	33 869 12 15	Dakar	\N	\N	\N	f	\N
2094	Xfs Multifret	xfs-multifret	Services Transit Aerien Et Maritime	\N	3	2026-03-02 23:11:15.542	2026-03-02 23:11:15.542	Services Transit Aerien Et Maritime	Rue Du Docteur Theze	33 842 74 28	Dakar	\N	\N	\N	f	\N
2095	Exim Voyages Sarl	exim-voyages-sarl	Vente De Billet D'Avion	\N	2	2026-03-02 23:11:15.544	2026-03-02 23:11:15.544	Vente De Billet D'Avion	Avenue Lamine Gueye 33823 23 78 Dakar Univers Tours Sarl Tourisme Et Agence De Voyage Rue Mousse Diop X Bd De La Republique	33 832 71 53	Dakar	\N	\N	\N	f	\N
2096	Socapi - Sa Carenage Et Prestations De	socapi-sa-carenage-et-prestations-de	Services	\N	3	2026-03-02 23:11:15.546	2026-03-02 23:11:15.546	Services	Bccd	33 868 34 23	Dakar	\N	\N	\N	f	\N
2097	Dos (Dakar Organisation	dos-dakar-organisation	Services - Sarl) Transit	\N	3	2026-03-02 23:11:15.547	2026-03-02 23:11:15.547	Services - Sarl) Transit	Rue Felix Faure	33 823 42 26	Dakar	\N	\N	\N	f	\N
2098	Transmara Inter (Soule Ndiaye) Transit Rue Tolbiac X Laperine Dakar Dynamic	transmara-inter-soule-ndiaye-transit-rue-tolbiac-x-laperine-dakar-dynamic	Services International Auxilliaires De Transport Fass Batiment	\N	6	2026-03-02 23:11:15.549	2026-03-02 23:11:15.549	Services International Auxilliaires De Transport Fass Batiment	Imm A1 3Éme Etage	77 640 51 05	Dakar	\N	\N	\N	f	\N
2099	Ectc Suarl (Entreprise De Construction De Transport Et De	ectc-suarl-entreprise-de-construction-de-transport-et-de	Commerce - Suarl) Transport Routier De Voyageurs	\N	2	2026-03-02 23:11:15.551	2026-03-02 23:11:15.551	Commerce - Suarl) Transport Routier De Voyageurs	Quartier Deggo Camberene	77 948 06 59	Dakar	\N	\N	\N	f	\N
2100	Ets Rokhaya Fall (Rokhaya Fall) Transport Et	ets-rokhaya-fall-rokhaya-fall-transport-et	Services	\N	3	2026-03-02 23:11:15.553	2026-03-02 23:11:15.553	Services	Avenue Lamine Gueye Dakar Transport Mbaye Fall Mboup Transport Cite Impots Et Domaines	33 823 02 05	Dakar	\N	\N	\N	f	\N
2101	T2Ms (Transport Mbengue	t2ms-transport-mbengue	Multiservices) Transport	\N	3	2026-03-02 23:11:15.555	2026-03-02 23:11:15.555	Multiservices) Transport	Bccd	76 330 90 37	Dakar	\N	\N	\N	f	\N
2102	Iflocs Sarl	iflocs-sarl	Services Annexes Et Auxilliaires De Transport	\N	3	2026-03-02 23:11:15.557	2026-03-02 23:11:15.557	Services Annexes Et Auxilliaires De Transport	Boulevard De La Liberration	30 114 60 62	Dakar	\N	\N	\N	f	\N
2103	Entreprise Activité Adresse Téléphone Mbour Sicosen	entreprise-activite-adresse-telephone-mbour-sicosen	Distribution Sarl Tourisme Et Agences De Voyages	\N	2	2026-03-02 23:11:15.559	2026-03-02 23:11:15.559	Distribution Sarl Tourisme Et Agences De Voyages	Mballing,Route De Joal En Face Case Beaute Mbour Dakar Afrique Logistique Sa Services D'Interimaires Rue Marchand X Tolbiac Immeuble Ndindy	33 952 00 20	Ville	\N	\N	\N	f	\N
2104	Karama Tours Suarl Voyages Et Tourisme Comico Mermoz N°12 Dakar Nitradini (Nianga Transit Dioni	karama-tours-suarl-voyages-et-tourisme-comico-mermoz-n-12-dakar-nitradini-nianga-transit-dioni	Services Annexes Et Auxilliaires De Transport	\N	3	2026-03-02 23:11:15.561	2026-03-02 23:11:15.561	Services Annexes Et Auxilliaires De Transport	Avenue Andre Peytavin	33 825 06 36	Dakar	\N	\N	\N	f	\N
2105	Aye Babacar Diop Transporteur Transport Camberene Deggo Dakar Intermediaire De	aye-babacar-diop-transporteur-transport-camberene-deggo-dakar-intermediaire-de	Services Et De Support En Afrique (Issa Sa) Transports De Passagers Sicap Baobabs	\N	3	2026-03-02 23:11:15.562	2026-03-02 23:11:15.562	Services Et De Support En Afrique (Issa Sa) Transports De Passagers Sicap Baobabs	Rue Goma Villa 734	33 822 72 76	Guediaw	\N	\N	\N	f	\N
2106	Ste Societe De Transit Express Sarl Prestations De	ste-societe-de-transit-express-sarl-prestations-de	Services	\N	3	2026-03-02 23:11:15.564	2026-03-02 23:11:15.564	Services	Rue Malan Immeuble Electra	33 825 37 64	Dakar	\N	\N	\N	f	\N
2107	Inensus W Est Africa Sarl	inensus-w-est-africa-sarl	Production Et Distribution Electricite	\N	1	2026-03-02 23:11:15.566	2026-03-02 23:11:15.566	Production Et Distribution Electricite	Avenue Faidherbe 338 360 316 Dakar Groupe Meissala Sural Location De Voitures Rue Denommee	77 396 16 00	Dakar	\N	\N	\N	f	\N
2108	e Gie Xorom Si International Tourisme - Voyage -	e-gie-xorom-si-international-tourisme-voyage	Commerce	\N	2	2026-03-02 23:11:15.569	2026-03-02 23:11:15.569	Commerce	Quartier Mbelgor - Foundiougne Dakar L'Hydropostale Sarl Transport Par Eau Cite Sagef Ouest Foire	77 713 80 00	Foundiougn	\N	\N	\N	f	\N
2109	Gts (Golden Transit &	gts-golden-transit	Services) Transit Prestations De Services	\N	3	2026-03-02 23:11:15.57	2026-03-02 23:11:15.57	Services) Transit Prestations De Services	Rue Robert Delmas X Masclary	33 842 55 44	Dakar	\N	\N	\N	f	\N
2110	Africa Coastal	africa-coastal	Services Senegal Sa Consignation Manutentation Bld Djily Mbaye X	\N	3	2026-03-02 23:11:15.572	2026-03-02 23:11:15.572	Services Senegal Sa Consignation Manutentation Bld Djily Mbaye X	Rue De Thann Immeuble Xew El 1° Etage	77 143 25 35	Dakar	\N	\N	\N	f	\N
2111	Evt Sarl (Espace Voyages Et Transport) Activites Des Agences De Reservation Et Voyagistes Rue Ramez	evt-sarl-espace-voyages-et-transport-activites-des-agences-de-reservation-et-voyagistes-rue-ramez	Services Sarl Transports Routiers Passagers Sicap	\N	3	2026-03-02 23:11:15.574	2026-03-02 23:11:15.574	Services Sarl Transports Routiers Passagers Sicap	Rue 10 Dara Garage N° 05	33 859 60 58	Dakar	\N	\N	\N	f	\N
2112	Delta Medical - Sarl	delta-medical-sarl-1	Commerce Materiel Medical	\N	2	2026-03-02 23:11:15.577	2026-03-02 23:11:15.577	Commerce Materiel Medical	Rue Mousse Diop (Ex - Blanchot)	33 869 18 18	Dakar	\N	\N	\N	f	\N
2113	Sotelmed Sa	sotelmed-sa	Vente De Materiels Medical & Services Afferents	\N	2	2026-03-02 23:11:15.578	2026-03-02 23:11:15.578	Vente De Materiels Medical & Services Afferents	Rue Jules Ferry	33 853 00 71	Dakar	\N	\N	\N	f	\N
2114	2 As (Afric Assistance &	2-as-afric-assistance	Services Sarl) Assistance Medicale Ngor Lot B	\N	5	2026-03-02 23:11:15.58	2026-03-02 23:11:15.58	Services Sarl) Assistance Medicale Ngor Lot B	Rue 26	33 825 03 08	Dakar	\N	\N	\N	f	\N
2115	Iss-Fop Sarl (Institut Sante	iss-fop-sarl-institut-sante	Services) Formation Professionnelle Paramedicale - Cabinet Et Assistance Medicale - Laboratoire D'Analyse	\N	5	2026-03-02 23:11:15.582	2026-03-02 23:11:15.582	Services) Formation Professionnelle Paramedicale - Cabinet Et Assistance Medicale - Laboratoire D'Analyse	Bd De La Gueule Tapee Prolonge - Rue 45 X 28 Et 30 Près De Snhlm	33 971 15 35	Dakar	\N	\N	\N	f	\N
2116	Medical Partner Suarl	medical-partner-suarl-1	Vente De Materiaux Medicaux	\N	2	2026-03-02 23:11:15.586	2026-03-02 23:11:15.586	Vente De Materiaux Medicaux	Rue Carnot	33 824 02 07	Dakar	\N	\N	\N	f	\N
2117	Medisys Sarl (Medical Systems Sarl)	medisys-sarl-medical-systems-sarl-1	Vente De Materiel Medical Poiint E X	\N	2	2026-03-02 23:11:15.589	2026-03-02 23:11:15.589	Vente De Materiel Medical Poiint E X	Avenue Cheikh Anta Diop	33 824 20 72	Dakar	\N	\N	\N	f	\N
2118	Global Pharma Suarl Importation Et	global-pharma-suarl-importation-et-1	Distribution De Produits Et Equipement De Sante Fenetre Mermoz	\N	2	2026-03-02 23:11:15.592	2026-03-02 23:11:15.592	Distribution De Produits Et Equipement De Sante Fenetre Mermoz	Immeuble Tours	33 879 80 80	Dakar	\N	\N	\N	f	\N
2119	Kima Health Partner	kima-health-partner-1	Vente D'Equipements Produits Dispositifs Accessoires Medicaux	\N	2	2026-03-02 23:11:15.594	2026-03-02 23:11:15.594	Vente D'Equipements Produits Dispositifs Accessoires Medicaux	Rue 03 Mamelles Elevage Ouakam 0 Dakar Ihs (Institut D'Hygiene Social) Activites Pour La Sante Des Hommes Avenue Malick Sy Blaise Diagne 0 Dakar Clinique Fann Hock Sarl Activites Pour La Sante Des Hommes (Clinique Medicale Rue 70 X 55 Fann Hock Dakar	33 821 06 01	Dakar	\N	\N	\N	f	\N
2120	Tropicare W Ca	tropicare-w-ca-1	Vente De Materiel Et Produit Medical	\N	2	2026-03-02 23:11:15.597	2026-03-02 23:11:15.597	Vente De Materiel Et Produit Medical	Rue Hann Mariste Immeuble/O N°3Cite Geographique - Castors	33 824 12 21	Dakar	\N	\N	\N	f	\N
2121	Clinique Du Littoral Sau Prestataire De	clinique-du-littoral-sau-prestataire-de-1	Service Medical Saly Center	\N	5	2026-03-02 23:11:15.6	2026-03-02 23:11:15.6	Service Medical Saly Center	Route De Ngaparou	33 824 84 00	Mbour	\N	\N	\N	f	\N
2122	La Maison Du Medecin	la-maison-du-medecin	Distribution Materiel Medical	\N	2	2026-03-02 23:11:15.604	2026-03-02 23:11:15.604	Distribution Materiel Medical	Rue El Hadji Mbaye Gueye	33 835 33 33	Dakar	\N	\N	\N	f	\N
2123	Img (International Medical Group)	img-international-medical-group	Vente Materiel Medical D'Occasion Et Renove	\N	2	2026-03-02 23:11:15.605	2026-03-02 23:11:15.605	Vente Materiel Medical D'Occasion Et Renove	Route De L'Aeroport Cite Yves Niang N° 21	33 821 68 89	Dakar	\N	\N	\N	f	\N
2124	Kid Suarl	kid-suarl-1	Vente En Gros De Produits Pharmaceutiques Et Medicaux Rte De Ngaparou X Ave Des Milliardaires 0 Ville Entreprise Activité Adresse Téléphone Dakar Clinique Du Plateau Activites Pour La Sante Des Hommes (Clinique Medicale)	\N	2	2026-03-02 23:11:15.611	2026-03-02 23:11:15.611	Vente En Gros De Produits Pharmaceutiques Et Medicaux Rte De Ngaparou X Ave Des Milliardaires 0 Ville Entreprise Activité Adresse Téléphone Dakar Clinique Du Plateau Activites Pour La Sante Des Hommes (Clinique Medicale)	Rue Felix Faure	33 860 41 78	Mbour	\N	\N	\N	f	\N
2322	Societe Commerciale Ndiene Sarl	societe-commerciale-ndiene-sarl-1	Commerce	\N	2	2026-03-02 23:11:16.405	2026-03-02 23:11:16.405	Commerce	Quartier Darou Minam Corniche Ndiouga Kebe - Touba	33 484 09 45	Touba	\N	\N	\N	f	\N
2323	Touba Oil Sa	touba-oil-sa-1	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:16.411	2026-03-02 23:11:16.411	Vente De Produits Petroliers	Boulevard Du Centenaire De La Commune De Dakar 33 8217000 Dakar Amadou Lo (Unite De Stockage De Riz Import) Commerce De Riz Avenue Lamine Gueye	33 824 14 56	Pikine	\N	\N	\N	f	\N
2324	Damag - Sa	damag-sa-1	Commerce Multiple - Super Marche Sahm Av Georges Pompidou -	\N	2	2026-03-02 23:11:16.416	2026-03-02 23:11:16.416	Commerce Multiple - Super Marche Sahm Av Georges Pompidou -	Immeuble City Sport 1 Er Etage (Ex Bd De La Gueule Tapee X Avenue Cheikh Anta Diop	33 821 64 15	Dakar	\N	\N	\N	f	\N
2325	Darou Salam Kebe Et Freres Sarl Autres	darou-salam-kebe-et-freres-sarl-autres-1	Commerces	\N	2	2026-03-02 23:11:16.42	2026-03-02 23:11:16.42	Commerces	Rue Raffenel	33 849 05 05	Dakar	\N	\N	\N	f	\N
2326	Comtrade Sarl Import-Export	comtrade-sarl-import-export-1	Commerce General	\N	2	2026-03-02 23:11:16.424	2026-03-02 23:11:16.424	Commerce General	Avenue Lamine Gueye	33 839 82 82	Dakar	\N	\N	\N	f	\N
2327	Waf Commodities (West Africa Commodities)	waf-commodities-west-africa-commodities-1	Commerce De Produits Agricoles	\N	2	2026-03-02 23:11:16.428	2026-03-02 23:11:16.428	Commerce De Produits Agricoles	Rue Malan Immeuble Electra	33 849 44 43	Dakar	\N	\N	\N	f	\N
2328	Diop	diop-1	Distribution Commerce Derkle	\N	2	2026-03-02 23:11:16.431	2026-03-02 23:11:16.431	Distribution Commerce Derkle	Route De Castors	33 975 73 85	Dakar	\N	\N	\N	f	\N
2329	Etc Commodites Senegal Sarl	etc-commodites-senegal-sarl-1	Commerce General Hann Fort B	\N	2	2026-03-02 23:11:16.436	2026-03-02 23:11:16.436	Commerce General Hann Fort B	Route Des Peres Mariste	77 637 52 62	Dakar	\N	\N	\N	f	\N
2330	Lcs - Sa (Les Cableries Du Senegal) Industrie -	lcs-sa-les-cableries-du-senegal-industrie-1	Fabrication De Cables Electriques - Commerce Import Export	\N	2	2026-03-02 23:11:16.443	2026-03-02 23:11:16.443	Fabrication De Cables Electriques - Commerce Import Export	Bccd X Rue 6	33 832 03 13	Dakar	\N	\N	\N	f	\N
2331	H & D Industrie Sarl	h-d-industrie-sarl	Fabrication De Savons Detergents	\N	7	2026-03-02 23:11:16.446	2026-03-02 23:11:16.446	Fabrication De Savons Detergents	Bccd	33 822 23 23	Dakar	\N	\N	\N	f	\N
2332	Suneor (Ex Sonacos Sa - Ste Nationale De Commercialisation Des Oleagineux)	suneor-ex-sonacos-sa-ste-nationale-de-commercialisation-des-oleagineux	Production Huiles /Tourteaux, Graine Ara:Sesame, Autres Corps Gras	\N	7	2026-03-02 23:11:16.448	2026-03-02 23:11:16.448	Production Huiles /Tourteaux, Graine Ara:Sesame, Autres Corps Gras	Rue Calmette	33 870 01 90	Dakar	\N	\N	\N	f	\N
2333	Diagonal-Sa	diagonal-sa-2	Distribution	\N	2	2026-03-02 23:11:16.453	2026-03-02 23:11:16.453	Distribution	Route De Rufisque	33 839 78 00	Thiaroye	\N	\N	\N	f	\N
2334	Fall	fall-1	Distributions & Services Sarl Vente De Produits Telephoniques	\N	2	2026-03-02 23:11:16.456	2026-03-02 23:11:16.456	Distributions & Services Sarl Vente De Produits Telephoniques	Bd General Degaulle X Rue 43	33 834 05 84	Dakar	\N	\N	\N	f	\N
2335	Station D'Essence Edk (Etablissement Demba Ka)	station-d-essence-edk-etablissement-demba-ka-1	Vente De Produits Petroliers Ouest Foire Face Vdn -	\N	1	2026-03-02 23:11:16.458	2026-03-02 23:11:16.458	Vente De Produits Petroliers Ouest Foire Face Vdn -	Immeuble Anta,Telecoms Residence	33 832 94 94	Dakar	\N	\N	\N	f	\N
2336	Ets Jamil Tarraf & Cie	ets-jamil-tarraf-cie-1	Commerce Alimentaire - Import/Export	\N	2	2026-03-02 23:11:16.462	2026-03-02 23:11:16.462	Commerce Alimentaire - Import/Export	Rue Raffenel	33 889 79 50	Dakar	\N	\N	\N	f	\N
2337	Ericsson Senegal	ericsson-senegal	Services Rendus Principalement Aux Entreprises Almadies	\N	3	2026-03-02 23:11:16.464	2026-03-02 23:11:16.464	Services Rendus Principalement Aux Entreprises Almadies	Route Du Meridien President	33 889 49 49	Dakar	\N	\N	\N	f	\N
2338	Sebo Sa (Senegalaise D'Emballage De Boissons) Embouteillage De Boissons Alcoolisees - Autres	sebo-sa-senegalaise-d-emballage-de-boissons-embouteillage-de-boissons-alcoolisees-autres	Commerce	\N	2	2026-03-02 23:11:16.466	2026-03-02 23:11:16.466	Commerce	Bccd X Rue 6	33 829 30 00	Dakar	\N	\N	\N	f	\N
2339	Oleosen Sa	oleosen-sa-1	Production Et Conditionnement Huile	\N	7	2026-03-02 23:11:16.469	2026-03-02 23:11:16.469	Production Et Conditionnement Huile	Bccd	33 832 49 80	Rufisque	\N	\N	\N	f	\N
2340	W Artsila Nsd W Est Africa Achats -	w-artsila-nsd-w-est-africa-achats-1	Ventes De Groupes Electrogenes Et De Moteurs Diesels	\N	2	2026-03-02 23:11:16.472	2026-03-02 23:11:16.472	Ventes De Groupes Electrogenes Et De Moteurs Diesels	Bccd	33 839 84 84	Dakar	\N	\N	\N	f	\N
2341	Sedad Sarl	sedad-sarl-1	Distribution Engrais, Semences Produits Phytos	\N	2	2026-03-02 23:11:16.475	2026-03-02 23:11:16.475	Distribution Engrais, Semences Produits Phytos	Bccd,Imm Beau Rivage	33 832 10 26	Dakar	\N	\N	\N	f	\N
2342	Siagro Sa (Ste Industrielle Agroalimentaire)	siagro-sa-ste-industrielle-agroalimentaire	Production D'Eau Minerale - De Lait Et De Jus De Fruits	\N	4	2026-03-02 23:11:16.477	2026-03-02 23:11:16.477	Production D'Eau Minerale - De Lait Et De Jus De Fruits	Avenue Malick Sy Immeuble Batimat (Ex Rue Mage X Albert Sarraut)	33 832 46 76	Dakar	\N	\N	\N	f	\N
2343	Saf Industries Senegal - Sa (Savonnerie Africaine Fakhry)	saf-industries-senegal-sa-savonnerie-africaine-fakhry-1	Fabrication De Savons - Autres Commerces	\N	2	2026-03-02 23:11:16.48	2026-03-02 23:11:16.48	Fabrication De Savons - Autres Commerces	Bccd	33 849 56 66	Dakar	\N	\N	\N	f	\N
2344	Mbacke & Freres Surl	mbacke-freres-surl-2	Commerce Produits Alimentaires Et Transport	\N	2	2026-03-02 23:11:16.484	2026-03-02 23:11:16.484	Commerce Produits Alimentaires Et Transport	Route De L'Hopital - Marche Ourossogui	33 941 19 04	Ourossogui	\N	\N	\N	f	\N
2345	Ste Bernabe Senegal	ste-bernabe-senegal-1	Commerce ( Negoce De Materiaux De Construction)	\N	2	2026-03-02 23:11:16.487	2026-03-02 23:11:16.487	Commerce ( Negoce De Materiaux De Construction)	Bccd	33 957 39 39	Dakar	\N	\N	\N	f	\N
2346	Ccd Sarl (Compagnie Commerciale Dia Et Freres)	ccd-sarl-compagnie-commerciale-dia-et-freres-1	Commerce General De Marchandises Diverses	\N	2	2026-03-02 23:11:16.49	2026-03-02 23:11:16.49	Commerce General De Marchandises Diverses	Rue Tolbiac	33 849 01 01	Dakar	\N	\N	\N	f	\N
2347	Sab Sa (Ste Africaine De Bois) Industrie Du Bois -	sab-sa-ste-africaine-de-bois-industrie-du-bois-1	Revente En L'Etat	\N	2	2026-03-02 23:11:16.493	2026-03-02 23:11:16.493	Revente En L'Etat	Bccd	33 823 23 47	Dakar	\N	\N	\N	f	\N
2348	Entreprise Activité Adresse Téléphone Rufisque Comptoir Commercial Maamarah Sarl	entreprise-activite-adresse-telephone-rufisque-comptoir-commercial-maamarah-sarl	Commerce Rufisque	\N	2	2026-03-02 23:11:16.495	2026-03-02 23:11:16.495	Commerce Rufisque	Rue Ousmane Soce Diop N°468	33 832 36 95	Ville	\N	\N	\N	f	\N
2349	Atlas	atlas-1	Distribution Sarl Commerce Import-Export	\N	2	2026-03-02 23:11:16.498	2026-03-02 23:11:16.498	Distribution Sarl Commerce Import-Export	Rue 4 Zone Industrielle	33 836 01 64	Dakar	\N	\N	\N	f	\N
2350	Mka Excellence Sarl	mka-excellence-sarl-1	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:16.501	2026-03-02 23:11:16.501	Vente De Produits Petroliers	Rue Mangin X Avenue Blaise Diagne	33 832 92 10	Dakar	\N	\N	\N	f	\N
2129	Promedicus Engineering Sarl	promedicus-engineering-sarl	Vente D'Equipements Medicaux Reconditionnes	\N	2	2026-03-02 23:11:15.624	2026-03-02 23:11:15.624	Vente D'Equipements Medicaux Reconditionnes	Rue 65 X 78 Mermoz Pyrotechnie Villa N° 46	33 825 26 26	Dakar	\N	\N	\N	f	\N
2130	Pharm Afric Sarl Prestation De	pharm-afric-sarl-prestation-de	Service (Promotion Medicale) Derkle Cite Gazelle 0 Dakar Dr Talal Attye Activites Pour La Sante Des Hommes	\N	1	2026-03-02 23:11:15.626	2026-03-02 23:11:15.626	Service (Promotion Medicale) Derkle Cite Gazelle 0 Dakar Dr Talal Attye Activites Pour La Sante Des Hommes	Rue Jules Ferry	33 951 13 83	Dakar	\N	\N	\N	f	\N
2131	Francis Lezin Boukoulou Activites Pour La Sante Des Hommes	francis-lezin-boukoulou-activites-pour-la-sante-des-hommes	(Service Bucco Dentaire	\N	5	2026-03-02 23:11:15.638	2026-03-02 23:11:15.638	(Service Bucco Dentaire	Rue 108, Sicap Mermoz	33 822 60 92	Dakar	\N	\N	\N	f	\N
2132	Dr Oumou Khairy Ndiaye	dr-oumou-khairy-ndiaye	Service Medical	\N	5	2026-03-02 23:11:15.641	2026-03-02 23:11:15.641	Service Medical	Immeuble Adja Nafi Rond Point Colobane	33 864 13 41	Dakar	\N	\N	\N	f	\N
2133	Dr Moussa Hassan Activites Pour La Sante Des Hommes (Pediatre) Rue Joffre 0 Dakar Cabinet Dentaire	dr-moussa-hassan-activites-pour-la-sante-des-hommes-pediatre-rue-joffre-0-dakar-cabinet-dentaire	(Service Medical Gynecologie	\N	5	2026-03-02 23:11:15.643	2026-03-02 23:11:15.643	(Service Medical Gynecologie	Avenue Blaise Diagne	33 822 05 66	Dakar	\N	\N	\N	f	\N
2134	Moussa Badiane	moussa-badiane	Service Medical Fenetre Mermoz Villa N° 102/A 0 Rufisque Cabinet Dentaire Ya Salam (Dr Oumar Hanne) Activites Pour La Sante Des Hommes ( Chirurgie Dentaire)	\N	5	2026-03-02 23:11:15.646	2026-03-02 23:11:15.646	Service Medical Fenetre Mermoz Villa N° 102/A 0 Rufisque Cabinet Dentaire Ya Salam (Dr Oumar Hanne) Activites Pour La Sante Des Hommes ( Chirurgie Dentaire)	Bd Maurice Gueye X Clinique Rada	33 860 36 22	Dakar	\N	\N	\N	f	\N
2135	Medix Sarl	medix-sarl-1	Commerce De Produits Medicaux	\N	2	2026-03-02 23:11:15.65	2026-03-02 23:11:15.65	Commerce De Produits Medicaux	Rue Jean Mermoz X Pasteur	33 836 00 04	Dakar	\N	\N	\N	f	\N
2136	Souhaibou Ndongo	souhaibou-ndongo	Service Medical Dakar 0 Dakar Cabinet Dr Ali Baddredine Activites Pour La Sante Des Hommes	\N	5	2026-03-02 23:11:15.653	2026-03-02 23:11:15.653	Service Medical Dakar 0 Dakar Cabinet Dr Ali Baddredine Activites Pour La Sante Des Hommes	Avenue Des Diambars	33 821 80 74	Dakar	\N	\N	\N	f	\N
2137	Clinique Medicale	clinique-medicale	Services (Leandre Salvy Martin) Activites Pour La Sante Des Hommes (Clinique)	\N	5	2026-03-02 23:11:15.655	2026-03-02 23:11:15.655	Services (Leandre Salvy Martin) Activites Pour La Sante Des Hommes (Clinique)	Rue Klebert 0 Dakar Blu Senegal Suarl Distribution De Boisson Energisante Mermoz Pyrotechnique	33 821 85 54	Dakar	\N	\N	\N	f	\N
2138	Clinique Dentaire Dr Abdallah Imad Activites Pour La Sante Des Hommes (Chururgie Dentaire) Scat	clinique-dentaire-dr-abdallah-imad-activites-pour-la-sante-des-hommes-chururgie-dentaire-scat	Reproduction Animales (Cabinet Veterinaire) Thille Boubacar En Face Marche	\N	5	2026-03-02 23:11:15.657	2026-03-02 23:11:15.657	Reproduction Animales (Cabinet Veterinaire) Thille Boubacar En Face Marche	Hebdomadaire	77 635 51 51	Dakar	\N	\N	\N	f	\N
2139	Entreprise Activité Adresse Téléphone Dakar Cabinet Fatou Binetou Sene Activites Pour La Sante Des	entreprise-activite-adresse-telephone-dakar-cabinet-fatou-binetou-sene-activites-pour-la-sante-des	(Services Medicaux) Point E	\N	5	2026-03-02 23:11:15.66	2026-03-02 23:11:15.66	(Services Medicaux) Point E	Rue 5 N° 11	33 821 31 15	Ville	\N	\N	\N	f	\N
2140	Alseyni Dansokho Pratique Medicale Et/Ou Dentaire Parcelles Assainies Unite 14 0 Dakar Akonde Noel	alseyni-dansokho-pratique-medicale-et-ou-dentaire-parcelles-assainies-unite-14-0-dakar-akonde-noel	(Services Medical) Fann Point E	\N	5	2026-03-02 23:11:15.663	2026-03-02 23:11:15.663	(Services Medical) Fann Point E	Rue C Amitie X Rue 10 33824 60 34 Dakar Medika Group Sarl Achat Et Vente De Produits Medicaux Zone B Ballon N°26	33 824 88 88	Dakar	\N	\N	\N	f	\N
2141	Cabinet Dentaire Salthia Activites Pour La Sante Des Hommes	cabinet-dentaire-salthia-activites-pour-la-sante-des-hommes	(Service Medical Clinique Dentaire Et Autres Services Sante Ouakam	\N	5	2026-03-02 23:11:15.665	2026-03-02 23:11:15.665	(Service Medical Clinique Dentaire Et Autres Services Sante Ouakam	Quartier Sinthie	77 639 51 40	Dakar	\N	\N	\N	f	\N
2142	Mme Madeleine Fall	mme-madeleine-fall	Service Medical Sicap Liberte 6 N° 658 0 Dakar Aliou Niang Activites Pour La Sante Des Hommes( Consultance Medecine) Cite Fadia - Guentaba 0 Dakar Cabinet Medical Naby Activites Pour La Sante Des Hommes (Cabinet Medical)	\N	5	2026-03-02 23:11:15.668	2026-03-02 23:11:15.668	Service Medical Sicap Liberte 6 N° 658 0 Dakar Aliou Niang Activites Pour La Sante Des Hommes( Consultance Medecine) Cite Fadia - Guentaba 0 Dakar Cabinet Medical Naby Activites Pour La Sante Des Hommes (Cabinet Medical)	Avenue Blaise Diagne X Rue 13 Medina Imm	77 638 97 83	Dakar	\N	\N	\N	f	\N
2143	Elhadji Oumar Ndoye Activites Pour La Sante Des Hommes	elhadji-oumar-ndoye-activites-pour-la-sante-des-hommes	(Service Medical) Sicap Liberte4 Villa N°5235 0 Dakar Sada Diallo Activites Pour La Sante Sante Des Hommes (Consultance En Analyses Biologiques) Cite Shs N° 161 Golf Nord 0 Dakar Dr Ababacar W Ilane Activites Pour La Sante Des Hommes (Psychiatre)	\N	5	2026-03-02 23:11:15.671	2026-03-02 23:11:15.671	(Service Medical) Sicap Liberte4 Villa N°5235 0 Dakar Sada Diallo Activites Pour La Sante Sante Des Hommes (Consultance En Analyses Biologiques) Cite Shs N° 161 Golf Nord 0 Dakar Dr Ababacar W Ilane Activites Pour La Sante Des Hommes (Psychiatre)	Rue Carnot 0 Dakar Fadoua El Argoubi Chirara Activites Pour La Sante Des Hommes (Kinesitherape Clinique Du Cap	77 647 49 99	Dakar	\N	\N	\N	f	\N
2144	Snhlm - Sa Mixte (Ste Nationale Des Habitations A Loyer Moderes)	snhlm-sa-mixte-ste-nationale-des-habitations-a-loyer-moderes	Service	\N	3	2026-03-02 23:11:15.674	2026-03-02 23:11:15.674	Service	Immobilier Du Logement Colobane - Rue 34	33 849 56 99	Dakar	\N	\N	\N	f	\N
2145	Sicap - Sa Mixte (Societe Immobiliere Du Cap Vert)	sicap-sa-mixte-societe-immobiliere-du-cap-vert	Service	\N	3	2026-03-02 23:11:15.676	2026-03-02 23:11:15.676	Service	Immobilier Du Logement Place De L'Unite Africaine - Jet D'Eau	33 889 60 00	Dakar	\N	\N	\N	f	\N
2146	Kkb (Holding Keur Khadim) Bpt -	kkb-holding-keur-khadim-bpt-1	Commerce General - Boulangerie - Mareyeur Pëche - Transport - Gestion	\N	2	2026-03-02 23:11:15.68	2026-03-02 23:11:15.68	Commerce General - Boulangerie - Mareyeur Pëche - Transport - Gestion	Immobiliere Bccd X Rue 3	33 869 37 30	Dakar	\N	\N	\N	f	\N
2147	Mixta Senegal Sa	mixta-senegal-sa	Service	\N	3	2026-03-02 23:11:15.682	2026-03-02 23:11:15.682	Service	Immobilier Rue De Diourbel X Rond Point De L'Ellipse Point E Dakar	77 638 92 45	Dakar	\N	\N	\N	f	\N
2148	Import Export Transactions Immobilieres Kss	import-export-transactions-immobilieres-kss-1	Commerce - Transactions	\N	2	2026-03-02 23:11:15.686	2026-03-02 23:11:15.686	Commerce - Transactions	Immobilieres Yoff - Route De L'Aeroport Cite Lobatt Fall Villa N° 28	33 820 05 01	Dakar	\N	\N	\N	f	\N
2149	Sitcom (Societe Immobiliere De Transport Et De	sitcom-societe-immobiliere-de-transport-et-de-1	Commerce) Transactions	\N	2	2026-03-02 23:11:15.689	2026-03-02 23:11:15.689	Commerce) Transactions	Immobiliere - Commerce - Services Bccd - Rue 2 Prolongee	77 405 09 09	Dakar	\N	\N	\N	f	\N
2150	Spi Sarl (Senegalaise De Promotion Immobiliere Sarl)	spi-sarl-senegalaise-de-promotion-immobiliere-sarl	Service	\N	3	2026-03-02 23:11:15.692	2026-03-02 23:11:15.692	Service	Immobilier Almadies, Route De Ngor, Zone 12 - En Face Station Shell	33 832 39 05	Dakar	\N	\N	\N	f	\N
2151	Regus Senegal Sarl Autres	regus-senegal-sarl-autres	Services	\N	3	2026-03-02 23:11:15.695	2026-03-02 23:11:15.695	Services	Immobiliers Boulevad Djily Mbaye	33 822 87 53	Dakar	\N	\N	\N	f	\N
2152	Le Domaine De Capparis Sarl Autres Activite Immobilieres Saly 0 Dakar Sidak Sarl	le-domaine-de-capparis-sarl-autres-activite-immobilieres-saly-0-dakar-sidak-sarl	Service	\N	3	2026-03-02 23:11:15.698	2026-03-02 23:11:15.698	Service	Immobilier Rue 3 X A Point E Residence Katy	33 821 61 75	Mbour	\N	\N	\N	f	\N
2153	Corfitex Trading Limited Senegal Autres	corfitex-trading-limited-senegal-autres	Services	\N	3	2026-03-02 23:11:15.7	2026-03-02 23:11:15.7	Services	Immobiliers Central Park, Avenue Malick Sy X Autoroute	33 839 59 27	Dakar	\N	\N	\N	f	\N
2154	Epi Sa (Etudes Placements Investissements) Autres	epi-sa-etudes-placements-investissements-autres	Services	\N	3	2026-03-02 23:11:15.703	2026-03-02 23:11:15.703	Services	Immobiliers Rue Des Ecrivains X Bld De L'Est - Point E	33 842 05 80	Dakar	\N	\N	\N	f	\N
2155	Cabinet Massamba Seck	cabinet-massamba-seck	Services	\N	3	2026-03-02 23:11:15.706	2026-03-02 23:11:15.706	Services	Immobiliers / Consultance Sonepi N° 71-B 2ème Etage	33 821 28 99	Dakar	\N	\N	\N	f	\N
2156	Sci Maïdia Autres	sci-maidia-autres	Services	\N	3	2026-03-02 23:11:15.709	2026-03-02 23:11:15.709	Services	Immobiliers Rue Felix Faure	33 991 48 19	Dakar	\N	\N	\N	f	\N
2157	Sci Basse Et Cie Autres	sci-basse-et-cie-autres	Services	\N	3	2026-03-02 23:11:15.712	2026-03-02 23:11:15.712	Services	Immobiliers Avenue Nelson Mandela X Joseph Gomis 0 Ville Entreprise Activité Adresse Téléphone Dakar Sipros (Societe D'Immobilier Professionnel Sarl) Activite Immobiliere 14, Bld Djily Mbaye Mmeuble Pinet Laprade	33 832 49 89	Dakar	\N	\N	\N	f	\N
2158	Sci Le Tamaris Autres	sci-le-tamaris-autres	Services	\N	3	2026-03-02 23:11:15.715	2026-03-02 23:11:15.715	Services	Immobiliers Rue Dr Thez X Galandou Diouf Centre Ville 0 Dakar Sci Hassan Hachem Et Fils Service Immobilier Rue Abdou Karim Bourgi	33 820 03 85	Dakar	\N	\N	\N	f	\N
2159	Sgs (Societe Generale De	sgs-societe-generale-de	Services Sarl) Activites	\N	3	2026-03-02 23:11:15.718	2026-03-02 23:11:15.718	Services Sarl) Activites	Immobilieres Pikine Sefa Plle N° 13	33 861 60 00	Pikine	\N	\N	\N	f	\N
2160	Good Rade Immo - Sarl	good-rade-immo-sarl	Service	\N	3	2026-03-02 23:11:15.721	2026-03-02 23:11:15.721	Service	Immobilier Vdn Mermoz Lot N°3	33 825 60 62	Dakar	\N	\N	\N	f	\N
2161	Sci Ibrahima Khalaf Et Freres Autres Activite Immobilieres Rue Madeleine Ngom 0 Dakar Contact	sci-ibrahima-khalaf-et-freres-autres-activite-immobilieres-rue-madeleine-ngom-0-dakar-contact	Services (Aminata Sarr Niang) Activites	\N	3	2026-03-02 23:11:15.724	2026-03-02 23:11:15.724	Services (Aminata Sarr Niang) Activites	Immobilieres Rue 23 X 10 Medina	33 849 57 57	Dakar	\N	\N	\N	f	\N
2162	W Adene D'Ouvrages & De	w-adene-d-ouvrages-de-1	Commerce Sarl	\N	2	2026-03-02 23:11:15.729	2026-03-02 23:11:15.729	Commerce Sarl	Immobilier-Commerce Nguehokh	33 820 71 21	Mbour	\N	\N	\N	f	\N
2163	Vivi Design Sarl	vivi-design-sarl	Services	\N	3	2026-03-02 23:11:15.732	2026-03-02 23:11:15.732	Services	Immobiliers Et Affaires Immobilieres Sipres 04 Yoff Route De L'Aeroport	33 849 01 06	Dakar	\N	\N	\N	f	\N
2164	Sci Educinvest - Societe Civile Immobilere Educinvest Societe Immobliere Rue X Boulevard Du Sud -	sci-educinvest-societe-civile-immobilere-educinvest-societe-immobliere-rue-x-boulevard-du-sud	Vente Et Location	\N	2	2026-03-02 23:11:15.734	2026-03-02 23:11:15.734	Vente Et Location	Immeuble Saphir Mermoz Route De Ouakam	33 824 48 49	Dakar	\N	\N	\N	f	\N
2165	W Aounde	w-aounde	Services Sarl Gestion	\N	3	2026-03-02 23:11:15.736	2026-03-02 23:11:15.736	Services Sarl Gestion	Immobiliere Usine Bene Taly	33 827 62 38	Dakar	\N	\N	\N	f	\N
2166	Co.Si.Dex. Sa (Compagnie Senegalaise Pour La	co-si-dex-sa-compagnie-senegalaise-pour-la	Distribution & L'Import - Export - Sa) Gestion De Biens	\N	2	2026-03-02 23:11:15.74	2026-03-02 23:11:15.74	Distribution & L'Import - Export - Sa) Gestion De Biens	Immobiliers Rue Vincens 0 Dakar Cegepi (Cheikh Latyr Diack) Expertise Immobiliere Point E Bd Du Sud N° 5	77 638 31 92	Dakar	\N	\N	\N	f	\N
2167	Sogicom (Societe De Gestion Immobiliere Et De	sogicom-societe-de-gestion-immobiliere-et-de-1	Commerce) Commerce - Transactions	\N	2	2026-03-02 23:11:15.743	2026-03-02 23:11:15.743	Commerce) Commerce - Transactions	Immobilieres Point E - Rue 3 Bis X F	33 822 60 94	Dakar	\N	\N	\N	f	\N
2168	Societe Civile Immobiliere Real Immo Autre	societe-civile-immobiliere-real-immo-autre	Service	\N	3	2026-03-02 23:11:15.745	2026-03-02 23:11:15.745	Service	Immobiliers Boulevard Djily Mbaye Imm Pinet Laprade Dakar- Plateau 0 Dakar Foncia Senegal Sa Agence Immobiliere Rue Mbaye Gueye Ex Sandiniery	33 821 59 28	Dakar	\N	\N	\N	f	\N
2169	Ab Immobilier Et	ab-immobilier-et	Services Sarl Gestion	\N	3	2026-03-02 23:11:15.747	2026-03-02 23:11:15.747	Services Sarl Gestion	Immobiliere Sicap Amitie Ii Appartement C 1Er Etage	33 889 63 63	Dakar	\N	\N	\N	f	\N
2170	Sci Les Lodges De L'Afrique De L'Ouest Societe Civile Immobiliere Village De Palmarin 0 Dakar Gie	sci-les-lodges-de-l-afrique-de-l-ouest-societe-civile-immobiliere-village-de-palmarin-0-dakar-gie	Services Vente De Materiels	\N	2	2026-03-02 23:11:15.749	2026-03-02 23:11:15.749	Services Vente De Materiels	Immobiliers Route Du Front De Terre	33 823 10 66	Fatick	\N	\N	\N	f	\N
2171	Sai Le Phoenix - Sa (Ste Anonyle Immobiliere Le Phoenix) Autres	sai-le-phoenix-sa-ste-anonyle-immobiliere-le-phoenix-autres	Services	\N	3	2026-03-02 23:11:15.752	2026-03-02 23:11:15.752	Services	Immobilieres Bccd X Rue 5 Z.I	33 821 97 49	Dakar	\N	\N	\N	f	\N
2172	Almamy	almamy	Services Suarl Locations De Biens	\N	3	2026-03-02 23:11:15.755	2026-03-02 23:11:15.755	Services Suarl Locations De Biens	Immobiliers - Tele Services Keur Massar	33 835 09 20	Dakar	\N	\N	\N	f	\N
2173	Societe Civile Immobiliere Al Jamami Achat	societe-civile-immobiliere-al-jamami-achat	Vente Et Location	\N	2	2026-03-02 23:11:15.757	2026-03-02 23:11:15.757	Vente Et Location	Immobilier Rue Raffenel	33 957 55 56	Dakar	\N	\N	\N	f	\N
2174	Paradis Immobiler Immobilier Scat Urbam Mariste 2 Lot 0 40 0 Dakar Gie Immobilier	paradis-immobiler-immobilier-scat-urbam-mariste-2-lot-0-40-0-dakar-gie-immobilier	Services Agence	\N	9	2026-03-02 23:11:15.76	2026-03-02 23:11:15.76	Services Agence	Immobiliere Cite Millionnaire 0 Dakar Taissir Immobiliere Et Services Suarl Gestion Immobiliere Cite Douane, Immeuble C Appt N°5 1 Er Stage, Colobane	77 637 37 39	Dakar	\N	\N	\N	f	\N
2175	Sci Alpha Babou Autres Activites Immobilieres Boulevard General Degaulle 0 Mbour Sepromi Sarl	sci-alpha-babou-autres-activites-immobilieres-boulevard-general-degaulle-0-mbour-sepromi-sarl	Services	\N	3	2026-03-02 23:11:15.763	2026-03-02 23:11:15.763	Services	Immobiliers Residence Popenguine Lot N° 92 Saly	33 822 97 82	Dakar	\N	\N	\N	f	\N
2176	Senimo (Societe Senegalaise De L'Immobilier)	senimo-societe-senegalaise-de-l-immobilier	Services	\N	3	2026-03-02 23:11:15.765	2026-03-02 23:11:15.765	Services	Immobiliers Ouest Foire Cite Sagef Villa N° 48	33 824 24 00	Dakar	\N	\N	\N	f	\N
2177	Aye Sisco Suarl (Societe Intercontinentale De	aye-sisco-suarl-societe-intercontinentale-de	Services De Commerce Et De Cons) Agence	\N	2	2026-03-02 23:11:15.769	2026-03-02 23:11:15.769	Services De Commerce Et De Cons) Agence	Immobiliere Et Prestation De Services Parcelles Assainies Unite 2 N°219	33 827 17 11	Guediaw	\N	\N	\N	f	\N
2178	A2I@ Suarl Agence Immobiliere Almdies Route De L'Aeroport 0 Mbour Sci Du Petit Lapin	a2i-suarl-agence-immobiliere-almdies-route-de-l-aeroport-0-mbour-sci-du-petit-lapin	Services	\N	3	2026-03-02 23:11:15.772	2026-03-02 23:11:15.772	Services	Immobiliers Route Centrale Somone	33 867 92 22	Dakar	\N	\N	\N	f	\N
2179	Kane Fiabilite Suarl Autres Activite Immobilieres Rue Cite Aelmas Ouest Foire 774387463 Dakar	kane-fiabilite-suarl-autres-activite-immobilieres-rue-cite-aelmas-ouest-foire-774387463-dakar	Services Express Tab (Agence Varela) Services	\N	3	2026-03-02 23:11:15.775	2026-03-02 23:11:15.775	Services Express Tab (Agence Varela) Services	Immobiliers Parcelles Assainies Unite 21 N ° 351	33 957 74 40	Dakar	\N	\N	\N	f	\N
2180	Infrastech Immo Suarl	infrastech-immo-suarl	Services	\N	3	2026-03-02 23:11:15.778	2026-03-02 23:11:15.778	Services	Immobiliers Ngor Virage, Route De L'Aeroport	77 638 83 30	Dakar	\N	\N	\N	f	\N
2181	Scp Tw Eede Activites Immobilieres Rue Colbert X Felix Faure 0 Dakar Karama (Catherine Sabbagh)	scp-tw-eede-activites-immobilieres-rue-colbert-x-felix-faure-0-dakar-karama-catherine-sabbagh	Service	\N	3	2026-03-02 23:11:15.781	2026-03-02 23:11:15.781	Service	Immobilier Rue Felix Eboue 0 Dakar Exas - Residence Vanessa & Annexes Sarl Activites Immobilieres Rue Joffre	33 877 36 08	Dakar	\N	\N	\N	f	\N
2182	Djibril Sakho Immobilier - Sarl	djibril-sakho-immobilier-sarl	Services	\N	3	2026-03-02 23:11:15.784	2026-03-02 23:11:15.784	Services	Immobilier Rue 22 X 27 Medina	33 889 24 24	Dakar	\N	\N	\N	f	\N
2183	Sci Happy Center	sci-happy-center-1	Services	\N	3	2026-03-02 23:11:15.788	2026-03-02 23:11:15.788	Services	Immobiliers Route De Saly Face Elton Mbour	33 957 06 43	Mbour	\N	\N	\N	f	\N
2184	Alicia Global Business	alicia-global-business	Services Suarl Locations De Biens	\N	7	2026-03-02 23:11:15.791	2026-03-02 23:11:15.791	Services Suarl Locations De Biens	Immobiliers Rue Non Denommee Gueule Tapee Fass Colobane	77 639 18 74	Dakar	\N	\N	\N	f	\N
2185	Allo Immo -Sarl	allo-immo-sarl-1	Service	\N	3	2026-03-02 23:11:15.795	2026-03-02 23:11:15.795	Service	Immobilier Route De Ngaparou Saly Centre	33 855 98 83	Mbour	\N	\N	\N	f	\N
2186	Sci Les Baobabs De Ngaparou Immobilier Ngaparou Plage 0 Dakar Luxgroup Sarl Prestation De	sci-les-baobabs-de-ngaparou-immobilier-ngaparou-plage-0-dakar-luxgroup-sarl-prestation-de	Services	\N	3	2026-03-02 23:11:15.797	2026-03-02 23:11:15.797	Services	Immobiliers Espace Ouakam 0 Dakar Etude Balla Dial Expertise Immobiliere Rue Joseph Gomis X Victor Hugo	33 957 51 83	Mbour	\N	\N	\N	f	\N
2187	Aman Company Suarl Agence Immobiliere Zone De Captage Front De Terre 0 Dakar Al Amine	aman-company-suarl-agence-immobiliere-zone-de-captage-front-de-terre-0-dakar-al-amine	Services Gestion	\N	3	2026-03-02 23:11:15.8	2026-03-02 23:11:15.8	Services Gestion	Immobiliere Ouagou Niayes I Volla N° 2791	33 823 73 08	Dakar	\N	\N	\N	f	\N
2188	Immobiliere	immobiliere	Services Express (Hassane Diaite) Activites	\N	3	2026-03-02 23:11:15.803	2026-03-02 23:11:15.803	Services Express (Hassane Diaite) Activites	Immobilieres Parcelles Assainies Unite 2 N° 291	33 867 59 28	Dakar	\N	\N	\N	f	\N
2189	Societe Civile Immobiliere Emeraude	societe-civile-immobiliere-emeraude	Service	\N	3	2026-03-02 23:11:15.805	2026-03-02 23:11:15.805	Service	Immobilier Place De L'Onu	33 825 57 43	Dakar	\N	\N	\N	f	\N
2190	Sin (Societe Immobiliere Niang Cheikh)	sin-societe-immobiliere-niang-cheikh	Service De Gerance	\N	3	2026-03-02 23:11:15.807	2026-03-02 23:11:15.807	Service De Gerance	Immobiliere Ouest Foire Route De L'Aeroport Lot N° 21	33 825 34 34	Dakar	\N	\N	\N	f	\N
2191	Immobiliere	immobiliere-1	Services Express Suarl	\N	3	2026-03-02 23:11:15.811	2026-03-02 23:11:15.811	Services Express Suarl	Immobilier Parcelles Assainies Unite 02 Villa 291	33 834 08 89	Dakar	\N	\N	\N	f	\N
2192	Gie Khadim Rassoul Immobilier Location &	gie-khadim-rassoul-immobilier-location-1	Vente	\N	2	2026-03-02 23:11:15.815	2026-03-02 23:11:15.815	Vente	Immobiliers Plles Assainies U22 N°247 0 Dakar Gie Tdm (Gie Touba Darou Manane Immobilier) Location De Biens Immobiliers Rue 6 X 1 Medinan, Immeuble Adja Aminata Diop	33 827 21 17	Dakar	\N	\N	\N	f	\N
2193	Look Immo M ( Meurville Marie Rose Anne Lucienne) Gestion Immobiliere Somone 0 Guediaw Aye Sm2I	look-immo-m-meurville-marie-rose-anne-lucienne-gestion-immobiliere-somone-0-guediaw-aye-sm2i	Services	\N	3	2026-03-02 23:11:15.818	2026-03-02 23:11:15.818	Services	Immobiliers Sodida Lot N°27 0 Dakar Citgim (Amadou Bator Samb) Location De Biens Immobiliers Rue Mass Diokhane	33 855 97 77	Mbour	\N	\N	\N	f	\N
2194	Agence Toure Immobilier Location,	agence-toure-immobilier-location	Vente De Biens	\N	2	2026-03-02 23:11:15.82	2026-03-02 23:11:15.82	Vente De Biens	Immobiliers 179 Cite Millionnaire Grand Yoff	33 961 64 00	Dakar	\N	\N	\N	f	\N
2195	Socobat Sarl (Societe De	socobat-sarl-societe-de	Commerce De Batiment - Sarl) Service	\N	2	2026-03-02 23:11:15.823	2026-03-02 23:11:15.823	Commerce De Batiment - Sarl) Service	Immobilier Hlm Grand Yoff	77 554 70 36	Dakar	\N	\N	\N	f	\N
2196	Entreprise Activité Adresse Téléphone Dakar Sci Diagnenar Autres	entreprise-activite-adresse-telephone-dakar-sci-diagnenar-autres	Services	\N	3	2026-03-02 23:11:15.826	2026-03-02 23:11:15.826	Services	Immobilieres Rue De Thiong	33 821 09 26	Ville	\N	\N	\N	f	\N
2197	Sw Eet Senegal Sarl	sw-eet-senegal-sarl-1	Services	\N	3	2026-03-02 23:11:15.829	2026-03-02 23:11:15.829	Services	Immobilers Saly Portudal 0 Dakar Sakho Immobilier Agence Immobiliere Rue 11 X 16 Medina	77 636 75 32	Mbour	\N	\N	\N	f	\N
2198	Oumou Informatique	oumou-informatique-1	Service Commerce Articles Informatiques Et Bureautiques	\N	2	2026-03-02 23:11:15.833	2026-03-02 23:11:15.833	Service Commerce Articles Informatiques Et Bureautiques	Avenue Blaise Diagne Face Douta Seck	33 855 94 95	Dakar	\N	\N	\N	f	\N
2199	Brightpoint Senegal	brightpoint-senegal-1	Vente Et Distribution De Materiel Informatique	\N	2	2026-03-02 23:11:15.839	2026-03-02 23:11:15.839	Vente Et Distribution De Materiel Informatique	Boulevard Djily Mbaye Immeuble Azur 15	33 823 62 81	Dakar	\N	\N	\N	f	\N
2200	Bull Senegal - Sarl	bull-senegal-sarl-1	Services Informatiques - Maintenance - Vente Materiels Informatiques - Services Divers	\N	2	2026-03-02 23:11:15.843	2026-03-02 23:11:15.843	Services Informatiques - Maintenance - Vente Materiels Informatiques - Services Divers	Avenue Andre Peytavin	33 849 05 00	Dakar	\N	\N	\N	f	\N
2201	Burotic Diffusion - Sarl Autres	burotic-diffusion-sarl-autres-1	Commerces - Ventes Materiel Informatique - Reparations	\N	2	2026-03-02 23:11:15.847	2026-03-02 23:11:15.847	Commerces - Ventes Materiel Informatique - Reparations	Avenue Albert Sarraut	33 849 69 99	Dakar	\N	\N	\N	f	\N
2202	Cencom Suarl	cencom-suarl	Services Informatiques Felix Faure	\N	3	2026-03-02 23:11:15.85	2026-03-02 23:11:15.85	Services Informatiques Felix Faure	Avenue Leopold Sedar Senghor	33 821 25 27	Dakar	\N	\N	\N	f	\N
2203	Computer Land	computer-land	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:15.852	2026-03-02 23:11:15.852	Vente De Materiels Informatiques	Avenue Andre Peytavin	33 820 81 77	Dakar	\N	\N	\N	f	\N
2204	Platform Technologies Sa	platform-technologies-sa	Commerce Materiel Informatique - Maintenance Materiel Informatique Sicap Amitie 1 X Av. Bourguiba Villa N° 3086 33 869 0140 Dakar Pico Mega - Fatou Seck Vente De Materiel Et Consommables Informatiques	\N	2	2026-03-02 23:11:15.855	2026-03-02 23:11:15.855	Commerce Materiel Informatique - Maintenance Materiel Informatique Sicap Amitie 1 X Av. Bourguiba Villa N° 3086 33 869 0140 Dakar Pico Mega - Fatou Seck Vente De Materiel Et Consommables Informatiques	Avenue Blaise Diagne En Face Centre Culturel Douta Seck 0 Dakar Abm Technogies Informatiques Et Telecomunications Residence Teranga Mermoz Pyrotechnique - Villa N° A7	33 889 90 50	Dakar	\N	\N	\N	f	\N
2205	Equant Senegal Sau (Ex Equant Integrations	equant-senegal-sau-ex-equant-integrations	Services (Ex - Its Senegal)) Activites Informatiques	\N	3	2026-03-02 23:11:15.857	2026-03-02 23:11:15.857	Services (Ex - Its Senegal)) Activites Informatiques	Rue Carnot X Berenger Ferraud	33 860 67 60	Dakar	\N	\N	\N	f	\N
2206	Tcs Sarl (Technologie Consulting	tcs-sarl-technologie-consulting-1	Services - Sarl) Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:15.86	2026-03-02 23:11:15.86	Services - Sarl) Vente De Materiels Informatiques	Rue El H. Mbaye Gueye X Vincens	33 869 86 86	Dakar	\N	\N	\N	f	\N
2207	Staburo Sarl	staburo-sarl-1	Commerce Materiel Bureautique	\N	2	2026-03-02 23:11:15.864	2026-03-02 23:11:15.864	Commerce Materiel Bureautique	Rue Abdou Karim Bourgi En Face Papex	33 823 64 80	Dakar	\N	\N	\N	f	\N
2208	Ms Suarl (Micro Solutions Suarl)	ms-suarl-micro-solutions-suarl-1	Vente Et Services Informatiques	\N	2	2026-03-02 23:11:15.873	2026-03-02 23:11:15.873	Vente Et Services Informatiques	Rue W Agane Diouf	33 827 27 57	Dakar	\N	\N	\N	f	\N
2209	Sesa Technilogies Sarl	sesa-technilogies-sarl-1	Commerce De Materiels Informatiques	\N	2	2026-03-02 23:11:15.881	2026-03-02 23:11:15.881	Commerce De Materiels Informatiques	Avenue Cheickh Anta Diop Sicap Mermoz Face Credit Lionais	33 889 64 64	Dakar	\N	\N	\N	f	\N
2210	Repro-Systems Prestation De	repro-systems-prestation-de	Services Et Importateur De Materiels Informatiques	\N	2	2026-03-02 23:11:15.886	2026-03-02 23:11:15.886	Services Et Importateur De Materiels Informatiques	Avenue Lamine Gueye	33 864 70 89	Dakar	\N	\N	\N	f	\N
2211	Ftf (Full Technologies Formations)	ftf-full-technologies-formations-1	Services Informatiques (Vente De Logiciels) Fan Mermoz Fn08 X Cheikh Anta	\N	2	2026-03-02 23:11:15.932	2026-03-02 23:11:15.932	Services Informatiques (Vente De Logiciels) Fan Mermoz Fn08 X Cheikh Anta	Diop(Rue Mousse Diop - Immeuble Bits	33 827 31 45	Dakar	\N	\N	\N	f	\N
2212	Hiperdist Senegal (High Performance	hiperdist-senegal-high-performance-1	Distribution Senegal) Vente De Materiels Informatiques Point E	\N	2	2026-03-02 23:11:15.94	2026-03-02 23:11:15.94	Distribution Senegal) Vente De Materiels Informatiques Point E	Rue 3 X Bd Du Sud	33 864 27 27	Dakar	\N	\N	\N	f	\N
2213	Africanet - Sarl Realisations - Exploitation De	africanet-sarl-realisations-exploitation-de	Services Informatiques Sacre Cœur 1 Villa N° 8333 0 Dakar Compudist Senegal Commerce Materiel Informatique	\N	2	2026-03-02 23:11:15.945	2026-03-02 23:11:15.945	Services Informatiques Sacre Cœur 1 Villa N° 8333 0 Dakar Compudist Senegal Commerce Materiel Informatique	Rue A X Av. Cheikh Anta Diop (Impasse Face Mobil Point E)	30 118 68 80	Dakar	\N	\N	\N	f	\N
2214	Contechs Suarl (Convergence Technologique Senegal - Suarl)	contechs-suarl-convergence-technologique-senegal-suarl-1	Vente Materiels Informatiques-Services Informatiques Et Bureautique	\N	2	2026-03-02 23:11:15.954	2026-03-02 23:11:15.954	Vente Materiels Informatiques-Services Informatiques Et Bureautique	Quartier Notaire	33 869 11 80	Dakar	\N	\N	\N	f	\N
2215	Satech Sarl (Societe Africaine De Technologie)	satech-sarl-societe-africaine-de-technologie	Services Informatiques	\N	9	2026-03-02 23:11:15.959	2026-03-02 23:11:15.959	Services Informatiques	Bd General Degaulle	33 860 25 26	Dakar	\N	\N	\N	f	\N
2216	Mci (Materiels Et Consommables Informatiques	mci-materiels-et-consommables-informatiques-1	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:15.966	2026-03-02 23:11:15.966	Vente De Materiels Informatiques	Rue 15 X Blaise Diagne	33 823 93 22	Dakar	\N	\N	\N	f	\N
2217	Sysaid Telecoms Sarl	sysaid-telecoms-sarl	Commerce Materiels Telecoms - Energie Et Informatique Vdn	\N	1	2026-03-02 23:11:15.971	2026-03-02 23:11:15.971	Commerce Materiels Telecoms - Energie Et Informatique Vdn	Immeuble Mariama Apt 3	33 869 80 78	Dakar	\N	\N	\N	f	\N
2218	Dismat	dismat-1	(Distribution De Materiels Informatiques) Commerce De Materiels Informatiques & Bureautiques	\N	2	2026-03-02 23:11:15.976	2026-03-02 23:11:15.976	(Distribution De Materiels Informatiques) Commerce De Materiels Informatiques & Bureautiques	Avenue Jean Jaures Immeuble Aly Ibrahim	33 867 23 03	Dakar	\N	\N	\N	f	\N
2219	Soyere Consulting Sarl	soyere-consulting-sarl	Services Informatiques	\N	3	2026-03-02 23:11:15.979	2026-03-02 23:11:15.979	Services Informatiques	Rue Carnot	33 821 01 01	Dakar	\N	\N	\N	f	\N
2220	Arc Cabling Systems Sarl	arc-cabling-systems-sarl	Services Informatiques	\N	3	2026-03-02 23:11:15.982	2026-03-02 23:11:15.982	Services Informatiques	Rue F Impasse Piscine Olympique Point E	33 855 19 46	Dakar	\N	\N	\N	f	\N
2221	Ots (Oberthur Technologies Senegal Suarl)	ots-oberthur-technologies-senegal-suarl	Services Informatiques	\N	9	2026-03-02 23:11:15.986	2026-03-02 23:11:15.986	Services Informatiques	Immeuble Azur 2, Almadies, Appart 3, 1Er Etage 8ème Etage	33 864 24 27	Dakar	\N	\N	\N	f	\N
2222	Global Netw Ork Consulting &	global-netw-ork-consulting	Service Services Informatiques Ouest Foire N°12 0 Dakar Technopolis Sarl Activites Informatiques Hann -	\N	3	2026-03-02 23:11:15.989	2026-03-02 23:11:15.989	Service Services Informatiques Ouest Foire N°12 0 Dakar Technopolis Sarl Activites Informatiques Hann -	Route Des Peres Maristes - Voie Privee N° 1	33 823 72 32	Dakar	\N	\N	\N	f	\N
2223	Socitech Senegal (Societe Internationale De Technologie)	socitech-senegal-societe-internationale-de-technologie-1	Vente Et Installation Du Système Informatique Allee Sacre Cœur 2 N° 8651	\N	2	2026-03-02 23:11:15.994	2026-03-02 23:11:15.994	Vente Et Installation Du Système Informatique Allee Sacre Cœur 2 N° 8651	Imm Mamou	33 860 33 34	Dakar	\N	\N	\N	f	\N
2224	Egb "Digital Store"	egb-digital-store-1	Vente De Materiels Et Consommables Informatique	\N	2	2026-03-02 23:11:15.999	2026-03-02 23:11:15.999	Vente De Materiels Et Consommables Informatique	Avenue Bourguiba Sicap Amitie N° 3082	33 860 60 11	Dakar	\N	\N	\N	f	\N
2225	Itech - Sarl (Information Technologie Solutions - Sarl)	itech-sarl-information-technologie-solutions-sarl	Services Informatiques 4,	\N	9	2026-03-02 23:11:16.01	2026-03-02 23:11:16.01	Services Informatiques 4,	Avenue Cheikh Anta Diop 33 889 7999 Dakar Enquete Publications Sarl Publication D'Un Journal D'Information Generales Boulevard De L'Est Imm. Samba Laobe Thiam Point E Appt A2	77 639 71 78	Dakar	\N	\N	\N	f	\N
2226	Rp Tekaccess - Sa	rp-tekaccess-sa-1	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:16.026	2026-03-02 23:11:16.026	Vente De Materiels Informatiques	Rue Felix Faure	77 644 70 33	Dakar	\N	\N	\N	f	\N
2227	Sinpac Sarl (Societe D'Informatique De Papeterie Et De	sinpac-sarl-societe-d-informatique-de-papeterie-et-de	Commerce) Vente De Materiels Informatiques Et Audiovisuels Place De L'Independance 1Er Etage Porte	\N	2	2026-03-02 23:11:16.03	2026-03-02 23:11:16.03	Commerce) Vente De Materiels Informatiques Et Audiovisuels Place De L'Independance 1Er Etage Porte	Immeuble Allumettes	33 823 69 52	Dakar	\N	\N	\N	f	\N
2228	Laser Bureau Informatique	laser-bureau-informatique-1	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:16.033	2026-03-02 23:11:16.033	Vente De Materiels Informatiques	Immeuble Brachet Av Faidherbe X Dial Diop (Ex Rue El Hadji Mbaye Gueye)	77 574 13 84	Dakar	\N	\N	\N	f	\N
2229	Informatique Expert	informatique-expert-1	Vente De Materiels Informatique	\N	2	2026-03-02 23:11:16.037	2026-03-02 23:11:16.037	Vente De Materiels Informatique	Boulevard Djily Mbaye Xrobert Delmas	33 864 65 64	Dakar	\N	\N	\N	f	\N
2230	Novosen Sa	novosen-sa-1	Commerce Materiel Informatique Point E -	\N	2	2026-03-02 23:11:16.041	2026-03-02 23:11:16.041	Commerce Materiel Informatique Point E -	Rue 4 Angle A -	33 842 97 27	Dakar	\N	\N	\N	f	\N
2231	W Akeur Baye Niasse Somecol Activites Informatiques Et Traitement De Donnees Diack Sao 1 Keur	w-akeur-baye-niasse-somecol-activites-informatiques-et-traitement-de-donnees-diack-sao-1-keur	Services Informatiques	\N	3	2026-03-02 23:11:16.044	2026-03-02 23:11:16.044	Services Informatiques	Boulevard Djily Mbaye	33 823 50 75	Pikine	\N	\N	\N	f	\N
2232	Gea (Golden Eyes Afrique Sarl)	gea-golden-eyes-afrique-sarl	Services Informatiques	\N	3	2026-03-02 23:11:16.047	2026-03-02 23:11:16.047	Services Informatiques	Avenue Georges Pompidou 0 Dakar Atm Afrique Services Informatique Yoff Ranrhar Derr Villa Adama Diop N ° 7	33 820 82 74	Dakar	\N	\N	\N	f	\N
2233	Ccbmt (Ccbm Technologies & Solutions)	ccbmt-ccbm-technologies-solutions	Services Informatiques Et Traitements De Donnees	\N	9	2026-03-02 23:11:16.05	2026-03-02 23:11:16.05	Services Informatiques Et Traitements De Donnees	Immeuble Forum Center Vdn Face Cices (128 Av Lamine Gueye X Paule Holle Ccts)	77 608 32 12	Dakar	\N	\N	\N	f	\N
2234	Mainsoft	mainsoft	Services - Sa (Ex Dametal) Maintenance Et Services Informatiques	\N	3	2026-03-02 23:11:16.053	2026-03-02 23:11:16.053	Services - Sa (Ex Dametal) Maintenance Et Services Informatiques	Bd De La Republique X Corniche Ouest	33 869 87 60	Dakar	\N	\N	\N	f	\N
2235	Phoenix Senegal Sarl (Ex Acs : Africa Computer Systems)	phoenix-senegal-sarl-ex-acs-africa-computer-systems	Commerce De Materiel Informatique	\N	2	2026-03-02 23:11:16.056	2026-03-02 23:11:16.056	Commerce De Materiel Informatique	Immeuble Hajjar Point E	33 865 11 50	Dakar	\N	\N	\N	f	\N
2236	Senew Eb Sarl	senew-eb-sarl	Service Informatique 2566 Av Bourguiba, Dieupeulii #1B 0 Dakar Gie Hbo Technology Services Informatique Front De Terre	\N	3	2026-03-02 23:11:16.058	2026-03-02 23:11:16.058	Service Informatique 2566 Av Bourguiba, Dieupeulii #1B 0 Dakar Gie Hbo Technology Services Informatique Front De Terre	Rue Gy 636	33 822 59 80	Dakar	\N	\N	\N	f	\N
2237	Nelam	nelam	Services Sarl Services Informatiques	\N	3	2026-03-02 23:11:16.061	2026-03-02 23:11:16.061	Services Sarl Services Informatiques	Rue W Agane Diouf	33 827 28 70	Dakar	\N	\N	\N	f	\N
2238	Aye Senebel Sarl	aye-senebel-sarl-1	Vente Materiels Et Consommables Informatiques P,A Unite 1 N°312 0 Dakar Forum Suarl Vente De Materiel Informatique Et Electronique Km 1, Av Cheikh Anta Diop (Ex Sicap Liberte V Dakar) 0 Dakar Bt Services Techniques Maintenance Informatique Et Bureautique	\N	2	2026-03-02 23:11:16.065	2026-03-02 23:11:16.065	Vente Materiels Et Consommables Informatiques P,A Unite 1 N°312 0 Dakar Forum Suarl Vente De Materiel Informatique Et Electronique Km 1, Av Cheikh Anta Diop (Ex Sicap Liberte V Dakar) 0 Dakar Bt Services Techniques Maintenance Informatique Et Bureautique	Rue Mz-70 Mermoz Pyrotechnique	77 450 46 01	Guediaw	\N	\N	\N	f	\N
2239	Focus Audit Et Expertise	focus-audit-et-expertise-1	Vente De Materiel Et Consommables Informatiques	\N	2	2026-03-02 23:11:16.074	2026-03-02 23:11:16.074	Vente De Materiel Et Consommables Informatiques	Rue 2 X Piscine Olympique,Imm. Bour Mahe Point E	77 657 60 57	Dakar	\N	\N	\N	f	\N
2240	E.T.I (Equipement Travaux Informatiques	e-t-i-equipement-travaux-informatiques-1	Commerce De Materiels Informatiques	\N	2	2026-03-02 23:11:16.079	2026-03-02 23:11:16.079	Commerce De Materiels Informatiques	Quartier Darou Salam - Pikine 0 Dakar Genicom - Sarl (Generale D'Informatique Et De Communication -Sarl) Vente De Materiels Informatiques Liberte 6 Extension	33 823 02 75	Pikine	\N	\N	\N	f	\N
2241	Solanum (Solanum Systems Ex Sygma Technologie Surl)	solanum-solanum-systems-ex-sygma-technologie-surl	Services Informatiques Amitie 2 Villa N° 4067	\N	9	2026-03-02 23:11:16.083	2026-03-02 23:11:16.083	Services Informatiques Amitie 2 Villa N° 4067	(Immeuble Faycal Appart. R5)	33 867 40 95	Dakar	\N	\N	\N	f	\N
2242	Smi - Sarl (Senegal Maintenance Informatique)	smi-sarl-senegal-maintenance-informatique	Services Informatiques	\N	3	2026-03-02 23:11:16.086	2026-03-02 23:11:16.086	Services Informatiques	Rue Adja Madeleine Ngom 338229557 Dakar Origine Reseuax Telecom Sarl Services Informatiques Et Traitement De Donnees Cite Habitex Ouest Foire 0 Guediaw Aye Oasis Media Group Formations - Services Informatiques Sacre Cœur Iii (Cite Nguenteba)	77 539 71 05	Dakar	\N	\N	\N	f	\N
2243	Seysoo Sarl	seysoo-sarl	Service Informatique	\N	3	2026-03-02 23:11:16.088	2026-03-02 23:11:16.088	Service Informatique	Route Sacre Cœur 2 - 8613 / F	33 824 41 35	Dakar	\N	\N	\N	f	\N
2244	Connectis House (Mame Nogaye Fall)	connectis-house-mame-nogaye-fall-1	Vente De Materiels Informatiques Et Electroniques	\N	2	2026-03-02 23:11:16.095	2026-03-02 23:11:16.095	Vente De Materiels Informatiques Et Electroniques	Rue Amadou Assane Ndoye	33 823 31 19	Dakar	\N	\N	\N	f	\N
2245	Systems Plus - Sarl	systems-plus-sarl-1	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:16.099	2026-03-02 23:11:16.099	Vente De Materiels Informatiques	Avenue Lamine Gueye	77 351 73 58	Dakar	\N	\N	\N	f	\N
2246	Entreprise Activité Adresse Téléphone Dakar Akil Telecom	entreprise-activite-adresse-telephone-dakar-akil-telecom	Commerce Materiel Informatique Et Accessoires	\N	2	2026-03-02 23:11:16.102	2026-03-02 23:11:16.102	Commerce Materiel Informatique Et Accessoires	Rue Jacques Bugnicourt	33 827 23 78	Ville	\N	\N	\N	f	\N
2247	Cosi (Cosi International) Assistance Conseils -	cosi-cosi-international-assistance-conseils-1	Ventes De Pdts Informatiques	\N	2	2026-03-02 23:11:16.106	2026-03-02 23:11:16.106	Ventes De Pdts Informatiques	Rue Carnot	33 842 67 05	Dakar	\N	\N	\N	f	\N
2248	Crio Consultants Suarl Activites Informatiques Rue W Agane Diouf Residence Alassane Fall 33823 27	crio-consultants-suarl-activites-informatiques-rue-w-agane-diouf-residence-alassane-fall-33823-27	Vente De Materiels Informatiques Et Lectroniques Amitie / Point E -	\N	2	2026-03-02 23:11:16.109	2026-03-02 23:11:16.109	Vente De Materiels Informatiques Et Lectroniques Amitie / Point E -	Immeuble Hajjar	33 823 69 12	Dakar	\N	\N	\N	f	\N
2249	Serigne Mouhamadou Fallou Mbaye "Mbi"	serigne-mouhamadou-fallou-mbaye-mbi-1	Vente Outils Informatique Consommables Fournitures De Burau	\N	2	2026-03-02 23:11:16.115	2026-03-02 23:11:16.115	Vente Outils Informatique Consommables Fournitures De Burau	Rue 9 X Blaise Diagne	33 860 19 14	Dakar	\N	\N	\N	f	\N
2250	Latitude Gps Ouest Africa Sarl	latitude-gps-ouest-africa-sarl	Services Informatiques Et Traitement De Donnees	\N	3	2026-03-02 23:11:16.119	2026-03-02 23:11:16.119	Services Informatiques Et Traitement De Donnees	Rue De L'Unicef-Les Almadies	77 537 39 90	Dakar	\N	\N	\N	f	\N
2251	Csf Developpement Sarl	csf-developpement-sarl	Services Informatiques	\N	3	2026-03-02 23:11:16.124	2026-03-02 23:11:16.124	Services Informatiques	Rue Mohamed 5 0 Dakar Jokkolabs Sarl Activites Informatiques Sacre Cœur Villa N°9653, Rue 11	33 867 63 29	Dakar	\N	\N	\N	f	\N
2252	Khew Eul.Com - Sa	khew-eul-com-sa-1	Vente De Materiels Informatiques/Heberment De Site Internet	\N	2	2026-03-02 23:11:16.129	2026-03-02 23:11:16.129	Vente De Materiels Informatiques/Heberment De Site Internet	Rue Joseph Gomis	33 860 69 00	Dakar	\N	\N	\N	f	\N
2253	Gcs - Sarl (Global Computer Solutions)	gcs-sarl-global-computer-solutions-1	Commerce Et Services Informatiques	\N	2	2026-03-02 23:11:16.134	2026-03-02 23:11:16.134	Commerce Et Services Informatiques	Avenue Lamine Guéye A Cote De Touba Sandaga ( Ex Rue Tolbiac Prolongee X Avenue Faidherbe	33 824 92 71	Dakar	\N	\N	\N	f	\N
2254	Univers De L'Equipement (Mamadou Ndiaye)	univers-de-l-equipement-mamadou-ndiaye-1	Commerce De Materiels Informatiques	\N	2	2026-03-02 23:11:16.139	2026-03-02 23:11:16.139	Commerce De Materiels Informatiques	Rue 25 X 20 Medina	33 823 43 58	Dakar	\N	\N	\N	f	\N
2255	Abc (Ada Business Center)	abc-ada-business-center-1	Commerce (Bureautique - Librairie - Cadeaux D'Entreprise - Consommable Informatique)	\N	2	2026-03-02 23:11:16.143	2026-03-02 23:11:16.143	Commerce (Bureautique - Librairie - Cadeaux D'Entreprise - Consommable Informatique)	Rue Carnot X Mohamed V	33 823 10 23	Dakar	\N	\N	\N	f	\N
2256	Gie Ambur Informatique (Agence De Maintenance - Bureautique Et Informatique) Prestations De	gie-ambur-informatique-agence-de-maintenance-bureautique-et-informatique-prestations-de	Services Informatiques	\N	3	2026-03-02 23:11:16.146	2026-03-02 23:11:16.146	Services Informatiques	Avenue Georges Pompidou	33 842 49 22	Dakar	\N	\N	\N	f	\N
2257	B.I.R.S (Bureautique Informatique Reseaux Et	b-i-r-s-bureautique-informatique-reseaux-et-1	Services) Commerce General En Informatique	\N	2	2026-03-02 23:11:16.15	2026-03-02 23:11:16.15	Services) Commerce General En Informatique	Route De L'Aeroport Yoff Tonghor	33 822 64 66	Dakar	\N	\N	\N	f	\N
2258	Oasis Informatique Sarl	oasis-informatique-sarl	Services Informatiques Sodida	\N	3	2026-03-02 23:11:16.153	2026-03-02 23:11:16.153	Services Informatiques Sodida	Immeuble Les Dunes D-24	33 820 67 97	Dakar	\N	\N	\N	f	\N
2259	2Sc2I Sarl (Senegalaise Des	2sc2i-sarl-senegalaise-des	Services Et Conseils En Ingenierie Informatique) Services Informatique	\N	3	2026-03-02 23:11:16.155	2026-03-02 23:11:16.155	Services Et Conseils En Ingenierie Informatique) Services Informatique	Route De Rufisque	33 825 32 07	Dakar	\N	\N	\N	f	\N
2260	Pc Concept	pc-concept	Services Informatiques	\N	3	2026-03-02 23:11:16.158	2026-03-02 23:11:16.158	Services Informatiques	Rue 3 X Blaise Diagne	77 332 70 93	Dakar	\N	\N	\N	f	\N
2261	Malick Diaham	malick-diaham-1	Vente Et Services Informatique	\N	2	2026-03-02 23:11:16.162	2026-03-02 23:11:16.162	Vente Et Services Informatique	Rue 33 X 16 Medina 0 Dakar Ca-Dem Technologies Activites Informatiques Sicap Bourguiba - Face Ecole Police	77 631 18 04	Dakar	\N	\N	\N	f	\N
2262	Bag - Sarl (Bureautique Et Arts Graphiques)	bag-sarl-bureautique-et-arts-graphiques-1	Vente Et Maintenance Materiels Bureautiques	\N	2	2026-03-02 23:11:16.166	2026-03-02 23:11:16.166	Vente Et Maintenance Materiels Bureautiques	Rue Vincens	33 827 95 29	Dakar	\N	\N	\N	f	\N
2263	Etoile Bureautique	etoile-bureautique-1	Vente De Fourniture De Bureau Et Materiel	\N	1	2026-03-02 23:11:16.171	2026-03-02 23:11:16.171	Vente De Fourniture De Bureau Et Materiel	InformatiqueImmeuble 2F Rond Point Jet D'Eau	33 822 57 26	Dakar	\N	\N	\N	f	\N
2264	Soelog Suarl	soelog-suarl	Services Informatiques Et Traitement De Donnees	\N	3	2026-03-02 23:11:16.176	2026-03-02 23:11:16.176	Services Informatiques Et Traitement De Donnees	Rue Siant Michel Imm Tamaris	77 819 38 90	Dakar	\N	\N	\N	f	\N
2265	Gie Informatique Global Système	gie-informatique-global-systeme	Vente De Materiel Informatique Et Mobilier De Bureau	\N	2	2026-03-02 23:11:16.181	2026-03-02 23:11:16.181	Vente De Materiel Informatique Et Mobilier De Bureau	Rue Abdou Karim Bourgi Dakar	77 644 36 21	Dakar	\N	\N	\N	f	\N
2266	Pc Trade Sarl	pc-trade-sarl-1	Vente De Produits Informatiques - Prestations De Services Informatiques Hann Plage -	\N	2	2026-03-02 23:11:16.186	2026-03-02 23:11:16.186	Vente De Produits Informatiques - Prestations De Services Informatiques Hann Plage -	Route Du Cvd Impasse Des Cocotiers	33 823 61 72	Dakar	\N	\N	\N	f	\N
2267	W Tc (W Ade Trading Company) - Ex Bit Senegal (Bits]	w-tc-w-ade-trading-company-ex-bit-senegal-bits-1	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:16.19	2026-03-02 23:11:16.19	Vente De Materiels Informatiques	Rue Felix Faure X Mousse Diop	33 864 23 94	Dakar	\N	\N	\N	f	\N
2268	Sesame Afrique Sarl	sesame-afrique-sarl	Services Informatiques	\N	3	2026-03-02 23:11:16.193	2026-03-02 23:11:16.193	Services Informatiques	Immeuble Hajjar 1Er Etage Point E Amitie Rue 9 X 11	33 827 16 49	Dakar	\N	\N	\N	f	\N
2269	Leixem Africa Suarl Prestation De	leixem-africa-suarl-prestation-de	Services Informatiques	\N	3	2026-03-02 23:11:16.196	2026-03-02 23:11:16.196	Services Informatiques	Rue W Agane Diouf,2 Etage 0 Dakar Acis Informatique Vente D'Outils Informatique Consommables Fournitures De Bureau Rue 09 X Blaise Diagne Medina	33 821 18 02	Dakar	\N	\N	\N	f	\N
2270	Mac Et Pc	mac-et-pc-1	Services (Carole Marie A Nelson) Vente De Materiels Informatiques-Services Dakar Mermoz 2 Eme Porte	\N	2	2026-03-02 23:11:16.2	2026-03-02 23:11:16.2	Services (Carole Marie A Nelson) Vente De Materiels Informatiques-Services Dakar Mermoz 2 Eme Porte	Immeuble B 0 Dakar High Soft Activites Informatiques Maristes 1 N° 97 Scat Urbam 0 Dakar Millenium Service (Ndiouga Ndiaye) Vente De Materiels De Bureau, Bureautique Et Informatique Ave Andre Peytavin	33 825 52 11	Dakar	\N	\N	\N	f	\N
2271	Sen Technologies Sarl	sen-technologies-sarl	Services Informatiques	\N	9	2026-03-02 23:11:16.203	2026-03-02 23:11:16.203	Services Informatiques	Rue 43 X Bd General Degaulle	33 820 40 66	Dakar	\N	\N	\N	f	\N
2272	Scie Sa (Societe De Commercialisation D'Info	scie-sa-societe-de-commercialisation-d-info-1	Commerce D'Informations	\N	2	2026-03-02 23:11:16.207	2026-03-02 23:11:16.207	Commerce D'Informations	Avenue Des Ambassadeurs Fann	33 837 98 47	Dakar	\N	\N	\N	f	\N
2273	Gie "Ndoka Multi	gie-ndoka-multi-1	Services" Commerce General- Bureautique-Papeterie Place	\N	2	2026-03-02 23:11:16.212	2026-03-02 23:11:16.212	Services" Commerce General- Bureautique-Papeterie Place	Abdoulaye W Ade Sor Saint-Louis	33 821 99 88	Saint-Louis	\N	\N	\N	f	\N
2274	Univers De La Technologie Sarl	univers-de-la-technologie-sarl	Vente De Materiel Informatique	\N	2	2026-03-02 23:11:16.216	2026-03-02 23:11:16.216	Vente De Materiel Informatique	Rue Jules Ferry X Mohamed 5	77 450 02 81	Dakar	\N	\N	\N	f	\N
2275	Ets Salim W Ehbe Et Freres - Sarl	ets-salim-w-ehbe-et-freres-sarl-1	Commerce - Farine (99%)- Autres Marchanise (0,8%) Materiels Informatiques	\N	2	2026-03-02 23:11:16.221	2026-03-02 23:11:16.221	Commerce - Farine (99%)- Autres Marchanise (0,8%) Materiels Informatiques	Route De Rufisque	77 717 17 42	Dakar	\N	\N	\N	f	\N
2276	Kaiman Sarl	kaiman-sarl	Services Informatiques 2-B	\N	3	2026-03-02 23:11:16.224	2026-03-02 23:11:16.224	Services Informatiques 2-B	Rue 1 X C Point E	30 100 84 42	Dakar	\N	\N	\N	f	\N
2277	Cedar Informatique Suarl (Conseil Etude Developpement Audit & Reorganisation Informatique)	cedar-informatique-suarl-conseil-etude-developpement-audit-reorganisation-informatique	Services Informatiques	\N	3	2026-03-02 23:11:16.227	2026-03-02 23:11:16.227	Services Informatiques	Route Des Ecrivains Point E	77 554 45 37	Dakar	\N	\N	\N	f	\N
2278	Bureautique Informatique	bureautique-informatique	Services Suarl Activite De Commerce De Materiels Informatique	\N	2	2026-03-02 23:11:16.23	2026-03-02 23:11:16.23	Services Suarl Activite De Commerce De Materiels Informatique	Rue Castors Villa N° 49	33 827 70 77	Dakar	\N	\N	\N	f	\N
2279	Busnet (Abdou Ndiaye Console) Prestation De	busnet-abdou-ndiaye-console-prestation-de	Services Informatiques	\N	3	2026-03-02 23:11:16.234	2026-03-02 23:11:16.234	Services Informatiques	Boulevard General De Gaulle 0 Saint-Louis Gie Infelec (Gie Informatique Electronique) Services Informatiques Km 3 Route De Dakar Pikine Sor	33 867 45 90	Dakar	\N	\N	\N	f	\N
2280	Ib Consulting Sarl Activites Informatiques Rue Parent 0 Dakar Tamaka Technilogies	ib-consulting-sarl-activites-informatiques-rue-parent-0-dakar-tamaka-technilogies	Services Informatiques	\N	3	2026-03-02 23:11:16.236	2026-03-02 23:11:16.236	Services Informatiques	Rue 33 X 16 Medina 338238965 Dakar Bip Distribution (Modou Gaye) Vente De Materiel Informatique - Fournitures Informatiques Et Bureautique Rue 17 X 10 Medina	77 646 17 88	Dakar	\N	\N	\N	f	\N
2281	Papeterie Sope Nabi Suarl	papeterie-sope-nabi-suarl-1	Vente De Demateriels Informatique Et Consommable	\N	2	2026-03-02 23:11:16.24	2026-03-02 23:11:16.24	Vente De Demateriels Informatique Et Consommable	Avenue Blaise Diagne Face Rue 17 Dakar	33 842 62 99	Dakar	\N	\N	\N	f	\N
2282	Dm21 (Amadou Sow )	dm21-amadou-sow	Distribution De Materiels Industriels Et Informatiques (Commerce General	\N	2	2026-03-02 23:11:16.243	2026-03-02 23:11:16.243	Distribution De Materiels Industriels Et Informatiques (Commerce General	Rue Tolbiac X Brassa	33 842 86 88	Dakar	\N	\N	\N	f	\N
2283	Societe D'Ingenierie Et De	societe-d-ingenierie-et-de	Services Informatiques Du Senegal Suarl Formation -Installation Et Modules Informatiques Pikine Chavanel N°548 70 30 90 33 Dakar Dot Home Sarl Formation En Informatique	\N	3	2026-03-02 23:11:16.246	2026-03-02 23:11:16.246	Services Informatiques Du Senegal Suarl Formation -Installation Et Modules Informatiques Pikine Chavanel N°548 70 30 90 33 Dakar Dot Home Sarl Formation En Informatique	Bd De La Gueule Tapee	33 839 73 73	Pikine	\N	\N	\N	f	\N
2284	Xone Tech Suarl	xone-tech-suarl	Services Informatiques	\N	3	2026-03-02 23:11:16.249	2026-03-02 23:11:16.249	Services Informatiques	Rue W Agane Diouf	77 632 08 76	Dakar	\N	\N	\N	f	\N
2285	Gie Bissik Informatique	gie-bissik-informatique-1	Vente Materiells Et Consommable D'Ordinateurs,Fournitures Bureautique Yaye Bigue Toure	\N	2	2026-03-02 23:11:16.253	2026-03-02 23:11:16.253	Vente Materiells Et Consommable D'Ordinateurs,Fournitures Bureautique Yaye Bigue Toure	Rue 63X50 Bld De La Geule Tapee-Dakar	33 821 59 07	Dakar	\N	\N	\N	f	\N
2286	Folou Sarl Activites Informatique	folou-sarl-activites-informatique-1	(Vente De Logiciels Et Livres) Cite Air France	\N	2	2026-03-02 23:11:16.257	2026-03-02 23:11:16.257	(Vente De Logiciels Et Livres) Cite Air France	Imm. Ndiouk 2 Eme Etage	33 867 22 21	Dakar	\N	\N	\N	f	\N
2287	Gie Igs (Informatique Et Gestion De Societe)	gie-igs-informatique-et-gestion-de-societe	Services Informatiques 33,	\N	3	2026-03-02 23:11:16.26	2026-03-02 23:11:16.26	Services Informatiques 33,	Rue A. K. Bourgi	33 872 11 37	Dakar	\N	\N	\N	f	\N
2288	Super Informatique (Modou Mamoune Lo)	super-informatique-modou-mamoune-lo	Services Informatiques	\N	3	2026-03-02 23:11:16.263	2026-03-02 23:11:16.263	Services Informatiques	Avenue Blaise Diagne X Rue 21 0 Dakar Dnd Consulting Sarl Services Informatiques Cite Sipres Cheikh Anta Diop	33 842 08 32	Dakar	\N	\N	\N	f	\N
2289	Alfayda Informatique	alfayda-informatique	Service Services Informatiques Medina	\N	3	2026-03-02 23:11:16.267	2026-03-02 23:11:16.267	Service Services Informatiques Medina	Rue ,23 X 6	77 377 84 70	Dakar	\N	\N	\N	f	\N
2290	Toure Computer Systeme(Abdoulaye Toure)	toure-computer-systeme-abdoulaye-toure-1	Commerce Informatique	\N	2	2026-03-02 23:11:16.276	2026-03-02 23:11:16.276	Commerce Informatique	Rue 45 X 28 Medina Dakar	77 971 78 80	Dakar	\N	\N	\N	f	\N
2291	Nalla Technologies (Youssoupha Sarr)	nalla-technologies-youssoupha-sarr	Service Informatique	\N	9	2026-03-02 23:11:16.279	2026-03-02 23:11:16.279	Service Informatique	Route De Rufisque Qt Lansar Lot N°101	33 893 52 52	Pikine	\N	\N	\N	f	\N
2292	Daouda Soumah	daouda-soumah-1	Commerce Bureautique Informatique	\N	2	2026-03-02 23:11:16.283	2026-03-02 23:11:16.283	Commerce Bureautique Informatique	Rue Non Denommee Grand Yoff 0 Dakar W In Technologie Suarl Conception Et Vente De Materiel Informatiques Et Accessoires Rue Huart X Parchappe 0 Dakar Isalex Senegal Sarl Achats - Vente - Importations Imprimantes,Encre Tous Materiels Informatique Sotrac Villa 436	77 369 65 94	Dakar	\N	\N	\N	f	\N
2293	Bms (Birane Multi	bms-birane-multi	Services)- Mme Aby Ciss Service Informatique	\N	3	2026-03-02 23:11:16.287	2026-03-02 23:11:16.287	Services)- Mme Aby Ciss Service Informatique	Rue Magin X Belfort 0 Dakar Tecsys Sarl Consultance Et Installations Informatiques Ouest Foire Villa N° 14 0 Dakar Gps (Global Price Solutions) Services Informatiques Sicap Route Liberte 6	77 520 17 18	Dakar	\N	\N	\N	f	\N
2294	Mamadou Diedhiou (Africa Synchro Technologie) Maintenance Informatique Darou Salam 02, Khar Yalla 0	mamadou-diedhiou-africa-synchro-technologie-maintenance-informatique-darou-salam-02-khar-yalla-0	Services Informatiques Medina	\N	9	2026-03-02 23:11:16.29	2026-03-02 23:11:16.29	Services Informatiques Medina	Rue 25 X 26 Immeuble Mame Maguette Diop	33 835 94 84	Dakar	\N	\N	\N	f	\N
2295	It Consulting	it-consulting	Services - Sarl Ingenierie - Ventes De Materiels Informatiques	\N	2	2026-03-02 23:11:16.293	2026-03-02 23:11:16.293	Services - Sarl Ingenierie - Ventes De Materiels Informatiques	Rue El Hadji Mass Diokhane	33 822 75 76	Dakar	\N	\N	\N	f	\N
2296	Entreprise Activité Adresse Téléphone Dakar Babacar Drame	entreprise-activite-adresse-telephone-dakar-babacar-drame	Vente De Materiel Informatique	\N	2	2026-03-02 23:11:16.297	2026-03-02 23:11:16.297	Vente De Materiel Informatique	Rue 31 X Blaise Diagne 0 Dakar Ultima Technologies - Suarl Services Informatiques Sacre Cœur 3 Lot 50	77 552 35 27	Ville	\N	\N	\N	f	\N
2297	Gie Seninvest	gie-seninvest	Services Informatiques Rond Point Jet D'Eau	\N	3	2026-03-02 23:11:16.3	2026-03-02 23:11:16.3	Services Informatiques Rond Point Jet D'Eau	Immeuble Abc N° 12 Et 13 R 0 Dakar Eams (Amadou Moustapha Sall) Vente De Materiels Et Consommables Informatique Rue 11 X Blaise Diagne 0 Pikine Thepas Informatiques Services Vente Des Materiels Informatiques Grand Mbao Cite Baobab	33 867 03 60	Dakar	\N	\N	\N	f	\N
2298	Salam Computer	salam-computer-1	Vente Outils Informatique Consommables Et Fournitures De Bureau	\N	2	2026-03-02 23:11:16.306	2026-03-02 23:11:16.306	Vente Outils Informatique Consommables Et Fournitures De Bureau	Rue 9 X Blaise Diagne	77 574 82 33	Dakar	\N	\N	\N	f	\N
2299	Netcom Sa (Netw Ork Energie Et Communication)	netcom-sa-netw-ork-energie-et-communication-1	Vente De Materiels Telecommunications - Prestations Services Informatiques	\N	1	2026-03-02 23:11:16.311	2026-03-02 23:11:16.311	Vente De Materiels Telecommunications - Prestations Services Informatiques	Rue Carnot X Mass Diokhane	33 864 35 71	Dakar	\N	\N	\N	f	\N
2300	W Orld Digitech Systems Suarl	w-orld-digitech-systems-suarl	Commerce Materiel Informatique Point E	\N	2	2026-03-02 23:11:16.314	2026-03-02 23:11:16.314	Commerce Materiel Informatique Point E	Rue A X 1	33 849 06 16	Dakar	\N	\N	\N	f	\N
2301	Alpha'Numerik Sarl	alpha-numerik-sarl	Services Informatiques	\N	3	2026-03-02 23:11:16.318	2026-03-02 23:11:16.318	Services Informatiques	Rue Jules Ferry 0 Dakar Siedis Sarl (Senegal Import Export Distribution Et Services) Service Informatique Avenue Malick Sy	33 864 20 01	Dakar	\N	\N	\N	f	\N
2302	Station Total Senegal (Ex Totalfinaelf Senegal - Sa)	station-total-senegal-ex-totalfinaelf-senegal-sa	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:16.321	2026-03-02 23:11:16.321	Vente De Produits Petroliers	Bccd	33 839 84 39	Dakar	\N	\N	\N	f	\N
2303	Senelec - Sa (Societe Nationale D'Electricite Du Senegal )	senelec-sa-societe-nationale-d-electricite-du-senegal-1	Production Et Distribution D'Electricite	\N	1	2026-03-02 23:11:16.326	2026-03-02 23:11:16.326	Production Et Distribution D'Electricite	Rue Vincens	33 839 54 54	Dakar	\N	\N	\N	f	\N
2304	Vivo Energie Senegal (Ex Shell Senegal )Sa	vivo-energie-senegal-ex-shell-senegal-sa-1	Distribution D'Hydrocarbures	\N	1	2026-03-02 23:11:16.33	2026-03-02 23:11:16.33	Distribution D'Hydrocarbures	Route Des Hydrocarbures - Quartier Bel-Air	33 821 02 99	Dakar	\N	\N	\N	f	\N
2305	Sococim Industries - Sa	sococim-industries-sa-1	Fabrication De Produits Mineraux Pour La Construction - Services Aux Entreprises - Autres Commerces Ancienne	\N	2	2026-03-02 23:11:16.334	2026-03-02 23:11:16.334	Fabrication De Produits Mineraux Pour La Construction - Services Aux Entreprises - Autres Commerces Ancienne	Route De Thies - Colobane Gouye Mouride - Rufisque	33 949 37 37	Dakar	\N	\N	\N	f	\N
2306	Oilibya (Libya Oil Senegal - Ex Mobil Oil Senegal - Sa : En 2007)	oilibya-libya-oil-senegal-ex-mobil-oil-senegal-sa-en-2007-1	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:16.339	2026-03-02 23:11:16.339	Vente De Produits Petroliers	Bccd	33 869 31 81	Dakar	\N	\N	\N	f	\N
2307	Patisen - Sa	patisen-sa-1	Production Et Distribution De Pdts Alimentaires (Boillons, Chocolat- Reconditionnement De Poivre	\N	1	2026-03-02 23:11:16.343	2026-03-02 23:11:16.343	Production Et Distribution De Pdts Alimentaires (Boillons, Chocolat- Reconditionnement De Poivre	Bd De La Liberation - Place Leclerc (Ex - Bccd X Rue 4)	33 839 37 37	Dakar	\N	\N	\N	f	\N
2308	Oryx Senegal - Sa Stockage -	oryx-senegal-sa-stockage-1	Vente De Produits Petrolers	\N	1	2026-03-02 23:11:16.348	2026-03-02 23:11:16.348	Vente De Produits Petrolers	Bd Djily Mbaye - Immeuble Fondation Fahd - 12ème Etage	33 859 03 00	Dakar	\N	\N	\N	f	\N
2309	Ccmn (Comptoir Commercial Mandiaye Ndiaye)	ccmn-comptoir-commercial-mandiaye-ndiaye	Commerce Import-Export	\N	2	2026-03-02 23:11:16.351	2026-03-02 23:11:16.351	Commerce Import-Export	Rue Daloa	33 879 10 00	Kaolack	\N	\N	\N	f	\N
2310	Elton Sa (Elton Oil Company Sa)	elton-sa-elton-oil-company-sa-1	Distribution De Produits Petroliers Et De Lubrifiants	\N	1	2026-03-02 23:11:16.356	2026-03-02 23:11:16.356	Distribution De Produits Petroliers Et De Lubrifiants	Avenue Abdoulaye Fadiga, Imm Abdoul Ahad Mbacke, Porte A 4ème Etage	33 941 16 15	Dakar	\N	\N	\N	f	\N
2311	Puma Energy Senegal (Ex Vitogaz Senegal) Emplissage Et	puma-energy-senegal-ex-vitogaz-senegal-emplissage-et-1	Distribution De Gaz	\N	1	2026-03-02 23:11:16.361	2026-03-02 23:11:16.361	Distribution De Gaz	Route De Rufisque	33 889 09 20	Dakar	\N	\N	\N	f	\N
2312	Tds Sarl (Tiger Denrees Senegal)	tds-sarl-tiger-denrees-senegal-1	Commerce General - Riz	\N	2	2026-03-02 23:11:16.365	2026-03-02 23:11:16.365	Commerce General - Riz	Bccd (Ex 10, Rue Beranger Ferraud)	33 823 04 00	Dakar	\N	\N	\N	f	\N
2313	Louis Dreyfus Commodities Senegal (Ex La Cigogne Dakar)	louis-dreyfus-commodities-senegal-ex-la-cigogne-dakar-1	Distribution De Produits Chimiques, Engrais Et Hytosanitaires	\N	2	2026-03-02 23:11:16.37	2026-03-02 23:11:16.37	Distribution De Produits Chimiques, Engrais Et Hytosanitaires	Route De Rufisque En Face Sips (Entre Olybia Et Sab)	33 822 11 19	Dakar	\N	\N	\N	f	\N
2314	Nestle Senegal - Sa	nestle-senegal-sa	Production De Magi (À Base De Légumes Pour Assaisonnement)	\N	7	2026-03-02 23:11:16.373	2026-03-02 23:11:16.373	Production De Magi (À Base De Légumes Pour Assaisonnement)	Route De Rufisque	33 879 00 00	Dakar	\N	\N	\N	f	\N
2315	Satrec - Sa (Ste Africaine De Transformation De Reconditionnement Et De	satrec-sa-ste-africaine-de-transformation-de-reconditionnement-et-de	Commerce) Production Laitiere	\N	2	2026-03-02 23:11:16.376	2026-03-02 23:11:16.376	Commerce) Production Laitiere	Bccd	33 849 25 00	Dakar	\N	\N	\N	f	\N
2316	Cfao Motors Senegal (Ex - Africauto Senegal) Concessionnaire De Vehicules Et Accessoires - Autre	cfao-motors-senegal-ex-africauto-senegal-concessionnaire-de-vehicules-et-accessoires-autre-1	Commerces - Entretien Et Reparation De Vehicules - Auxilliaires Transports - Telecommunications - Services	\N	2	2026-03-02 23:11:16.381	2026-03-02 23:11:16.381	Commerces - Entretien Et Reparation De Vehicules - Auxilliaires Transports - Telecommunications - Services	Immobiliers Bccd	33 832 55 44	Dakar	\N	\N	\N	f	\N
2317	Soboa - Sa (Ste Des Brasseries De L'Ouest Africain)	soboa-sa-ste-des-brasseries-de-l-ouest-africain	Fabrications Bierres Et Boissons Gazeuses	\N	1	2026-03-02 23:11:16.383	2026-03-02 23:11:16.383	Fabrications Bierres Et Boissons Gazeuses	Route Des Brasseries - Bel Air	33 849 38 38	Dakar	\N	\N	\N	f	\N
2318	Csl - Sa (Compagnie Senegalaise Des Lubrifiants)	csl-sa-compagnie-senegalaise-des-lubrifiants	Fabrication De Lubrifiants	\N	7	2026-03-02 23:11:16.386	2026-03-02 23:11:16.386	Fabrication De Lubrifiants	Bccd	33 824 99 40	Dakar	\N	\N	\N	f	\N
2319	Pad - Sa (Port Autonome De Dakar)	pad-sa-port-autonome-de-dakar-1	Services Annexes Et Auxilliaires De Transport	\N	8	2026-03-02 23:11:16.391	2026-03-02 23:11:16.391	Services Annexes Et Auxilliaires De Transport	Bd De La Liberation	33 836 14 88	Dakar	\N	\N	\N	f	\N
2320	Sofiex - Sarl (Ste De	sofiex-sarl-ste-de	Fabrication Et D'Import Export) Fabrication Et D'Import Export	\N	2	2026-03-02 23:11:16.393	2026-03-02 23:11:16.393	Fabrication Et D'Import Export) Fabrication Et D'Import Export	Rue Galandou Diouf	33 825 30 11	Dakar	\N	\N	\N	f	\N
2321	Sdc Senegal Sa (Societe De	sdc-senegal-sa-societe-de	Distribution Et De Commerce - Senegal) Negoce Importation De Riz	\N	2	2026-03-02 23:11:16.398	2026-03-02 23:11:16.398	Distribution Et De Commerce - Senegal) Negoce Importation De Riz	Rue Mousse Diop	33 839 80 00	Dakar	\N	\N	\N	f	\N
2760	Genie Et Construction Sarl	genie-et-construction-sarl	Genie Civil Et Construction	\N	6	2026-03-02 23:11:17.658	2026-03-02 23:11:17.658	Genie Civil Et Construction			Dakar	\N	\N	\N	f	\N
2761	Mecbat Sarl	mecbat-sarl	Mecanisation Batiment	\N	6	2026-03-02 23:11:17.66	2026-03-02 23:11:17.66	Mecanisation Batiment			Dakar	\N	\N	\N	f	\N
2762	Africa Construction Sa	africa-construction-sa	Construction	\N	6	2026-03-02 23:11:17.663	2026-03-02 23:11:17.663	Construction			Dakar	\N	\N	\N	f	\N
2763	Batim Sarl	batim-sarl	Batiment Et Construction	\N	6	2026-03-02 23:11:17.665	2026-03-02 23:11:17.665	Batiment Et Construction			Dakar	\N	\N	\N	f	\N
2764	Senegambat Sarl	senegambat-sarl	Construction Et Renovation	\N	6	2026-03-02 23:11:17.667	2026-03-02 23:11:17.667	Construction Et Renovation			Dakar	\N	\N	\N	f	\N
2765	Egs Sa (Entreprise Generale Senegalaise)	egs-sa-entreprise-generale-senegalaise	Construction Generale	\N	6	2026-03-02 23:11:17.669	2026-03-02 23:11:17.669	Construction Generale			Dakar	\N	\N	\N	f	\N
2766	Setrab Sarl (Service Travaux Batiment)	setrab-sarl-service-travaux-batiment	Travaux Batiment	\N	6	2026-03-02 23:11:17.671	2026-03-02 23:11:17.671	Travaux Batiment			Dakar	\N	\N	\N	f	\N
2767	Tps Sa (Travaux Publics Senegal)	tps-sa-travaux-publics-senegal	Travaux Publics	\N	6	2026-03-02 23:11:17.673	2026-03-02 23:11:17.673	Travaux Publics			Dakar	\N	\N	\N	f	\N
2768	Socotec Senegal	socotec-senegal	Controle Technique Construction	\N	6	2026-03-02 23:11:17.675	2026-03-02 23:11:17.675	Controle Technique Construction			Dakar	\N	\N	\N	f	\N
2769	Bureau Veritas Senegal	bureau-veritas-senegal	Controle Et Inspection	\N	6	2026-03-02 23:11:17.677	2026-03-02 23:11:17.677	Controle Et Inspection			Dakar	\N	\N	\N	f	\N
2770	Apave Senegal	apave-senegal	Controle Technique Industriel	\N	6	2026-03-02 23:11:17.679	2026-03-02 23:11:17.679	Controle Technique Industriel			Dakar	\N	\N	\N	f	\N
2771	Edifices Sarl	edifices-sarl	Construction Immobiliere	\N	6	2026-03-02 23:11:17.686	2026-03-02 23:11:17.686	Construction Immobiliere			Dakar	\N	\N	\N	f	\N
2777	Sages Sarl (Societe Africaine Genie Electrique)	sages-sarl-societe-africaine-genie-electrique	Genie Electrique	\N	6	2026-03-02 23:11:17.699	2026-03-02 23:11:17.699	Genie Electrique			Dakar	\N	\N	\N	f	\N
2778	Smec Sarl (Societe Montage Electricite Construction)	smec-sarl-societe-montage-electricite-construction	Montage Electrique	\N	6	2026-03-02 23:11:17.702	2026-03-02 23:11:17.702	Montage Electrique			Dakar	\N	\N	\N	f	\N
2779	Gcm Sa (Genie Civil Moderne)	gcm-sa-genie-civil-moderne	Genie Civil	\N	6	2026-03-02 23:11:17.704	2026-03-02 23:11:17.704	Genie Civil			Dakar	\N	\N	\N	f	\N
2780	Sni Sa (Societe Nouvelle Immobiliere)	sni-sa-societe-nouvelle-immobiliere	Promotion Immobiliere	\N	6	2026-03-02 23:11:17.706	2026-03-02 23:11:17.706	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2790	Touba Construction Sarl	touba-construction-sarl	Construction Batiment	\N	6	2026-03-02 23:11:17.73	2026-03-02 23:11:17.73	Construction Batiment			Touba	\N	\N	\N	f	\N
2791	Kaolack Btp Sarl	kaolack-btp-sarl	Batiment Et Travaux Publics	\N	6	2026-03-02 23:11:17.732	2026-03-02 23:11:17.732	Batiment Et Travaux Publics			Kaolack	\N	\N	\N	f	\N
2792	Saint Louis Construction Sa	saint-louis-construction-sa	Construction Et Btp	\N	6	2026-03-02 23:11:17.734	2026-03-02 23:11:17.734	Construction Et Btp			Saint-Louis	\N	\N	\N	f	\N
2793	Grp Sa (Groupement Realisation Publique)	grp-sa-groupement-realisation-publique	Travaux Publics	\N	6	2026-03-02 23:11:17.736	2026-03-02 23:11:17.736	Travaux Publics			Dakar	\N	\N	\N	f	\N
2794	Ets Ba Construction Sarl	ets-ba-construction-sarl	Construction Et Btp	\N	6	2026-03-02 23:11:17.738	2026-03-02 23:11:17.738	Construction Et Btp			Dakar	\N	\N	\N	f	\N
2795	Sogem Sa (Societe Generale Materiaux)	sogem-sa-societe-generale-materiaux	Materiaux Batiment	\N	6	2026-03-02 23:11:17.741	2026-03-02 23:11:17.741	Materiaux Batiment			Dakar	\N	\N	\N	f	\N
2796	Sntr Sarl (Societe Nationale Travaux Routiers)	sntr-sarl-societe-nationale-travaux-routiers	Travaux Routiers	\N	6	2026-03-02 23:11:17.743	2026-03-02 23:11:17.743	Travaux Routiers			Dakar	\N	\N	\N	f	\N
2797	Sea Sa (Societe Entretien Autoroutes)	sea-sa-societe-entretien-autoroutes	Entretien Infrastructure Routiere	\N	6	2026-03-02 23:11:17.745	2026-03-02 23:11:17.745	Entretien Infrastructure Routiere			Dakar	\N	\N	\N	f	\N
2798	Rts Sa (Route Travaux Senegal)	rts-sa-route-travaux-senegal	Construction Routes	\N	6	2026-03-02 23:11:17.747	2026-03-02 23:11:17.747	Construction Routes			Dakar	\N	\N	\N	f	\N
2799	Eiffage Senegal Sa	eiffage-senegal-sa	Construction Et Btp	\N	6	2026-03-02 23:11:17.749	2026-03-02 23:11:17.749	Construction Et Btp			Dakar	\N	\N	\N	f	\N
2800	Sogea-Satom Senegal	sogea-satom-senegal	Genie Civil Et Construction	\N	6	2026-03-02 23:11:17.751	2026-03-02 23:11:17.751	Genie Civil Et Construction			Dakar	\N	\N	\N	f	\N
2801	Bouygues Batiment Senegal	bouygues-batiment-senegal	Construction Batiment	\N	6	2026-03-02 23:11:17.755	2026-03-02 23:11:17.755	Construction Batiment			Dakar	\N	\N	\N	f	\N
2802	Vinci Construction Senegal	vinci-construction-senegal	Construction Generale	\N	6	2026-03-02 23:11:17.757	2026-03-02 23:11:17.757	Construction Generale			Dakar	\N	\N	\N	f	\N
2803	Colas Senegal Sa	colas-senegal-sa	Construction Routes Et Voiries	\N	6	2026-03-02 23:11:17.759	2026-03-02 23:11:17.759	Construction Routes Et Voiries			Dakar	\N	\N	\N	f	\N
2804	Morandi Et Associes Sa	morandi-et-associes-sa	Architecture Et Ingenierie	\N	6	2026-03-02 23:11:17.761	2026-03-02 23:11:17.761	Architecture Et Ingenierie			Dakar	\N	\N	\N	f	\N
2805	Sabec Sa (Societe Africaine Batiment)	sabec-sa-societe-africaine-batiment	Construction Batiment	\N	6	2026-03-02 23:11:17.763	2026-03-02 23:11:17.763	Construction Batiment			Dakar	\N	\N	\N	f	\N
2806	Sgbtp Sarl (Societe Generale Btp)	sgbtp-sarl-societe-generale-btp	Batiment Et Travaux Publics	\N	6	2026-03-02 23:11:17.765	2026-03-02 23:11:17.765	Batiment Et Travaux Publics			Dakar	\N	\N	\N	f	\N
2807	Stb Sarl (Societe Travaux Batiment)	stb-sarl-societe-travaux-batiment	Travaux Batiment	\N	6	2026-03-02 23:11:17.767	2026-03-02 23:11:17.767	Travaux Batiment			Dakar	\N	\N	\N	f	\N
2351	Sosemat Sa (Societe Senegalaise De Materiaux)	sosemat-sa-societe-senegalaise-de-materiaux	Production (Fer A Beton (70%) Et Zing (19,86%) Et Importation De Materiaux (10,14%)	\N	2	2026-03-02 23:11:16.503	2026-03-02 23:11:16.503	Production (Fer A Beton (70%) Et Zing (19,86%) Et Importation De Materiaux (10,14%)	Bccd	33 820 21 22	Dakar	\N	\N	\N	f	\N
2352	Khalil Koleit Autres	khalil-koleit-autres-1	Commerces	\N	2	2026-03-02 23:11:16.506	2026-03-02 23:11:16.506	Commerces	Rue Robert Brun	33 859 97 97	Dakar	\N	\N	\N	f	\N
2353	Eydon - Sa (Eydon Petroleum - Sa)	eydon-sa-eydon-petroleum-sa-1	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:16.509	2026-03-02 23:11:16.509	Vente De Produits Petroliers (Station D'Essence)	Rue Dr Calmette	33 839 82 62	Dakar	\N	\N	\N	f	\N
2354	Rufsac - Sa (Rufisquoise De	rufsac-sa-rufisquoise-de-1	Fabrication De Sacs) Fabrication De Sacs En Papiers Kraft	\N	7	2026-03-02 23:11:16.512	2026-03-02 23:11:16.512	Fabrication De Sacs) Fabrication De Sacs En Papiers Kraft	Route De Rufisque * Cap Des Biches	33 889 51 70	Rufisque	\N	\N	\N	f	\N
2355	Esd (Equipement &	esd-equipement	Services Dakar) Services Principalement Rendus Aux Entreprises	\N	3	2026-03-02 23:11:16.514	2026-03-02 23:11:16.514	Services Dakar) Services Principalement Rendus Aux Entreprises	Route De Ouakam	33 825 17 47	Dakar	\N	\N	\N	f	\N
2356	Sencom - Sarl (Senegalaise De	sencom-sarl-senegalaise-de-1	Commerce) Vente De Riz Bcccd (Ex 79	\N	2	2026-03-02 23:11:16.517	2026-03-02 23:11:16.517	Commerce) Vente De Riz Bcccd (Ex 79	Rue Joseph Gomis (Ex - Bayeux)	33 975 15 88	Dakar	\N	\N	\N	f	\N
2357	Gfl - Sa (Groupe Fauzie Layousse - Ex Ets) Transport -	gfl-sa-groupe-fauzie-layousse-ex-ets-transport-3	Commerce Import/Export	\N	2	2026-03-02 23:11:16.522	2026-03-02 23:11:16.522	Commerce Import/Export	Route De Rufisque	33 832 07 07	Rufisque	\N	\N	\N	f	\N
2358	Technocell	technocell-1	Commerce	\N	2	2026-03-02 23:11:16.525	2026-03-02 23:11:16.525	Commerce	Route De L'Aeroport Almadies	33 821 02 08	Dakar	\N	\N	\N	f	\N
2359	Ccm (Comptoir Commercial Mariama)	ccm-comptoir-commercial-mariama-1	Commerce General	\N	2	2026-03-02 23:11:16.528	2026-03-02 23:11:16.528	Commerce General	Rue Raffenel	33 855 94 95	Dakar	\N	\N	\N	f	\N
2360	Cda (Chaine De	cda-chaine-de-1	Distribution Alimentaire) Vente De Marchandises - Boucherie (59,25%)- Fabrication D'Autres Produits Alimentaires (40,25%)	\N	2	2026-03-02 23:11:16.532	2026-03-02 23:11:16.532	Distribution Alimentaire) Vente De Marchandises - Boucherie (59,25%)- Fabrication D'Autres Produits Alimentaires (40,25%)	Rue Du Docteur Theze	33 869 33 33	Dakar	\N	\N	\N	f	\N
2361	Diprom - Sa	diprom-sa	(Distribution De Produits Metalliques) Production Metallurgie ( 48,27% ) Et Gaz( 50,6%)	\N	1	2026-03-02 23:11:16.534	2026-03-02 23:11:16.534	(Distribution De Produits Metalliques) Production Metallurgie ( 48,27% ) Et Gaz( 50,6%)	Bccd	33 869 31 81	Dakar	\N	\N	\N	f	\N
2362	Ets Said Noujaim Freres Sa Industrie De Confiserie -	ets-said-noujaim-freres-sa-industrie-de-confiserie-1	Commerce - Vente Emballages - Location	\N	2	2026-03-02 23:11:16.537	2026-03-02 23:11:16.537	Commerce - Vente Emballages - Location	Immeuble - Vente Matieres Premieres Confiserie Avenue Lamine Gueye	33 839 90 39	Dakar	\N	\N	\N	f	\N
2363	Cstm - Sa (Cie Senegalaise Pour La Transformation Des Metaux)	cstm-sa-cie-senegalaise-pour-la-transformation-des-metaux	Fabrication D'Articles De Menages En Alu - Toles Et Bacs Alu De Toiture	\N	7	2026-03-02 23:11:16.539	2026-03-02 23:11:16.539	Fabrication D'Articles De Menages En Alu - Toles Et Bacs Alu De Toiture	Bccd	33 839 90 00	Dakar	\N	\N	\N	f	\N
2364	Smc Sarl (Societe Senegalaise Mauritanienne De	smc-sarl-societe-senegalaise-mauritanienne-de-1	Commerce Commerce	\N	2	2026-03-02 23:11:16.542	2026-03-02 23:11:16.542	Commerce Commerce	Rue Robert Brun	33 832 06 83	Dakar	\N	\N	\N	f	\N
2365	Scdf Sarl (Societe Commerciale Diakhate & Fils)	scdf-sarl-societe-commerciale-diakhate-fils-1	Commerce General	\N	2	2026-03-02 23:11:16.545	2026-03-02 23:11:16.545	Commerce General	Rue Tolbiac	33 834 68 87	Dakar	\N	\N	\N	f	\N
2366	Maha	maha-1	Distribution Sarl Services Hydrocarbure	\N	1	2026-03-02 23:11:16.548	2026-03-02 23:11:16.548	Distribution Sarl Services Hydrocarbure	Boulevard Maurice Gueye Rufisque	33 842 29 39	Rufisque	\N	\N	\N	f	\N
2367	Sanofi Aventis Senegal (Ex Sanofi Synthelabo Afo)	sanofi-aventis-senegal-ex-sanofi-synthelabo-afo-1	Fabrication De Produit Pharmaceutique (Promotion Pharmaceutique) Point E	\N	5	2026-03-02 23:11:16.551	2026-03-02 23:11:16.551	Fabrication De Produit Pharmaceutique (Promotion Pharmaceutique) Point E	Immeuble Epi	77 556 45 75	Dakar	\N	\N	\N	f	\N
2368	Sonatel Multimedia - Sa (Ex - Telecom Plus - Sa En 2000) Commercialisation De Produits Et	sonatel-multimedia-sa-ex-telecom-plus-sa-en-2000-commercialisation-de-produits-et	Services De Telecommunication Stele Mermoz -	\N	9	2026-03-02 23:11:16.553	2026-03-02 23:11:16.553	Services De Telecommunication Stele Mermoz -	Route De Ouakam	33 865 02 02	Dakar	\N	\N	\N	f	\N
2369	Intertrade Senegal Suarl	intertrade-senegal-suarl-1	Commerce	\N	2	2026-03-02 23:11:16.556	2026-03-02 23:11:16.556	Commerce	Bccd	33 835 00 27	Dakar	\N	\N	\N	f	\N
2370	Ciel Oil (Etablissement Galaye Ndiaye)	ciel-oil-etablissement-galaye-ndiaye-1	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:16.559	2026-03-02 23:11:16.559	Vente De Produits Petroliers	Bccd	77 639 88 84	Dakar	\N	\N	\N	f	\N
2371	Sera Sa (Ste D'Equipement Et De Representation Automobile)	sera-sa-ste-d-equipement-et-de-representation-automobile-1	Commerce Vehicule - Autres Comerces - Entretien Et Reparation Vehicules Automobiles	\N	2	2026-03-02 23:11:16.562	2026-03-02 23:11:16.562	Commerce Vehicule - Autres Comerces - Entretien Et Reparation Vehicules Automobiles	Bccd	33 957 64 64	Dakar	\N	\N	\N	f	\N
2372	Scl (Societe De Cultures Legumieres) Culture De Mais Doux Residence Elisa - Sor - Saint-Louis 33	scl-societe-de-cultures-legumieres-culture-de-mais-doux-residence-elisa-sor-saint-louis-33-1	Fabrication De Futs Metalliques - Emballages Plastiques - Toles Metalliques - Location - Ventes D'Accessoires	\N	2	2026-03-02 23:11:16.565	2026-03-02 23:11:16.565	Fabrication De Futs Metalliques - Emballages Plastiques - Toles Metalliques - Location - Ventes D'Accessoires	Bccd	33 849 32 60	Saint-Louis	\N	\N	\N	f	\N
2373	Sotrapal (Ste De Transformation De Produit Alimentaire) Industrie Laitiere (Prestations De	sotrapal-ste-de-transformation-de-produit-alimentaire-industrie-laitiere-prestations-de	Services	\N	4	2026-03-02 23:11:16.568	2026-03-02 23:11:16.568	Services	Bccd	33 822 17 91	Dakar	\N	\N	\N	f	\N
2374	Senac Sa (Senegalaise De L'Amiante Ciment)	senac-sa-senegalaise-de-l-amiante-ciment	Production De Materaux De Construction - (Peinture :93,75%, Fibro Ciment : 0, Tuiles : 3,71%, Services )	\N	6	2026-03-02 23:11:16.57	2026-03-02 23:11:16.57	Production De Materaux De Construction - (Peinture :93,75%, Fibro Ciment : 0, Tuiles : 3,71%, Services )	Avenue Lamine Gueye X Rue Monteil	33 879 16 60	Dakar	\N	\N	\N	f	\N
2375	Winthrop Pharma Senegal (Ex Africasoins	winthrop-pharma-senegal-ex-africasoins-1	Production (Ex Aventis Pharma - Sa Industrie Pharmaceutique	\N	5	2026-03-02 23:11:16.573	2026-03-02 23:11:16.573	Production (Ex Aventis Pharma - Sa Industrie Pharmaceutique	Route De Rufisque	33 829 57 00	Dakar	\N	\N	\N	f	\N
2376	Ccs Sa (Comptoir Commercial Du Senegal)	ccs-sa-comptoir-commercial-du-senegal-1	Commerce - Import/Export Materiels Sanitaires	\N	2	2026-03-02 23:11:16.576	2026-03-02 23:11:16.576	Commerce - Import/Export Materiels Sanitaires	Avenue Malick Sy X Autoroute Passage Gare Routiere	33 849 61 61	Dakar	\N	\N	\N	f	\N
2377	Groupe Safcom (Societe Africaine De	groupe-safcom-societe-africaine-de-1	Commerce) Commerce Cite Sipres Mourtada (Ex 12	\N	2	2026-03-02 23:11:16.58	2026-03-02 23:11:16.58	Commerce) Commerce Cite Sipres Mourtada (Ex 12	Rue W Agane Diouf	33 865 15 55	Dakar	\N	\N	\N	f	\N
2378	Aridim Sarl	aridim-sarl-1	Commerce	\N	2	2026-03-02 23:11:16.583	2026-03-02 23:11:16.583	Commerce	Rue Tolbiac	33 869 30 70	Dakar	\N	\N	\N	f	\N
2379	Kerry Trade Sarl	kerry-trade-sarl-1	Commerce General Zone Industrielle	\N	2	2026-03-02 23:11:16.587	2026-03-02 23:11:16.587	Commerce General Zone Industrielle	Rue 4	77 360 05 59	Dakar	\N	\N	\N	f	\N
2380	Ets Mahmoud Meroueh	ets-mahmoud-meroueh-1	Commerce - Import/Export	\N	2	2026-03-02 23:11:16.59	2026-03-02 23:11:16.59	Commerce - Import/Export	Rue Mousse Diop (Ex - Blanchot)	77 638 77 30	Dakar	\N	\N	\N	f	\N
2381	Ccbme - Sarl (Comptoir Commercial Bara Mboup Electronique)	ccbme-sarl-comptoir-commercial-bara-mboup-electronique-1	Commerce General - Electronique - Marchandises Diverses	\N	2	2026-03-02 23:11:16.593	2026-03-02 23:11:16.593	Commerce General - Electronique - Marchandises Diverses	Avenue Lamine Gueye	33 825 73 51	Dakar	\N	\N	\N	f	\N
2382	Ccbmh Sa (Ex Comptoir Commercial Bara Mboup) Autres	ccbmh-sa-ex-comptoir-commercial-bara-mboup-autres-1	Services	\N	2	2026-03-02 23:11:16.597	2026-03-02 23:11:16.597	Services	Immobiliers (Exercice Precedant = Commerce General) Avenue Lamine Gueye (Ex Adresse = Sodida - Lot 2B Est)	33 859 09 00	Dakar	\N	\N	\N	f	\N
2383	Nina (Venus Industrie Inc - Sarl)	nina-venus-industrie-inc-sarl	Fabrication De Meches Artificielles	\N	7	2026-03-02 23:11:16.6	2026-03-02 23:11:16.6	Fabrication De Meches Artificielles	Route De Rufisque - Mbao	33 834 95 11	Dakar	\N	\N	\N	f	\N
2384	Mamadou Barry	mamadou-barry-1	Commerce Santhiaba Ziguinchor 776325512 Dakar Agroline Sa Autres Industries Alimentaires	\N	2	2026-03-02 23:11:16.603	2026-03-02 23:11:16.603	Commerce Santhiaba Ziguinchor 776325512 Dakar Agroline Sa Autres Industries Alimentaires	Route De Rufisque	33 837 74 41	Ziguinchor	\N	\N	\N	f	\N
2385	Sogepal - Sarl (Societe Generale De Produits Alimentaires)	sogepal-sarl-societe-generale-de-produits-alimentaires	Fabrication De Produits D'Assaisonnement	\N	4	2026-03-02 23:11:16.605	2026-03-02 23:11:16.605	Fabrication De Produits D'Assaisonnement	Bccd - Rue 7	33 823 68 10	Dakar	\N	\N	\N	f	\N
2386	Bia Dakar (Ex Art, Atelier De Renovation Et De Transformation)	bia-dakar-ex-art-atelier-de-renovation-et-de-transformation	Services Rendus Principalement Aux Entreprises	\N	3	2026-03-02 23:11:16.607	2026-03-02 23:11:16.607	Services Rendus Principalement Aux Entreprises	Route De Rufisque	33 823 32 83	Dakar	\N	\N	\N	f	\N
2387	Snhlm - Sa Mixte (Ste Nationale Des Habitations A Loyer Moderes)	snhlm-sa-mixte-ste-nationale-des-habitations-a-loyer-moderes-1	Service	\N	3	2026-03-02 23:11:16.611	2026-03-02 23:11:16.611	Service	Immobilier Du Logement Colobane - Rue 34	33 836 89 39	Dakar	\N	\N	\N	f	\N
2388	Ccis (Compagnie Commerciale Et Industrielle Du Senegal)	ccis-compagnie-commerciale-et-industrielle-du-senegal	Fabrication E Matieres Plastiques Hann -	\N	7	2026-03-02 23:11:16.614	2026-03-02 23:11:16.614	Fabrication E Matieres Plastiques Hann -	Route Du Front De Terre X Rue Du Service Geographique	33 824 90 25	Dakar	\N	\N	\N	f	\N
2389	Sicof - Sarl (Societe Industrielle Commerciale Et Financiere Harati & Freres)	sicof-sarl-societe-industrielle-commerciale-et-financiere-harati-freres-1	Commerce Alimentaire	\N	2	2026-03-02 23:11:16.617	2026-03-02 23:11:16.617	Commerce Alimentaire	Rue Raffenel	33 849 39 39	Dakar	\N	\N	\N	f	\N
2390	Redington Senegal Limited Sarl	redington-senegal-limited-sarl-1	Commerce General-Import- Export	\N	2	2026-03-02 23:11:16.62	2026-03-02 23:11:16.62	Commerce General-Import- Export	Rue Non Denommee Imm Abc Rond Point Jet D'Eau	33 869 31 50	Dakar	\N	\N	\N	f	\N
2391	Cogesen - Sarl	cogesen-sarl	Commerce General	\N	2	2026-03-02 23:11:16.622	2026-03-02 23:11:16.622	Commerce General	Rue Marchand X Autoroute	33 869 71 00	Dakar	\N	\N	\N	f	\N
2392	Station Shell Pasteur Et Shell Unit ( Khaled Ayache)-	station-shell-pasteur-et-shell-unit-khaled-ayache-1	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:16.626	2026-03-02 23:11:16.626	Vente De Produits Petroliers (Station D'Essence)	Avenue Pasteur	33 864 36 55	Dakar	\N	\N	\N	f	\N
2393	Valdafrique - Labo Canonne - Sa Industries Pharmaceutiques - Autres	valdafrique-labo-canonne-sa-industries-pharmaceutiques-autres-2	Commerces - Services Rendus Auf Entreprises	\N	2	2026-03-02 23:11:16.631	2026-03-02 23:11:16.631	Commerces - Services Rendus Auf Entreprises	Route De Diokoul - Rufisque	33 823 19 66	Dakar	\N	\N	\N	f	\N
2394	Sirmel Senegal - Sa	sirmel-senegal-sa-1	Commerce De Materiels Electriques	\N	2	2026-03-02 23:11:16.634	2026-03-02 23:11:16.634	Commerce De Materiels Electriques	Route De Rufisque Thiaroye Dur Mer	33 953 51 92	Dakar	\N	\N	\N	f	\N
2395	Neptune Oil Senegal Achat	neptune-oil-senegal-achat-1	Vente De Produits Hydrocarbures	\N	1	2026-03-02 23:11:16.638	2026-03-02 23:11:16.638	Vente De Produits Hydrocarbures	Route De Ngor,Face Stade Municipal Ngor	33 879 12 11	Dakar	\N	\N	\N	f	\N
2396	Sosecar Sa (Ste Senegalaise D'Exploitation De Carriere)	sosecar-sa-ste-senegalaise-d-exploitation-de-carriere-1	Fabrication De Produits Mineraux Pour La Construction	\N	6	2026-03-02 23:11:16.641	2026-03-02 23:11:16.641	Fabrication De Produits Mineraux Pour La Construction	Avenue Ousmane Soce Diop - Rufisque	33 869 62 82	Rufisque	\N	\N	\N	f	\N
2397	Solidis Sarl	solidis-sarl-1	Commerce	\N	2	2026-03-02 23:11:16.644	2026-03-02 23:11:16.644	Commerce	Rue Felix Eboue	33 836 33 51	Dakar	\N	\N	\N	f	\N
2398	Waf Commodities (West Africa Commodities)	waf-commodities-west-africa-commodities-2	Commerce De Produits Agricoles	\N	2	2026-03-02 23:11:16.648	2026-03-02 23:11:16.648	Commerce De Produits Agricoles	Rue Malan Immeuble El ectra	33 825 30 11	Dakar	\N	\N	\N	f	\N
2399	Ets Jamil Tarraf & Cie	ets-jamil-tarraf-cie-2	Commerce Alimentaire - Import/Export	\N	2	2026-03-02 23:11:16.652	2026-03-02 23:11:16.652	Commerce Alimentaire - Import/Export	Rue Raffenel	33 889 79 50	Dakar	\N	\N	\N	f	\N
2400	Sedad Sarl	sedad-sarl-2	Distribution Engrais, Semences Produits Phytos	\N	2	2026-03-02 23:11:16.656	2026-03-02 23:11:16.656	Distribution Engrais, Semences Produits Phytos	Bccd, Imm Beau Rivage	33 821 28 99	Dakar	\N	\N	\N	f	\N
2401	Mbacke & Freres Surl	mbacke-freres-surl-3	Commerce Produits Alimentaires Et Transport	\N	2	2026-03-02 23:11:16.661	2026-03-02 23:11:16.661	Commerce Produits Alimentaires Et Transport	Route De L'Hopital - Marche Ourossogui	33 832 56 29	Ourossogui	\N	\N	\N	f	\N
2402	Cda (Chaine De	cda-chaine-de-2	Distribution Alimentaire) Vente De Marchandises - Boucherie (59,25%)- Fabrication D'Autres Produits Alimentaires (40,25%)	\N	2	2026-03-02 23:11:16.664	2026-03-02 23:11:16.664	Distribution Alimentaire) Vente De Marchandises - Boucherie (59,25%)- Fabrication D'Autres Produits Alimentaires (40,25%)	Rue Du Docteur Theze	33 823 11 83	Dakar	\N	\N	\N	f	\N
2403	Sicof - Sarl (Societe Industrielle Commerciale Et Financiere Harati & Freres)	sicof-sarl-societe-industrielle-commerciale-et-financiere-harati-freres-2	Commerce Alimentaire	\N	2	2026-03-02 23:11:16.668	2026-03-02 23:11:16.668	Commerce Alimentaire	Rue Raffenel	33 821 84 17	Dakar	\N	\N	\N	f	\N
2404	Sosagrin Sa (Societe Senegalaise Agro- Industrielle) Industrie Agroalimentaire De Transformation -	sosagrin-sa-societe-senegalaise-agro-industrielle-industrie-agroalimentaire-de-transformation-1	Vente De Produits Agro- Alimentaires	\N	2	2026-03-02 23:11:16.671	2026-03-02 23:11:16.671	Vente De Produits Agro- Alimentaires	Bccd	33 870 07 79	Dakar	\N	\N	\N	f	\N
2405	Spia Sa (Societe Des Produits Industriels Et Agricoles)	spia-sa-societe-des-produits-industriels-et-agricoles	Fabrication De Pdts Agro- Chimiques Vdn Ouest Foire Lot N° 3 ( Ex 56	\N	4	2026-03-02 23:11:16.673	2026-03-02 23:11:16.673	Fabrication De Pdts Agro- Chimiques Vdn Ouest Foire Lot N° 3 ( Ex 56	Avenue Faidherbe Dakar Ou Zone Industrielle )	33 832 18 88	Dakar	\N	\N	\N	f	\N
2406	Tropicasem - Sa	tropicasem-sa-1	Distribution De Semences Maraichers - Micro Irrigation	\N	2	2026-03-02 23:11:16.677	2026-03-02 23:11:16.677	Distribution De Semences Maraichers - Micro Irrigation	Bccd	77 332 62 16	Dakar	\N	\N	\N	f	\N
2407	Mi - Dis Sa (Midadi	mi-dis-sa-midadi-1	Distribution) Distribution - Commerece Alimentaire	\N	2	2026-03-02 23:11:16.68	2026-03-02 23:11:16.68	Distribution) Distribution - Commerece Alimentaire	Rue Raffenel	33 832 05 05	Dakar	\N	\N	\N	f	\N
2408	Afitex Afrique Sarl Represenation Et	afitex-afrique-sarl-represenation-et-1	Distribution De Produits Agricoles Et Industriels Toute Des Almadies,	\N	2	2026-03-02 23:11:16.683	2026-03-02 23:11:16.683	Distribution De Produits Agricoles Et Industriels Toute Des Almadies,	Immeuble Oasis 1	33 853 28 28	Dakar	\N	\N	\N	f	\N
2409	Sodial (Societe De	sodial-societe-de-1	Distribution Alimentaire) Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:16.686	2026-03-02 23:11:16.686	Distribution Alimentaire) Commerce De Produits Alimentaires	Rue Paul Holle 33821 18 92 Dakar Finamark - Sarl Autres Commerces - Import/Export Produits Alimentaire Parcelles Assainies De Guentaba Lot N° 16	33 963 30 18	Dakar	\N	\N	\N	f	\N
2410	Prodas Sarl	prodas-sarl-1	Vente D'Aliments Et Poussins Village De Toglou Cr De Diass 0 Dakar Mapal (Manufacture De Produits Alimentaires) Industrie Alimentaire	\N	2	2026-03-02 23:11:16.69	2026-03-02 23:11:16.69	Vente D'Aliments Et Poussins Village De Toglou Cr De Diass 0 Dakar Mapal (Manufacture De Produits Alimentaires) Industrie Alimentaire	Bccd	33 855 86 13	Mbour	\N	\N	\N	f	\N
2411	Equip Plus - Sa	equip-plus-sa-1	Vente De Materiels Agricoles - Industriels - Scolaires	\N	2	2026-03-02 23:11:16.693	2026-03-02 23:11:16.693	Vente De Materiels Agricoles - Industriels - Scolaires	Bccd	33 889 33 33	Dakar	\N	\N	\N	f	\N
2412	Africa Chips Senegal Suarl	africa-chips-senegal-suarl	Production De Chips Alimentaires Km 3	\N	4	2026-03-02 23:11:16.695	2026-03-02 23:11:16.695	Production De Chips Alimentaires Km 3	Route De Rufis que	33 832 32 32	Dakar	\N	\N	\N	f	\N
2413	Touba	touba	Commerce - Sarl Vente De Produits Alimentaires Pikine	\N	2	2026-03-02 23:11:16.698	2026-03-02 23:11:16.698	Commerce - Sarl Vente De Produits Alimentaires Pikine	Route Des Niay es	33 832 76 75	Pikine	\N	\N	\N	f	\N
2414	Sepam - Sa (Ste D'Exploitation Des Produits Agricoles Et Maraichers)	sepam-sa-ste-d-exploitation-des-produits-agricoles-et-maraichers	Production Et Exportation De Produits Maraîchers Et Agricoles	\N	2	2026-03-02 23:11:16.7	2026-03-02 23:11:16.7	Production Et Exportation De Produits Maraîchers Et Agricoles	Avenue Ousmane Soce Diop - Rufisque	77 638 65 13	Rufisque	\N	\N	\N	f	\N
2415	Mor Mbaye Sylla	mor-mbaye-sylla-2	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:16.705	2026-03-02 23:11:16.705	Commerce De Produits Alimentaires	Rue Escale Quartie r Thikhna Louga	33 836 11 81	Louga	\N	\N	\N	f	\N
2416	Senchim - Sa	senchim-sa	Fabrication De Produits Agro-Chimique: (Angrais - Phytosanitaire ) Commercialisation Des Pdts Des Ics	\N	4	2026-03-02 23:11:16.707	2026-03-02 23:11:16.707	Fabrication De Produits Agro-Chimique: (Angrais - Phytosanitaire ) Commercialisation Des Pdts Des Ics	Route De Rufisque	77 569 02 22	Dakar	\N	\N	\N	f	\N
2417	Semac Sa (Societe Senegalaise De Marchandises Diverses)	semac-sa-societe-senegalaise-de-marchandises-diverses-1	Commerce De Produits Agricoles	\N	2	2026-03-02 23:11:16.71	2026-03-02 23:11:16.71	Commerce De Produits Agricoles	Rue Malan	33 879 14 44	Dakar	\N	\N	\N	f	\N
2418	Sonia Sarl (Ste Nouvelle D'Industrie Alimentaire)	sonia-sarl-ste-nouvelle-d-industrie-alimentaire	Fabrication De Pdts Alimentaires - Moutarde - Piment - Bouillon Sodida - Lots N° 40-41 33824 55 27 Dakar Produmel Senegal Suarl Agriculture/ Production De Melons Sebikhotane,Quatier Darou	\N	4	2026-03-02 23:11:16.713	2026-03-02 23:11:16.713	Fabrication De Pdts Alimentaires - Moutarde - Piment - Bouillon Sodida - Lots N° 40-41 33824 55 27 Dakar Produmel Senegal Suarl Agriculture/ Production De Melons Sebikhotane,Quatier Darou	Salam,Rue 10 Rufisque	33 966 16 49	Dakar	\N	\N	\N	f	\N
2419	Cosemad (Compagnie Senegalaise Mariama Dieng )	cosemad-compagnie-senegalaise-mariama-dieng-1	Commerce General - Alimentaire Sacre	\N	2	2026-03-02 23:11:16.718	2026-03-02 23:11:16.718	Commerce General - Alimentaire Sacre	Rue En Face Immeuble Mariama (39 X 22 Medina)	33 832 88 18	Dakar	\N	\N	\N	f	\N
2420	Sen-Alimentation Sarl	sen-alimentation-sarl-1	Commerce Produits Alimentaires	\N	2	2026-03-02 23:11:16.721	2026-03-02 23:11:16.721	Commerce Produits Alimentaires	Rue Galandou Diouf	33 859 17 67	Dakar	\N	\N	\N	f	\N
2421	Nosopal (Nouvelle Societe De	nosopal-nouvelle-societe-de	Production) Fabrication De Produits Alimentaires	\N	4	2026-03-02 23:11:16.723	2026-03-02 23:11:16.723	Production) Fabrication De Produits Alimentaires	Route De Rufisque Zfid Mbao (Ex Rue Colbert X Felix Faure	33 879 16 17	Dakar	\N	\N	\N	f	\N
2422	Societe 3 F - Sarl Transformation Conditionnement Et	societe-3-f-sarl-transformation-conditionnement-et-1	Commerce Des Pdts Chimiques Et Alimentaires(Sucre, Bicarbonnate, Autres,…) Hann -	\N	2	2026-03-02 23:11:16.727	2026-03-02 23:11:16.727	Commerce Des Pdts Chimiques Et Alimentaires(Sucre, Bicarbonnate, Autres,…) Hann -	Route De La Pharmacie Nationale -	33 969 19 33	Dakar	\N	\N	\N	f	\N
2423	Moustapha Tall Sa	moustapha-tall-sa-1	Commerce Denrees Alimentaires	\N	2	2026-03-02 23:11:16.732	2026-03-02 23:11:16.732	Commerce Denrees Alimentaires	Rue Amadou Lakhsane Nd oye X Raffenel	33 860 63 66	Dakar	\N	\N	\N	f	\N
2424	Epicerie Du Coin (Elie Mejaes Chouery Et Fils)	epicerie-du-coin-elie-mejaes-chouery-et-fils-2	Commerce General Alimentaire	\N	2	2026-03-02 23:11:16.737	2026-03-02 23:11:16.737	Commerce General Alimentaire	Avenue Malick Sy - Esca le - Mbour	33 836 89 80	Mbour	\N	\N	\N	f	\N
2425	Elias Fazah (Ets Elias Fazah)	elias-fazah-ets-elias-fazah-1	Commerce De Produits Alimentaire - Pdts De Boulangerie - Patisserie (Voir Si Activité 2Fff Est Uniquemement Commerce)	\N	2	2026-03-02 23:11:16.742	2026-03-02 23:11:16.742	Commerce De Produits Alimentaire - Pdts De Boulangerie - Patisserie (Voir Si Activité 2Fff Est Uniquemement Commerce)	Rue Robert Brun	77 636 55 26	Dakar	\N	\N	\N	f	\N
2426	Tass Diffusion Sarl	tass-diffusion-sarl-1	Commerce De Produits Agro Alimentaires	\N	2	2026-03-02 23:11:16.747	2026-03-02 23:11:16.747	Commerce De Produits Agro Alimentaires	Avenue Lamine Gueye	33 823 36 68	Dakar	\N	\N	\N	f	\N
2427	Suncard Family Market Sarl	suncard-family-market-sarl-1	Commerce De Produits Alimentaires Liberte Vi Extensi on,	\N	2	2026-03-02 23:11:16.751	2026-03-02 23:11:16.751	Commerce De Produits Alimentaires Liberte Vi Extensi on,	Immeuble Soda Marieme	33 842 34 34	Dakar	\N	\N	\N	f	\N
2428	3F Senegal Suarl	3f-senegal-suarl-1	Vente De Produits Alimentaires	\N	2	2026-03-02 23:11:16.756	2026-03-02 23:11:16.756	Vente De Produits Alimentaires	Quartier Boucotte Sud	33 836 00 72	Ziguinchor	\N	\N	\N	f	\N
2429	Asl - Laboratoire De Recherche	asl-laboratoire-de-recherche	Services Annexes A L'Agriculture	\N	5	2026-03-02 23:11:16.758	2026-03-02 23:11:16.758	Services Annexes A L'Agriculture	Bccd - Yarakh	33 821 37 83	Dakar	\N	\N	\N	f	\N
2430	Surl Keur Faty Ndiaga Sylla	surl-keur-faty-ndiaga-sylla-1	Vente De Produits Alimentaires Pikine	\N	2	2026-03-02 23:11:16.763	2026-03-02 23:11:16.763	Vente De Produits Alimentaires Pikine	Route Des Niay es Plle N° 7275	33 832 83 50	Pikine	\N	\N	\N	f	\N
2431	Buur Sine International Sarl Importation Et	buur-sine-international-sarl-importation-et	Production De Produits Agricoles	\N	2	2026-03-02 23:11:16.766	2026-03-02 23:11:16.766	Production De Produits Agricoles	Imme uble Cdeao Hann Mariste	33 860 70 60	Dakar	\N	\N	\N	f	\N
2432	Skl Sarl	skl-sarl-1	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:16.77	2026-03-02 23:11:16.77	Commerce De Produits Alimentaires	Rue Robert Brun	33 832 12 81	Dakar	\N	\N	\N	f	\N
2433	Mamadou Cire Diallo	mamadou-cire-diallo-1	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:16.774	2026-03-02 23:11:16.774	Commerce De Produits Alimentaires	Rue Grasland	33 823 18 14	Dakar	\N	\N	\N	f	\N
2434	Entreprise Activité Adresse Téléphone Dakar Liaison Commerciale Du Senegal, Lcs (Mouhamadoul Habib	entreprise-activite-adresse-telephone-dakar-liaison-commerciale-du-senegal-lcs-mouhamadoul-habib	Ventes D'Arachides Camberene	\N	2	2026-03-02 23:11:16.778	2026-03-02 23:11:16.778	Ventes D'Arachides Camberene	Quartier Degg o Dakar	33 823 18 14	Ville	\N	\N	\N	f	\N
2435	Novasen Sa	novasen-sa	Production Et Commercialisation Arachide De Bouche Et Huile - Industrie Des Oleagineux	\N	7	2026-03-02 23:11:16.782	2026-03-02 23:11:16.782	Production Et Commercialisation Arachide De Bouche Et Huile - Industrie Des Oleagineux	Bccd	33 854 64 99	Dakar	\N	\N	\N	f	\N
2436	Ets Deggo	ets-deggo-2	Multiservices - Mamadou Kane Vente D'Aliments De Betail Et Produits Boulangerie	\N	2	2026-03-02 23:11:16.788	2026-03-02 23:11:16.788	Multiservices - Mamadou Kane Vente D'Aliments De Betail Et Produits Boulangerie	Quartier Santa Yalla N°16 Rufisque	33 832 26 30	Rufisque	\N	\N	\N	f	\N
2437	Sodea Sarl (Societe Pour Le Developpement Agro- Industriel) Distribition De Produits	sodea-sarl-societe-pour-le-developpement-agro-industriel-distribition-de-produits	Vente Location Maintenance Compresseurs	\N	2	2026-03-02 23:11:16.792	2026-03-02 23:11:16.792	Vente Location Maintenance Compresseurs	Grue Chariot Eleveur Groupes Electrogenes Vehicules Travaux Publics Agricole Bccd	33 874 00 45	Dakar	\N	\N	\N	f	\N
2438	Senhuile Sa	senhuile-sa	Production Et Exportation De Produits Agricoles	\N	2	2026-03-02 23:11:16.796	2026-03-02 23:11:16.796	Production Et Exportation De Produits Agricoles	Imme uble Seydi Djamil, 7° Etage	33 823 32 83	Dakar	\N	\N	\N	f	\N
2439	Damora - Sarl	damora-sarl-1	Commerce Alimentaires	\N	2	2026-03-02 23:11:16.801	2026-03-02 23:11:16.801	Commerce Alimentaires	Avenue Andre Peytavin 0 Dakar Hortis Suarl Distributions D'Intrants Agricoles Scat Urbam Hann Mariste , 13D	33 962 98 99	Dakar	\N	\N	\N	f	\N
2440	Agroseed (Ex Interface Trading)	agroseed-ex-interface-trading-1	Commerce De Semences	\N	2	2026-03-02 23:11:16.806	2026-03-02 23:11:16.806	Commerce De Semences	Rue 39 X Bd General De Gaulle (Immeuble Adja Mame Ndiaye - Rond Point Canal 4 Fass Paillote	33 848 21 81	Dakar	\N	\N	\N	f	\N
2441	Bss Sarl (Blue Skies Senegal Sarl)	bss-sarl-blue-skies-senegal-sarl-1	Commerce De Produits Agricoles	\N	2	2026-03-02 23:11:16.81	2026-03-02 23:11:16.81	Commerce De Produits Agricoles	Rue Galandou Diouf 0 Thiaroye Baleine Export Sarl Traitement Et Exportation De Produits De Mer - Vente De Produits Alimentaires Route De Rufisque - Zone Industrielle Sonepi	33 822 85 52	Dakar	\N	\N	\N	f	\N
2442	Coderiz (Compagnie De Developpement Rizicole) Agriculture Sodida Lot N°21 0 Dakar Prodipa	coderiz-compagnie-de-developpement-rizicole-agriculture-sodida-lot-n-21-0-dakar-prodipa	(Production Et Distribution De Produits Alimentaires) Production Et Distribution De Produits Alimentaires	\N	2	2026-03-02 23:11:16.814	2026-03-02 23:11:16.814	(Production Et Distribution De Produits Alimentaires) Production Et Distribution De Produits Alimentaires	Bccd	33 836 93 32	Dakar	\N	\N	\N	f	\N
2443	Sbe Senegal - Sarl	sbe-senegal-sarl-1	Commerce De Produits Agricoles Vdn	\N	2	2026-03-02 23:11:16.818	2026-03-02 23:11:16.818	Commerce De Produits Agricoles Vdn	Immeuble Pyramid 0 Dakar Green Food Suarl Vente De Produit Alimentaires, Fruits Et Legumes Avenue Blaise Diagne	33 832 44 89	Dakar	\N	\N	\N	f	\N
2444	Saed (Societe D'Amenagement Et D'Exploitation Du Delta)	saed-societe-d-amenagement-et-d-exploitation-du-delta-1	Services Annexes A L'Agriculture Et A L'Elev	\N	4	2026-03-02 23:11:16.824	2026-03-02 23:11:16.824	Services Annexes A L'Agriculture Et A L'Elev	Avenue Insa Coulibaly - Saint Louis	33 864 70 16	Saint-Louis	\N	\N	\N	f	\N
2445	Prosem - Sarl (Ex - Prophyse)	prosem-sarl-ex-prophyse-1	Commerce Pdts Agricoles - Activites Annexes A L'Agriculture	\N	2	2026-03-02 23:11:16.828	2026-03-02 23:11:16.828	Commerce Pdts Agricoles - Activites Annexes A L'Agriculture	Rue Ramez Bourgi (Ex - Essarts)	33 828 10 24	Dakar	\N	\N	\N	f	\N
2446	Fouad Ali Hoballah Autres	fouad-ali-hoballah-autres-1	Commerce - Distribution De Produits Alimentaires	\N	2	2026-03-02 23:11:16.832	2026-03-02 23:11:16.832	Commerce - Distribution De Produits Alimentaires	Rue Raffenel	33 822 87 20	Dakar	\N	\N	\N	f	\N
2447	Somaphy W Est Africa Sa	somaphy-w-est-africa-sa-1	Vente De Materiels Agricoles	\N	2	2026-03-02 23:11:16.836	2026-03-02 23:11:16.836	Vente De Materiels Agricoles	Immeuble Aresa Cite Com ico	33 820 55 45	Dakar	\N	\N	\N	f	\N
2448	Scpa Sarl (Societe De Commercialisation De Produits Alimentaires)	scpa-sarl-societe-de-commercialisation-de-produits-alimentaires-1	Vente De Produits Alimentaires	\N	2	2026-03-02 23:11:16.84	2026-03-02 23:11:16.84	Vente De Produits Alimentaires	Rue Valmy	33 827 96 59	Dakar	\N	\N	\N	f	\N
2449	Supermache U (Thiery Martinet)	supermache-u-thiery-martinet-2	Commerce Alimentaires Diverses	\N	2	2026-03-02 23:11:16.844	2026-03-02 23:11:16.844	Commerce Alimentaires Diverses	Rue A. Seck Marie Par sine	33 822 22 94	Saint-Louis	\N	\N	\N	f	\N
2450	Frigosen	frigosen	Fabrication D'Autres Produits Alimentaire Mbour	\N	4	2026-03-02 23:11:16.846	2026-03-02 23:11:16.846	Fabrication D'Autres Produits Alimentaire Mbour	Rue S.N Tall X Tamsir .D.Sall	33 961 12 63	Mbour	\N	\N	\N	f	\N
2451	Alimentation Al Jaw Ad Superette (Toufik Ahmad Mohsen)	alimentation-al-jaw-ad-superette-toufik-ahmad-mohsen-1	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:16.849	2026-03-02 23:11:16.849	Commerce De Produits Alimentaires	Rue Abdou Karim Bo urgi	33 963 34 92	Dakar	\N	\N	\N	f	\N
2452	Dynapharm Senegal	dynapharm-senegal	Ventes De Complements Alimentaires	\N	2	2026-03-02 23:11:16.851	2026-03-02 23:11:16.851	Ventes De Complements Alimentaires	Avenue Georges Po mpidou	77 616 72 59	Dakar	\N	\N	\N	f	\N
2453	Mbaye Ndiaye	mbaye-ndiaye-1	Vente Aliments Volaille Bambylor W Ayembam 0 Dakar Arinc Agro Senegal Sarl Agriculture Liberte 6 0 Mbour Chez Antoinette (Antoinette Ndebane Faye) Alimentation Generale Santhie Joal Fadiouth 0 Ville Entreprise Activité Adresse Téléphone Dakar Metro - Sarl Distribution - Commerce Alimentaire	\N	2	2026-03-02 23:11:16.854	2026-03-02 23:11:16.854	Vente Aliments Volaille Bambylor W Ayembam 0 Dakar Arinc Agro Senegal Sarl Agriculture Liberte 6 0 Mbour Chez Antoinette (Antoinette Ndebane Faye) Alimentation Generale Santhie Joal Fadiouth 0 Ville Entreprise Activité Adresse Téléphone Dakar Metro - Sarl Distribution - Commerce Alimentaire	Avenue Lamine Gu eye	33 825 03 03	Rufisque	\N	\N	\N	f	\N
2454	Gie Etat (Entreprise Travaux Agriculture Transports ) Agriculture - Horticulture - Maraichage	gie-etat-entreprise-travaux-agriculture-transports-agriculture-horticulture-maraichage	Production Et Distribution De Produits Agricoles	\N	2	2026-03-02 23:11:16.856	2026-03-02 23:11:16.856	Production Et Distribution De Produits Agricoles	Rue Saint Michel	33 822 27 41	Rufisque	\N	\N	\N	f	\N
2455	Electroplus (Aya Chaito)	electroplus-aya-chaito-1	Commerce De Gros De Biens De Consommation Non Alimentaires	\N	2	2026-03-02 23:11:16.86	2026-03-02 23:11:16.86	Commerce De Gros De Biens De Consommation Non Alimentaires	Rue Mousse Diop	33 993 52 80	Dakar	\N	\N	\N	f	\N
2456	Comdis - Sa	comdis-sa	(Commerce Et Distribution) Commerce General - Distribution De Pdts Alimentaires	\N	2	2026-03-02 23:11:16.863	2026-03-02 23:11:16.863	(Commerce Et Distribution) Commerce General - Distribution De Pdts Alimentaires	Rue Malan	77 391 60 31	Dakar	\N	\N	\N	f	\N
2457	Africa My Home - Africa Human Resources Suarl	africa-my-home-africa-human-resources-suarl	Commerce De Gros De Biens De Consommation Non Alime ntaires Point E Villa N°4326	\N	2	2026-03-02 23:11:16.867	2026-03-02 23:11:16.867	Commerce De Gros De Biens De Consommation Non Alime ntaires Point E Villa N°4326	Rue B 0 Dakar Societe Africaine De Representation De Materiel Sarmati (Agricole Et De Techniques D'Irrigation) Vente Materiels Agricoles Avenue Bourguiba A Cote De L'Universite B	33 823 75 49	Dakar	\N	\N	\N	f	\N
2458	Tolsen Agro Industrie Fenetre Mermoz 0 Saint-Louis Pharmacie Veterinaire Delta Agroveto	tolsen-agro-industrie-fenetre-mermoz-0-saint-louis-pharmacie-veterinaire-delta-agroveto	Services (Papa Ndene Diouf) Vente De Produits De Betails	\N	2	2026-03-02 23:11:16.87	2026-03-02 23:11:16.87	Services (Papa Ndene Diouf) Vente De Produits De Betails	Quartier Service Elevag e Sor 0 Dakar Le Pingoin Sarl Fabrique Et Commer De Glacons Alimentaires Rue Abdou Karim Bourgi	33 825 25 20	Dakar	\N	\N	\N	f	\N
2459	Sen Toll - Sarl	sen-toll-sarl-2	Commerce Materiels Agricole	\N	2	2026-03-02 23:11:16.874	2026-03-02 23:11:16.874	Commerce Materiels Agricole	Avenue Des Grds Hommes S or Ndioloffene	33 860 96 88	Saint-Louis	\N	\N	\N	f	\N
2460	Top Mountain Sarl Commercialisaton Et	top-mountain-sarl-commercialisaton-et-1	Distribution De Produits Agricoles	\N	2	2026-03-02 23:11:16.876	2026-03-02 23:11:16.876	Distribution De Produits Agricoles	Route De Rufisque	33 961 52 25	Dakar	\N	\N	\N	f	\N
2461	Lepi (Laboratoire D'Essai Contrôle De Produits Industriels) Prestations De	lepi-laboratoire-d-essai-controle-de-produits-industriels-prestations-de	Services (Analyse Produits Alimentaires)	\N	4	2026-03-02 23:11:16.878	2026-03-02 23:11:16.878	Services (Analyse Produits Alimentaires)	Rue W Agane Diouf	33 869 79 29	Dakar	\N	\N	\N	f	\N
2462	Ets Diop & Freres Sarl	ets-diop-freres-sarl-1	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:16.882	2026-03-02 23:11:16.882	Commerce De Produits Alimentaires	Rue Graland	33 822 89 15	Dakar	\N	\N	\N	f	\N
2463	a Senagro Jullam Afia Transformation Laitiere Et	a-senagro-jullam-afia-transformation-laitiere-et-1	Distribution De Produits Alimentaires Lot 247	\N	2	2026-03-02 23:11:16.885	2026-03-02 23:11:16.885	Distribution De Produits Alimentaires Lot 247	Quartier Salikenie Tambacounda	77 638 81 16	Tambacound	\N	\N	\N	f	\N
2464	Ruy Xalel - Sa	ruy-xalel-sa-1	Fabrication Distribution Autres Produits Alimentaire	\N	2	2026-03-02 23:11:16.889	2026-03-02 23:11:16.889	Fabrication Distribution Autres Produits Alimentaire	Rue Felix Eboue	33 961 49 49	Dakar	\N	\N	\N	f	\N
2465	Compagnie Agricole De	compagnie-agricole-de-1	Distributions Et De Services Vente De Produits Agricols Et Intants Usine Ben Tall y Villa N° 2896 0 Dakar Africa Seeds Autres Cultures Agriculture Vivriere Sangalkam	\N	2	2026-03-02 23:11:16.892	2026-03-02 23:11:16.892	Distributions Et De Services Vente De Produits Agricols Et Intants Usine Ben Tall y Villa N° 2896 0 Dakar Africa Seeds Autres Cultures Agriculture Vivriere Sangalkam	Route Keur Ndiaye Lo	33 821 72 00	Dakar	\N	\N	\N	f	\N
2466	Compagnie Agricole De Saint-Louis	compagnie-agricole-de-saint-louis-1	Productions Agricoles Pointe Nord De L'Île Saint Lou is 0 Mbour Gie Anba Sibelle Industrie Alimentaire Residence Medssef	\N	4	2026-03-02 23:11:16.895	2026-03-02 23:11:16.895	Productions Agricoles Pointe Nord De L'Île Saint Lou is 0 Mbour Gie Anba Sibelle Industrie Alimentaire Residence Medssef	Route De Dak ar	33 939 51 95	Saint-Louis	\N	\N	\N	f	\N
2467	Terroirs Du Senegal - Suarl	terroirs-du-senegal-suarl	Production Agricole Keur Ndiaye Lo A Cote De L'Usine Sarbi	\N	4	2026-03-02 23:11:16.897	2026-03-02 23:11:16.897	Production Agricole Keur Ndiaye Lo A Cote De L'Usine Sarbi	Route De Sangalkam	33 954 90 38	Dakar	\N	\N	\N	f	\N
2468	Libre	libre-2	Service Monoprix - Souad Saliman Al Reefi Commerce Alimentaire - Epicerie	\N	2	2026-03-02 23:11:16.901	2026-03-02 23:11:16.901	Service Monoprix - Souad Saliman Al Reefi Commerce Alimentaire - Epicerie	Rue Assane Ndoye	33 836 86 68	Dakar	\N	\N	\N	f	\N
2469	Mamadou Dia	mamadou-dia-1	Commercee Et Distribution D'Intrants Agricoles Medin a	\N	2	2026-03-02 23:11:16.904	2026-03-02 23:11:16.904	Commercee Et Distribution D'Intrants Agricoles Medin a	Rue 11 X Blaise Diagne	30 102 25 74	Dakar	\N	\N	\N	f	\N
2470	Spcrs (Societe Pour La Promotion Et La Commercialis ation Du Riz)	spcrs-societe-pour-la-promotion-et-la-commercialis-ation-du-riz-1	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:16.908	2026-03-02 23:11:16.908	Commerce De Produits Alimentaires	Rue Beranger Ferra ud,Dakar 0 Dkar Fodd Store And Equipements Commerce De Produits Alimentaires Sacre Cœur 3	33 823 87 94	Dakar	\N	\N	\N	f	\N
2471	Jts Senegal Sarl (Jardins Tropicaux Semences Senegal - Sarl)	jts-senegal-sarl-jardins-tropicaux-semences-senegal-sarl-1	Commerce De Semences	\N	2	2026-03-02 23:11:16.912	2026-03-02 23:11:16.912	Commerce De Semences	Avenue Du President Lamine Guey e	33 961 77 77	Thies	\N	\N	\N	f	\N
2472	Entreprise F.K. Vitprop (Fatou Diaw )	entreprise-f-k-vitprop-fatou-diaw-1	Commerce De Produits Alimentaires Rez De Chausee	\N	2	2026-03-02 23:11:16.915	2026-03-02 23:11:16.915	Commerce De Produits Alimentaires Rez De Chausee	Imm euble J Sacre Cœur	77 363 24 22	Dakar	\N	\N	\N	f	\N
2473	Massaroise De	massaroise-de	Distribution Sarl Commerce De Detail En Magasin Specialise De Produits Alimentaires	\N	2	2026-03-02 23:11:16.918	2026-03-02 23:11:16.918	Distribution Sarl Commerce De Detail En Magasin Specialise De Produits Alimentaires	Route Cite Enseignants Face Senelec	33 825 51 65	Pikine	\N	\N	\N	f	\N
2474	Entreprise Activité Adresse Téléphone Dakar Salia (Societe Alimentaire Africaine)	entreprise-activite-adresse-telephone-dakar-salia-societe-alimentaire-africaine	Vente De Produits Alimentaire	\N	2	2026-03-02 23:11:16.92	2026-03-02 23:11:16.92	Vente De Produits Alimentaire	Rue Sandiniery	33 860 22 01	Ville	\N	\N	\N	f	\N
2475	Delicia - Sarl	delicia-sarl-1	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:16.924	2026-03-02 23:11:16.924	Commerce De Produits Alimentaires	Rue G X Rue Leon Gontran Damas, Fann Residence	77 638 47 26	Dakar	\N	\N	\N	f	\N
2476	Galsen Corp Sarl Exploitation Agricole 2738 Hlm Nimzatt Rue 221 0 Dakar Guinness Cameroun Sa	galsen-corp-sarl-exploitation-agricole-2738-hlm-nimzatt-rue-221-0-dakar-guinness-cameroun-sa	Commerce De Produits Alimentaires (Bierre)	\N	2	2026-03-02 23:11:16.926	2026-03-02 23:11:16.926	Commerce De Produits Alimentaires (Bierre)	Route De Ngor, Les Almadies	77 639 43 37	Dakar	\N	\N	\N	f	\N
2477	Ets Nemer Sara - Sarl	ets-nemer-sara-sarl-2	Commerce Alimentaire	\N	2	2026-03-02 23:11:16.93	2026-03-02 23:11:16.93	Commerce Alimentaire	Rue Lemoine	77 638 81 16	Ziguinchor	\N	\N	\N	f	\N
2478	Kayode Cessou & Cie Sarl	kayode-cessou-cie-sarl	Fabrication D'Autres Produits Alimentaires	\N	4	2026-03-02 23:11:16.933	2026-03-02 23:11:16.933	Fabrication D'Autres Produits Alimentaires	Rue 19 X 28 Medina	30 119 26 76	Dakar	\N	\N	\N	f	\N
2479	Avimat Senegal Suarl	avimat-senegal-suarl	Production D'Aliments De Betail	\N	7	2026-03-02 23:11:16.935	2026-03-02 23:11:16.935	Production D'Aliments De Betail	Route De Rufisque 0 Dakar 3S Commodities Commerce De Produits Agricoles Rue Parent	33 963 00 99	Dakar	\N	\N	\N	f	\N
2480	Groupe Lak'S Sarl Importation Et	groupe-lak-s-sarl-importation-et-1	Distribution De Produits Alimentaires	\N	2	2026-03-02 23:11:16.939	2026-03-02 23:11:16.939	Distribution De Produits Alimentaires	Avenue Lamine Gueye	33 823 36 84	Dakar	\N	\N	\N	f	\N
2481	Seah Sarl (Societe D'Equipement Agricole Et Hydraulique)	seah-sarl-societe-d-equipement-agricole-et-hydraulique-1	Commerce Materiels Agricole Et Hydraulique Rurale	\N	2	2026-03-02 23:11:16.942	2026-03-02 23:11:16.942	Commerce Materiels Agricole Et Hydraulique Rurale	Avenue Bourguiba Immeuble Ymca Lot N°06	77 385 73 70	Dakar	\N	\N	\N	f	\N
2482	Ccmn (Comptoir Commercial Mandiaye Ndiaye)	ccmn-comptoir-commercial-mandiaye-ndiaye-1	Commerce Import-Export	\N	2	2026-03-02 23:11:16.945	2026-03-02 23:11:16.945	Commerce Import-Export	Rue Daloa	33 839 84 39	Kaolack	\N	\N	\N	f	\N
2483	Sofiex - Sarl (Ste De	sofiex-sarl-ste-de-1	Fabrication Et D'Import Export) Fabrication Et D'Import Export	\N	2	2026-03-02 23:11:16.949	2026-03-02 23:11:16.949	Fabrication Et D'Import Export) Fabrication Et D'Import Export	Rue Galandou Diouf	33 941 16 15	Dakar	\N	\N	\N	f	\N
2484	Sdc Senegal Sa (Societe De	sdc-senegal-sa-societe-de-1	Distribution Et De Commerce - Senegal) Negoce Importation De Riz	\N	2	2026-03-02 23:11:16.952	2026-03-02 23:11:16.952	Distribution Et De Commerce - Senegal) Negoce Importation De Riz	Rue Mousse Diop	33 849 01 83	Dakar	\N	\N	\N	f	\N
2485	Comtrade Sarl Import-Export	comtrade-sarl-import-export-2	Commerce General	\N	2	2026-03-02 23:11:16.955	2026-03-02 23:11:16.955	Commerce General	Avenue Lamine Gueye	33 484 09 45	Dakar	\N	\N	\N	f	\N
2486	Lcs - Sa (Les Cableries Du Senegal) Industrie -	lcs-sa-les-cableries-du-senegal-industrie-2	Fabrication De Cables Electriques - Commerce Import Export	\N	2	2026-03-02 23:11:16.958	2026-03-02 23:11:16.958	Fabrication De Cables Electriques - Commerce Import Export	Bccd X Rue 6	33 849 44 43	Dakar	\N	\N	\N	f	\N
2487	Ets Jamil Tarraf & Cie	ets-jamil-tarraf-cie-3	Commerce Alimentaire - Import/Export	\N	2	2026-03-02 23:11:16.963	2026-03-02 23:11:16.963	Commerce Alimentaire - Import/Export	Rue Raffenel	33 849 34 34	Dakar	\N	\N	\N	f	\N
2488	Atlas	atlas-2	Distribution Sarl Commerce Import-Export	\N	2	2026-03-02 23:11:16.966	2026-03-02 23:11:16.966	Distribution Sarl Commerce Import-Export	Rue 4 Zone Industrielle	33 821 28 99	Dakar	\N	\N	\N	f	\N
2489	Sosemat Sa (Societe Senegalaise De Materiaux)	sosemat-sa-societe-senegalaise-de-materiaux-1	Production (Fer A Beton (70%) Et Zing (19,86%) Et Importation De Materiaux (10,14%)	\N	2	2026-03-02 23:11:16.968	2026-03-02 23:11:16.968	Production (Fer A Beton (70%) Et Zing (19,86%) Et Importation De Materiaux (10,14%)	Bccd	33 832 57 16	Dakar	\N	\N	\N	f	\N
2490	Gfl - Sa (Groupe Fauzie Layousse - Ex Ets) Transport -	gfl-sa-groupe-fauzie-layousse-ex-ets-transport-4	Commerce Import/Export	\N	2	2026-03-02 23:11:16.974	2026-03-02 23:11:16.974	Commerce Import/Export	Route De Rufisque	33 853 05 98	Rufisque	\N	\N	\N	f	\N
2491	Ccs Sa (Comptoir Commercial Du Senegal)	ccs-sa-comptoir-commercial-du-senegal-2	Commerce - Import/Export Materiels Sanitaires	\N	2	2026-03-02 23:11:16.978	2026-03-02 23:11:16.978	Commerce - Import/Export Materiels Sanitaires	Avenue Malick Sy X Autoroute Passage Gare Routiere	33 820 12 61	Dakar	\N	\N	\N	f	\N
2492	Ets Mahmoud Meroueh	ets-mahmoud-meroueh-2	Commerce - Import/Export	\N	2	2026-03-02 23:11:16.981	2026-03-02 23:11:16.981	Commerce - Import/Export	Rue Mousse Diop (Ex - Blanchot)	33 821 16 45	Dakar	\N	\N	\N	f	\N
2493	Redington Senegal Limited Sarl	redington-senegal-limited-sarl-2	Commerce General-Import- Export	\N	2	2026-03-02 23:11:16.985	2026-03-02 23:11:16.985	Commerce General-Import- Export	Rue Non Denommee Imm Abc Rond Point Jet D'Eau	33 832 05 64	Dakar	\N	\N	\N	f	\N
2494	Carrefour Automobiles	carrefour-automobiles-1	Vente De Vehicule - Import Export	\N	2	2026-03-02 23:11:16.988	2026-03-02 23:11:16.988	Vente De Vehicule - Import Export	Autoroute X Croisement Camberene	33 832 12 20	Dakar	\N	\N	\N	f	\N
2495	Cosetam - Sa (Cie Senegalaise Pour Tous Appareillages Mecaniques)	cosetam-sa-cie-senegalaise-pour-tous-appareillages-mecaniques	Commerce Import/Export - Mecanique Generale	\N	2	2026-03-02 23:11:16.99	2026-03-02 23:11:16.99	Commerce Import/Export - Mecanique Generale	Route Des Hydrocarbures - Bel-Air	33 839 86 86	Dakar	\N	\N	\N	f	\N
2496	Cic Senegal - Sarl (Compagnie D'Investissement Cerealier)	cic-senegal-sarl-compagnie-d-investissement-cerealier-1	Commerce - Import/Export - Distribution Produits Cerealiers	\N	2	2026-03-02 23:11:16.993	2026-03-02 23:11:16.993	Commerce - Import/Export - Distribution Produits Cerealiers	Bd El Hadji Djily Mbaye	33 832 59 05	Dakar	\N	\N	\N	f	\N
2497	Se Pro Com (Societe D'Equipement Et De Promotion Commerciale - Sarl)	se-pro-com-societe-d-equipement-et-de-promotion-commerciale-sarl	Commerce Generl - Import Export	\N	2	2026-03-02 23:11:16.995	2026-03-02 23:11:16.995	Commerce Generl - Import Export	Avenue Bourguiba Ex Dicopa 0 Thies Toubafruit Sarl Exportation Et Vente De Produits Agricoles Ex C, Evangelique Escale Thies	33 821 28 80	Dakar	\N	\N	\N	f	\N
2498	Papa Abdoul Aziz Dieng	papa-abdoul-aziz-dieng-1	Commerce General Import- Export Sicap Dieuppeul Villa N° 2894 B 0 Dakar Sarl Ocean Fish Exportateur Des Produits De La Mer	\N	2	2026-03-02 23:11:16.998	2026-03-02 23:11:16.998	Commerce General Import- Export Sicap Dieuppeul Villa N° 2894 B 0 Dakar Sarl Ocean Fish Exportateur Des Produits De La Mer	Bccd	33 832 80 62	Dakar	\N	\N	\N	f	\N
2499	La Pirogue Bleue - Sarl Achat -	la-pirogue-bleue-sarl-achat-1	Vente - Export De Pdts De La Mer	\N	2	2026-03-02 23:11:17.001	2026-03-02 23:11:17.001	Vente - Export De Pdts De La Mer	Bccd	33 834 21 40	Dakar	\N	\N	\N	f	\N
2500	Comptoir De	comptoir-de	Distribution De Materiaux Sarl Commerce De Metaux - Import Export	\N	2	2026-03-02 23:11:17.003	2026-03-02 23:11:17.003	Distribution De Materiaux Sarl Commerce De Metaux - Import Export	Bccd, Rond Point Scoa Fann Rocade	77 333 58 12	Dakar	\N	\N	\N	f	\N
2501	Ndiakhate Ndiassane (Abdoulaye Diakhate)	ndiakhate-ndiassane-abdoulaye-diakhate	Commerce Import-Export	\N	2	2026-03-02 23:11:17.005	2026-03-02 23:11:17.005	Commerce Import-Export	Rue 6 X Bd Gueule Tapee	77 553 33 33	Dakar	\N	\N	\N	f	\N
2502	Sepam - Sa (Ste D'Exploitation Des Produits Agricoles Et Maraichers)	sepam-sa-ste-d-exploitation-des-produits-agricoles-et-maraichers-1	Production Et Exportation De Produits Maraîchers Et Agricoles	\N	2	2026-03-02 23:11:17.007	2026-03-02 23:11:17.007	Production Et Exportation De Produits Maraîchers Et Agricoles	Avenue Ousmane Soce Diop - Rufisque	33 835 18 78	Rufisque	\N	\N	\N	f	\N
2503	Gie Alpex	gie-alpex	Commerce Import - Export Grand Dakar Villa N 355 0 Dakar Cempa - Sarl (Centrale D'Emballage Et De Papier) Import Export - Vente D'Emballages Et De Papiers	\N	2	2026-03-02 23:11:17.009	2026-03-02 23:11:17.009	Commerce Import - Export Grand Dakar Villa N 355 0 Dakar Cempa - Sarl (Centrale D'Emballage Et De Papier) Import Export - Vente D'Emballages Et De Papiers	Rue Carnot	33 820 97 65	Dakar	\N	\N	\N	f	\N
2504	Gie Solumex	gie-solumex	Commerce Import Export Sicap Liverte Iv N° 5067J 0 Dakar Crustexport Mareyeur - Exportateur	\N	2	2026-03-02 23:11:17.012	2026-03-02 23:11:17.012	Commerce Import Export Sicap Liverte Iv N° 5067J 0 Dakar Crustexport Mareyeur - Exportateur	Route Des Almadies	77 631 39 93	Dakar	\N	\N	\N	f	\N
2505	W Orld Vision Sn - Suarl	w-orld-vision-sn-suarl-1	Commerce Export	\N	2	2026-03-02 23:11:17.015	2026-03-02 23:11:17.015	Commerce Export	Bccd 0 Dakar Solene Afrique De L'Ouest Sarl Import Export Etudes Solaires Centenaire De La Commune	77 469 38 19	Dakar	\N	\N	\N	f	\N
2506	Ngom & Freres Sarl Import-Export -	ngom-freres-sarl-import-export-1	Vente Equipement De Peche	\N	2	2026-03-02 23:11:17.017	2026-03-02 23:11:17.017	Vente Equipement De Peche	Rue 2 Bis X Avenue Bourguiba	33 859 65 65	Dakar	\N	\N	\N	f	\N
2507	Senogano Cct Dakar - Sarl	senogano-cct-dakar-sarl	Commerce Materiel De Pêche - Import/Export	\N	2	2026-03-02 23:11:17.019	2026-03-02 23:11:17.019	Commerce Materiel De Pêche - Import/Export	Avenue Georges Pompidou	33 842 40 20	Dakar	\N	\N	\N	f	\N
2508	Pmi - Sarl (Pieces Materiels Import)	pmi-sarl-pieces-materiels-import-1	Commerce Pieces Et Materiels - Import/ Export	\N	2	2026-03-02 23:11:17.022	2026-03-02 23:11:17.022	Commerce Pieces Et Materiels - Import/ Export	Avenue Bourguiba	33 821 60 64	Dakar	\N	\N	\N	f	\N
2509	Sts (Societe Des Tomates Sechees)	sts-societe-des-tomates-sechees	Production , Traitement Et Exportation Tomates Point E	\N	2	2026-03-02 23:11:17.023	2026-03-02 23:11:17.023	Production , Traitement Et Exportation Tomates Point E	Rue De Kaolack X Rue De Saint- Louis	33 822 24 52	Dakar	\N	\N	\N	f	\N
2510	Matelec - Sarl	matelec-sarl	Commerce - Import/Export	\N	2	2026-03-02 23:11:17.025	2026-03-02 23:11:17.025	Commerce - Import/Export	Rue Mousse Diop (Ex - Blanchot)	33 820 05 30	Dakar	\N	\N	\N	f	\N
2511	Calimex Sarl (Charif Ali Import & Export)	calimex-sarl-charif-ali-import-export-1	Distribution /Import Export	\N	2	2026-03-02 23:11:17.029	2026-03-02 23:11:17.029	Distribution /Import Export	Rue Galandou Diouf	33 822 07 68	Dakar	\N	\N	\N	f	\N
2512	Global Prestige	global-prestige	Commerce Import Export	\N	2	2026-03-02 23:11:17.03	2026-03-02 23:11:17.03	Commerce Import Export	Rue Aristide Le Dantec	33 821 65 25	Dakar	\N	\N	\N	f	\N
2513	Sepa Sarl (Societe D'Exportation De Produits Agricoles)	sepa-sarl-societe-d-exportation-de-produits-agricoles-1	Commerce Import Export	\N	2	2026-03-02 23:11:17.036	2026-03-02 23:11:17.036	Commerce Import Export	Rue 39X40 Colobane App C1	33 832 15 78	Dakar	\N	\N	\N	f	\N
2514	Sofravin - Sa (Ste Francaise Des Vins) Importations - Conditionnement Et	sofravin-sa-ste-francaise-des-vins-importations-conditionnement-et-1	Ventes De Vins En Gros	\N	2	2026-03-02 23:11:17.039	2026-03-02 23:11:17.039	Ventes De Vins En Gros	Rue Des Chais - Bel-Air - Pres De Sonacos	33 821 55 35	Dakar	\N	\N	\N	f	\N
2515	Agro Senegal Exports - Sarl	agro-senegal-exports-sarl-1	Commerce Import-Export	\N	2	2026-03-02 23:11:17.042	2026-03-02 23:11:17.042	Commerce Import-Export	Rue Mohamed 5	33 832 87 78	Dakar	\N	\N	\N	f	\N
2516	Fournauto Sarl (Ste Senegalaise Pour La Fourniture De Pieces Et Accessoires Automobiles)	fournauto-sarl-ste-senegalaise-pour-la-fourniture-de-pieces-et-accessoires-automobiles-1	Commerce Pieces Autos - Import/Export	\N	2	2026-03-02 23:11:17.045	2026-03-02 23:11:17.045	Commerce Pieces Autos - Import/Export	Avenue Lamine Gueye	33 864 15 12	Dakar	\N	\N	\N	f	\N
2517	Literie Senegalaise - Sarl Autres	literie-senegalaise-sarl-autres-1	Commerces - Import/Export	\N	2	2026-03-02 23:11:17.048	2026-03-02 23:11:17.048	Commerces - Import/Export	Rue Galandou Diouf	33 821 56 11	Dakar	\N	\N	\N	f	\N
2518	Sipa (Senegalaise D'Importation De Produits D'Ameublement) Importation Et	sipa-senegalaise-d-importation-de-produits-d-ameublement-importation-et-1	Revente De Produits D'Ameublement	\N	2	2026-03-02 23:11:17.051	2026-03-02 23:11:17.051	Revente De Produits D'Ameublement	Rue Fleurus	33 823 05 00	Dakar	\N	\N	\N	f	\N
2519	Dk Motors Sa	dk-motors-sa-1	Commerce Import Export & Concession Vehicule	\N	2	2026-03-02 23:11:17.055	2026-03-02 23:11:17.055	Commerce Import Export & Concession Vehicule	Bd Du Centenaire De La Commune De Dakar	33 889 08 89	Dakar	\N	\N	\N	f	\N
2520	Gtc (Global Trading Corporation Sarl) Exportation De Ferraille Cite Sonatel 2 N° 43 0 Dakar Chafic	gtc-global-trading-corporation-sarl-exportation-de-ferraille-cite-sonatel-2-n-43-0-dakar-chafic	Commerce - Import/Export	\N	2	2026-03-02 23:11:17.057	2026-03-02 23:11:17.057	Commerce - Import/Export	Rue Robert Brun	33 859 13 13	Dakar	\N	\N	\N	f	\N
2521	Imex Afric Sarl	imex-afric-sarl-1	Commerce Import Export	\N	2	2026-03-02 23:11:17.061	2026-03-02 23:11:17.061	Commerce Import Export	Rue Abdou Karim Bourgi	33 822 26 11	Dakar	\N	\N	\N	f	\N
2522	Ssc (Ste Senegalaise De	ssc-ste-senegalaise-de-1	Commerce) (Ex - Codaco - Mme Salman Thiam) Commerce - Import / Export	\N	2	2026-03-02 23:11:17.065	2026-03-02 23:11:17.065	Commerce) (Ex - Codaco - Mme Salman Thiam) Commerce - Import / Export	Avenue Lamine Gueye	33 825 32 32	Dakar	\N	\N	\N	f	\N
2523	Senimport Suarl	senimport-suarl-1	Commerce Import Export	\N	2	2026-03-02 23:11:17.069	2026-03-02 23:11:17.069	Commerce Import Export	Avenue Georges Pompidou	33 821 42 75	Dakar	\N	\N	\N	f	\N
2524	Promegal (Producteurs De Melon Du Senegal -Sarl)	promegal-producteurs-de-melon-du-senegal-sarl	Production Et Exportation De Melons Bayakh	\N	2	2026-03-02 23:11:17.071	2026-03-02 23:11:17.071	Production Et Exportation De Melons Bayakh	Route De Sangalkam	33 832 92 85	Thies	\N	\N	\N	f	\N
2525	Repro-Systems Prestation De	repro-systems-prestation-de-1	Services Et Importateur De Materiels Informatiques	\N	2	2026-03-02 23:11:17.075	2026-03-02 23:11:17.075	Services Et Importateur De Materiels Informatiques	Avenue Lamine Gueye	77 525 45 80	Dakar	\N	\N	\N	f	\N
2526	Societe Aimex Sarl Exportation Et	societe-aimex-sarl-exportation-et-1	Ventes De Marchandises	\N	2	2026-03-02 23:11:17.079	2026-03-02 23:11:17.079	Ventes De Marchandises	Rue Paul Holle	33 889 66 66	Dakar	\N	\N	\N	f	\N
2527	Mobicom - Sa (Mobilier Et Communication)	mobicom-sa-mobilier-et-communication-1	Commerce Import/Export De Mobilier	\N	2	2026-03-02 23:11:17.083	2026-03-02 23:11:17.083	Commerce Import/Export De Mobilier	Rue Aristide Le Dantec	33 822 81 53	Dakar	\N	\N	\N	f	\N
2528	Armena - Sa (Art Menager)	armena-sa-art-menager-1	Commerce Import Export	\N	2	2026-03-02 23:11:17.087	2026-03-02 23:11:17.087	Commerce Import Export	Avenue Lamine Gueye	33 822 59 50	Dakar	\N	\N	\N	f	\N
2529	Smps / Societe Moderne De Pneumatique Senegalaise (Ex Scms Sa = Ste Commercialisation Michelin	smps-societe-moderne-de-pneumatique-senegalaise-ex-scms-sa-ste-commercialisation-michelin-1	Commerce De Pneumatiques - Importation Et Revente En Gros	\N	2	2026-03-02 23:11:17.09	2026-03-02 23:11:17.09	Commerce De Pneumatiques - Importation Et Revente En Gros	Bccd	33 859 01 60	Dakar	\N	\N	\N	f	\N
2530	Sni - Sa (Ste Nattes Industrie)	sni-sa-ste-nattes-industrie	Fabrication De Nappes En Plastiques - Import Export	\N	2	2026-03-02 23:11:17.092	2026-03-02 23:11:17.092	Fabrication De Nappes En Plastiques - Import Export	Bccd	77 273 61 05	Dakar	\N	\N	\N	f	\N
2531	Regal Commidities Suarl Exportation De Noix De Cajou Goumel Ziguinchor 0 Dakar Socer - Sarl (Ste De	regal-commidities-suarl-exportation-de-noix-de-cajou-goumel-ziguinchor-0-dakar-socer-sarl-ste-de	Commerce D'Etudes Et De Realisation) Import - Export	\N	2	2026-03-02 23:11:17.095	2026-03-02 23:11:17.095	Commerce D'Etudes Et De Realisation) Import - Export	Rue 13 Dieuppeul 2 Villa N° 2543	33 832 34 67	Ziguinchor	\N	\N	\N	f	\N
2532	Polychimie - Sa	polychimie-sa-1	Commerce - Import/Export - Distribution Pdts	\N	2	2026-03-02 23:11:17.099	2026-03-02 23:11:17.099	Commerce - Import/Export - Distribution Pdts	ChimiquesBccd	33 823 46 45	Dakar	\N	\N	\N	f	\N
2533	Multidis - Sarl Autres	multidis-sarl-autres-1	Commerce - Import/Export	\N	2	2026-03-02 23:11:17.103	2026-03-02 23:11:17.103	Commerce - Import/Export	Rue Abdou Karim Bourgi	33 832 33 48	Dakar	\N	\N	\N	f	\N
2534	Seafood (Senegal Seafood International -Sa)	seafood-senegal-seafood-international-sa-1	Vente De Poissons A L'Export	\N	2	2026-03-02 23:11:17.106	2026-03-02 23:11:17.106	Vente De Poissons A L'Export	Avenue Jean Jaures	33 823 33 90	Dakar	\N	\N	\N	f	\N
2535	Carne Sarl	carne-sarl-1	Commerce Import Export	\N	2	2026-03-02 23:11:17.11	2026-03-02 23:11:17.11	Commerce Import Export	Route De Rufisque, Km 4,5 Rue 6 Dakar	33 889 35 05	Dakar	\N	\N	\N	f	\N
2536	Cheikh Mbacke Beye	cheikh-mbacke-beye-1	Commerce Import-Export Produits Cosmetiques	\N	2	2026-03-02 23:11:17.114	2026-03-02 23:11:17.114	Commerce Import-Export Produits Cosmetiques	Avenue Blaise Diagne X Rue 19 Tilene	33 960 95 00	Dakar	\N	\N	\N	f	\N
2537	Famous International	famous-international-1	Vente Import - Export	\N	2	2026-03-02 23:11:17.118	2026-03-02 23:11:17.118	Vente Import - Export	Rue Raffenel X Abdou Karim Bourgi 0 Dakar Hello Fish Exportation De Produits Halieutiques Hann Maristes X Echangeur	33 820 16 36	Dakar	\N	\N	\N	f	\N
2538	Sagra (Societe Africaine Des Corps Gras)	sagra-societe-africaine-des-corps-gras-1	Commerce-Import & Export	\N	2	2026-03-02 23:11:17.122	2026-03-02 23:11:17.122	Commerce-Import & Export	Rue Vincens Dakar	33 842 14 87	Dakar	\N	\N	\N	f	\N
2539	Buur Sine International Sarl Importation Et	buur-sine-international-sarl-importation-et-1	Production De Produits Agricoles	\N	2	2026-03-02 23:11:17.126	2026-03-02 23:11:17.126	Production De Produits Agricoles	Immeuble Cdeao Hann Mariste	33 842 28 40	Dakar	\N	\N	\N	f	\N
2540	Ssipc Sarl (Ste Senegalaise D'Import Export Commercial)	ssipc-sarl-ste-senegalaise-d-import-export-commercial	Commerce General - Import/Export	\N	2	2026-03-02 23:11:17.129	2026-03-02 23:11:17.129	Commerce General - Import/Export	Avenue Blaise Diagne X 3, Avenue Du Senegal	33 832 12 81	Dakar	\N	\N	\N	f	\N
2541	Groupe Sigma	groupe-sigma-1	Commerce Import-Export Sacre Cœur Vdn Villa 10162 0 Thies Scarf Sarl Traitement Et Exportation De Dechets Plastiques	\N	2	2026-03-02 23:11:17.133	2026-03-02 23:11:17.133	Commerce Import-Export Sacre Cœur Vdn Villa 10162 0 Thies Scarf Sarl Traitement Et Exportation De Dechets Plastiques	Route Nationale Khodoba Communaute Rurale De Keur Moussa	33 821 61 78	Dakar	\N	\N	\N	f	\N
2542	Pallene - Sarl (Import - Export - Industrie) Autres	pallene-sarl-import-export-industrie-autres-1	Commerce - Import/Export (Tomate Concentree)	\N	2	2026-03-02 23:11:17.137	2026-03-02 23:11:17.137	Commerce - Import/Export (Tomate Concentree)	Rue Raffenel	77 267 62 51	Dakar	\N	\N	\N	f	\N
2543	Coimex Sarl (Cote Ouest Import Export) Import-Export	coimex-sarl-cote-ouest-import-export-import-export-1	Commerce General	\N	2	2026-03-02 23:11:17.141	2026-03-02 23:11:17.141	Commerce General	Avenue Peytavin	33 822 89 99	Dakar	\N	\N	\N	f	\N
2544	Corelec	corelec-1	Commerce General / Importation De Materiel Electrique	\N	2	2026-03-02 23:11:17.145	2026-03-02 23:11:17.145	Commerce General / Importation De Materiel Electrique	Immeuble Cafe De Rome 4° Etage 0 Dakar Promo Import Sarl Commerce General - Import Export - Avenue Georges Pompidou	33 832 80 82	Dakar	\N	\N	\N	f	\N
2545	Ets Ismail Kassir	ets-ismail-kassir	Commerce Import-Export	\N	2	2026-03-02 23:11:17.148	2026-03-02 23:11:17.148	Commerce Import-Export	Avenue Lamine Gueye 0 Dakar Global Pharma Suarl Importation Et Distribution De Produits Et Equipement De Sante Fenetre Mermoz Immeuble Tours	33 889 00 77	Dakar	\N	\N	\N	f	\N
2546	Cafe Layal (Mme Rabab Jaber Nee Kassem) Restauration (50), Import Export,	cafe-layal-mme-rabab-jaber-nee-kassem-restauration-50-import-export-1	Vente Cafe & Divers (30%), Boulangerie (20%)	\N	2	2026-03-02 23:11:17.152	2026-03-02 23:11:17.152	Vente Cafe & Divers (30%), Boulangerie (20%)	Rue Paul Holle	33 860 36 22	Dakar	\N	\N	\N	f	\N
2547	Cayor Technoplus Suarl	cayor-technoplus-suarl-1	Vente De Meubles Neufs Importes Liberte Vi Extension Not N° 18	\N	2	2026-03-02 23:11:17.156	2026-03-02 23:11:17.156	Vente De Meubles Neufs Importes Liberte Vi Extension Not N° 18	Route Du Front De Terre	33 832 33 41	Dakar	\N	\N	\N	f	\N
2548	Entreprise Activité Adresse Téléphone Dakar Senhuile Sa	entreprise-activite-adresse-telephone-dakar-senhuile-sa	Production Et Exportation De Produits Agricoles	\N	2	2026-03-02 23:11:17.159	2026-03-02 23:11:17.159	Production Et Exportation De Produits Agricoles	Immeuble Seydi Djamil, 7° Etage	77 549 37 21	Ville	\N	\N	\N	f	\N
2549	Mouhamadou Maye Sylla Import - Export Avenue Faidherbe 0 Dakar Vanilia	mouhamadou-maye-sylla-import-export-avenue-faidherbe-0-dakar-vanilia	Distribution Import Export	\N	2	2026-03-02 23:11:17.162	2026-03-02 23:11:17.162	Distribution Import Export	Rue Robert Brun	33 842 58 57	Dakar	\N	\N	\N	f	\N
2550	Sosecodis (Societe Senegalaise De	sosecodis-societe-senegalaise-de	Commerce Et De Distribution) Import Export	\N	2	2026-03-02 23:11:17.166	2026-03-02 23:11:17.166	Commerce Et De Distribution) Import Export	Rue Galandou Diouf	33 823 18 14	Dakar	\N	\N	\N	f	\N
2551	Mohamed Baroud	mohamed-baroud-1	Commerce Textile - Import/Export	\N	2	2026-03-02 23:11:17.17	2026-03-02 23:11:17.17	Commerce Textile - Import/Export	Avenue Lamine Gueye	77 637 67 70	Dakar	\N	\N	\N	f	\N
2552	Modis Sarl	modis-sarl-1	Commerce Import Export	\N	2	2026-03-02 23:11:17.174	2026-03-02 23:11:17.174	Commerce Import Export	Rue Abdou Karim Bougi	33 823 36 84	Dakar	\N	\N	\N	f	\N
2553	Baleine Export Sarl Traitement Et Exportation De Produits De Mer -	baleine-export-sarl-traitement-et-exportation-de-produits-de-mer-2	Vente De Produits Alimentaires	\N	2	2026-03-02 23:11:17.181	2026-03-02 23:11:17.181	Vente De Produits Alimentaires	Route De Rufisque - Zone Industrielle Sonepi	33 821 67 67	Thiaroye	\N	\N	\N	f	\N
2554	Chelico Senegal - Sarl Import-Export Touba Almadies Lot N° 10 Derriere Bicis 0 Pikine Gie Siprod	chelico-senegal-sarl-import-export-touba-almadies-lot-n-10-derriere-bicis-0-pikine-gie-siprod	Commerce Import Export	\N	2	2026-03-02 23:11:17.184	2026-03-02 23:11:17.184	Commerce Import Export	Rue De Reims X Armand Angrand Dakar 0 Dakar Socico (Societe De Commerce International Et De Construction) Importation - Vente De Friperie Rue 40 X 49 Colobane	33 864 10 52	Dakar	\N	\N	\N	f	\N
2555	Sicor Suarl (Societe Internationale De Coutage Et De Representation Suarl)	sicor-suarl-societe-internationale-de-coutage-et-de-representation-suarl	Commerce Import-Export	\N	2	2026-03-02 23:11:17.187	2026-03-02 23:11:17.187	Commerce Import-Export	Rue Robert Brun	33 839 85 86	Dakar	\N	\N	\N	f	\N
2556	Khodia Sales And	khodia-sales-and-1	Services Sural Commerce General Import- Export Et Prestation De Services	\N	2	2026-03-02 23:11:17.192	2026-03-02 23:11:17.192	Services Sural Commerce General Import- Export Et Prestation De Services	Rue 41 X 22 Medina 0 Pikine Etablissements Jallow Abdoulie Commerce Import-Export De Marchandises Colobane Nianghor Cite Police Pikine Plle N° 2112 0 Dakar Sanli Senegal Sarl Commerce Import-Export De Cyclomoteurs Immeuble Mariama Ba - Bld Gueule Tapee X Rue 16 Bis Medina	33 867 10 56	Dakar	\N	\N	\N	f	\N
2557	Agricom Export Sarl Export De Pdts Maraichers Keur Sega - Pout 0 Dakar Grb - Sarl (Groupement	agricom-export-sarl-export-de-pdts-maraichers-keur-sega-pout-0-dakar-grb-sarl-groupement	Commerces - Import/Export Tissus	\N	2	2026-03-02 23:11:17.195	2026-03-02 23:11:17.195	Commerces - Import/Export Tissus	Rue Abdou Karim Bourgi	33 842 92 95	Pout	\N	\N	\N	f	\N
2558	Max Negoce Sarl	max-negoce-sarl-1	Commerce Import-Export	\N	2	2026-03-02 23:11:17.199	2026-03-02 23:11:17.199	Commerce Import-Export	Avenue Lamine Gueye	33 823 37 65	Dakar	\N	\N	\N	f	\N
2559	Datong Afrique International (Lee Jicai) Negociation Internationale, Import Export Avenue Lamine 0	datong-afrique-international-lee-jicai-negociation-internationale-import-export-avenue-lamine-0	Commerce Import Export Et Location	\N	2	2026-03-02 23:11:17.202	2026-03-02 23:11:17.202	Commerce Import Export Et Location	Immeuble Avenue Georges Pompidou	33 835 54 56	Dakar	\N	\N	\N	f	\N
2560	Bernasol Sarl Importation Et	bernasol-sarl-importation-et-2	Vente Ngaparou Diamaguene	\N	2	2026-03-02 23:11:17.208	2026-03-02 23:11:17.208	Vente Ngaparou Diamaguene	Route De Saly	33 822 54 24	Mbour	\N	\N	\N	f	\N
2561	Mac (Machine De Construction Et Equipement)	mac-machine-de-construction-et-equipement	Commerce General - Import Export	\N	2	2026-03-02 23:11:17.211	2026-03-02 23:11:17.211	Commerce General - Import Export	Route De Rufisque	33 834 02 02	Pikine	\N	\N	\N	f	\N
2562	Ezimpex (Ex - Codimex Depuis 1998)	ezimpex-ex-codimex-depuis-1998-1	Commerce - Import/Export	\N	2	2026-03-02 23:11:17.215	2026-03-02 23:11:17.215	Commerce - Import/Export	Rue Galandou Diouf	77 552 97 30	Dakar	\N	\N	\N	f	\N
2563	Gie Nidamour	gie-nidamour	Commerce General Import Export Prest Services Sicap Sacre Cœur 3 Dakar 0 Dakar Saveur D'Afrique Sarl Import Export	\N	2	2026-03-02 23:11:17.218	2026-03-02 23:11:17.218	Commerce General Import Export Prest Services Sicap Sacre Cœur 3 Dakar 0 Dakar Saveur D'Afrique Sarl Import Export	Rue 25 X Corniche Medina	33 851 56 97	Dakar	\N	\N	\N	f	\N
2564	Cristabel Diffusion Importations -	cristabel-diffusion-importations-1	Ventes Point E -	\N	2	2026-03-02 23:11:17.223	2026-03-02 23:11:17.223	Ventes Point E -	Rue 4 Entre A Et B (Ex - Rue 7 X B - Villa N° 4276 - Point E)	33 822 76 76	Dakar	\N	\N	\N	f	\N
2565	Fallou Thiam Ndindy Securite	fallou-thiam-ndindy-securite-1	Commerce General Import- Export	\N	2	2026-03-02 23:11:17.228	2026-03-02 23:11:17.228	Commerce General Import- Export	Rue Fass Casier N°2 0 Dakar Ced (Consortium D'Entreprises De Dakar - Amadou Makhtar Diagne) Commerce Import-Export Sicap Liberte 5 N° 5388	33 823 36 87	Dakar	\N	\N	\N	f	\N
2566	S.C.S (Senegal Climatisation Suarl) Importations -	s-c-s-senegal-climatisation-suarl-importations-1	Ventes	\N	2	2026-03-02 23:11:17.232	2026-03-02 23:11:17.232	Ventes	Rue Marchand X Tolbiac 0 Dakar Marzin - Sports Sarl Importateur Revendeur Avenue Lamine Gueye Bulding Maginot	33 820 26 33	Dakar	\N	\N	\N	f	\N
2567	Touba Darou W Ahab W Orld Market	touba-darou-w-ahab-w-orld-market-1	Commerce Import-Export	\N	2	2026-03-02 23:11:17.235	2026-03-02 23:11:17.235	Commerce Import-Export	Rue Felix Faure 0 Dakar Aex & Co Suarl Transformation Et Exportation De Produits Halieutiques Rue A. Assane Ndoye	33 822 19 71	Dakar	\N	\N	\N	f	\N
2568	Gie Ndam Import Export Import Export Parcelles Assainies Unite 10 Keur Massar 776529673 Dakar	gie-ndam-import-export-import-export-parcelles-assainies-unite-10-keur-massar-776529673-dakar	Commerce) Commerce General - Import -Export	\N	2	2026-03-02 23:11:17.238	2026-03-02 23:11:17.238	Commerce) Commerce General - Import -Export	Rue Raffenel	77 377 90 45	Pikine	\N	\N	\N	f	\N
2569	Coseni Sarl	coseni-sarl	Commerce Import-Export	\N	2	2026-03-02 23:11:17.24	2026-03-02 23:11:17.24	Commerce Import-Export	Avenue Blaise Diagne	33 842 96 26	Dakar	\N	\N	\N	f	\N
2570	Groupe Lak'S Sarl Importation Et	groupe-lak-s-sarl-importation-et-2	Distribution De Produits Alimentaires	\N	2	2026-03-02 23:11:17.244	2026-03-02 23:11:17.244	Distribution De Produits Alimentaires	Avenue Lamine Gueye	33 823 77 99	Dakar	\N	\N	\N	f	\N
2571	Ericsson Senegal	ericsson-senegal-1	Services Rendus Principalement Aux Entreprises Almadies	\N	3	2026-03-02 23:11:17.247	2026-03-02 23:11:17.247	Services Rendus Principalement Aux Entreprises Almadies	Route Du Meridien President	33 949 16 00	Dakar	\N	\N	\N	f	\N
2572	Esd (Equipement &	esd-equipement-1	Services Dakar) Services Principalement Rendus Aux Entreprises	\N	3	2026-03-02 23:11:17.25	2026-03-02 23:11:17.25	Services Dakar) Services Principalement Rendus Aux Entreprises	Route De Ouakam	33 829 30 00	Dakar	\N	\N	\N	f	\N
2573	Bia Dakar (Ex Art, Atelier De Renovation Et De Transformation)	bia-dakar-ex-art-atelier-de-renovation-et-de-transformation-1	Services Rendus Principalement Aux Entreprises	\N	3	2026-03-02 23:11:17.254	2026-03-02 23:11:17.254	Services Rendus Principalement Aux Entreprises	Route De Rufisque	33 860 77 76	Dakar	\N	\N	\N	f	\N
2574	Valdafrique - Labo Canonne - Sa Industries Pharmaceutiques - Autres	valdafrique-labo-canonne-sa-industries-pharmaceutiques-autres-3	Commerces - Services Rendus Auf Entreprises	\N	2	2026-03-02 23:11:17.26	2026-03-02 23:11:17.26	Commerces - Services Rendus Auf Entreprises	Route De Diokoul - Rufisque	33 853 23 38	Dakar	\N	\N	\N	f	\N
2575	Delattre Levivier Maroc Sa	delattre-levivier-maroc-sa	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.262	2026-03-02 23:11:17.262	Services Fournis Aux Entreprises	Avenue Pasteur S/C Domilicia	33 869 43 43	Dakar	\N	\N	\N	f	\N
2576	Sinoma International Engineering Senegal Sau	sinoma-international-engineering-senegal-sau	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.264	2026-03-02 23:11:17.264	Services Fournis Aux Entreprises	Rue Felix Faure	33 832 32 46	Dakar	\N	\N	\N	f	\N
2577	Som Sarl-Societe D'Operation Miniere	som-sarl-societe-d-operation-miniere	Services Rendus Aux Entreprises Central	\N	3	2026-03-02 23:11:17.267	2026-03-02 23:11:17.267	Services Rendus Aux Entreprises Central	Park,Avenue Malick Sy X Autoroute 33 86002 28 Dakar Arc Informatique - Sarl Fournisseur D'Acces Internet (Sevices Aux Entreprises) Rue Saint Michel X Galandou Diouf - Immeuble Coumba Castel	77 597 08 27	Dakar	\N	\N	\N	f	\N
2578	Prest'Interim Sarl	prest-interim-sarl	Services Fournis Aux Entreprises Grand Standing	\N	3	2026-03-02 23:11:17.269	2026-03-02 23:11:17.269	Services Fournis Aux Entreprises Grand Standing	Imm, Assana Ndiaye Thies 775698025 Dakar Ibm Senegal - Sarl (International Business Machines Senegal - Sarl Services Fournis Aux Entreprises Rue Mousse Diop X Amadou Assane Ndoye	33 869 64 54	Thies	\N	\N	\N	f	\N
2579	Boa	boa	Services (Bank Of Africa Services) Activites De Soutien Aux Entreprises	\N	3	2026-03-02 23:11:17.271	2026-03-02 23:11:17.271	Services (Bank Of Africa Services) Activites De Soutien Aux Entreprises	Immeuble Elan-Zone 12, Route De Ngor Almadie 33865 63 80 Dakar Havas Media Senegal - Sa Services Fournis Aux Entreprises Avenue Hassan Ii	33 849 28 00	Dakar	\N	\N	\N	f	\N
2580	Oracle Senegal Sarl	oracle-senegal-sarl	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.274	2026-03-02 23:11:17.274	Services Fournis Aux Entreprises	Immeuble Isocele Rue De Diourbel X Rond Point De L'Ellipse	33 867 57 37	Dakar	\N	\N	\N	f	\N
2581	Isade Sa (Institut Superieur Africain Pour Le Developpemnt De L'Entreprise)	isade-sa-institut-superieur-africain-pour-le-developpemnt-de-l-entreprise	Services Rendus Principalement Aux Entreprises Point E	\N	3	2026-03-02 23:11:17.276	2026-03-02 23:11:17.276	Services Rendus Principalement Aux Entreprises Point E	Rue 1 X A	33 849 05 00	Dakar	\N	\N	\N	f	\N
2582	Sgu Sarl	sgu-sarl	Services Rendus Aux Entreprises	\N	3	2026-03-02 23:11:17.279	2026-03-02 23:11:17.279	Services Rendus Aux Entreprises	Avenue Malick Sy X Autoroute	33 869 29 69	Dakar	\N	\N	\N	f	\N
2583	Kumba W Est Africa Sarl	kumba-w-est-africa-sarl	Services Fournis Aux Entreprises Nca	\N	3	2026-03-02 23:11:17.281	2026-03-02 23:11:17.281	Services Fournis Aux Entreprises Nca	Avenue Jean Jaures X Carnot Immeuble 4E Etage	33 860 13 78	Dakar	\N	\N	\N	f	\N
2584	Apave Sahel (Ex Ytc - Ingenierie - Sa)	apave-sahel-ex-ytc-ingenierie-sa	Services Principalement Rendus Aux Entreprises	\N	3	2026-03-02 23:11:17.284	2026-03-02 23:11:17.284	Services Principalement Rendus Aux Entreprises	Bd De La Republique	33 889 51 00	Dakar	\N	\N	\N	f	\N
2585	Ozyx Composite Sarl	ozyx-composite-sarl	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.286	2026-03-02 23:11:17.286	Services Fournis Aux Entreprises	Bccd	33 822 96 22	Dakar	\N	\N	\N	f	\N
2586	Yingli Green Energy W Est Africa Succursale	yingli-green-energy-w-est-africa-succursale	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.288	2026-03-02 23:11:17.288	Services Fournis Aux Entreprises	Boulevard Djily Mbaye Immeuble Azur 15 772185728 Dakar Dvs Suarl ( Digital Virgo Senegal / Ex Jet Multimedia Senegal) Services Fournis Aux Entreprises Nca Sicap Amitie 1 Avenue Bouguiba	33 867 54 97	Dakar	\N	\N	\N	f	\N
2587	Daport Sa	daport-sa	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.29	2026-03-02 23:11:17.29	Services Fournis Aux Entreprises	Rue Mohamed 5 X Rue Jules Ferry	33 860 90 01	Dakar	\N	\N	\N	f	\N
2588	Egis Route Succursale Senegal	egis-route-succursale-senegal	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.292	2026-03-02 23:11:17.292	Services Fournis Aux Entreprises	Avenue Abdoulaye Fadiga, Immeuble Abdou Lahad Mbacke, (1Er Etgae)	33 849 19 49	Dakar	\N	\N	\N	f	\N
2589	Entreprise Activité Adresse Téléphone Mbour Etude Maitre Marie Ba	entreprise-activite-adresse-telephone-mbour-etude-maitre-marie-ba	Services Fournis Aux Entreprises Saly En Face Ecole Francaise Jacques Prevert 339571175 Dakar Setec Infrastucture Afrique Services Fournis Aux Entreprises Nca	\N	3	2026-03-02 23:11:17.294	2026-03-02 23:11:17.294	Services Fournis Aux Entreprises Saly En Face Ecole Francaise Jacques Prevert 339571175 Dakar Setec Infrastucture Afrique Services Fournis Aux Entreprises Nca	Avenue Pasteur 33849 65 05 Dakar Sogest Sarl Services Fournis Aux Entreprises Avenue Malick Sy Immeuble Batimat En Face Cosec	33 823 35 10	Ville	\N	\N	\N	f	\N
2590	Systemes Pv Suarl	systemes-pv-suarl	Services Fournis Aux Entreprises 5	\N	3	2026-03-02 23:11:17.296	2026-03-02 23:11:17.296	Services Fournis Aux Entreprises 5	Rue Dx Aime Cesaire Fann Residence	77 283 05 00	Dakar	\N	\N	\N	f	\N
2591	Netlogik Afrique Surl	netlogik-afrique-surl	Services Rendus Principalement Aux Entreprises	\N	3	2026-03-02 23:11:17.299	2026-03-02 23:11:17.299	Services Rendus Principalement Aux Entreprises	Rue Mousse Diop	33 825 97 55	Dakar	\N	\N	\N	f	\N
2592	Volconsa Senegal	volconsa-senegal	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.301	2026-03-02 23:11:17.301	Services Fournis Aux Entreprises	Avenue Bourguiba, Sicap Dieppeul I	33 823 35 10	Dakar	\N	\N	\N	f	\N
2593	Le Floch Depollution Sa	le-floch-depollution-sa	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.303	2026-03-02 23:11:17.303	Services Fournis Aux Entreprises	Boulevard De La Republique	33 849 40 40	Dakar	\N	\N	\N	f	\N
2594	Optesis Sarl (Ex Optima Solutions)	optesis-sarl-ex-optima-solutions	Services Fournis Aux Entreprises Hann Maristes	\N	3	2026-03-02 23:11:17.306	2026-03-02 23:11:17.306	Services Fournis Aux Entreprises Hann Maristes	Immeuble Z- 19	33 889 70 70	Dakar	\N	\N	\N	f	\N
2595	Cabex Sarl	cabex-sarl	Services Aux Entreprises (Expertise Comptable)	\N	3	2026-03-02 23:11:17.308	2026-03-02 23:11:17.308	Services Aux Entreprises (Expertise Comptable)	Rue Amadou Assane Ndoye	33 859 90 00	Dakar	\N	\N	\N	f	\N
2596	Ssb (Societe Senegalaise De Bureautique)	ssb-societe-senegalaise-de-bureautique-1	Commerce - Services Aux Entreprises Point E N° 1	\N	2	2026-03-02 23:11:17.311	2026-03-02 23:11:17.311	Commerce - Services Aux Entreprises Point E N° 1	Rue Des Ecrivains X Bd De L'Est	33 860 41 41	Dakar	\N	\N	\N	f	\N
2597	Thi Surl (Techniques Hospitalieres & Industrielles)	thi-surl-techniques-hospitalieres-industrielles	Services Rendus Principalement Aux Entreprises Patte D'Oie Builders Place Du Marche (Ex 6,	\N	7	2026-03-02 23:11:17.314	2026-03-02 23:11:17.314	Services Rendus Principalement Aux Entreprises Patte D'Oie Builders Place Du Marche (Ex 6,	Rue De Reims) 33822 72 20 Dakar Neticoa Senegal Sa Services Fournis Aux Entreprises Sicap Amitie I Immeuble Gamma	33 869 26 71	Dakar	\N	\N	\N	f	\N
2598	Ikonomia - Sa	ikonomia-sa	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.316	2026-03-02 23:11:17.316	Services Fournis Aux Entreprises	Rue A X 7 Et 8 Point E	77 639 29 96	Dakar	\N	\N	\N	f	\N
2599	Cabinet A-To Audit Group Surl	cabinet-a-to-audit-group-surl	Services Fournis Aux Entreprises (Audit)	\N	3	2026-03-02 23:11:17.318	2026-03-02 23:11:17.318	Services Fournis Aux Entreprises (Audit)	Avenue Georges Pompidou	77 677 64 83	Dakar	\N	\N	\N	f	\N
2600	Usp Group Sarl	usp-group-sarl	Services Rendus Aux Entreprises	\N	3	2026-03-02 23:11:17.32	2026-03-02 23:11:17.32	Services Rendus Aux Entreprises	Avenue Malick Sy X Autoroute	33 864 55 02	Dakar	\N	\N	\N	f	\N
2601	A.T.C. Sarl (Agencement Technique Et Creation - Sarl)	a-t-c-sarl-agencement-technique-et-creation-sarl	Services Fournis Aux Entreprises Cite Biagui /	\N	3	2026-03-02 23:11:17.323	2026-03-02 23:11:17.323	Services Fournis Aux Entreprises Cite Biagui /	Route Du Service Geographique - Zone Industrielle De Hann	77 569 80 25	Dakar	\N	\N	\N	f	\N
2602	Ceragon Netw Orks Senegal Suarl	ceragon-netw-orks-senegal-suarl	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.325	2026-03-02 23:11:17.325	Services Fournis Aux Entreprises	Rue 7 Croisement B Point E 330821 75 79 Dakar Drum Resources Limited Sarl(Drum Commodities Senegal) Activites De Soutien Aux Entreprises Yoff Apecsy Ii N°902 772349081 Dakar Advise Services Fournis Aux Entreprises Avenue Malick Sy - Espace Ccs	33 849 65 05	Dakar	\N	\N	\N	f	\N
2603	Assi Sarl (Agence Senegalaise De	assi-sarl-agence-senegalaise-de	Services Et D'Interim) Services Fournis Aux Entreprises Point E -	\N	3	2026-03-02 23:11:17.327	2026-03-02 23:11:17.327	Services Et D'Interim) Services Fournis Aux Entreprises Point E -	Avenue Birago Diop-Rue C X 3 Villa N° 12-A Bis Rue Axc	33 869 40 40	Dakar	\N	\N	\N	f	\N
2604	Seriacom Senegal Sa	seriacom-senegal-sa	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.329	2026-03-02 23:11:17.329	Services Fournis Aux Entreprises	Avenue G,Pompidou Imm , S Anata 2 Iém	33 834 74 94	Dakar	\N	\N	\N	f	\N
2605	Soaf Sarl (Societe Ouest Africaine De Forage Sarl)	soaf-sarl-societe-ouest-africaine-de-forage-sarl	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.331	2026-03-02 23:11:17.331	Services Fournis Aux Entreprises	Bd De La Republique	33 853 28 00	Dakar	\N	\N	\N	f	\N
2606	Conex Afrique Sarl (Conseils Et Expertise En Afrique)	conex-afrique-sarl-conseils-et-expertise-en-afrique	Services Rendus Principalement Aux Entreprises	\N	3	2026-03-02 23:11:17.333	2026-03-02 23:11:17.333	Services Rendus Principalement Aux Entreprises	Avenue Carde	77 637 96 55	Dakar	\N	\N	\N	f	\N
2607	Franki Fondation Senegal	franki-fondation-senegal	Services Fournis Aux Entreprises	\N	3	2026-03-02 23:11:17.336	2026-03-02 23:11:17.336	Services Fournis Aux Entreprises	Avenue Pasteur	33 824 39 39	Dakar	\N	\N	\N	f	\N
2608	Sgi Senegal Sarl	sgi-senegal-sarl	Services Ingenieries Aux Entreprises	\N	3	2026-03-02 23:11:17.338	2026-03-02 23:11:17.338	Services Ingenieries Aux Entreprises	Avenue Pasteur	33 821 78 00	Dakar	\N	\N	\N	f	\N
2609	Dpw Dakar (Dp World Dakar Sa)	dpw-dakar-dp-world-dakar-sa	Manutention Portuaire	\N	10	2026-03-02 23:11:17.34	2026-03-02 23:11:17.34	Manutention Portuaire			Dakar	\N	\N	\N	f	\N
2610	Groupe Air Senegal Sa	groupe-air-senegal-sa	Transport Aerien	\N	10	2026-03-02 23:11:17.342	2026-03-02 23:11:17.342	Transport Aerien			Dakar	\N	\N	\N	f	\N
2611	Ads (Agence Des Aeroports Du Senegal)	ads-agence-des-aeroports-du-senegal	Gestion Aeroports	\N	10	2026-03-02 23:11:17.344	2026-03-02 23:11:17.344	Gestion Aeroports			Dakar	\N	\N	\N	f	\N
2612	Bolore Africa Logistics Senegal	bolore-africa-logistics-senegal	Logistique Et Transport	\N	10	2026-03-02 23:11:17.346	2026-03-02 23:11:17.346	Logistique Et Transport			Dakar	\N	\N	\N	f	\N
2613	Dakarnave Sa	dakarnave-sa	Reparation Navale	\N	10	2026-03-02 23:11:17.348	2026-03-02 23:11:17.348	Reparation Navale			Dakar	\N	\N	\N	f	\N
2614	Transrail Sa	transrail-sa	Transport Ferroviaire	\N	10	2026-03-02 23:11:17.35	2026-03-02 23:11:17.35	Transport Ferroviaire			Dakar	\N	\N	\N	f	\N
2615	Sncs (Societe Nationale Chemins De Fer Senegal)	sncs-societe-nationale-chemins-de-fer-senegal	Transport Ferroviaire	\N	10	2026-03-02 23:11:17.353	2026-03-02 23:11:17.353	Transport Ferroviaire			Dakar	\N	\N	\N	f	\N
2616	Kp Sa (Kuehne Et Nagel Senegal)	kp-sa-kuehne-et-nagel-senegal	Logistique Et Transport	\N	10	2026-03-02 23:11:17.355	2026-03-02 23:11:17.355	Logistique Et Transport			Dakar	\N	\N	\N	f	\N
2617	Gfi Sa (Groupement Frigorifique Senegal)	gfi-sa-groupement-frigorifique-senegal	Stockage Frigorifique	\N	10	2026-03-02 23:11:17.357	2026-03-02 23:11:17.357	Stockage Frigorifique			Dakar	\N	\N	\N	f	\N
2618	Cma Cgm Tdc Senegal	cma-cgm-tdc-senegal	Transport Maritime	\N	10	2026-03-02 23:11:17.359	2026-03-02 23:11:17.359	Transport Maritime			Dakar	\N	\N	\N	f	\N
2619	Damco Senegal	damco-senegal	Logistique Et Transport	\N	10	2026-03-02 23:11:17.361	2026-03-02 23:11:17.361	Logistique Et Transport			Dakar	\N	\N	\N	f	\N
2620	Maersk Line Senegal	maersk-line-senegal	Transport Maritime	\N	10	2026-03-02 23:11:17.363	2026-03-02 23:11:17.363	Transport Maritime			Dakar	\N	\N	\N	f	\N
2621	Dakar Terminal Sa	dakar-terminal-sa	Terminal Portuaire	\N	10	2026-03-02 23:11:17.365	2026-03-02 23:11:17.365	Terminal Portuaire			Dakar	\N	\N	\N	f	\N
2622	Ddd Sa (Dakar Dem Dikk)	ddd-sa-dakar-dem-dikk	Transport Urbain	\N	10	2026-03-02 23:11:17.367	2026-03-02 23:11:17.367	Transport Urbain			Dakar	\N	\N	\N	f	\N
2623	Senegal Handling Services Sa	senegal-handling-services-sa	Assistance En Escale	\N	10	2026-03-02 23:11:17.369	2026-03-02 23:11:17.369	Assistance En Escale			Dakar	\N	\N	\N	f	\N
2624	Khoury Transports Sarl	khoury-transports-sarl	Transport Routier	\N	10	2026-03-02 23:11:17.371	2026-03-02 23:11:17.371	Transport Routier			Dakar	\N	\N	\N	f	\N
2625	Apm Terminals Senegal Sa	apm-terminals-senegal-sa	Terminal A Conteneurs	\N	10	2026-03-02 23:11:17.374	2026-03-02 23:11:17.374	Terminal A Conteneurs			Dakar	\N	\N	\N	f	\N
2626	Ahs (Airport Handling Senegal)	ahs-airport-handling-senegal	Assistance Aeroportuaire	\N	10	2026-03-02 23:11:17.376	2026-03-02 23:11:17.376	Assistance Aeroportuaire			Dakar	\N	\N	\N	f	\N
2627	Iberia Airlines Senegal	iberia-airlines-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.379	2026-03-02 23:11:17.379	Transport Aerien			Dakar	\N	\N	\N	f	\N
2628	Spp Sa (Societe Du Pipeline Petrole Senegal)	spp-sa-societe-du-pipeline-petrole-senegal	Transport Petrole Par Pipeline	\N	10	2026-03-02 23:11:17.381	2026-03-02 23:11:17.381	Transport Petrole Par Pipeline			Dakar	\N	\N	\N	f	\N
2629	Urd Sa (Union Routiere De Distribution)	urd-sa-union-routiere-de-distribution	Transport Routier	\N	10	2026-03-02 23:11:17.383	2026-03-02 23:11:17.383	Transport Routier			Dakar	\N	\N	\N	f	\N
2630	Getma Senegal Sa	getma-senegal-sa	Manutention Et Logistique	\N	10	2026-03-02 23:11:17.386	2026-03-02 23:11:17.386	Manutention Et Logistique			Dakar	\N	\N	\N	f	\N
2631	Asky Airlines Senegal	asky-airlines-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.388	2026-03-02 23:11:17.388	Transport Aerien			Dakar	\N	\N	\N	f	\N
2632	Mlt Sa (Manutention Logistique Terrestre)	mlt-sa-manutention-logistique-terrestre	Manutention	\N	10	2026-03-02 23:11:17.39	2026-03-02 23:11:17.39	Manutention			Dakar	\N	\N	\N	f	\N
2633	Delta Air Lines Senegal	delta-air-lines-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.392	2026-03-02 23:11:17.392	Transport Aerien			Dakar	\N	\N	\N	f	\N
2634	Tap Air Portugal Senegal	tap-air-portugal-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.395	2026-03-02 23:11:17.395	Transport Aerien			Dakar	\N	\N	\N	f	\N
2635	Anacim (Agence Nationale Aviation Civile Meteorologie)	anacim-agence-nationale-aviation-civile-meteorologie	Aviation Civile	\N	10	2026-03-02 23:11:17.397	2026-03-02 23:11:17.397	Aviation Civile			Dakar	\N	\N	\N	f	\N
2636	Sogetrans Sa	sogetrans-sa	Transport Et Logistique	\N	10	2026-03-02 23:11:17.399	2026-03-02 23:11:17.399	Transport Et Logistique			Dakar	\N	\N	\N	f	\N
2637	Sefics Sa	sefics-sa	Transitaire Maritime	\N	10	2026-03-02 23:11:17.401	2026-03-02 23:11:17.401	Transitaire Maritime			Dakar	\N	\N	\N	f	\N
2638	Saga Senegal Sa	saga-senegal-sa	Transport Et Logistique	\N	10	2026-03-02 23:11:17.403	2026-03-02 23:11:17.403	Transport Et Logistique			Dakar	\N	\N	\N	f	\N
2639	Kenya Airways Senegal	kenya-airways-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.405	2026-03-02 23:11:17.405	Transport Aerien			Dakar	\N	\N	\N	f	\N
2640	Ethiopian Airlines Senegal	ethiopian-airlines-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.408	2026-03-02 23:11:17.408	Transport Aerien			Dakar	\N	\N	\N	f	\N
2641	Grimaldi Lines Senegal	grimaldi-lines-senegal	Transport Maritime	\N	10	2026-03-02 23:11:17.41	2026-03-02 23:11:17.41	Transport Maritime			Dakar	\N	\N	\N	f	\N
2642	Socopao Senegal Sa	socopao-senegal-sa	Consignation Et Transit	\N	10	2026-03-02 23:11:17.413	2026-03-02 23:11:17.413	Consignation Et Transit			Dakar	\N	\N	\N	f	\N
2643	Cosama (Compagnie Senegalaise Affretes Maritime)	cosama-compagnie-senegalaise-affretes-maritime	Armement Maritime	\N	10	2026-03-02 23:11:17.416	2026-03-02 23:11:17.416	Armement Maritime			Dakar	\N	\N	\N	f	\N
2644	Transitex Senegal Sarl	transitex-senegal-sarl	Transit Et Douane	\N	10	2026-03-02 23:11:17.418	2026-03-02 23:11:17.418	Transit Et Douane			Dakar	\N	\N	\N	f	\N
2645	Sitas (Societe Internationale Transitaires Senegal)	sitas-societe-internationale-transitaires-senegal	Transit Maritime	\N	10	2026-03-02 23:11:17.42	2026-03-02 23:11:17.42	Transit Maritime			Dakar	\N	\N	\N	f	\N
2646	Sdtm (Societe Dakaroise Transport Maritime)	sdtm-societe-dakaroise-transport-maritime	Transport Maritime	\N	10	2026-03-02 23:11:17.423	2026-03-02 23:11:17.423	Transport Maritime			Dakar	\N	\N	\N	f	\N
2647	Senegal Services Maritimes Sarl	senegal-services-maritimes-sarl	Services Maritimes	\N	10	2026-03-02 23:11:17.425	2026-03-02 23:11:17.425	Services Maritimes			Dakar	\N	\N	\N	f	\N
2648	Africa Lines Senegal	africa-lines-senegal	Transport Maritime	\N	10	2026-03-02 23:11:17.428	2026-03-02 23:11:17.428	Transport Maritime			Dakar	\N	\N	\N	f	\N
2649	Transeneo Sa	transeneo-sa	Transit Et Logistique	\N	10	2026-03-02 23:11:17.43	2026-03-02 23:11:17.43	Transit Et Logistique			Dakar	\N	\N	\N	f	\N
2650	Sernam Senegal	sernam-senegal	Transport Rapide Messagerie	\N	10	2026-03-02 23:11:17.432	2026-03-02 23:11:17.432	Transport Rapide Messagerie			Dakar	\N	\N	\N	f	\N
2651	Transports Diagne Sarl	transports-diagne-sarl	Transport Routier	\N	10	2026-03-02 23:11:17.435	2026-03-02 23:11:17.435	Transport Routier			Dakar	\N	\N	\N	f	\N
2652	Gms (Groupement Manutention Senegalaise)	gms-groupement-manutention-senegalaise	Manutention Portuaire	\N	10	2026-03-02 23:11:17.437	2026-03-02 23:11:17.437	Manutention Portuaire			Dakar	\N	\N	\N	f	\N
2653	Translog Afrique Sarl	translog-afrique-sarl	Transport Et Logistique	\N	10	2026-03-02 23:11:17.439	2026-03-02 23:11:17.439	Transport Et Logistique			Dakar	\N	\N	\N	f	\N
2654	Afric Transit Sa	afric-transit-sa	Transit Et Consignation	\N	10	2026-03-02 23:11:17.441	2026-03-02 23:11:17.441	Transit Et Consignation			Dakar	\N	\N	\N	f	\N
2655	Dhl Senegal Sa	dhl-senegal-sa	Messagerie Internationale	\N	10	2026-03-02 23:11:17.443	2026-03-02 23:11:17.443	Messagerie Internationale			Dakar	\N	\N	\N	f	\N
2656	Fedex Senegal	fedex-senegal	Messagerie Express	\N	10	2026-03-02 23:11:17.445	2026-03-02 23:11:17.445	Messagerie Express			Dakar	\N	\N	\N	f	\N
2657	Ups Senegal	ups-senegal	Messagerie Et Logistique	\N	10	2026-03-02 23:11:17.448	2026-03-02 23:11:17.448	Messagerie Et Logistique			Dakar	\N	\N	\N	f	\N
2658	Chronopost Senegal	chronopost-senegal	Messagerie Express	\N	10	2026-03-02 23:11:17.45	2026-03-02 23:11:17.45	Messagerie Express			Dakar	\N	\N	\N	f	\N
2659	Sdv Senegal (Bollore Logistics)	sdv-senegal-bollore-logistics	Transport Et Logistique	\N	10	2026-03-02 23:11:17.452	2026-03-02 23:11:17.452	Transport Et Logistique			Dakar	\N	\N	\N	f	\N
2660	Dakar Airport Services Sarl	dakar-airport-services-sarl	Services Aeroportuaires	\N	10	2026-03-02 23:11:17.454	2026-03-02 23:11:17.454	Services Aeroportuaires			Dakar	\N	\N	\N	f	\N
2661	Senegal Sealines Sa	senegal-sealines-sa	Transport Maritime	\N	10	2026-03-02 23:11:17.456	2026-03-02 23:11:17.456	Transport Maritime			Dakar	\N	\N	\N	f	\N
2662	Groupe Transalliance Senegal	groupe-transalliance-senegal	Transport Et Logistique	\N	10	2026-03-02 23:11:17.458	2026-03-02 23:11:17.458	Transport Et Logistique			Dakar	\N	\N	\N	f	\N
2663	Sat (Societe Africaine Transports)	sat-societe-africaine-transports	Transport Routier	\N	10	2026-03-02 23:11:17.46	2026-03-02 23:11:17.46	Transport Routier			Dakar	\N	\N	\N	f	\N
2664	Sotras Sarl	sotras-sarl	Transport Routier	\N	10	2026-03-02 23:11:17.462	2026-03-02 23:11:17.462	Transport Routier			Dakar	\N	\N	\N	f	\N
2665	Smt Sarl (Senegal Maritime Transport)	smt-sarl-senegal-maritime-transport	Transport Maritime	\N	10	2026-03-02 23:11:17.464	2026-03-02 23:11:17.464	Transport Maritime			Dakar	\N	\N	\N	f	\N
2666	Sea Invest Senegal	sea-invest-senegal	Manutention Portuaire	\N	10	2026-03-02 23:11:17.466	2026-03-02 23:11:17.466	Manutention Portuaire			Dakar	\N	\N	\N	f	\N
2667	Africa Merchant Lines	africa-merchant-lines	Transport Maritime	\N	10	2026-03-02 23:11:17.467	2026-03-02 23:11:17.467	Transport Maritime			Dakar	\N	\N	\N	f	\N
2668	Global Air Express Sarl	global-air-express-sarl	Fret Aerien Express	\N	10	2026-03-02 23:11:17.47	2026-03-02 23:11:17.47	Fret Aerien Express			Dakar	\N	\N	\N	f	\N
2669	Consignation Navires Et Services	consignation-navires-et-services	Consignation Maritime	\N	10	2026-03-02 23:11:17.472	2026-03-02 23:11:17.472	Consignation Maritime			Dakar	\N	\N	\N	f	\N
2670	Groupe Kalilou Transport	groupe-kalilou-transport	Transport Voyageurs	\N	10	2026-03-02 23:11:17.475	2026-03-02 23:11:17.475	Transport Voyageurs			Dakar	\N	\N	\N	f	\N
2671	Dtc Sarl (Dakar Transit Container)	dtc-sarl-dakar-transit-container	Transit Conteneurs	\N	10	2026-03-02 23:11:17.478	2026-03-02 23:11:17.478	Transit Conteneurs			Dakar	\N	\N	\N	f	\N
2672	African Global Logistics Sarl	african-global-logistics-sarl	Logistique Internationale	\N	10	2026-03-02 23:11:17.481	2026-03-02 23:11:17.481	Logistique Internationale			Dakar	\N	\N	\N	f	\N
2673	West Africa Transit Sarl	west-africa-transit-sarl	Transit Sous Regional	\N	10	2026-03-02 23:11:17.483	2026-03-02 23:11:17.483	Transit Sous Regional			Dakar	\N	\N	\N	f	\N
2674	Teranga Express Sarl	teranga-express-sarl	Transport Express	\N	10	2026-03-02 23:11:17.485	2026-03-02 23:11:17.485	Transport Express			Dakar	\N	\N	\N	f	\N
2675	Ams (African Marine Services)	ams-african-marine-services	Services Maritimes	\N	10	2026-03-02 23:11:17.487	2026-03-02 23:11:17.487	Services Maritimes			Dakar	\N	\N	\N	f	\N
2676	Sotraser Sarl	sotraser-sarl	Transport Routier	\N	10	2026-03-02 23:11:17.49	2026-03-02 23:11:17.49	Transport Routier			Thiès	\N	\N	\N	f	\N
2677	Africa Express Lines	africa-express-lines	Transport Maritime	\N	10	2026-03-02 23:11:17.492	2026-03-02 23:11:17.492	Transport Maritime			Dakar	\N	\N	\N	f	\N
2678	Groupe Bds Transport	groupe-bds-transport	Transport Voyageurs	\N	10	2026-03-02 23:11:17.494	2026-03-02 23:11:17.494	Transport Voyageurs			Dakar	\N	\N	\N	f	\N
2679	Cts (Compagnie Transports Sous-Regionaux)	cts-compagnie-transports-sous-regionaux	Transport Sous Regional	\N	10	2026-03-02 23:11:17.496	2026-03-02 23:11:17.496	Transport Sous Regional			Dakar	\N	\N	\N	f	\N
2680	Sotraldi Sa	sotraldi-sa	Transit Et Distribution	\N	10	2026-03-02 23:11:17.499	2026-03-02 23:11:17.499	Transit Et Distribution			Dakar	\N	\N	\N	f	\N
2681	Senegal Cargo Sarl	senegal-cargo-sarl	Fret Et Cargo	\N	10	2026-03-02 23:11:17.502	2026-03-02 23:11:17.502	Fret Et Cargo			Dakar	\N	\N	\N	f	\N
2682	Express Maritime Sarl	express-maritime-sarl	Transport Maritime Rapide	\N	10	2026-03-02 23:11:17.504	2026-03-02 23:11:17.504	Transport Maritime Rapide			Dakar	\N	\N	\N	f	\N
2683	Maritime Et Logistique Sarl	maritime-et-logistique-sarl	Logistique Maritime	\N	10	2026-03-02 23:11:17.507	2026-03-02 23:11:17.507	Logistique Maritime			Dakar	\N	\N	\N	f	\N
2684	Transitop Sarl	transitop-sarl	Transit Douanier	\N	10	2026-03-02 23:11:17.509	2026-03-02 23:11:17.509	Transit Douanier			Dakar	\N	\N	\N	f	\N
2685	Tls Sa (Transport Logistique Senegal)	tls-sa-transport-logistique-senegal	Transport Et Logistique	\N	10	2026-03-02 23:11:17.511	2026-03-02 23:11:17.511	Transport Et Logistique			Dakar	\N	\N	\N	f	\N
2686	Cts Sa (Compagnie Transport Senegalaise)	cts-sa-compagnie-transport-senegalaise	Transport Voyageurs	\N	10	2026-03-02 23:11:17.513	2026-03-02 23:11:17.513	Transport Voyageurs			Dakar	\N	\N	\N	f	\N
2687	Setrans Sarl	setrans-sarl	Services Transport	\N	10	2026-03-02 23:11:17.515	2026-03-02 23:11:17.515	Services Transport			Dakar	\N	\N	\N	f	\N
2688	Afric Ocean Senegal	afric-ocean-senegal	Transport Maritime	\N	10	2026-03-02 23:11:17.517	2026-03-02 23:11:17.517	Transport Maritime			Dakar	\N	\N	\N	f	\N
2689	Tms (Transit Maritime Senegal)	tms-transit-maritime-senegal	Transit Maritime	\N	10	2026-03-02 23:11:17.518	2026-03-02 23:11:17.518	Transit Maritime			Dakar	\N	\N	\N	f	\N
2690	Gls Senegal (Groupe Logistique Senegal)	gls-senegal-groupe-logistique-senegal	Logistique Et Stockage	\N	10	2026-03-02 23:11:17.52	2026-03-02 23:11:17.52	Logistique Et Stockage			Dakar	\N	\N	\N	f	\N
2691	Sefitra Sa	sefitra-sa	Fret International	\N	10	2026-03-02 23:11:17.522	2026-03-02 23:11:17.522	Fret International			Dakar	\N	\N	\N	f	\N
2692	Sahel Transport Sarl	sahel-transport-sarl	Transport Sahel	\N	10	2026-03-02 23:11:17.524	2026-03-02 23:11:17.524	Transport Sahel			Dakar	\N	\N	\N	f	\N
2693	Intercargo Sarl	intercargo-sarl	Transitaire Cargo	\N	10	2026-03-02 23:11:17.526	2026-03-02 23:11:17.526	Transitaire Cargo			Dakar	\N	\N	\N	f	\N
2694	Sotralis Sa	sotralis-sa	Transitaire Logistique	\N	10	2026-03-02 23:11:17.528	2026-03-02 23:11:17.528	Transitaire Logistique			Dakar	\N	\N	\N	f	\N
2695	Tds (Transitaire Douanier Senegalais)	tds-transitaire-douanier-senegalais	Transit Et Douane	\N	10	2026-03-02 23:11:17.53	2026-03-02 23:11:17.53	Transit Et Douane			Dakar	\N	\N	\N	f	\N
2696	Airseas Senegal	airseas-senegal	Fret Aerien Et Maritime	\N	10	2026-03-02 23:11:17.532	2026-03-02 23:11:17.532	Fret Aerien Et Maritime			Dakar	\N	\N	\N	f	\N
2697	Atl Sarl (Afrique Transports Logistique)	atl-sarl-afrique-transports-logistique	Transport Et Logistique	\N	10	2026-03-02 23:11:17.534	2026-03-02 23:11:17.534	Transport Et Logistique			Dakar	\N	\N	\N	f	\N
2698	Sotraval Sarl	sotraval-sarl	Transport Valeurs	\N	10	2026-03-02 23:11:17.535	2026-03-02 23:11:17.535	Transport Valeurs			Dakar	\N	\N	\N	f	\N
2699	Limak Senegal Airport	limak-senegal-airport	Construction Et Gestion Aeroport	\N	10	2026-03-02 23:11:17.537	2026-03-02 23:11:17.537	Construction Et Gestion Aeroport			Dakar	\N	\N	\N	f	\N
2700	Aeria Sa (Aeroport International Blaise Diagne)	aeria-sa-aeroport-international-blaise-diagne	Gestion Aeroport	\N	10	2026-03-02 23:11:17.539	2026-03-02 23:11:17.539	Gestion Aeroport			Dakar	\N	\N	\N	f	\N
2701	Transocean Sarl	transocean-sarl	Transport International	\N	10	2026-03-02 23:11:17.541	2026-03-02 23:11:17.541	Transport International			Dakar	\N	\N	\N	f	\N
2702	Safa (Societe Africaine Fret Aerien)	safa-societe-africaine-fret-aerien	Fret Aerien	\N	10	2026-03-02 23:11:17.543	2026-03-02 23:11:17.543	Fret Aerien			Dakar	\N	\N	\N	f	\N
2703	Sgts (Societe Generale Transports Senegal)	sgts-societe-generale-transports-senegal	Transport Routier	\N	10	2026-03-02 23:11:17.545	2026-03-02 23:11:17.545	Transport Routier			Dakar	\N	\N	\N	f	\N
2704	Dakar Logistique Sa	dakar-logistique-sa	Logistique Urbaine	\N	10	2026-03-02 23:11:17.547	2026-03-02 23:11:17.547	Logistique Urbaine			Dakar	\N	\N	\N	f	\N
2705	Slt Sarl (Senegal Logistics Transport)	slt-sarl-senegal-logistics-transport	Transport Et Logistique	\N	10	2026-03-02 23:11:17.549	2026-03-02 23:11:17.549	Transport Et Logistique			Dakar	\N	\N	\N	f	\N
2706	Vts (Vecteur Transport Senegal)	vts-vecteur-transport-senegal	Transport Sous Regional	\N	10	2026-03-02 23:11:17.551	2026-03-02 23:11:17.551	Transport Sous Regional			Dakar	\N	\N	\N	f	\N
2707	Senegal Container Services	senegal-container-services	Services Conteneurs	\N	10	2026-03-02 23:11:17.554	2026-03-02 23:11:17.554	Services Conteneurs			Dakar	\N	\N	\N	f	\N
2708	West Africa Shipping Sa	west-africa-shipping-sa	Transport Maritime	\N	10	2026-03-02 23:11:17.556	2026-03-02 23:11:17.556	Transport Maritime			Dakar	\N	\N	\N	f	\N
2709	Transitaires Reunis Senegal	transitaires-reunis-senegal	Transit Maritime	\N	10	2026-03-02 23:11:17.558	2026-03-02 23:11:17.558	Transit Maritime			Dakar	\N	\N	\N	f	\N
2710	Gulf Air Senegal	gulf-air-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.559	2026-03-02 23:11:17.559	Transport Aerien			Dakar	\N	\N	\N	f	\N
2711	Royal Air Maroc Senegal	royal-air-maroc-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.561	2026-03-02 23:11:17.561	Transport Aerien			Dakar	\N	\N	\N	f	\N
2712	Air France Senegal	air-france-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.563	2026-03-02 23:11:17.563	Transport Aerien			Dakar	\N	\N	\N	f	\N
2713	Turkish Airlines Senegal	turkish-airlines-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.565	2026-03-02 23:11:17.565	Transport Aerien			Dakar	\N	\N	\N	f	\N
2714	Brussels Airlines Senegal	brussels-airlines-senegal	Transport Aerien	\N	10	2026-03-02 23:11:17.567	2026-03-02 23:11:17.567	Transport Aerien			Dakar	\N	\N	\N	f	\N
2715	Corsair International Senegal	corsair-international-senegal	Transport Aerien Charters	\N	10	2026-03-02 23:11:17.569	2026-03-02 23:11:17.569	Transport Aerien Charters			Dakar	\N	\N	\N	f	\N
2716	Ecas (Entrepot Central Africain Senegal)	ecas-entrepot-central-africain-senegal	Entreposage Et Stockage	\N	10	2026-03-02 23:11:17.571	2026-03-02 23:11:17.571	Entreposage Et Stockage			Dakar	\N	\N	\N	f	\N
2717	Sen Cargo Sarl	sen-cargo-sarl	Fret Et Cargo Senegal	\N	10	2026-03-02 23:11:17.573	2026-03-02 23:11:17.573	Fret Et Cargo Senegal			Dakar	\N	\N	\N	f	\N
2718	Logitrans Sarl	logitrans-sarl	Logistique Transit	\N	10	2026-03-02 23:11:17.575	2026-03-02 23:11:17.575	Logistique Transit			Dakar	\N	\N	\N	f	\N
2719	Sen Bus Sarl	sen-bus-sarl	Transport Bus Urbain	\N	10	2026-03-02 23:11:17.576	2026-03-02 23:11:17.576	Transport Bus Urbain			Dakar	\N	\N	\N	f	\N
2720	Rapidex Sarl	rapidex-sarl	Transport Rapide Colis	\N	10	2026-03-02 23:11:17.578	2026-03-02 23:11:17.578	Transport Rapide Colis			Dakar	\N	\N	\N	f	\N
2721	Transcargo Sarl	transcargo-sarl	Transport Cargo	\N	10	2026-03-02 23:11:17.58	2026-03-02 23:11:17.58	Transport Cargo			Dakar	\N	\N	\N	f	\N
2722	Sts (Senegal Transit Services)	sts-senegal-transit-services	Transit Douanier	\N	10	2026-03-02 23:11:17.582	2026-03-02 23:11:17.582	Transit Douanier			Dakar	\N	\N	\N	f	\N
2723	Global Logistics Senegal Sarl	global-logistics-senegal-sarl	Logistique Internationale	\N	10	2026-03-02 23:11:17.584	2026-03-02 23:11:17.584	Logistique Internationale			Dakar	\N	\N	\N	f	\N
2724	Sen Fret Sarl	sen-fret-sarl	Fret International	\N	10	2026-03-02 23:11:17.586	2026-03-02 23:11:17.586	Fret International			Dakar	\N	\N	\N	f	\N
2725	Total Gaz Transport Senegal	total-gaz-transport-senegal	Transport Gaz	\N	10	2026-03-02 23:11:17.588	2026-03-02 23:11:17.588	Transport Gaz			Dakar	\N	\N	\N	f	\N
2726	Etp Arezki Sa	etp-arezki-sa	Travaux Publics	\N	6	2026-03-02 23:11:17.59	2026-03-02 23:11:17.59	Travaux Publics			Dakar	\N	\N	\N	f	\N
2727	B L Harbert International	b-l-harbert-international	Construction Batiment	\N	6	2026-03-02 23:11:17.592	2026-03-02 23:11:17.592	Construction Batiment			Dakar	\N	\N	\N	f	\N
2728	Razel Senegal Sa	razel-senegal-sa	Travaux Publics Et Genie Civil	\N	6	2026-03-02 23:11:17.594	2026-03-02 23:11:17.594	Travaux Publics Et Genie Civil			Dakar	\N	\N	\N	f	\N
2729	Senac Sa (Construction Et Genie Civil)	senac-sa-construction-et-genie-civil	Construction Et Genie Civil	\N	6	2026-03-02 23:11:17.596	2026-03-02 23:11:17.596	Construction Et Genie Civil			Dakar	\N	\N	\N	f	\N
2730	Socetra Sarl	socetra-sarl	Travaux De Construction	\N	6	2026-03-02 23:11:17.598	2026-03-02 23:11:17.598	Travaux De Construction			Dakar	\N	\N	\N	f	\N
2731	Famy Senegal Sa	famy-senegal-sa	Construction Batiment	\N	6	2026-03-02 23:11:17.6	2026-03-02 23:11:17.6	Construction Batiment			Dakar	\N	\N	\N	f	\N
2732	Palm Btp Sa	palm-btp-sa	Batiment Et Travaux Publics	\N	6	2026-03-02 23:11:17.602	2026-03-02 23:11:17.602	Batiment Et Travaux Publics			Dakar	\N	\N	\N	f	\N
2733	Rodrigues Et Camacho Sa	rodrigues-et-camacho-sa	Construction Et Btp	\N	6	2026-03-02 23:11:17.604	2026-03-02 23:11:17.604	Construction Et Btp			Dakar	\N	\N	\N	f	\N
2734	Baol Construction Sarl	baol-construction-sarl	Construction Batiment	\N	6	2026-03-02 23:11:17.606	2026-03-02 23:11:17.606	Construction Batiment			Dakar	\N	\N	\N	f	\N
2735	Cccs Suarl	cccs-suarl	Construction Et Genie Civil	\N	6	2026-03-02 23:11:17.607	2026-03-02 23:11:17.607	Construction Et Genie Civil			Dakar	\N	\N	\N	f	\N
2736	Sinco Spa	sinco-spa	Travaux Publics	\N	6	2026-03-02 23:11:17.609	2026-03-02 23:11:17.609	Travaux Publics			Dakar	\N	\N	\N	f	\N
2737	Ipc Sa (Ingenierie Projets Construction)	ipc-sa-ingenierie-projets-construction	Ingenierie Travaux	\N	6	2026-03-02 23:11:17.611	2026-03-02 23:11:17.611	Ingenierie Travaux			Dakar	\N	\N	\N	f	\N
2738	Socabeg Sa	socabeg-sa	Construction Batiment Genie Civil	\N	6	2026-03-02 23:11:17.613	2026-03-02 23:11:17.613	Construction Batiment Genie Civil			Dakar	\N	\N	\N	f	\N
2739	Sarec-Tp Sarl	sarec-tp-sarl	Travaux Publics	\N	6	2026-03-02 23:11:17.615	2026-03-02 23:11:17.615	Travaux Publics			Dakar	\N	\N	\N	f	\N
2740	Getran Sa	getran-sa	Genie Civil Et Btp	\N	6	2026-03-02 23:11:17.616	2026-03-02 23:11:17.616	Genie Civil Et Btp			Dakar	\N	\N	\N	f	\N
2741	Sls Socere Lambert Somec Sa	sls-socere-lambert-somec-sa	Electricite Et Installations	\N	6	2026-03-02 23:11:17.618	2026-03-02 23:11:17.618	Electricite Et Installations			Dakar	\N	\N	\N	f	\N
2742	Tecma Electriques Sa	tecma-electriques-sa	Installations Electriques	\N	6	2026-03-02 23:11:17.62	2026-03-02 23:11:17.62	Installations Electriques			Dakar	\N	\N	\N	f	\N
2743	Derkle Materiaux Sa	derkle-materiaux-sa	Materiaux De Construction	\N	6	2026-03-02 23:11:17.622	2026-03-02 23:11:17.622	Materiaux De Construction			Dakar	\N	\N	\N	f	\N
2744	Egcd Sa (Entreprise Generale Construction Dakar)	egcd-sa-entreprise-generale-construction-dakar	Construction	\N	6	2026-03-02 23:11:17.624	2026-03-02 23:11:17.624	Construction			Dakar	\N	\N	\N	f	\N
2745	Scpi Sa (Senegal Construction Promotion Immobiliere)	scpi-sa-senegal-construction-promotion-immobiliere	Promotion Immobiliere	\N	6	2026-03-02 23:11:17.626	2026-03-02 23:11:17.626	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2746	Esmb Sarl	esmb-sarl	Construction Et Btp	\N	6	2026-03-02 23:11:17.627	2026-03-02 23:11:17.627	Construction Et Btp			Dakar	\N	\N	\N	f	\N
2747	Cotramer Sa	cotramer-sa	Construction Renovation	\N	6	2026-03-02 23:11:17.629	2026-03-02 23:11:17.629	Construction Renovation			Dakar	\N	\N	\N	f	\N
2748	Dmi Sarl (Dakar Materiaux Industries)	dmi-sarl-dakar-materiaux-industries	Materiaux Construction	\N	6	2026-03-02 23:11:17.631	2026-03-02 23:11:17.631	Materiaux Construction			Dakar	\N	\N	\N	f	\N
2749	Senegindia Sa	senegindia-sa	Construction Et Industrie	\N	6	2026-03-02 23:11:17.634	2026-03-02 23:11:17.634	Construction Et Industrie			Dakar	\N	\N	\N	f	\N
2750	Gic Sa (Gestion Ingenierie Construction)	gic-sa-gestion-ingenierie-construction	Construction Et Gestion	\N	6	2026-03-02 23:11:17.636	2026-03-02 23:11:17.636	Construction Et Gestion			Dakar	\N	\N	\N	f	\N
2751	Ecore Sa (Construction Routes)	ecore-sa-construction-routes	Construction Routes	\N	6	2026-03-02 23:11:17.638	2026-03-02 23:11:17.638	Construction Routes			Dakar	\N	\N	\N	f	\N
2752	Sodacom Sarl	sodacom-sarl	Construction Et Btp	\N	6	2026-03-02 23:11:17.64	2026-03-02 23:11:17.64	Construction Et Btp			Dakar	\N	\N	\N	f	\N
2753	L Habitat Sarl	l-habitat-sarl-1	Construction Logements	\N	6	2026-03-02 23:11:17.643	2026-03-02 23:11:17.643	Construction Logements			Dakar	\N	\N	\N	f	\N
2754	Prochimat Sa	prochimat-sa	Produits Chimiques Batiment	\N	6	2026-03-02 23:11:17.645	2026-03-02 23:11:17.645	Produits Chimiques Batiment			Dakar	\N	\N	\N	f	\N
2755	Eice Sa (Entreprise Ingenierie Construction Electrique)	eice-sa-entreprise-ingenierie-construction-electrique	Construction Electrique	\N	6	2026-03-02 23:11:17.647	2026-03-02 23:11:17.647	Construction Electrique			Dakar	\N	\N	\N	f	\N
2756	Sosenco Sarl	sosenco-sarl	Travaux Publics	\N	6	2026-03-02 23:11:17.649	2026-03-02 23:11:17.649	Travaux Publics			Dakar	\N	\N	\N	f	\N
2757	Etpa Sarl	etpa-sarl	Travaux Publics	\N	6	2026-03-02 23:11:17.651	2026-03-02 23:11:17.651	Travaux Publics			Dakar	\N	\N	\N	f	\N
2758	Ebs Sarl (Entreprise Batiment Senegal)	ebs-sarl-entreprise-batiment-senegal	Construction Batiment	\N	6	2026-03-02 23:11:17.653	2026-03-02 23:11:17.653	Construction Batiment			Dakar	\N	\N	\N	f	\N
2759	Stp Sa (Senegal Travaux Publics)	stp-sa-senegal-travaux-publics	Travaux Publics	\N	6	2026-03-02 23:11:17.656	2026-03-02 23:11:17.656	Travaux Publics			Dakar	\N	\N	\N	f	\N
2772	Sadio Construction Sarl	sadio-construction-sarl	Construction Batiment	\N	6	2026-03-02 23:11:17.688	2026-03-02 23:11:17.688	Construction Batiment			Dakar	\N	\N	\N	f	\N
2773	Build Senegal Sarl	build-senegal-sarl	Construction Moderne	\N	6	2026-03-02 23:11:17.69	2026-03-02 23:11:17.69	Construction Moderne			Dakar	\N	\N	\N	f	\N
2774	Cbn (Construction Batiment Nord) Sarl	cbn-construction-batiment-nord-sarl	Construction Batiment	\N	6	2026-03-02 23:11:17.693	2026-03-02 23:11:17.693	Construction Batiment			Saint-Louis	\N	\N	\N	f	\N
2775	Ets Bassene Construction	ets-bassene-construction	Construction Et Btp	\N	6	2026-03-02 23:11:17.695	2026-03-02 23:11:17.695	Construction Et Btp			Ziguinchor	\N	\N	\N	f	\N
2776	Ets Cisse Travaux Publics	ets-cisse-travaux-publics	Travaux Publics	\N	6	2026-03-02 23:11:17.697	2026-03-02 23:11:17.697	Travaux Publics			Thiès	\N	\N	\N	f	\N
2781	Technibat Sarl	technibat-sarl	Technique Batiment	\N	6	2026-03-02 23:11:17.708	2026-03-02 23:11:17.708	Technique Batiment			Dakar	\N	\N	\N	f	\N
2782	Afribat Sa	afribat-sa	Batiment Africain	\N	6	2026-03-02 23:11:17.71	2026-03-02 23:11:17.71	Batiment Africain			Dakar	\N	\N	\N	f	\N
2783	Sne Sa (Societe Nouvelle Electrique)	sne-sa-societe-nouvelle-electrique	Installations Electriques	\N	6	2026-03-02 23:11:17.712	2026-03-02 23:11:17.712	Installations Electriques			Dakar	\N	\N	\N	f	\N
2784	Ecb Sa (Entreprise Construction Batiment)	ecb-sa-entreprise-construction-batiment	Construction	\N	6	2026-03-02 23:11:17.714	2026-03-02 23:11:17.714	Construction			Dakar	\N	\N	\N	f	\N
2785	Sge Sarl (Societe Generale Electricite)	sge-sarl-societe-generale-electricite	Installations Electriques	\N	6	2026-03-02 23:11:17.716	2026-03-02 23:11:17.716	Installations Electriques			Dakar	\N	\N	\N	f	\N
2786	Bati-Plus Sarl	bati-plus-sarl	Batiment Et Construction	\N	6	2026-03-02 23:11:17.718	2026-03-02 23:11:17.718	Batiment Et Construction			Dakar	\N	\N	\N	f	\N
2787	Scg Sa (Societe Construction Generale)	scg-sa-societe-construction-generale	Construction Generale	\N	6	2026-03-02 23:11:17.724	2026-03-02 23:11:17.724	Construction Generale			Dakar	\N	\N	\N	f	\N
2788	Somatra Sarl	somatra-sarl	Travaux Et Materiaux	\N	6	2026-03-02 23:11:17.726	2026-03-02 23:11:17.726	Travaux Et Materiaux			Dakar	\N	\N	\N	f	\N
2789	Mbour Construction Sa	mbour-construction-sa	Construction Batiment	\N	6	2026-03-02 23:11:17.728	2026-03-02 23:11:17.728	Construction Batiment			Mbour	\N	\N	\N	f	\N
2964	Sogen Suarl (Sante Generale)	sogen-suarl-sante-generale	Sante Et Distribution	\N	5	2026-03-02 23:11:18.095	2026-03-02 23:11:18.095	Sante Et Distribution			Dakar	\N	\N	\N	f	\N
2969	Serep Sa (Senegal Retail Promotion)	serep-sa-senegal-retail-promotion	Promotion Touristique	\N	12	2026-03-02 23:11:18.107	2026-03-02 23:11:18.107	Promotion Touristique			Dakar	\N	\N	\N	f	\N
2970	African Hotel Development Sa	african-hotel-development-sa	Developpement Hoteliers	\N	12	2026-03-02 23:11:18.11	2026-03-02 23:11:18.11	Developpement Hoteliers			Dakar	\N	\N	\N	f	\N
2971	Saccv Sa (Casino Du Cap Vert)	saccv-sa-casino-du-cap-vert	Casino Et Hotellerie	\N	12	2026-03-02 23:11:18.113	2026-03-02 23:11:18.113	Casino Et Hotellerie			Dakar	\N	\N	\N	f	\N
2972	Casino Du Port Sa	casino-du-port-sa	Casino Et Restauration	\N	12	2026-03-02 23:11:18.115	2026-03-02 23:11:18.115	Casino Et Restauration			Dakar	\N	\N	\N	f	\N
2973	Triple A Sarl (Restauration)	triple-a-sarl-restauration	Restauration Rapide	\N	12	2026-03-02 23:11:18.118	2026-03-02 23:11:18.118	Restauration Rapide			Dakar	\N	\N	\N	f	\N
2974	Restaurant Le Lagon Sarl	restaurant-le-lagon-sarl	Restaurant	\N	12	2026-03-02 23:11:18.12	2026-03-02 23:11:18.12	Restaurant			Dakar	\N	\N	\N	f	\N
2975	Hotel Palm Beach Senegal	hotel-palm-beach-senegal	Hotellerie Et Plage	\N	12	2026-03-02 23:11:18.122	2026-03-02 23:11:18.122	Hotellerie Et Plage			Saly	\N	\N	\N	f	\N
2976	Hotel Savana Sa	hotel-savana-sa	Hotellerie	\N	12	2026-03-02 23:11:18.125	2026-03-02 23:11:18.125	Hotellerie			Dakar	\N	\N	\N	f	\N
2977	La Linguere Restaurant Sarl	la-linguere-restaurant-sarl	Restaurant Gastronomique	\N	12	2026-03-02 23:11:18.127	2026-03-02 23:11:18.127	Restaurant Gastronomique			Dakar	\N	\N	\N	f	\N
2808	Ceta Sarl (Construction Etancheite)	ceta-sarl-construction-etancheite	Construction Etancheite	\N	6	2026-03-02 23:11:17.769	2026-03-02 23:11:17.769	Construction Etancheite			Dakar	\N	\N	\N	f	\N
2809	Sarl Btp Plus	sarl-btp-plus	Batiment Travaux Publics	\N	6	2026-03-02 23:11:17.771	2026-03-02 23:11:17.771	Batiment Travaux Publics			Dakar	\N	\N	\N	f	\N
2810	Sateg Sa (Societe Africaine Travaux Genie)	sateg-sa-societe-africaine-travaux-genie	Construction Et Genie Civil	\N	6	2026-03-02 23:11:17.773	2026-03-02 23:11:17.773	Construction Et Genie Civil			Dakar	\N	\N	\N	f	\N
2811	Sbs Sa (Senegal Batiment Services)	sbs-sa-senegal-batiment-services	Services Batiment	\N	6	2026-03-02 23:11:17.775	2026-03-02 23:11:17.775	Services Batiment			Dakar	\N	\N	\N	f	\N
2812	Tmc Sa (Travaux Maintenance Construction)	tmc-sa-travaux-maintenance-construction	Construction Et Maintenance	\N	6	2026-03-02 23:11:17.778	2026-03-02 23:11:17.778	Construction Et Maintenance			Dakar	\N	\N	\N	f	\N
2813	Sarc Sarl (Societe Africaine Realisations Construction)	sarc-sarl-societe-africaine-realisations-construction	Construction	\N	6	2026-03-02 23:11:17.78	2026-03-02 23:11:17.78	Construction			Dakar	\N	\N	\N	f	\N
2814	Casasud Sa	casasud-sa	Construction Et Promotion	\N	6	2026-03-02 23:11:17.782	2026-03-02 23:11:17.782	Construction Et Promotion			Dakar	\N	\N	\N	f	\N
2815	Cmt Sarl (Construction Maconnerie Terrassement)	cmt-sarl-construction-maconnerie-terrassement	Maconnerie Et Terrassement	\N	6	2026-03-02 23:11:17.784	2026-03-02 23:11:17.784	Maconnerie Et Terrassement			Dakar	\N	\N	\N	f	\N
2816	Ets Traore Construction Sarl	ets-traore-construction-sarl	Construction Batiment	\N	6	2026-03-02 23:11:17.786	2026-03-02 23:11:17.786	Construction Batiment			Dakar	\N	\N	\N	f	\N
2817	Ets Toure Btp Sarl	ets-toure-btp-sarl	Batiment Travaux Publics	\N	6	2026-03-02 23:11:17.788	2026-03-02 23:11:17.788	Batiment Travaux Publics			Dakar	\N	\N	\N	f	\N
2818	Ets Diallo Construction Sarl	ets-diallo-construction-sarl	Construction Et Btp	\N	6	2026-03-02 23:11:17.79	2026-03-02 23:11:17.79	Construction Et Btp			Dakar	\N	\N	\N	f	\N
2819	Cetp Sa (Centrale Travaux Publics)	cetp-sa-centrale-travaux-publics	Travaux Publics	\N	6	2026-03-02 23:11:17.792	2026-03-02 23:11:17.792	Travaux Publics			Dakar	\N	\N	\N	f	\N
2820	Mbtp Sarl (Mouvement Batiment Travaux Publics)	mbtp-sarl-mouvement-batiment-travaux-publics	Batiment Travaux Publics	\N	6	2026-03-02 23:11:17.795	2026-03-02 23:11:17.795	Batiment Travaux Publics			Dakar	\N	\N	\N	f	\N
2821	Saga Immobilier Sa	saga-immobilier-sa	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.797	2026-03-02 23:11:17.797	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2822	Immobiliere Generale Du Senegal Sa	immobiliere-generale-du-senegal-sa	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.799	2026-03-02 23:11:17.799	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2823	Sicap Sa (Societe Immobiliere Cap Vert)	sicap-sa-societe-immobiliere-cap-vert	Logement Social	\N	11	2026-03-02 23:11:17.801	2026-03-02 23:11:17.801	Logement Social			Dakar	\N	\N	\N	f	\N
2824	Sim Sa (Societe Immobiliere Medina)	sim-sa-societe-immobiliere-medina	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.804	2026-03-02 23:11:17.804	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2825	Snhlm Sa (Societe Nationale Habitations Loyer Modere)	snhlm-sa-societe-nationale-habitations-loyer-modere	Logement Social	\N	11	2026-03-02 23:11:17.805	2026-03-02 23:11:17.805	Logement Social			Dakar	\N	\N	\N	f	\N
2826	Cca Sarl (Cabinet Conseil Affaires Immobilieres)	cca-sarl-cabinet-conseil-affaires-immobilieres	Conseil Immobilier	\N	11	2026-03-02 23:11:17.807	2026-03-02 23:11:17.807	Conseil Immobilier			Dakar	\N	\N	\N	f	\N
2827	Cpi Sa (Compagnie Patrimoniale Investissement)	cpi-sa-compagnie-patrimoniale-investissement	Investissement Immobilier	\N	11	2026-03-02 23:11:17.81	2026-03-02 23:11:17.81	Investissement Immobilier			Dakar	\N	\N	\N	f	\N
2828	Soprim Sarl (Societe Promotion Immobiliere)	soprim-sarl-societe-promotion-immobiliere	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.812	2026-03-02 23:11:17.812	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2829	Immobiliere Horizon Sa	immobiliere-horizon-sa	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.814	2026-03-02 23:11:17.814	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2830	Agence Immobiliere Terang	agence-immobiliere-terang	Agence Immobiliere	\N	11	2026-03-02 23:11:17.816	2026-03-02 23:11:17.816	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2831	Cabinet Immobilier Diarra	cabinet-immobilier-diarra	Conseil Et Transaction Immobiliere	\N	11	2026-03-02 23:11:17.819	2026-03-02 23:11:17.819	Conseil Et Transaction Immobiliere			Dakar	\N	\N	\N	f	\N
2832	Spi Sa (Societe Promotion Immobiliere Senegal)	spi-sa-societe-promotion-immobiliere-senegal	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.822	2026-03-02 23:11:17.822	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2833	Immogroup Sarl	immogroup-sarl	Gestion Immobiliere	\N	11	2026-03-02 23:11:17.824	2026-03-02 23:11:17.824	Gestion Immobiliere			Dakar	\N	\N	\N	f	\N
2834	Sci Amitie	sci-amitie	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.827	2026-03-02 23:11:17.827	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2835	Sci Plateau	sci-plateau	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.829	2026-03-02 23:11:17.829	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2836	Alliance Immobiliere Sa	alliance-immobiliere-sa	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.832	2026-03-02 23:11:17.832	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2837	Prestige Immobilier Sarl	prestige-immobilier-sarl	Vente Location Immobiliere	\N	11	2026-03-02 23:11:17.834	2026-03-02 23:11:17.834	Vente Location Immobiliere			Dakar	\N	\N	\N	f	\N
2838	Immobilis Sarl	immobilis-sarl	Promotion Et Gestion Immobiliere	\N	11	2026-03-02 23:11:17.837	2026-03-02 23:11:17.837	Promotion Et Gestion Immobiliere			Dakar	\N	\N	\N	f	\N
2839	Agence Le Dome Sarl	agence-le-dome-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.839	2026-03-02 23:11:17.839	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2840	Sacika Sarl (Societe Africaine Construction Investissement)	sacika-sarl-societe-africaine-construction-investissement	Construction Et Investissement	\N	11	2026-03-02 23:11:17.841	2026-03-02 23:11:17.841	Construction Et Investissement			Dakar	\N	\N	\N	f	\N
2841	Snpi Sarl (Societe Nationale Promotion Immobiliere)	snpi-sarl-societe-nationale-promotion-immobiliere	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.843	2026-03-02 23:11:17.843	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2842	Ige Sa (Investissement Gestion Immobiliere)	ige-sa-investissement-gestion-immobiliere	Gestion Immobiliere	\N	11	2026-03-02 23:11:17.845	2026-03-02 23:11:17.845	Gestion Immobiliere			Dakar	\N	\N	\N	f	\N
2843	Adn Immobilier Sarl	adn-immobilier-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.847	2026-03-02 23:11:17.847	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2844	Inova Immo Sarl	inova-immo-sarl	Innovation Immobiliere	\N	11	2026-03-02 23:11:17.849	2026-03-02 23:11:17.849	Innovation Immobiliere			Dakar	\N	\N	\N	f	\N
2845	Dakar Habitat Sa	dakar-habitat-sa	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.851	2026-03-02 23:11:17.851	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2846	Saly Immobilier Sa	saly-immobilier-sa	Immobilier Touristique	\N	11	2026-03-02 23:11:17.853	2026-03-02 23:11:17.853	Immobilier Touristique			Mbour	\N	\N	\N	f	\N
2847	Cap Immobilier Sarl	cap-immobilier-sarl	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.855	2026-03-02 23:11:17.855	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2848	Agence Immobiliere Gakou (Modibo Gakou)	agence-immobiliere-gakou-modibo-gakou	Agence Immobiliere	\N	11	2026-03-02 23:11:17.856	2026-03-02 23:11:17.856	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2849	Societe Civile Immobiliere Alpha	societe-civile-immobiliere-alpha	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.858	2026-03-02 23:11:17.858	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2850	Sacyka Sarl	sacyka-sarl	Societe Africaine Construction Kaw	\N	11	2026-03-02 23:11:17.86	2026-03-02 23:11:17.86	Societe Africaine Construction Kaw			Dakar	\N	\N	\N	f	\N
2851	Mboufta Sarl	mboufta-sarl	Immobilier Et Construction	\N	11	2026-03-02 23:11:17.862	2026-03-02 23:11:17.862	Immobilier Et Construction			Dakar	\N	\N	\N	f	\N
2852	Cabinet Immobilier Le Saloum	cabinet-immobilier-le-saloum	Agence Immobiliere	\N	11	2026-03-02 23:11:17.864	2026-03-02 23:11:17.864	Agence Immobiliere			Kaolack	\N	\N	\N	f	\N
2853	Almamy Services Suarl	almamy-services-suarl	Services Immobiliers	\N	11	2026-03-02 23:11:17.866	2026-03-02 23:11:17.866	Services Immobiliers			Dakar	\N	\N	\N	f	\N
2854	Saim Maty Sa	saim-maty-sa	Societe Africaine Immobiliere Maty	\N	11	2026-03-02 23:11:17.868	2026-03-02 23:11:17.868	Societe Africaine Immobiliere Maty			Dakar	\N	\N	\N	f	\N
2855	B 3 Sarl (Promotion Immobiliere)	b-3-sarl-promotion-immobiliere	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.871	2026-03-02 23:11:17.871	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2856	Jamm Rek Senegal Sarl	jamm-rek-senegal-sarl	Immobilier Et Location	\N	11	2026-03-02 23:11:17.873	2026-03-02 23:11:17.873	Immobilier Et Location			Dakar	\N	\N	\N	f	\N
2857	Sarl Agipco	sarl-agipco	Agence Immobiliere Et Promotion	\N	11	2026-03-02 23:11:17.875	2026-03-02 23:11:17.875	Agence Immobiliere Et Promotion			Dakar	\N	\N	\N	f	\N
2858	Mailois Suarl	mailois-suarl	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.877	2026-03-02 23:11:17.877	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2859	Star Immobilier Suarl	star-immobilier-suarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.879	2026-03-02 23:11:17.879	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2860	Sarofa Inc Sarl	sarofa-inc-sarl	Societe Africaine Immobiliere	\N	11	2026-03-02 23:11:17.881	2026-03-02 23:11:17.881	Societe Africaine Immobiliere			Dakar	\N	\N	\N	f	\N
2861	Sci Vendome Et Sci De La Cite	sci-vendome-et-sci-de-la-cite	Societes Civiles Immobilieres	\N	11	2026-03-02 23:11:17.882	2026-03-02 23:11:17.882	Societes Civiles Immobilieres			Dakar	\N	\N	\N	f	\N
2862	Sci Kleber	sci-kleber	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.884	2026-03-02 23:11:17.884	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2863	Sci Cham	sci-cham	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.886	2026-03-02 23:11:17.886	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2864	Sci Naice	sci-naice	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.889	2026-03-02 23:11:17.889	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2865	Partners Immobilier Sarl	partners-immobilier-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.89	2026-03-02 23:11:17.89	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2866	Djidjack Immo Sarl	djidjack-immo-sarl	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.892	2026-03-02 23:11:17.892	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2867	Les Rochers De Ngor Sa	les-rochers-de-ngor-sa	Immobilier Prestige	\N	11	2026-03-02 23:11:17.894	2026-03-02 23:11:17.894	Immobilier Prestige			Dakar	\N	\N	\N	f	\N
2868	Sci Kubraa	sci-kubraa	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.896	2026-03-02 23:11:17.896	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2869	Immobilier La Lagune Sarl	immobilier-la-lagune-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.898	2026-03-02 23:11:17.898	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2870	Societe Civile Immobiliere Al Jamami	societe-civile-immobiliere-al-jamami	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.9	2026-03-02 23:11:17.9	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2871	Fantasy S Suarl	fantasy-s-suarl	Immobilier Et Loisirs	\N	11	2026-03-02 23:11:17.902	2026-03-02 23:11:17.902	Immobilier Et Loisirs			Dakar	\N	\N	\N	f	\N
2872	Sakara Sarl (Immobilier)	sakara-sarl-immobilier	Immobilier Et Services	\N	11	2026-03-02 23:11:17.903	2026-03-02 23:11:17.903	Immobilier Et Services			Dakar	\N	\N	\N	f	\N
2873	Immobiliere Excellence Sarl	immobiliere-excellence-sarl	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.905	2026-03-02 23:11:17.905	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2874	Immobiliere Fasso Sarl	immobiliere-fasso-sarl	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.907	2026-03-02 23:11:17.907	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2875	Iris Immobilier Sarl	iris-immobilier-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.909	2026-03-02 23:11:17.909	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2876	Sci Les Parcs De Saly	sci-les-parcs-de-saly	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.911	2026-03-02 23:11:17.911	Societe Civile Immobiliere			Mbour	\N	\N	\N	f	\N
2877	Agence Immobiliere Sokhna Mbacke	agence-immobiliere-sokhna-mbacke	Agence Immobiliere	\N	11	2026-03-02 23:11:17.913	2026-03-02 23:11:17.913	Agence Immobiliere			Touba	\N	\N	\N	f	\N
2878	Lafia Immo Sarl	lafia-immo-sarl	Immobilier Et Habitat	\N	11	2026-03-02 23:11:17.916	2026-03-02 23:11:17.916	Immobilier Et Habitat			Dakar	\N	\N	\N	f	\N
2879	Sci Sinare	sci-sinare	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.918	2026-03-02 23:11:17.918	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2880	Immo Plus Sarl	immo-plus-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.92	2026-03-02 23:11:17.92	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2881	Sci Seydina Limamou	sci-seydina-limamou	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.923	2026-03-02 23:11:17.923	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2882	Sci Djolof	sci-djolof	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.925	2026-03-02 23:11:17.925	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2883	Sci Keur Moussa	sci-keur-moussa	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.926	2026-03-02 23:11:17.926	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2884	Sci Casamance	sci-casamance	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.928	2026-03-02 23:11:17.928	Societe Civile Immobiliere			Ziguinchor	\N	\N	\N	f	\N
2885	Sci Saloum	sci-saloum	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.93	2026-03-02 23:11:17.93	Societe Civile Immobiliere			Kaolack	\N	\N	\N	f	\N
2886	Agence Immobiliere Du Fleuve	agence-immobiliere-du-fleuve	Agence Immobiliere	\N	11	2026-03-02 23:11:17.932	2026-03-02 23:11:17.932	Agence Immobiliere			Saint-Louis	\N	\N	\N	f	\N
2887	Ndiaye Immobilier Sarl	ndiaye-immobilier-sarl	Agence Et Promotion Immobiliere	\N	11	2026-03-02 23:11:17.934	2026-03-02 23:11:17.934	Agence Et Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2888	Sow Immo Sarl	sow-immo-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.936	2026-03-02 23:11:17.936	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2889	Ba Immobilier Sarl	ba-immobilier-sarl	Immobilier Et Gestion	\N	11	2026-03-02 23:11:17.938	2026-03-02 23:11:17.938	Immobilier Et Gestion			Dakar	\N	\N	\N	f	\N
2890	Thiaw Immo Suarl	thiaw-immo-suarl	Promotion Immobiliere	\N	11	2026-03-02 23:11:17.94	2026-03-02 23:11:17.94	Promotion Immobiliere			Dakar	\N	\N	\N	f	\N
2891	Cheikh Immobilier Sarl	cheikh-immobilier-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.942	2026-03-02 23:11:17.942	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2892	Toure Immo Sarl	toure-immo-sarl	Immobilier Et Location	\N	11	2026-03-02 23:11:17.944	2026-03-02 23:11:17.944	Immobilier Et Location			Dakar	\N	\N	\N	f	\N
2893	Safi Immo Sarl	safi-immo-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.946	2026-03-02 23:11:17.946	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2894	Senimmo Sa	senimmo-sa	Promotion Immobiliere Senegal	\N	11	2026-03-02 23:11:17.947	2026-03-02 23:11:17.947	Promotion Immobiliere Senegal			Dakar	\N	\N	\N	f	\N
2895	Africahabitat Sa	africahabitat-sa	Habitat Africain	\N	11	2026-03-02 23:11:17.949	2026-03-02 23:11:17.949	Habitat Africain			Dakar	\N	\N	\N	f	\N
2896	Mdc Immobilier Sarl	mdc-immobilier-sarl	Mandataire Commerce Immobilier	\N	11	2026-03-02 23:11:17.951	2026-03-02 23:11:17.951	Mandataire Commerce Immobilier			Dakar	\N	\N	\N	f	\N
2897	Sci Baraka	sci-baraka	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.952	2026-03-02 23:11:17.952	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2898	Sci Keur Yoro Laye	sci-keur-yoro-laye	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.954	2026-03-02 23:11:17.954	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2899	Sci La Forteresse	sci-la-forteresse	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.956	2026-03-02 23:11:17.956	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2900	Sci Teranga	sci-teranga	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.958	2026-03-02 23:11:17.958	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2901	Sci Les Almadies	sci-les-almadies	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.96	2026-03-02 23:11:17.96	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2902	Sci Ngor Almadies Residence	sci-ngor-almadies-residence	Societe Civile Immobiliere	\N	11	2026-03-02 23:11:17.961	2026-03-02 23:11:17.961	Societe Civile Immobiliere			Dakar	\N	\N	\N	f	\N
2903	Bousso Immo Sarl	bousso-immo-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.963	2026-03-02 23:11:17.963	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2904	Dieye Immobilier Sarl	dieye-immobilier-sarl	Promotion Et Gestion Immobiliere	\N	11	2026-03-02 23:11:17.965	2026-03-02 23:11:17.965	Promotion Et Gestion Immobiliere			Dakar	\N	\N	\N	f	\N
2905	Faye Immo Sarl	faye-immo-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.967	2026-03-02 23:11:17.967	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2906	Ndao Immobilier Sarl	ndao-immobilier-sarl	Vente Et Location	\N	11	2026-03-02 23:11:17.969	2026-03-02 23:11:17.969	Vente Et Location			Dakar	\N	\N	\N	f	\N
2907	Sarr Immo Suarl	sarr-immo-suarl	Immobilier Et Gestion	\N	11	2026-03-02 23:11:17.971	2026-03-02 23:11:17.971	Immobilier Et Gestion			Dakar	\N	\N	\N	f	\N
2908	Fall Immobilier Sarl	fall-immobilier-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.973	2026-03-02 23:11:17.973	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2909	Karim Immobilier Sarl	karim-immobilier-sarl	Agence Immobiliere	\N	11	2026-03-02 23:11:17.975	2026-03-02 23:11:17.975	Agence Immobiliere			Dakar	\N	\N	\N	f	\N
2910	Laborex Senegal Sa	laborex-senegal-sa	Distribution Produits Pharmaceutiques	\N	5	2026-03-02 23:11:17.977	2026-03-02 23:11:17.977	Distribution Produits Pharmaceutiques			Dakar	\N	\N	\N	f	\N
2911	Cophase Sa	cophase-sa	Commerce Grossiste Produits Pharmaceutiques	\N	5	2026-03-02 23:11:17.98	2026-03-02 23:11:17.98	Commerce Grossiste Produits Pharmaceutiques			Dakar	\N	\N	\N	f	\N
2912	Sodipharm Sa	sodipharm-sa	Distribution Medicaments	\N	5	2026-03-02 23:11:17.982	2026-03-02 23:11:17.982	Distribution Medicaments			Dakar	\N	\N	\N	f	\N
2913	Pfizer Afrique De L Ouest	pfizer-afrique-de-l-ouest	Industrie Pharmaceutique	\N	5	2026-03-02 23:11:17.984	2026-03-02 23:11:17.984	Industrie Pharmaceutique			Dakar	\N	\N	\N	f	\N
2914	Duopharm Sarl	duopharm-sarl	Distribution Pharmaceutique	\N	5	2026-03-02 23:11:17.985	2026-03-02 23:11:17.985	Distribution Pharmaceutique			Dakar	\N	\N	\N	f	\N
2915	Sanofi Aventis Senegal Sa	sanofi-aventis-senegal-sa	Industrie Pharmaceutique	\N	5	2026-03-02 23:11:17.987	2026-03-02 23:11:17.987	Industrie Pharmaceutique			Dakar	\N	\N	\N	f	\N
2916	Winthrop Pharma Senegal	winthrop-pharma-senegal	Produits Pharmaceutiques	\N	5	2026-03-02 23:11:17.989	2026-03-02 23:11:17.989	Produits Pharmaceutiques			Dakar	\N	\N	\N	f	\N
2917	Valdafrique Labo Canonne	valdafrique-labo-canonne	Laboratoire Pharmaceutique	\N	5	2026-03-02 23:11:17.991	2026-03-02 23:11:17.991	Laboratoire Pharmaceutique			Dakar	\N	\N	\N	f	\N
2918	Pharmacie Guigon	pharmacie-guigon	Pharmacie	\N	5	2026-03-02 23:11:17.993	2026-03-02 23:11:17.993	Pharmacie			Dakar	\N	\N	\N	f	\N
2919	Pharmacie Du Plateau	pharmacie-du-plateau	Pharmacie	\N	5	2026-03-02 23:11:17.994	2026-03-02 23:11:17.994	Pharmacie			Dakar	\N	\N	\N	f	\N
2920	Ecopharm Senegal Sa	ecopharm-senegal-sa	Produits Pharmaceutiques	\N	5	2026-03-02 23:11:17.996	2026-03-02 23:11:17.996	Produits Pharmaceutiques			Dakar	\N	\N	\N	f	\N
2921	Wap (West Afric Pharma Sa)	wap-west-afric-pharma-sa	Distribution Pharmaceutique Afrique	\N	5	2026-03-02 23:11:17.998	2026-03-02 23:11:17.998	Distribution Pharmaceutique Afrique			Dakar	\N	\N	\N	f	\N
2922	Pharmacie Centrale Du Senegal	pharmacie-centrale-du-senegal	Pharmacie Centrale	\N	5	2026-03-02 23:11:18	2026-03-02 23:11:18	Pharmacie Centrale			Dakar	\N	\N	\N	f	\N
2923	Pharmacie Thiossane	pharmacie-thiossane	Pharmacie	\N	5	2026-03-02 23:11:18.002	2026-03-02 23:11:18.002	Pharmacie			Dakar	\N	\N	\N	f	\N
2924	Pharmacie Des Almadies	pharmacie-des-almadies	Pharmacie	\N	5	2026-03-02 23:11:18.004	2026-03-02 23:11:18.004	Pharmacie			Dakar	\N	\N	\N	f	\N
2925	Pharmacie Pasteur Dakar	pharmacie-pasteur-dakar	Pharmacie	\N	5	2026-03-02 23:11:18.005	2026-03-02 23:11:18.005	Pharmacie			Dakar	\N	\N	\N	f	\N
2926	Pharmacie Kermel	pharmacie-kermel	Pharmacie	\N	5	2026-03-02 23:11:18.007	2026-03-02 23:11:18.007	Pharmacie			Dakar	\N	\N	\N	f	\N
2927	Pharmacie Soumbedioune	pharmacie-soumbedioune	Pharmacie	\N	5	2026-03-02 23:11:18.009	2026-03-02 23:11:18.009	Pharmacie			Dakar	\N	\N	\N	f	\N
2928	Pharmacie Colobane	pharmacie-colobane	Pharmacie	\N	5	2026-03-02 23:11:18.011	2026-03-02 23:11:18.011	Pharmacie			Dakar	\N	\N	\N	f	\N
2929	Pharmacie Point E	pharmacie-point-e	Pharmacie	\N	5	2026-03-02 23:11:18.014	2026-03-02 23:11:18.014	Pharmacie			Dakar	\N	\N	\N	f	\N
2930	Pharmacie Fann	pharmacie-fann	Pharmacie	\N	5	2026-03-02 23:11:18.017	2026-03-02 23:11:18.017	Pharmacie			Dakar	\N	\N	\N	f	\N
2931	Pharmacie Grand Yoff	pharmacie-grand-yoff	Pharmacie	\N	5	2026-03-02 23:11:18.019	2026-03-02 23:11:18.019	Pharmacie			Dakar	\N	\N	\N	f	\N
2932	Pharmacie Parcelles Assainies	pharmacie-parcelles-assainies	Pharmacie	\N	5	2026-03-02 23:11:18.021	2026-03-02 23:11:18.021	Pharmacie			Dakar	\N	\N	\N	f	\N
2933	Pharmacie Mermoz	pharmacie-mermoz	Pharmacie	\N	5	2026-03-02 23:11:18.029	2026-03-02 23:11:18.029	Pharmacie			Dakar	\N	\N	\N	f	\N
2934	Pharmacie Liberte 6	pharmacie-liberte-6	Pharmacie	\N	5	2026-03-02 23:11:18.031	2026-03-02 23:11:18.031	Pharmacie			Dakar	\N	\N	\N	f	\N
2935	Pharmacie Du Marche Tilene	pharmacie-du-marche-tilene	Pharmacie	\N	5	2026-03-02 23:11:18.034	2026-03-02 23:11:18.034	Pharmacie			Dakar	\N	\N	\N	f	\N
2936	Pharmacie Kaolack Centrale	pharmacie-kaolack-centrale	Pharmacie	\N	5	2026-03-02 23:11:18.036	2026-03-02 23:11:18.036	Pharmacie			Kaolack	\N	\N	\N	f	\N
2937	Pharmacie De La Paix Kaolack	pharmacie-de-la-paix-kaolack	Pharmacie	\N	5	2026-03-02 23:11:18.039	2026-03-02 23:11:18.039	Pharmacie			Kaolack	\N	\N	\N	f	\N
2938	Pharmacie El Hadj Omar Kaolack	pharmacie-el-hadj-omar-kaolack	Pharmacie	\N	5	2026-03-02 23:11:18.041	2026-03-02 23:11:18.041	Pharmacie			Kaolack	\N	\N	\N	f	\N
2939	Pharmacie Kolda	pharmacie-kolda	Pharmacie	\N	5	2026-03-02 23:11:18.043	2026-03-02 23:11:18.043	Pharmacie			Kolda	\N	\N	\N	f	\N
2940	Pharmacie Du Fleuve Louga	pharmacie-du-fleuve-louga	Pharmacie	\N	5	2026-03-02 23:11:18.045	2026-03-02 23:11:18.045	Pharmacie			Louga	\N	\N	\N	f	\N
2941	Pharmacie De Mbacke	pharmacie-de-mbacke	Pharmacie	\N	5	2026-03-02 23:11:18.047	2026-03-02 23:11:18.047	Pharmacie			Mbacke	\N	\N	\N	f	\N
2942	Pharmacie Touba Principale	pharmacie-touba-principale	Pharmacie	\N	5	2026-03-02 23:11:18.049	2026-03-02 23:11:18.049	Pharmacie			Touba	\N	\N	\N	f	\N
2943	Pharmacie Thies Centre	pharmacie-thies-centre	Pharmacie	\N	5	2026-03-02 23:11:18.051	2026-03-02 23:11:18.051	Pharmacie			Thiès	\N	\N	\N	f	\N
2944	Pharmacie Saint-Louis Centrale	pharmacie-saint-louis-centrale	Pharmacie	\N	5	2026-03-02 23:11:18.053	2026-03-02 23:11:18.053	Pharmacie			Saint-Louis	\N	\N	\N	f	\N
2945	Pharmacie Mbour	pharmacie-mbour	Pharmacie	\N	5	2026-03-02 23:11:18.054	2026-03-02 23:11:18.054	Pharmacie			Mbour	\N	\N	\N	f	\N
2946	Pharmacie Ziguinchor	pharmacie-ziguinchor	Pharmacie	\N	5	2026-03-02 23:11:18.056	2026-03-02 23:11:18.056	Pharmacie			Ziguinchor	\N	\N	\N	f	\N
2947	Pharmacie Tambacounda	pharmacie-tambacounda	Pharmacie	\N	5	2026-03-02 23:11:18.059	2026-03-02 23:11:18.059	Pharmacie			Tambacounda	\N	\N	\N	f	\N
2948	Pharmacie Diourbel	pharmacie-diourbel	Pharmacie	\N	5	2026-03-02 23:11:18.061	2026-03-02 23:11:18.061	Pharmacie			Diourbel	\N	\N	\N	f	\N
2949	Pharmacie Fatick	pharmacie-fatick	Pharmacie	\N	5	2026-03-02 23:11:18.063	2026-03-02 23:11:18.063	Pharmacie			Fatick	\N	\N	\N	f	\N
2950	Pharmacie Matam	pharmacie-matam	Pharmacie	\N	5	2026-03-02 23:11:18.065	2026-03-02 23:11:18.065	Pharmacie			Matam	\N	\N	\N	f	\N
2951	Pharmacie Kedougou	pharmacie-kedougou	Pharmacie	\N	5	2026-03-02 23:11:18.067	2026-03-02 23:11:18.067	Pharmacie			Kedougou	\N	\N	\N	f	\N
2952	Pharmacie Sedhiou	pharmacie-sedhiou	Pharmacie	\N	5	2026-03-02 23:11:18.069	2026-03-02 23:11:18.069	Pharmacie			Sedhiou	\N	\N	\N	f	\N
2953	Pharmacie Kaffrine	pharmacie-kaffrine	Pharmacie	\N	5	2026-03-02 23:11:18.071	2026-03-02 23:11:18.071	Pharmacie			Kaffrine	\N	\N	\N	f	\N
2954	Institut Pasteur De Dakar	institut-pasteur-de-dakar	Recherche Et Analyses Biologiques	\N	5	2026-03-02 23:11:18.073	2026-03-02 23:11:18.073	Recherche Et Analyses Biologiques			Dakar	\N	\N	\N	f	\N
2955	Clinique Du Cap Vert	clinique-du-cap-vert	Clinique Privee	\N	5	2026-03-02 23:11:18.075	2026-03-02 23:11:18.075	Clinique Privee			Dakar	\N	\N	\N	f	\N
2956	Clinique Madeleine Dakar	clinique-madeleine-dakar	Clinique Privee	\N	5	2026-03-02 23:11:18.077	2026-03-02 23:11:18.077	Clinique Privee			Dakar	\N	\N	\N	f	\N
2957	Polyclinique De Dakar	polyclinique-de-dakar	Polyclinique	\N	5	2026-03-02 23:11:18.078	2026-03-02 23:11:18.078	Polyclinique			Dakar	\N	\N	\N	f	\N
2958	Sas Labo (Societe Africaine Sante Laboratoire)	sas-labo-societe-africaine-sante-laboratoire	Laboratoire Analyses Medicales	\N	5	2026-03-02 23:11:18.08	2026-03-02 23:11:18.08	Laboratoire Analyses Medicales			Dakar	\N	\N	\N	f	\N
2959	Biolab Senegal Sarl	biolab-senegal-sarl	Laboratoire Biologique	\N	5	2026-03-02 23:11:18.082	2026-03-02 23:11:18.082	Laboratoire Biologique			Dakar	\N	\N	\N	f	\N
2960	Laborex Teranga Sarl	laborex-teranga-sarl	Distribution Pharmaceutique	\N	5	2026-03-02 23:11:18.085	2026-03-02 23:11:18.085	Distribution Pharmaceutique			Dakar	\N	\N	\N	f	\N
2961	Meddis Sarl (Medicaments Distribution)	meddis-sarl-medicaments-distribution	Distribution Medicaments	\N	5	2026-03-02 23:11:18.087	2026-03-02 23:11:18.087	Distribution Medicaments			Dakar	\N	\N	\N	f	\N
2962	Cmi Sarl (Commerce Medical International)	cmi-sarl-commerce-medical-international	Commerce Materiel Medical	\N	5	2026-03-02 23:11:18.09	2026-03-02 23:11:18.09	Commerce Materiel Medical			Dakar	\N	\N	\N	f	\N
2963	Sms Sa (Senegal Medical Supplies)	sms-sa-senegal-medical-supplies	Fournitures Medicales	\N	5	2026-03-02 23:11:18.092	2026-03-02 23:11:18.092	Fournitures Medicales			Dakar	\N	\N	\N	f	\N
2965	Terrou-Bi Sa	terrou-bi-sa	Hotel Et Restauration	\N	12	2026-03-02 23:11:18.097	2026-03-02 23:11:18.097	Hotel Et Restauration			Dakar	\N	\N	\N	f	\N
2966	Sogetoc Sa	sogetoc-sa	Restauration Et Hotellerie	\N	12	2026-03-02 23:11:18.099	2026-03-02 23:11:18.099	Restauration Et Hotellerie			Dakar	\N	\N	\N	f	\N
2967	Dakar Catering Sa	dakar-catering-sa	Restauration Collective	\N	12	2026-03-02 23:11:18.102	2026-03-02 23:11:18.102	Restauration Collective			Dakar	\N	\N	\N	f	\N
2968	Rci Sa (Resort Company Invest)	rci-sa-resort-company-invest	Hotellerie Et Tourisme	\N	12	2026-03-02 23:11:18.105	2026-03-02 23:11:18.105	Hotellerie Et Tourisme			Dakar	\N	\N	\N	f	\N
2978	Pointe Des Almadies Sarl	pointe-des-almadies-sarl	Restaurant Et Bar	\N	12	2026-03-02 23:11:18.13	2026-03-02 23:11:18.13	Restaurant Et Bar			Dakar	\N	\N	\N	f	\N
2979	Hotel Kadiandoumagne Sarl	hotel-kadiandoumagne-sarl	Hotellerie	\N	12	2026-03-02 23:11:18.132	2026-03-02 23:11:18.132	Hotellerie			Dakar	\N	\N	\N	f	\N
2980	Le Kilimandjaro Sarl	le-kilimandjaro-sarl	Restaurant Africain	\N	12	2026-03-02 23:11:18.134	2026-03-02 23:11:18.134	Restaurant Africain			Dakar	\N	\N	\N	f	\N
2981	Hotel Meridien President Dakar Sa	hotel-meridien-president-dakar-sa	Hotel De Luxe	\N	12	2026-03-02 23:11:18.137	2026-03-02 23:11:18.137	Hotel De Luxe			Dakar	\N	\N	\N	f	\N
2982	Hotel Sofitel Dakar	hotel-sofitel-dakar	Hotel 5 Etoiles	\N	12	2026-03-02 23:11:18.14	2026-03-02 23:11:18.14	Hotel 5 Etoiles			Dakar	\N	\N	\N	f	\N
2983	Radisson Blu Dakar Sa	radisson-blu-dakar-sa	Hotel Luxe	\N	12	2026-03-02 23:11:18.142	2026-03-02 23:11:18.142	Hotel Luxe			Dakar	\N	\N	\N	f	\N
2984	Hotel King Fahd Palace Dakar	hotel-king-fahd-palace-dakar	Hotel De Luxe	\N	12	2026-03-02 23:11:18.144	2026-03-02 23:11:18.144	Hotel De Luxe			Dakar	\N	\N	\N	f	\N
2985	Hotel Novotel Dakar	hotel-novotel-dakar	Hotel Affaires	\N	12	2026-03-02 23:11:18.147	2026-03-02 23:11:18.147	Hotel Affaires			Dakar	\N	\N	\N	f	\N
2986	Ibis Dakar Sa	ibis-dakar-sa	Hotel Economique	\N	12	2026-03-02 23:11:18.149	2026-03-02 23:11:18.149	Hotel Economique			Dakar	\N	\N	\N	f	\N
2987	Hotel Ngor Diarama Sarl	hotel-ngor-diarama-sarl	Hotel Et Village De Vacances	\N	12	2026-03-02 23:11:18.151	2026-03-02 23:11:18.151	Hotel Et Village De Vacances			Dakar	\N	\N	\N	f	\N
2988	Creolia Restaurant Sarl	creolia-restaurant-sarl	Restaurant Creole	\N	12	2026-03-02 23:11:18.154	2026-03-02 23:11:18.154	Restaurant Creole			Dakar	\N	\N	\N	f	\N
2989	Le Pescador Sarl	le-pescador-sarl	Restaurant Poissons	\N	12	2026-03-02 23:11:18.156	2026-03-02 23:11:18.156	Restaurant Poissons			Dakar	\N	\N	\N	f	\N
2990	La Case Sarl (Restaurant)	la-case-sarl-restaurant	Restaurant Traditionnel	\N	12	2026-03-02 23:11:18.159	2026-03-02 23:11:18.159	Restaurant Traditionnel			Dakar	\N	\N	\N	f	\N
2991	Le Djolof Restaurant Sarl	le-djolof-restaurant-sarl	Restaurant Senegalais	\N	12	2026-03-02 23:11:18.162	2026-03-02 23:11:18.162	Restaurant Senegalais			Dakar	\N	\N	\N	f	\N
2992	Hotel De La Paix Dakar	hotel-de-la-paix-dakar	Hotellerie	\N	12	2026-03-02 23:11:18.165	2026-03-02 23:11:18.165	Hotellerie			Dakar	\N	\N	\N	f	\N
2993	Hotel Saint-Louis Gouvernance	hotel-saint-louis-gouvernance	Hotellerie Historique	\N	12	2026-03-02 23:11:18.169	2026-03-02 23:11:18.169	Hotellerie Historique			Saint-Louis	\N	\N	\N	f	\N
2994	Hotel Mermoz Dakar Sarl	hotel-mermoz-dakar-sarl	Hotellerie	\N	12	2026-03-02 23:11:18.173	2026-03-02 23:11:18.173	Hotellerie			Dakar	\N	\N	\N	f	\N
2995	Saly Hotel Sa	saly-hotel-sa	Hotel Et Station Balneaire	\N	12	2026-03-02 23:11:18.175	2026-03-02 23:11:18.175	Hotel Et Station Balneaire			Saly	\N	\N	\N	f	\N
2996	Royal Saly Hotel Sa	royal-saly-hotel-sa	Hotel Et Village Vacances	\N	12	2026-03-02 23:11:18.177	2026-03-02 23:11:18.177	Hotel Et Village Vacances			Saly	\N	\N	\N	f	\N
2997	La Palmeraie Hotel Saly	la-palmeraie-hotel-saly	Hotellerie Et Tourisme	\N	12	2026-03-02 23:11:18.179	2026-03-02 23:11:18.179	Hotellerie Et Tourisme			Saly	\N	\N	\N	f	\N
2998	Lamantin Beach Hotel Sa	lamantin-beach-hotel-sa	Hotel Luxe Touristique	\N	12	2026-03-02 23:11:18.182	2026-03-02 23:11:18.182	Hotel Luxe Touristique			Saly	\N	\N	\N	f	\N
2999	Riu Hotel Senegal Sa	riu-hotel-senegal-sa	Hotel Touristique	\N	12	2026-03-02 23:11:18.184	2026-03-02 23:11:18.184	Hotel Touristique			Saly	\N	\N	\N	f	\N
3000	Savannah Casamance Hotel	savannah-casamance-hotel	Hotellerie Ecotouristique	\N	12	2026-03-02 23:11:18.186	2026-03-02 23:11:18.186	Hotellerie Ecotouristique			Ziguinchor	\N	\N	\N	f	\N
3001	Le Flamboyant Hotel Ziguinchor	le-flamboyant-hotel-ziguinchor	Hotellerie	\N	12	2026-03-02 23:11:18.188	2026-03-02 23:11:18.188	Hotellerie			Ziguinchor	\N	\N	\N	f	\N
3002	Casamance Hotel Sa	casamance-hotel-sa	Hotellerie Casamance	\N	12	2026-03-02 23:11:18.19	2026-03-02 23:11:18.19	Hotellerie Casamance			Ziguinchor	\N	\N	\N	f	\N
3003	Hotel Du Palais Saint-Louis	hotel-du-palais-saint-louis	Hotellerie Patrimoniale	\N	12	2026-03-02 23:11:18.192	2026-03-02 23:11:18.192	Hotellerie Patrimoniale			Saint-Louis	\N	\N	\N	f	\N
3004	La Pizzeria Sarl (Dakar)	la-pizzeria-sarl-dakar	Pizzeria Et Restauration	\N	12	2026-03-02 23:11:18.194	2026-03-02 23:11:18.194	Pizzeria Et Restauration			Dakar	\N	\N	\N	f	\N
3005	Le Sombrero Sarl	le-sombrero-sarl	Restaurant Mexicain	\N	12	2026-03-02 23:11:18.196	2026-03-02 23:11:18.196	Restaurant Mexicain			Dakar	\N	\N	\N	f	\N
3006	Dakar Food Services Sarl	dakar-food-services-sarl	Service Alimentaire	\N	12	2026-03-02 23:11:18.198	2026-03-02 23:11:18.198	Service Alimentaire			Dakar	\N	\N	\N	f	\N
3007	Restauration Collective Afrique Sarl	restauration-collective-afrique-sarl	Restauration Collective	\N	12	2026-03-02 23:11:18.2	2026-03-02 23:11:18.2	Restauration Collective			Dakar	\N	\N	\N	f	\N
3008	Elton Traiteur Sarl	elton-traiteur-sarl	Traiteur Et Evenementiel	\N	12	2026-03-02 23:11:18.202	2026-03-02 23:11:18.202	Traiteur Et Evenementiel			Dakar	\N	\N	\N	f	\N
3009	Sofitel Teranga Dakar	sofitel-teranga-dakar	Hotel De Luxe	\N	12	2026-03-02 23:11:18.204	2026-03-02 23:11:18.204	Hotel De Luxe			Dakar	\N	\N	\N	f	\N
3010	Steak House Dakar Sarl	steak-house-dakar-sarl	Restaurant Viandes	\N	12	2026-03-02 23:11:18.206	2026-03-02 23:11:18.206	Restaurant Viandes			Dakar	\N	\N	\N	f	\N
3011	Le Petit Paris Dakar Sarl	le-petit-paris-dakar-sarl	Brasserie Et Restaurant	\N	12	2026-03-02 23:11:18.208	2026-03-02 23:11:18.208	Brasserie Et Restaurant			Dakar	\N	\N	\N	f	\N
3012	Senecafe Sarl	senecafe-sarl	Cafe Et Restauration	\N	12	2026-03-02 23:11:18.21	2026-03-02 23:11:18.21	Cafe Et Restauration			Dakar	\N	\N	\N	f	\N
3013	Maquis Teranga Sarl	maquis-teranga-sarl	Restauration Africaine	\N	12	2026-03-02 23:11:18.212	2026-03-02 23:11:18.212	Restauration Africaine			Dakar	\N	\N	\N	f	\N
3014	Hotel Cheikh Amadou Bamba Touba	hotel-cheikh-amadou-bamba-touba	Hotellerie	\N	12	2026-03-02 23:11:18.214	2026-03-02 23:11:18.214	Hotellerie			Touba	\N	\N	\N	f	\N
3015	Hotel Kaolack Sa	hotel-kaolack-sa	Hotellerie	\N	12	2026-03-02 23:11:18.215	2026-03-02 23:11:18.215	Hotellerie			Kaolack	\N	\N	\N	f	\N
3016	Restaurant Thieboudienne Sarl	restaurant-thieboudienne-sarl	Restaurant Traditionnel Senegalais	\N	12	2026-03-02 23:11:18.217	2026-03-02 23:11:18.217	Restaurant Traditionnel Senegalais			Dakar	\N	\N	\N	f	\N
3017	Tambacounda Hotel Sa	tambacounda-hotel-sa	Hotellerie	\N	12	2026-03-02 23:11:18.219	2026-03-02 23:11:18.219	Hotellerie			Tambacounda	\N	\N	\N	f	\N
3018	Complexe Touristique Sine Saloum	complexe-touristique-sine-saloum	Tourisme Et Hotellerie	\N	12	2026-03-02 23:11:18.221	2026-03-02 23:11:18.221	Tourisme Et Hotellerie			Fatick	\N	\N	\N	f	\N
3019	Boulangerie Patisserie Ngor	boulangerie-patisserie-ngor	Boulangerie Et Patisserie	\N	12	2026-03-02 23:11:18.223	2026-03-02 23:11:18.223	Boulangerie Et Patisserie			Dakar	\N	\N	\N	f	\N
3020	Sodefitex Sa (Societe Dev Fibres Textiles)	sodefitex-sa-societe-dev-fibres-textiles	Culture Et Transformation Coton	\N	4	2026-03-02 23:11:18.225	2026-03-02 23:11:18.225	Culture Et Transformation Coton			Dakar	\N	\N	\N	f	\N
3021	Saed (Societe Amenagement Exploitation Delta)	saed-societe-amenagement-exploitation-delta	Amenagement Agricole Delta	\N	4	2026-03-02 23:11:18.227	2026-03-02 23:11:18.227	Amenagement Agricole Delta			Saint-Louis	\N	\N	\N	f	\N
3022	Sonacos Sa (Societe Nationale Commerce Graines Oleag)	sonacos-sa-societe-nationale-commerce-graines-oleag	Commerce Arachide	\N	4	2026-03-02 23:11:18.229	2026-03-02 23:11:18.229	Commerce Arachide			Dakar	\N	\N	\N	f	\N
3023	Suneor Sa (Huilerie Senegal)	suneor-sa-huilerie-senegal	Huilerie Et Savonnerie	\N	4	2026-03-02 23:11:18.231	2026-03-02 23:11:18.231	Huilerie Et Savonnerie			Dakar	\N	\N	\N	f	\N
3024	Baobab Organic Sarl	baobab-organic-sarl	Produits Bio Et Naturels	\N	4	2026-03-02 23:11:18.233	2026-03-02 23:11:18.233	Produits Bio Et Naturels			Dakar	\N	\N	\N	f	\N
3025	Seges Sa (Societe Exploitation Graines Senegal)	seges-sa-societe-exploitation-graines-senegal	Exploitation Graines Oleagineuses	\N	4	2026-03-02 23:11:18.236	2026-03-02 23:11:18.236	Exploitation Graines Oleagineuses			Dakar	\N	\N	\N	f	\N
3026	Kirene Sa (Source Kirene)	kirene-sa-source-kirene	Eau Minerale Et Boissons	\N	4	2026-03-02 23:11:18.239	2026-03-02 23:11:18.239	Eau Minerale Et Boissons			Dakar	\N	\N	\N	f	\N
3027	Patisen Sa (Patisserie Industrielle Senegal)	patisen-sa-patisserie-industrielle-senegal	Patisserie Industrielle	\N	4	2026-03-02 23:11:18.242	2026-03-02 23:11:18.242	Patisserie Industrielle			Dakar	\N	\N	\N	f	\N
3028	Ngiba Sarl (Societe Senegalo Espagnole Peche)	ngiba-sarl-societe-senegalo-espagnole-peche	Peche Et Transformation	\N	4	2026-03-02 23:11:18.245	2026-03-02 23:11:18.245	Peche Et Transformation			Dakar	\N	\N	\N	f	\N
3029	Soboa Sa (Brasseries Afrique Occidentale)	soboa-sa-brasseries-afrique-occidentale	Brasserie Et Boissons	\N	4	2026-03-02 23:11:18.247	2026-03-02 23:11:18.247	Brasserie Et Boissons			Dakar	\N	\N	\N	f	\N
3030	Smi Sarl (Senegal Maraichage Industries)	smi-sarl-senegal-maraichage-industries	Maraichage Et Agro Industrie	\N	4	2026-03-02 23:11:18.25	2026-03-02 23:11:18.25	Maraichage Et Agro Industrie			Dakar	\N	\N	\N	f	\N
3031	Seras Sa (Societe Exploitation Ressources Animales)	seras-sa-societe-exploitation-ressources-animales	Elevage Et Ressources Animales	\N	4	2026-03-02 23:11:18.252	2026-03-02 23:11:18.252	Elevage Et Ressources Animales			Dakar	\N	\N	\N	f	\N
3032	Senegal Pecheries Sarl	senegal-pecheries-sarl	Peche Industrielle	\N	4	2026-03-02 23:11:18.254	2026-03-02 23:11:18.254	Peche Industrielle			Dakar	\N	\N	\N	f	\N
3033	Boulangerie Industrielle Moussa Sa	boulangerie-industrielle-moussa-sa	Boulangerie Industrielle	\N	4	2026-03-02 23:11:18.257	2026-03-02 23:11:18.257	Boulangerie Industrielle			Dakar	\N	\N	\N	f	\N
3034	Sacpa Sarl (Societe Africaine Conditionnement Agricole)	sacpa-sarl-societe-africaine-conditionnement-agricole	Conditionnement Produits Agricoles	\N	4	2026-03-02 23:11:18.259	2026-03-02 23:11:18.259	Conditionnement Produits Agricoles			Dakar	\N	\N	\N	f	\N
3035	Les Moulins Du Sahel Sarl	les-moulins-du-sahel-sarl	Meunerie Et Farine	\N	4	2026-03-02 23:11:18.262	2026-03-02 23:11:18.262	Meunerie Et Farine			Dakar	\N	\N	\N	f	\N
3036	Sitab Sa (Societe Industrielle Tabac)	sitab-sa-societe-industrielle-tabac	Industrie Du Tabac	\N	4	2026-03-02 23:11:18.265	2026-03-02 23:11:18.265	Industrie Du Tabac			Dakar	\N	\N	\N	f	\N
3037	Grands Moulins De Dakar Sa	grands-moulins-de-dakar-sa	Meunerie Industrielle	\N	4	2026-03-02 23:11:18.267	2026-03-02 23:11:18.267	Meunerie Industrielle			Dakar	\N	\N	\N	f	\N
3038	Les Grands Moulins De Mbao Sa	les-grands-moulins-de-mbao-sa	Industrie Farine	\N	4	2026-03-02 23:11:18.27	2026-03-02 23:11:18.27	Industrie Farine			Dakar	\N	\N	\N	f	\N
3039	Soprona Sarl (Production Alimentaire)	soprona-sarl-production-alimentaire	Production Alimentaire	\N	4	2026-03-02 23:11:18.272	2026-03-02 23:11:18.272	Production Alimentaire			Dakar	\N	\N	\N	f	\N
3040	Suncoast Milling Sa	suncoast-milling-sa	Meunerie Et Farine	\N	4	2026-03-02 23:11:18.274	2026-03-02 23:11:18.274	Meunerie Et Farine			Dakar	\N	\N	\N	f	\N
3041	Sioa Sa (Societe Industrielle Huilerie Afrique Ouest)	sioa-sa-societe-industrielle-huilerie-afrique-ouest	Huilerie	\N	4	2026-03-02 23:11:18.276	2026-03-02 23:11:18.276	Huilerie			Dakar	\N	\N	\N	f	\N
3042	Osiris Sarl (Open Software Internet Research)	osiris-sarl-open-software-internet-research	Solutions Informatiques	\N	13	2026-03-02 23:11:18.278	2026-03-02 23:11:18.278	Solutions Informatiques			Dakar	\N	\N	\N	f	\N
3043	Gainde 2000 Sa	gainde-2000-sa	Informatique Et Services Douaniers	\N	13	2026-03-02 23:11:18.28	2026-03-02 23:11:18.28	Informatique Et Services Douaniers			Dakar	\N	\N	\N	f	\N
3044	Atos Senegal Sa	atos-senegal-sa	Services Informatiques	\N	13	2026-03-02 23:11:18.282	2026-03-02 23:11:18.282	Services Informatiques			Dakar	\N	\N	\N	f	\N
3045	Cgi Afrique Sarl	cgi-afrique-sarl	Conseil Et Ingenierie Informatique	\N	13	2026-03-02 23:11:18.284	2026-03-02 23:11:18.284	Conseil Et Ingenierie Informatique			Dakar	\N	\N	\N	f	\N
3046	Altran Afrique Sarl	altran-afrique-sarl	Conseil En Transformation Digitale	\N	13	2026-03-02 23:11:18.285	2026-03-02 23:11:18.285	Conseil En Transformation Digitale			Dakar	\N	\N	\N	f	\N
3047	Snt Digital Sarl	snt-digital-sarl	Numerique Et Services	\N	13	2026-03-02 23:11:18.287	2026-03-02 23:11:18.287	Numerique Et Services			Dakar	\N	\N	\N	f	\N
3048	Orange Digital Center Senegal	orange-digital-center-senegal	Hub Numerique	\N	13	2026-03-02 23:11:18.289	2026-03-02 23:11:18.289	Hub Numerique			Dakar	\N	\N	\N	f	\N
3049	Manobi Senegal Sa	manobi-senegal-sa	Services Mobile Et Numerique	\N	13	2026-03-02 23:11:18.291	2026-03-02 23:11:18.291	Services Mobile Et Numerique			Dakar	\N	\N	\N	f	\N
3050	Webmaster Senegal Sarl	webmaster-senegal-sarl	Developpement Web	\N	13	2026-03-02 23:11:18.293	2026-03-02 23:11:18.293	Developpement Web			Dakar	\N	\N	\N	f	\N
3051	Intech Sa (Informatique Technologies Senegal)	intech-sa-informatique-technologies-senegal	Ingenierie Informatique	\N	13	2026-03-02 23:11:18.295	2026-03-02 23:11:18.295	Ingenierie Informatique			Dakar	\N	\N	\N	f	\N
3052	Dsir Sa (Dakar Systeme Informatique Reseau)	dsir-sa-dakar-systeme-informatique-reseau	Reseaux Et Systemes	\N	13	2026-03-02 23:11:18.297	2026-03-02 23:11:18.297	Reseaux Et Systemes			Dakar	\N	\N	\N	f	\N
3053	Ibm Senegal	ibm-senegal	Informatique Et Solutions	\N	13	2026-03-02 23:11:18.299	2026-03-02 23:11:18.299	Informatique Et Solutions			Dakar	\N	\N	\N	f	\N
3054	Microsoft Senegal	microsoft-senegal	Logiciels Et Cloud	\N	13	2026-03-02 23:11:18.301	2026-03-02 23:11:18.301	Logiciels Et Cloud			Dakar	\N	\N	\N	f	\N
3055	Oracle Senegal	oracle-senegal	Bases De Donnees Et Erp	\N	13	2026-03-02 23:11:18.303	2026-03-02 23:11:18.303	Bases De Donnees Et Erp			Dakar	\N	\N	\N	f	\N
3056	Cisco Senegal	cisco-senegal	Reseaux Et Telecommunications	\N	13	2026-03-02 23:11:18.305	2026-03-02 23:11:18.305	Reseaux Et Telecommunications			Dakar	\N	\N	\N	f	\N
3057	Hp Senegal (Hewlett Packard)	hp-senegal-hewlett-packard	Materiel Informatique	\N	13	2026-03-02 23:11:18.307	2026-03-02 23:11:18.307	Materiel Informatique			Dakar	\N	\N	\N	f	\N
3058	Dell Senegal	dell-senegal	Materiels Informatiques	\N	13	2026-03-02 23:11:18.31	2026-03-02 23:11:18.31	Materiels Informatiques			Dakar	\N	\N	\N	f	\N
3059	Siges Sa (Systemes Information Gestion Senegal)	siges-sa-systemes-information-gestion-senegal	Gestion Systemes Informatiques	\N	13	2026-03-02 23:11:18.312	2026-03-02 23:11:18.312	Gestion Systemes Informatiques			Dakar	\N	\N	\N	f	\N
3060	Sis Sa (Senegal Informatique Solutions)	sis-sa-senegal-informatique-solutions	Solutions Informatiques	\N	13	2026-03-02 23:11:18.314	2026-03-02 23:11:18.314	Solutions Informatiques			Dakar	\N	\N	\N	f	\N
3061	Netis Sarl (Reseaux Informatiques)	netis-sarl-reseaux-informatiques	Reseaux Et Informatique	\N	13	2026-03-02 23:11:18.316	2026-03-02 23:11:18.316	Reseaux Et Informatique			Dakar	\N	\N	\N	f	\N
3062	E-Sankofa Sarl	e-sankofa-sarl	Transformation Digitale	\N	13	2026-03-02 23:11:18.319	2026-03-02 23:11:18.319	Transformation Digitale			Dakar	\N	\N	\N	f	\N
3063	Adie Sa (Agence De L Informatique De L Etat)	adie-sa-agence-de-l-informatique-de-l-etat	Informatique Gouvernementale	\N	13	2026-03-02 23:11:18.321	2026-03-02 23:11:18.321	Informatique Gouvernementale			Dakar	\N	\N	\N	f	\N
3064	Sids Sa (Senegal Informatique Developpement Systemes)	sids-sa-senegal-informatique-developpement-systemes	Developpement Logiciels	\N	13	2026-03-02 23:11:18.323	2026-03-02 23:11:18.323	Developpement Logiciels			Dakar	\N	\N	\N	f	\N
3065	Tic Sarl (Technologies Information Communication)	tic-sarl-technologies-information-communication	Conseil Numerique	\N	13	2026-03-02 23:11:18.325	2026-03-02 23:11:18.325	Conseil Numerique			Dakar	\N	\N	\N	f	\N
3066	Sap Afrique Senegal	sap-afrique-senegal	Erp Et Solutions Entreprise	\N	13	2026-03-02 23:11:18.328	2026-03-02 23:11:18.328	Erp Et Solutions Entreprise			Dakar	\N	\N	\N	f	\N
1	Station Total Senegal	station-total-senegal	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:10.441	2026-03-02 23:11:10.441	Vente De Produits Petroliers	Bccd	33 839 84 39	Dakar	\N	\N	\N	f	\N
2	Senelec - Sa (Societe Nationale D'Electricite Du Senegal )	senelec-sa-societe-nationale-d-electricite-du-senegal	Production Et Distribution D'Electricite	\N	1	2026-03-02 23:11:10.449	2026-03-02 23:11:10.449	Production Et Distribution D'Electricite	Rue Vincens	33 839 54 54	Dakar	\N	\N	\N	f	\N
3	Vivo Energie Senegal (Ex Shell Senegal )Sa	vivo-energie-senegal-ex-shell-senegal-sa	Distribution D'Hydrocarbures	\N	1	2026-03-02 23:11:10.451	2026-03-02 23:11:10.451	Distribution D'Hydrocarbures	Route Des Hydrocarbures - Quartier Bel-Air	33 839 30 30	Dakar	\N	\N	\N	f	\N
4	Sococim Industries - Sa	sococim-industries-sa	Fabrication De Produits Mineraux Pour La Construction - Services Aux Entreprises - Autres Commerces Ancienne	\N	2	2026-03-02 23:11:10.453	2026-03-02 23:11:10.453	Fabrication De Produits Mineraux Pour La Construction - Services Aux Entreprises - Autres Commerces Ancienne	Route De Thies - Colobane Gouye Mouride - Rufisque	33 949 37 37	Dakar	\N	\N	\N	f	\N
5	Oilibya (Libya Oil Senegal - Ex Mobil Oil Senegal - Sa : En 2007)	oilibya-libya-oil-senegal-ex-mobil-oil-senegal-sa-en-2007	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:10.456	2026-03-02 23:11:10.456	Vente De Produits Petroliers	Bccd	33 839 88 88	Dakar	\N	\N	\N	f	\N
6	Patisen - Sa	patisen-sa	Production Et Distribution De Pdts Alimentaires (Boillons, Chocolat- Reconditionnement De Poivre	\N	1	2026-03-02 23:11:10.458	2026-03-02 23:11:10.458	Production Et Distribution De Pdts Alimentaires (Boillons, Chocolat- Reconditionnement De Poivre	Bd De La Liberation - Place Leclerc (Ex - Bccd X Rue 4)	33 859 30 00	Dakar	\N	\N	\N	f	\N
7	Oryx Senegal - Sa Stockage -	oryx-senegal-sa-stockage	Vente De Produits Petrolers	\N	1	2026-03-02 23:11:10.461	2026-03-02 23:11:10.461	Vente De Produits Petrolers	Bd Djily Mbaye - Immeuble Fondation Fahd - 12ème Etage	33 822 46 54	Dakar	\N	\N	\N	f	\N
8	Etnocell Sa	etnocell-sa	Vente Telephone Mobiles	\N	2	2026-03-02 23:11:10.463	2026-03-02 23:11:10.463	Vente Telephone Mobiles	Route De L'Aeroport Est Alma dies 0 Kaolack Ccmn (Comptoir Commercial Mandiaye Ndiaye) Commerce Import-Export Rue Daloa	33 823 00 33	Dakar	\N	\N	\N	f	\N
9	Elton Sa (Elton Oil Company Sa)	elton-sa-elton-oil-company-sa	Distribution De Produits Petroliers Et De Lubrifiants	\N	1	2026-03-02 23:11:10.465	2026-03-02 23:11:10.465	Distribution De Produits Petroliers Et De Lubrifiants	Avenue Abdoulaye Fadiga, Imm Abdoul Ahad Mbacke, Porte A 4ème Etage	33 941 16 15	Dakar	\N	\N	\N	f	\N
10	Puma Energy Senegal (Ex Vitogaz Senegal) Emplissage Et	puma-energy-senegal-ex-vitogaz-senegal-emplissage-et	Distribution De Gaz	\N	1	2026-03-02 23:11:10.467	2026-03-02 23:11:10.467	Distribution De Gaz	Route De Rufisque	33 849 77 00	Dakar	\N	\N	\N	f	\N
11	Tds Sarl (Tiger Denrees Senegal)	tds-sarl-tiger-denrees-senegal	Commerce General - Riz	\N	2	2026-03-02 23:11:10.469	2026-03-02 23:11:10.469	Commerce General - Riz	Bccd (Ex 10, Rue Beranger Fer raud)	33 879 15 15	Dakar	\N	\N	\N	f	\N
12	Louis Dreyfus Commodities Senegal (Ex La Cigogne Dakar)	louis-dreyfus-commodities-senegal-ex-la-cigogne-dakar	Distribution De Produits Chimiques, Engrais Et Hytosanitaires	\N	2	2026-03-02 23:11:10.471	2026-03-02 23:11:10.471	Distribution De Produits Chimiques, Engrais Et Hytosanitaires	Route De Rufisque En Face Sips (Entre Olybia Et Sab)	33 822 11 19	Dakar	\N	\N	\N	f	\N
13	Cfao Motors Senegal (Ex - Africauto Senegal) Concessionnaire De Vehicules Et Accessoires - Autre	cfao-motors-senegal-ex-africauto-senegal-concessionnaire-de-vehicules-et-accessoires-autre	Commerces - Entretien Et Reparation De Vehicules - Auxilliaires Transports - Telecommunications - Services	\N	2	2026-03-02 23:11:10.473	2026-03-02 23:11:10.473	Commerces - Entretien Et Reparation De Vehicules - Auxilliaires Transports - Telecommunications - Services	Immobiliers Bccd	33 869 02 02	Dakar	\N	\N	\N	f	\N
14	Societe Commerciale Ndiene Sarl	societe-commerciale-ndiene-sarl	Commerce	\N	2	2026-03-02 23:11:10.475	2026-03-02 23:11:10.475	Commerce	Quartier Darou Minam Corniche Ndiouga Kebe - Touba	33 825 30 11	Touba	\N	\N	\N	f	\N
15	Touba Oil Sa	touba-oil-sa	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:10.478	2026-03-02 23:11:10.478	Vente De Produits Petroliers	Boulevard Du Centenaire De La Commune De Dakar 33 8217000 Dakar Amadou Lo (Unite De Stockage De Riz Import) Commerce De Riz Avenue Lamine Gueye	33 824 14 56	Pikine	\N	\N	\N	f	\N
16	Damag - Sa	damag-sa	Commerce Multiple - Super Marche Sahm Av Georges Pompidou -	\N	2	2026-03-02 23:11:10.48	2026-03-02 23:11:10.48	Commerce Multiple - Super Marche Sahm Av Georges Pompidou -	Immeuble City Sport 1 Er Etage (Ex Bd De La Gueule Tapee X Avenue Cheikh Anta Diop	33 821 64 15	Dakar	\N	\N	\N	f	\N
17	Darou Salam Kebe Et Freres Sarl Autres	darou-salam-kebe-et-freres-sarl-autres	Commerces	\N	2	2026-03-02 23:11:10.482	2026-03-02 23:11:10.482	Commerces	Rue Raffenel	33 849 05 05	Dakar	\N	\N	\N	f	\N
18	Abasse	abasse	Distribution Surl Commerce	\N	2	2026-03-02 23:11:10.483	2026-03-02 23:11:10.483	Distribution Surl Commerce	Rue Raffenel X Grasland 0 Dakar Star Oil Sa Distribution D'Hydrocarbures Ouest Foire Cite Air Af rique N° B-47	33 822 55 91	Dakar	\N	\N	\N	f	\N
19	Comtrade Sarl Import-Export	comtrade-sarl-import-export	Commerce General	\N	2	2026-03-02 23:11:10.485	2026-03-02 23:11:10.485	Commerce General	Avenue Lamine Gueye	33 864 68 85	Dakar	\N	\N	\N	f	\N
20	Waf Commodities (West Africa Commodities)	waf-commodities-west-africa-commodities	Commerce De Produits Agricoles	\N	2	2026-03-02 23:11:10.487	2026-03-02 23:11:10.487	Commerce De Produits Agricoles	Rue Malan Immeuble El ectra	33 849 44 43	Dakar	\N	\N	\N	f	\N
21	Diop	diop	Distribution Commerce Derkle	\N	2	2026-03-02 23:11:10.489	2026-03-02 23:11:10.489	Distribution Commerce Derkle	Route De Castors	33 975 73 85	Dakar	\N	\N	\N	f	\N
22	Etc Commodites Senegal Sarl	etc-commodites-senegal-sarl	Commerce General Hann Fort B	\N	2	2026-03-02 23:11:10.491	2026-03-02 23:11:10.491	Commerce General Hann Fort B	Route Des Peres Mariste	77 637 52 62	Dakar	\N	\N	\N	f	\N
23	Lcs - Sa (Les Cableries Du Senegal) Industrie -	lcs-sa-les-cableries-du-senegal-industrie	Fabrication De Cables Electriques - Commerce Import Export	\N	2	2026-03-02 23:11:10.493	2026-03-02 23:11:10.493	Fabrication De Cables Electriques - Commerce Import Export	Bccd X Rue 6	33 832 03 13	Dakar	\N	\N	\N	f	\N
24	Diagonal-Sa	diagonal-sa	Distribution	\N	2	2026-03-02 23:11:10.495	2026-03-02 23:11:10.495	Distribution	Route De Rufisque	33 839 80 20	Thiaroye	\N	\N	\N	f	\N
25	Fall	fall	Distributions & Services Sarl Vente De Produits Telephoniques	\N	2	2026-03-02 23:11:10.497	2026-03-02 23:11:10.497	Distributions & Services Sarl Vente De Produits Telephoniques	Bd General Degaulle X Rue 43	33 834 05 84	Dakar	\N	\N	\N	f	\N
26	E.D.S (Entreprise De	e-d-s-entreprise-de	Distribution Au Senegal - Sarl ) Commerce	\N	2	2026-03-02 23:11:10.5	2026-03-02 23:11:10.5	Distribution Au Senegal - Sarl ) Commerce	Rue Galandou Diouf 0 Dakar Eres Senegal - Sa Vente De Produits Petroliers Zone Des Hydrocarbures - Mole 8	33 842 35 60	Dakar	\N	\N	\N	f	\N
27	Station D'Essence Edk (Etablissement Demba Ka)	station-d-essence-edk-etablissement-demba-ka	Vente De Produits Petroliers Ouest Foire Face Vdn -	\N	1	2026-03-02 23:11:10.502	2026-03-02 23:11:10.502	Vente De Produits Petroliers Ouest Foire Face Vdn -	Immeuble Anta,Telecoms Residence	33 832 94 94	Dakar	\N	\N	\N	f	\N
28	Ets Jamil Tarraf & Cie	ets-jamil-tarraf-cie	Commerce Alimentaire - Import/Export	\N	2	2026-03-02 23:11:10.504	2026-03-02 23:11:10.504	Commerce Alimentaire - Import/Export	Rue Raffenel	33 820 73 02	Dakar	\N	\N	\N	f	\N
29	Interface Mobile Sarl	interface-mobile-sarl	Distribution De Produit Et Appareil Villa N° 4607 Si cap Amitie 3 0 Dakar Sebo Sa (Senegalaise D'Emballage De Boissons) Embouteillage De Boissons Alcoolisees - Autres Commerce	\N	2	2026-03-02 23:11:10.506	2026-03-02 23:11:10.506	Distribution De Produit Et Appareil Villa N° 4607 Si cap Amitie 3 0 Dakar Sebo Sa (Senegalaise D'Emballage De Boissons) Embouteillage De Boissons Alcoolisees - Autres Commerce	Bccd X Rue 6	33 889 49 49	Dakar	\N	\N	\N	f	\N
30	W Artsila Nsd W Est Africa Achats -	w-artsila-nsd-w-est-africa-achats	Ventes De Groupes Electrogenes Et De Moteurs Diesels	\N	2	2026-03-02 23:11:10.508	2026-03-02 23:11:10.508	Ventes De Groupes Electrogenes Et De Moteurs Diesels	Bccd	33 832 49 80	Dakar	\N	\N	\N	f	\N
31	Sedad Sarl	sedad-sarl	Distribution Engrais, Semences Produits Phytos	\N	2	2026-03-02 23:11:10.509	2026-03-02 23:11:10.509	Distribution Engrais, Semences Produits Phytos	Bccd, Imm Beau Rivage	33 832 10 26	Dakar	\N	\N	\N	f	\N
32	Saf Industries Senegal - Sa (Savonnerie Africaine Fakhry)	saf-industries-senegal-sa-savonnerie-africaine-fakhry	Fabrication De Savons - Autres Commerces	\N	2	2026-03-02 23:11:10.511	2026-03-02 23:11:10.511	Fabrication De Savons - Autres Commerces	Bccd	33 832 56 29	Dakar	\N	\N	\N	f	\N
33	Mbacke & Freres Surl	mbacke-freres-surl	Commerce Produits Alimentaires Et Transport	\N	2	2026-03-02 23:11:10.513	2026-03-02 23:11:10.513	Commerce Produits Alimentaires Et Transport	Route De L'Hopital - Marche Ourossogui	33 823 66 87	Ourossogui	\N	\N	\N	f	\N
34	Ste Bernabe Senegal	ste-bernabe-senegal	Commerce ( Negoce De Materiaux De Construction)	\N	2	2026-03-02 23:11:10.516	2026-03-02 23:11:10.516	Commerce ( Negoce De Materiaux De Construction)	Bccd	33 966 11 58	Dakar	\N	\N	\N	f	\N
35	Ccd Sarl (Compagnie Commerciale Dia Et Freres)	ccd-sarl-compagnie-commerciale-dia-et-freres	Commerce General De Marchandises Diverses	\N	2	2026-03-02 23:11:10.518	2026-03-02 23:11:10.518	Commerce General De Marchandises Diverses	Rue Tolbia c	33 849 01 01	Dakar	\N	\N	\N	f	\N
36	Sab Sa (Ste Africaine De Bois) Industrie Du Bois -	sab-sa-ste-africaine-de-bois-industrie-du-bois	Revente En L'Etat	\N	2	2026-03-02 23:11:10.52	2026-03-02 23:11:10.52	Revente En L'Etat	Bccd	33 823 23 47	Dakar	\N	\N	\N	f	\N
37	Comptoir Commercial Maamarah Sarl	comptoir-commercial-maamarah-sarl	Commerce Rufisque	\N	2	2026-03-02 23:11:10.522	2026-03-02 23:11:10.522	Commerce Rufisque	Rue Ousmane Soce Diop N°468	33 832 36 95	Rufisque	\N	\N	\N	f	\N
38	Atlas	atlas	Distribution Sarl Commerce Import-Export	\N	2	2026-03-02 23:11:10.524	2026-03-02 23:11:10.524	Distribution Sarl Commerce Import-Export	Rue 4 Zone Industrielle	33 836 01 64	Dakar	\N	\N	\N	f	\N
39	Mka Excellence Sarl	mka-excellence-sarl	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:10.525	2026-03-02 23:11:10.525	Vente De Produits Petroliers	Rue Mangin X Avenue Bla ise Diagne	33 832 57 16	Dakar	\N	\N	\N	f	\N
40	Khalil Koleit Autres	khalil-koleit-autres	Commerces	\N	2	2026-03-02 23:11:10.527	2026-03-02 23:11:10.527	Commerces	Rue Robert Brun	33 832 90 75	Dakar	\N	\N	\N	f	\N
41	Eydon - Sa (Eydon Petroleum - Sa)	eydon-sa-eydon-petroleum-sa	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.529	2026-03-02 23:11:10.529	Vente De Produits Petroliers (Station D'Essence)	Rue Dr Calmette	33 822 69 85	Dakar	\N	\N	\N	f	\N
42	Sencom - Sarl (Senegalaise De	sencom-sarl-senegalaise-de	Commerce) Vente De Riz Bcccd (Ex 79	\N	2	2026-03-02 23:11:10.531	2026-03-02 23:11:10.531	Commerce) Vente De Riz Bcccd (Ex 79	Rue Joseph Gomis (Ex - Bay eux)	33 889 51 70	Dakar	\N	\N	\N	f	\N
43	Gfl - Sa (Groupe Fauzie Layousse - Ex Ets) Transport -	gfl-sa-groupe-fauzie-layousse-ex-ets-transport	Commerce Import/Export	\N	2	2026-03-02 23:11:10.533	2026-03-02 23:11:10.533	Commerce Import/Export	Route De Rufisque	33 823 34 71	Rufisque	\N	\N	\N	f	\N
44	Technocell	technocell	Commerce	\N	2	2026-03-02 23:11:10.535	2026-03-02 23:11:10.535	Commerce	Route De L'Aeroport Almadies	33 836 33 51	Dakar	\N	\N	\N	f	\N
45	Ccm (Comptoir Commercial Mariama)	ccm-comptoir-commercial-mariama	Commerce General	\N	2	2026-03-02 23:11:10.537	2026-03-02 23:11:10.537	Commerce General	Rue Raffenel	33 855 94 95	Dakar	\N	\N	\N	f	\N
46	Cda (Chaine De	cda-chaine-de	Distribution Alimentaire) Vente De Marchandises - Boucherie (59,25%)- Fabrication D'Autres Produits Alimentaires (40,25%)	\N	2	2026-03-02 23:11:10.539	2026-03-02 23:11:10.539	Distribution Alimentaire) Vente De Marchandises - Boucherie (59,25%)- Fabrication D'Autres Produits Alimentaires (40,25%)	Rue Du Docteur Theze	33 821 96 57	Dakar	\N	\N	\N	f	\N
47	Ets Said Noujaim Freres Sa Industrie De Confiserie -	ets-said-noujaim-freres-sa-industrie-de-confiserie	Commerce - Vente Emballages - Location	\N	2	2026-03-02 23:11:10.54	2026-03-02 23:11:10.54	Commerce - Vente Emballages - Location	Immeuble - Vente Matieres Premieres Confiserie Avenue Lamine Gueye	33 869 31 25	Dakar	\N	\N	\N	f	\N
48	Smc Sarl (Societe Senegalaise Mauritanienne De	smc-sarl-societe-senegalaise-mauritanienne-de	Commerce Commerce	\N	2	2026-03-02 23:11:10.542	2026-03-02 23:11:10.542	Commerce Commerce	Rue Robert Brun	33 855 79 50	Dakar	\N	\N	\N	f	\N
49	Scdf Sarl (Societe Commerciale Diakhate & Fils)	scdf-sarl-societe-commerciale-diakhate-fils	Commerce General	\N	2	2026-03-02 23:11:10.544	2026-03-02 23:11:10.544	Commerce General	Rue Tolbiac	33 822 04 66	Dakar	\N	\N	\N	f	\N
50	Intertrade Senegal Suarl	intertrade-senegal-suarl	Commerce	\N	2	2026-03-02 23:11:10.546	2026-03-02 23:11:10.546	Commerce	Bccd	33 835 00 27	Dakar	\N	\N	\N	f	\N
51	Ciel Oil (Etablissement Galaye Ndiaye)	ciel-oil-etablissement-galaye-ndiaye	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:10.548	2026-03-02 23:11:10.548	Vente De Produits Petroliers	Bccd	33 825 32 49	Dakar	\N	\N	\N	f	\N
52	Sera Sa (Ste D'Equipement Et De Representation Automobile)	sera-sa-ste-d-equipement-et-de-representation-automobile	Commerce Vehicule - Autres Comerces - Entretien Et Reparation Vehicules Automobiles	\N	2	2026-03-02 23:11:10.55	2026-03-02 23:11:10.55	Commerce Vehicule - Autres Comerces - Entretien Et Reparation Vehicules Automobiles	Bccd	33 832 75 39	Dakar	\N	\N	\N	f	\N
53	Distri Mat Sarl	distri-mat-sarl	(Distribution De Materiels De Const ruction - Sarl) Commerce	\N	2	2026-03-02 23:11:10.552	2026-03-02 23:11:10.552	(Distribution De Materiels De Const ruction - Sarl) Commerce	Rue Daloa Leona 0 Dakar Fumoa - Sa (Futs Metalliques Et Plastiques De L'Ouest Africain) Fabrication De Futs Metalliques - Emballages Plastiques - Toles Metalliques - Location - Ventes D'Accessoires Bccd	33 849 32 60	Kaolack	\N	\N	\N	f	\N
66	Sirmel Senegal - Sa	sirmel-senegal-sa	Commerce De Materiels Electriques	\N	2	2026-03-02 23:11:10.608	2026-03-02 23:11:10.608	Commerce De Materiels Electriques	Route De Rufisque Thiaroye Dur Mer	33 839 87 80	Dakar	\N	\N	\N	f	\N
67	Neptune Oil Senegal Achat	neptune-oil-senegal-achat	Vente De Produits Hydrocarbures	\N	1	2026-03-02 23:11:10.612	2026-03-02 23:11:10.612	Vente De Produits Hydrocarbures	Route De Ngor, Face Stade Municipal Ngor	33 879 12 11	Dakar	\N	\N	\N	f	\N
68	Solidis Sarl	solidis-sarl	Commerce	\N	2	2026-03-02 23:11:10.615	2026-03-02 23:11:10.615	Commerce	Rue Felix Eboue	33 869 62 82	Dakar	\N	\N	\N	f	\N
69	Aci (Agence De Cooperation Internationale)	aci-agence-de-cooperation-internationale	Commerce General Point E -	\N	2	2026-03-02 23:11:10.617	2026-03-02 23:11:10.617	Commerce General Point E -	Bd Du Sud X Rue G 1	33 941 23 22	Dakar	\N	\N	\N	f	\N
70	Kmob Sa	kmob-sa	Distribution Et Cmmercialisation Des Produits Et Services Lies Aux Telecommunications	\N	2	2026-03-02 23:11:10.619	2026-03-02 23:11:10.619	Distribution Et Cmmercialisation Des Produits Et Services Lies Aux Telecommunications	Avenue Malick Sy Immeuble Serham 5 Etage	33 824 35 49	Dakar	\N	\N	\N	f	\N
54	Ccs Sa (Comptoir Commercial Du Senegal)	ccs-sa-comptoir-commercial-du-senegal	Commerce - Import/Export Materiels Sanitaires	\N	2	2026-03-02 23:11:10.577	2026-03-02 23:11:10.577	Commerce - Import/Export Materiels Sanitaires	Avenue Malick Sy X Autoroute Passage Gare Routiere	77 572 08 37	Dakar	\N	\N	\N	f	\N
55	Groupe Safcom (Societe Africaine De	groupe-safcom-societe-africaine-de	Commerce) Commerce Cite Sipres Mourtada (Ex 12	\N	2	2026-03-02 23:11:10.58	2026-03-02 23:11:10.58	Commerce) Commerce Cite Sipres Mourtada (Ex 12	Rue W Agane Diouf	33 835 75 35	Dakar	\N	\N	\N	f	\N
56	Aridim Sarl	aridim-sarl	Commerce	\N	2	2026-03-02 23:11:10.582	2026-03-02 23:11:10.582	Commerce	Rue Tolbiac	33 869 30 70	Dakar	\N	\N	\N	f	\N
57	Kerry Trade Sarl	kerry-trade-sarl	Commerce General Zone Industrielle	\N	2	2026-03-02 23:11:10.584	2026-03-02 23:11:10.584	Commerce General Zone Industrielle	Rue 4	77 360 05 59	Dakar	\N	\N	\N	f	\N
58	Ets Mahmoud Meroueh	ets-mahmoud-meroueh	Commerce - Import/Export	\N	2	2026-03-02 23:11:10.586	2026-03-02 23:11:10.586	Commerce - Import/Export	Rue Mousse Diop (Ex - Blanc hot)	77 638 77 30	Dakar	\N	\N	\N	f	\N
59	Ccbme - Sarl (Comptoir Commercial Bara Mboup Electronique)	ccbme-sarl-comptoir-commercial-bara-mboup-electronique	Commerce General - Electronique - Marchandises Diverses	\N	2	2026-03-02 23:11:10.588	2026-03-02 23:11:10.588	Commerce General - Electronique - Marchandises Diverses	Avenue Lamine Gueye	33 822 23 75	Dakar	\N	\N	\N	f	\N
60	Ccbmh Sa (Ex Comptoir Commercial Bara Mboup) Autres	ccbmh-sa-ex-comptoir-commercial-bara-mboup-autres	Services	\N	2	2026-03-02 23:11:10.59	2026-03-02 23:11:10.59	Services	Immobiliers (Exercice Precedant = Commerce General) Avenue Lamine Gueye (Ex Adresse = Sodida - Lot 2B Est)	33 849 59 39	Dakar	\N	\N	\N	f	\N
61	Sicof - Sarl (Societe Industrielle Commerciale Et Financiere Harati & Freres)	sicof-sarl-societe-industrielle-commerciale-et-financiere-harati-freres	Commerce Alimentaire	\N	2	2026-03-02 23:11:10.592	2026-03-02 23:11:10.592	Commerce Alimentaire	Rue Raffenel	33 824 90 25	Dakar	\N	\N	\N	f	\N
62	Redington Senegal Limited Sarl	redington-senegal-limited-sarl	Commerce General-Import- Export	\N	2	2026-03-02 23:11:10.595	2026-03-02 23:11:10.595	Commerce General-Import- Export	Rue Non Denommee Imm Abc Rond Point Jet D'Eau	33 855 94 95	Dakar	\N	\N	\N	f	\N
63	Aye Bizi-Nillahi Sarl	aye-bizi-nillahi-sarl	Cogesen - Sarl Commerce General	\N	2	2026-03-02 23:11:10.597	2026-03-02 23:11:10.597	Cogesen - Sarl Commerce General	Rue Marchand X Autoroute	33 849 65 00	Guediaw	\N	\N	\N	f	\N
64	Station Shell Pasteur Et Shell Unit ( Khaled Ayache)-	station-shell-pasteur-et-shell-unit-khaled-ayache	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.6	2026-03-02 23:11:10.6	Vente De Produits Petroliers (Station D'Essence)	Avenue Pasteur	33 864 36 55	Dakar	\N	\N	\N	f	\N
65	Valdafrique - Labo Canonne - Sa Industries Pharmaceutiques - Autres	valdafrique-labo-canonne-sa-industries-pharmaceutiques-autres	Commerces - Services Rendus Auf Entreprises	\N	2	2026-03-02 23:11:10.604	2026-03-02 23:11:10.604	Commerces - Services Rendus Auf Entreprises	Route De Diokoul - Rufisque	33 823 19 66	Dakar	\N	\N	\N	f	\N
143	Scm - Suarl (Societe Commerciale Marega)	scm-suarl-societe-commerciale-marega	Commerce General	\N	2	2026-03-02 23:11:10.771	2026-03-02 23:11:10.771	Commerce General	Rue Grasland	33 836 15 89	Dakar	\N	\N	\N	f	\N
159	Office Choice	office-choice	Commerce Yoff	\N	2	2026-03-02 23:11:10.873	2026-03-02 23:11:10.873	Commerce Yoff	Route De L'Aeroport	33 865 05 05	Dakar	\N	\N	\N	f	\N
160	Entreprise Ndam Khabou Sarl	entreprise-ndam-khabou-sarl	Commerce	\N	2	2026-03-02 23:11:10.884	2026-03-02 23:11:10.884	Commerce	Quartier Baye Birane N° 102 - Thiaroye Sur Mer 0 Dakar Frip Ethique Sarl Commerce General Rue 37X30	33 820 20 34	Dakar	\N	\N	\N	f	\N
161	Ets Maleye - Magatte Diongue	ets-maleye-magatte-diongue	Commerce Pneumatique Et Accessoires Automobile	\N	2	2026-03-02 23:11:10.889	2026-03-02 23:11:10.889	Commerce Pneumatique Et Accessoires Automobile	Avenue Lamine Gueye	77 544 74 19	Dakar	\N	\N	\N	f	\N
162	Fall Et Aidara Sarl	fall-et-aidara-sarl	Commerce	\N	2	2026-03-02 23:11:10.894	2026-03-02 23:11:10.894	Commerce	Avenue Amamdou Gnagna Sow 0 Thies Al Youmoune Commerce Avenue Amadou Gnagna Sow Thies 0 Dakar Mc3 Senegal Vente De Materiel Informatique - Grossiste Materiel Informatique Mermoz Pyrotechnie - Villa 42	33 821 19 39	Thies	\N	\N	\N	f	\N
163	Master Office Sa (Ex Espace Sa "Office 1 Super Store", Ex Norgaard)	master-office-sa-ex-espace-sa-office-1-super-store-ex-norgaard	Commerce	\N	2	2026-03-02 23:11:10.899	2026-03-02 23:11:10.899	Commerce	Autoroute Prolongee X Rue Marchand	33 860 74 10	Dakar	\N	\N	\N	f	\N
164	Serigne Mbacke	serigne-mbacke	Commerce General	\N	2	2026-03-02 23:11:10.902	2026-03-02 23:11:10.902	Commerce General	Route De Rufisque Darou Miname Piki ne	33 849 06 66	Dakar	\N	\N	\N	f	\N
165	Etablissements Sara Sarl	etablissements-sara-sarl	Commerce Marchandises Diverses	\N	2	2026-03-02 23:11:10.905	2026-03-02 23:11:10.905	Commerce Marchandises Diverses	Rue Lieutenant Lemoin e Escale Ziguinchor	77 505 44 89	Ziguinchor	\N	\N	\N	f	\N
166	Sarl Matar & Fils	sarl-matar-fils	Commerce	\N	2	2026-03-02 23:11:10.907	2026-03-02 23:11:10.907	Commerce	Route De Rufisque	33 991 13 98	Dakar	\N	\N	\N	f	\N
167	Ets Ndiaye & Freres	ets-ndiaye-freres	Commerce	\N	2	2026-03-02 23:11:10.91	2026-03-02 23:11:10.91	Commerce	Rue Daloa	77 197 57 57	Kaolack	\N	\N	\N	f	\N
168	Cct (Compagnie Commerciale Thiam Suarl)	cct-compagnie-commerciale-thiam-suarl	Commerce	\N	2	2026-03-02 23:11:10.913	2026-03-02 23:11:10.913	Commerce	Avenue Adrien Senghor 0 Dakar Sodapral Suarl Commerce Avenue Lamine Gueye 33 821 80 0 Pikine Touba Commerce - Sarl Vente De Produits Alimentaires Pikine Route Des Niay es	33 941 37 16	Thies	\N	\N	\N	f	\N
169	Station Total Bourguiba (Gnagna Sylla)	station-total-bourguiba-gnagna-sylla	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.915	2026-03-02 23:11:10.915	Vente De Produits Petroliers (Station D'Essence)	Avenue Bourguiba	33 821 21 06	Dakar	\N	\N	\N	f	\N
170	Entreprise Da Rosa Suarl	entreprise-da-rosa-suarl	Btp-Transport-Commerce	\N	2	2026-03-02 23:11:10.917	2026-03-02 23:11:10.917	Btp-Transport-Commerce	Quartier Santhiaba	33 953 40 04	Ziguinchor	\N	\N	\N	f	\N
171	Mor Mbaye Sylla	mor-mbaye-sylla	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:10.92	2026-03-02 23:11:10.92	Commerce De Produits Alimentaires	Rue Escale Quartie r Thikhna Louga	33 869 60 60	Louga	\N	\N	\N	f	\N
172	Ccam Sarl (Comptoir Commercial Ai Moubarak)	ccam-sarl-comptoir-commercial-ai-moubarak	Commerce	\N	2	2026-03-02 23:11:10.921	2026-03-02 23:11:10.921	Commerce	Route De Rufisque Marche Diamaguene	77 569 02 22	Dakar	\N	\N	\N	f	\N
173	Frip Etique Sarl	frip-etique-sarl	Commerce General	\N	2	2026-03-02 23:11:10.923	2026-03-02 23:11:10.923	Commerce General	Rue 39 X 40 Colobane	77 551 12 47	Dakar	\N	\N	\N	f	\N
174	Pikine Materiaux Suarl	pikine-materiaux-suarl	Commerce Quincaillerie Pikine	\N	2	2026-03-02 23:11:10.928	2026-03-02 23:11:10.928	Commerce Quincaillerie Pikine	Route De Dakar Sor	33 822 95 93	Saint-Louis	\N	\N	\N	f	\N
175	Semac Sa (Societe Senegalaise De Marchandises Diverses)	semac-sa-societe-senegalaise-de-marchandises-diverses	Commerce De Produits Agricoles	\N	2	2026-03-02 23:11:10.93	2026-03-02 23:11:10.93	Commerce De Produits Agricoles	Rue Malan	33 953 40 04	Dakar	\N	\N	\N	f	\N
176	Cad - Sarl (Consortium Africain De Droguerie) Autres	cad-sarl-consortium-africain-de-droguerie-autres	Commerces - Consortium Africain De Droguerie	\N	2	2026-03-02 23:11:10.936	2026-03-02 23:11:10.936	Commerces - Consortium Africain De Droguerie	Rue Jules Ferry	33 822 00 03	Dakar	\N	\N	\N	f	\N
177	Sspc Sarl (Societe Senegalaise De Produits Chimiques)	sspc-sarl-societe-senegalaise-de-produits-chimiques	Distribution De Produits Chimiques	\N	2	2026-03-02 23:11:10.941	2026-03-02 23:11:10.941	Distribution De Produits Chimiques	Bccd (Ex 4 Rue Parchappe X Mage - Immeuble Djannah /Ex - Immeuble Le Saly)	33 966 16 49	Dakar	\N	\N	\N	f	\N
71	Oumou Informatique	oumou-informatique	Service Commerce Articles Informatiques Et Bureautiques	\N	2	2026-03-02 23:11:10.621	2026-03-02 23:11:10.621	Service Commerce Articles Informatiques Et Bureautiques	Avenue Blaise Diagne Face Douta Seck	33 821 73 13	Dakar	\N	\N	\N	f	\N
72	Sicas - Sa (Ste Industrielle Et Commerciale De L'Automobile Au Senegal)	sicas-sa-ste-industrielle-et-commerciale-de-l-automobile-au-senegal	Vente Pieces Detachees Vehicules - Moto - Motopompes Et Reparations	\N	2	2026-03-02 23:11:10.623	2026-03-02 23:11:10.623	Vente Pieces Detachees Vehicules - Moto - Motopompes Et Reparations	Avenue Malick Sy X Rue Ambroise Mendy (Medina)	33 835 79 51	Dakar	\N	\N	\N	f	\N
73	Cassis Froid (Cassis Anis Abass Raif)	cassis-froid-cassis-anis-abass-raif	Commerce D'Appareis Electro-Menagers	\N	2	2026-03-02 23:11:10.625	2026-03-02 23:11:10.625	Commerce D'Appareis Electro-Menagers	Rue Mousse Diop	33 849 01 91	Dakar	\N	\N	\N	f	\N
74	Ibrahima Toure	ibrahima-toure	Commerce - Transport Medina	\N	2	2026-03-02 23:11:10.627	2026-03-02 23:11:10.627	Commerce - Transport Medina	Rue 25 X 20	33 821 79 48	Dakar	\N	\N	\N	f	\N
75	Tremex Sa	tremex-sa	Vente De Produits Metallurgiques - Fers Et Metaux Non Ferreuf	\N	2	2026-03-02 23:11:10.628	2026-03-02 23:11:10.628	Vente De Produits Metallurgiques - Fers Et Metaux Non Ferreuf	Bccd	33 823 35 48	Dakar	\N	\N	\N	f	\N
76	Mad Sarl (M. A.	mad-sarl-m-a	Distribution) Commerce General	\N	2	2026-03-02 23:11:10.63	2026-03-02 23:11:10.63	Distribution) Commerce General	Bccd X Rue 6 - Zone Industrielle	33 832 16 29	Dakar	\N	\N	\N	f	\N
77	El Hadj Abdou Aziz Diagne	el-hadj-abdou-aziz-diagne	Commerce General	\N	2	2026-03-02 23:11:10.632	2026-03-02 23:11:10.632	Commerce General	Quartier Montagne, Pres Des Sapeurs Pompiers Louga	77 615 76 01	Louga	\N	\N	\N	f	\N
78	Sosagrin Sa (Societe Senegalaise Agro- Industrielle) Industrie Agroalimentaire De Transformation -	sosagrin-sa-societe-senegalaise-agro-industrielle-industrie-agroalimentaire-de-transformation	Vente De Produits Agro- Alimentaires	\N	2	2026-03-02 23:11:10.634	2026-03-02 23:11:10.634	Vente De Produits Agro- Alimentaires	Bccd	33 974 15 17	Dakar	\N	\N	\N	f	\N
79	Sanco (Societe Africaine De Negoce Et Commercialisation Des Oleagineux)	sanco-societe-africaine-de-negoce-et-commercialisation-des-oleagineux	Commerce Des Cereales Et Oleagineux	\N	2	2026-03-02 23:11:10.635	2026-03-02 23:11:10.635	Commerce Des Cereales Et Oleagineux	Rue Felix Eboue Face Grands Moulins De Dakar	33 832 18 88	Dakar	\N	\N	\N	f	\N
80	Carrefour Automobiles	carrefour-automobiles	Vente De Vehicule - Import Export	\N	2	2026-03-02 23:11:10.637	2026-03-02 23:11:10.637	Vente De Vehicule - Import Export	Autoroute X Croise ment Camberene	33 835 95 47	Dakar	\N	\N	\N	f	\N
81	Kheweul Sarl	kheweul-sarl	Commerce General	\N	2	2026-03-02 23:11:10.639	2026-03-02 23:11:10.639	Commerce General	Rue 25 Marche Ocass Touba 0 Dakar Cosetam - Sa (Cie Senegalaise Pour Tous Appareillages Mecaniques) Commerce Import/Export - Mecanique Generale Route De s Hydrocarbures - Bel-Air	33 839 86 86	Mbacke	\N	\N	\N	f	\N
82	Digital Technologies - Sa	digital-technologies-sa	Commerce General	\N	2	2026-03-02 23:11:10.641	2026-03-02 23:11:10.641	Commerce General	Bccd	33 867 82 67	Dakar	\N	\N	\N	f	\N
83	Cic Senegal - Sarl (Compagnie D'Investissement Cerealier)	cic-senegal-sarl-compagnie-d-investissement-cerealier	Commerce - Import/Export - Distribution Produits Cerealiers	\N	2	2026-03-02 23:11:10.643	2026-03-02 23:11:10.643	Commerce - Import/Export - Distribution Produits Cerealiers	Bd El Hadji Djily Mbaye	33 869 39 40	Dakar	\N	\N	\N	f	\N
84	W Amotras (W Ague Mondial Trading Senegal)	w-amotras-w-ague-mondial-trading-senegal	Commerce General	\N	2	2026-03-02 23:11:10.645	2026-03-02 23:11:10.645	Commerce General	Rue Raffenel	33 821 28 80	Dakar	\N	\N	\N	f	\N
85	Sylla Logistique Et	sylla-logistique-et	Commerce Sarl Commerce Hydro Carbures	\N	2	2026-03-02 23:11:10.646	2026-03-02 23:11:10.646	Commerce Sarl Commerce Hydro Carbures	Route De Rufisque 0 Dakar Ste Senegalaise Des Ets Afco - Sa Vente De Materiels Agricoles - De Transport (Fiat) Et De Pieces Detachees (89,84%) Prestations De Services (10,16%) - Rocade Fann Bel Air - Pont De Colobane	33 823 87 96	Thiaroye	\N	\N	\N	f	\N
86	Citysen	citysen	Commerce General	\N	2	2026-03-02 23:11:10.648	2026-03-02 23:11:10.648	Commerce General	Avenue Georges Pompidou	33 832 80 80	Dakar	\N	\N	\N	f	\N
87	Se Pro Com (Societe D'Equipement Et De Promotion Co mmerciale - Sarl)	se-pro-com-societe-d-equipement-et-de-promotion-co-mmerciale-sarl	Commerce Generl - Import Export	\N	2	2026-03-02 23:11:10.65	2026-03-02 23:11:10.65	Commerce Generl - Import Export	Avenue Bourguiba Ex Dicopa 0 Dakar Cassis Equipements-Suarl Commerce General Rue Mousse Diop	33 821 24 08	Dakar	\N	\N	\N	f	\N
88	Transmed Senegal	transmed-senegal	Commerce General	\N	2	2026-03-02 23:11:10.652	2026-03-02 23:11:10.652	Commerce General	Bccd	33 889 08 04	Dakar	\N	\N	\N	f	\N
89	Sade Senegal Sa Captage, Epuration Et	sade-senegal-sa-captage-epuration-et	Distribution D'Eau	\N	2	2026-03-02 23:11:10.654	2026-03-02 23:11:10.654	Distribution D'Eau	Route Des P eres Maristes - Hann	33 832 06 00	Dakar	\N	\N	\N	f	\N
90	Aye Jean Pierre Mendy	aye-jean-pierre-mendy	Vente De Produits Pharmaceutiques Nimzatt	\N	2	2026-03-02 23:11:10.655	2026-03-02 23:11:10.655	Vente De Produits Pharmaceutiques Nimzatt	Quartier M baye Fall Guediaw Aye	33 834 05 87	Guediaw	\N	\N	\N	f	\N
91	Societe Sant Yalla Borom Bi Sarl	societe-sant-yalla-borom-bi-sarl	Commerce - Btp	\N	2	2026-03-02 23:11:10.657	2026-03-02 23:11:10.657	Commerce - Btp	Quartier Touba Corniche Face Usine Glace - Touba	77 306 58 60	Touba	\N	\N	\N	f	\N
92	Ccbm Industries - Espace Auto Sa	ccbm-industries-espace-auto-sa	Commerce Vehicules - Pieces Detachees - Montage Vehicules Km 4	\N	2	2026-03-02 23:11:10.659	2026-03-02 23:11:10.659	Commerce Vehicules - Pieces Detachees - Montage Vehicules Km 4	Bccd	33 978 07 57	Dakar	\N	\N	\N	f	\N
93	Pharmacie Guigon (Bernard Henrie Guigon)	pharmacie-guigon-bernard-henrie-guigon	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:10.661	2026-03-02 23:11:10.661	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e	33 859 08 80	Dakar	\N	\N	\N	f	\N
94	Entreprise Activité Adresse Téléphone Dakar Maack (Maack Petroleum Company)	entreprise-activite-adresse-telephone-dakar-maack-maack-petroleum-company	Vente De Produits Petroliers Hlm Hann Maristes Ii R0 5 776386566 Dakar Dhf - Sa (Daniel Haddad Et Fils) Transport D'Hydrocarbures - Commerce - Culture Cerealiere	\N	1	2026-03-02 23:11:10.663	2026-03-02 23:11:10.663	Vente De Produits Petroliers Hlm Hann Maristes Ii R0 5 776386566 Dakar Dhf - Sa (Daniel Haddad Et Fils) Transport D'Hydrocarbures - Commerce - Culture Cerealiere	Bccd X Rue 2	33 981 11 18	Ville	\N	\N	\N	f	\N
95	Tropicasem - Sa	tropicasem-sa	Distribution De Semences Maraichers - Micro Irrigation	\N	2	2026-03-02 23:11:10.664	2026-03-02 23:11:10.664	Distribution De Semences Maraichers - Micro Irrigation	Bccd	77 332 62 16	Dakar	\N	\N	\N	f	\N
96	Mi - Dis Sa (Midadi	mi-dis-sa-midadi	Distribution) Distribution - Commerece Alimentaire	\N	2	2026-03-02 23:11:10.666	2026-03-02 23:11:10.666	Distribution) Distribution - Commerece Alimentaire	Rue Raffenel	33 832 05 05	Dakar	\N	\N	\N	f	\N
97	Station Total Point E (Ousmane Ly)	station-total-point-e-ousmane-ly	Vente De Produits Petroliers (Station D'Essence) Liberte 6 (Ex Point E	\N	1	2026-03-02 23:11:10.668	2026-03-02 23:11:10.668	Vente De Produits Petroliers (Station D'Essence) Liberte 6 (Ex Point E	Rue 5 X 11)	33 822 96 74	Dakar	\N	\N	\N	f	\N
98	Unitech Motors Sa	unitech-motors-sa	Vente De Vehicules	\N	2	2026-03-02 23:11:10.67	2026-03-02 23:11:10.67	Vente De Vehicules	Route De Rufisque	33 824 75 15	Dakar	\N	\N	\N	f	\N
99	Afitex Afrique Sarl Represenation Et	afitex-afrique-sarl-represenation-et	Distribution De Produits Agricoles Et Industriels Toute Des Almadies,	\N	2	2026-03-02 23:11:10.671	2026-03-02 23:11:10.671	Distribution De Produits Agricoles Et Industriels Toute Des Almadies,	Immeuble Oasis 1	33 853 20 35	Dakar	\N	\N	\N	f	\N
100	Yma Exports & Imports Senegal Sarl	yma-exports-imports-senegal-sarl	Commerce General Hann Mariste,	\N	2	2026-03-02 23:11:10.673	2026-03-02 23:11:10.673	Commerce General Hann Mariste,	Route Des Peres Maris te	33 869 81 99	Dakar	\N	\N	\N	f	\N
101	Akiss	akiss	Distribution Sarl Commerce Du Lait	\N	2	2026-03-02 23:11:10.675	2026-03-02 23:11:10.675	Distribution Sarl Commerce Du Lait	Rue Abdou Karim Bourgi Dakar	77 696 39 42	Dakar	\N	\N	\N	f	\N
102	I2 Senegal -Sarl	i2-senegal-sarl	Commerce	\N	2	2026-03-02 23:11:10.678	2026-03-02 23:11:10.678	Commerce	Bd De La Republique	77 333 54 46	Dakar	\N	\N	\N	f	\N
103	Holding Gueye - Sarl Transport - Terrassement - Mecanique - Carosserie -	holding-gueye-sarl-transport-terrassement-mecanique-carosserie	Vente De Voitures - Pieces Detachees	\N	2	2026-03-02 23:11:10.68	2026-03-02 23:11:10.68	Vente De Voitures - Pieces Detachees	Bccd - Seras	33 867 89 47	Dakar	\N	\N	\N	f	\N
104	Ets Alga Sarl (Etablissements Alga Sarl) Travaux D'Installation Et De Finition Et Autres	ets-alga-sarl-etablissements-alga-sarl-travaux-d-installation-et-de-finition-et-autres	Commerces	\N	2	2026-03-02 23:11:10.683	2026-03-02 23:11:10.683	Commerces	Route De Rufisque - Poste Thiaroye	33 837 12 70	Dakar	\N	\N	\N	f	\N
105	Dem Senegal	dem-senegal	Distribution De Vehicules Et Engins Neufs	\N	2	2026-03-02 23:11:10.685	2026-03-02 23:11:10.685	Distribution De Vehicules Et Engins Neufs	Immeuble C lairafrique, Place De L'Independance 0 Dakar Entracom - Serigne Niang (Entreprise De Transport Et De Commerce) Transport Et Commerce Face Gare Routiere Colobane Ca ntine N° 1433	33 834 89 84	Dakar	\N	\N	\N	f	\N
106	Thome Oil Sarl	thome-oil-sarl	Distribution De Produits Petroliers	\N	1	2026-03-02 23:11:10.687	2026-03-02 23:11:10.687	Distribution De Produits Petroliers	Bccd	33 834 52 26	Dakar	\N	\N	\N	f	\N
107	Sonacom Sarl (Societe Nationale De	sonacom-sarl-societe-nationale-de	Commerce Sarl) Commerce	\N	2	2026-03-02 23:11:10.689	2026-03-02 23:11:10.689	Commerce Sarl) Commerce	Rue Grasland	33 835 17 56	Dakar	\N	\N	\N	f	\N
108	Afrique Petrole - Sa	afrique-petrole-sa	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:10.691	2026-03-02 23:11:10.691	Vente De Produits Petroliers	Avenue Pasteur	33 822 04 66	Dakar	\N	\N	\N	f	\N
109	Ets Nazih Fazaa Surl Autres	ets-nazih-fazaa-surl-autres	Commerces - Ventes De Farine Et Divers	\N	2	2026-03-02 23:11:10.692	2026-03-02 23:11:10.692	Commerces - Ventes De Farine Et Divers	Rue Galandou Diouf	33 821 83 85	Dakar	\N	\N	\N	f	\N
110	Orca Sarl	orca-sarl	Commerce General	\N	2	2026-03-02 23:11:10.694	2026-03-02 23:11:10.694	Commerce General	Avenue Blaise Diagne	33 854 02 65	Dakar	\N	\N	\N	f	\N
111	Sodial (Societe De	sodial-societe-de	Distribution Alimentaire) Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:10.696	2026-03-02 23:11:10.696	Distribution Alimentaire) Commerce De Produits Alimentaires	Rue Paul Holle 33821 18 92 Kaolack Etablissement Diallo Et Freres Sarl Commerce General Rue Daloi Leona	33 842 31 79	Dakar	\N	\N	\N	f	\N
112	Sarre Technobat Suarl Btp -	sarre-technobat-suarl-btp	Commerce-Service	\N	2	2026-03-02 23:11:10.698	2026-03-02 23:11:10.698	Commerce-Service	Avenue Blaise Diagne	33 942 15 86	Dakar	\N	\N	\N	f	\N
113	C3S (Compagnie Serigne Seck)	c3s-compagnie-serigne-seck	Commerce Quincaillerie (Verre, Aluminium, Accessoires	\N	2	2026-03-02 23:11:10.7	2026-03-02 23:11:10.7	Commerce Quincaillerie (Verre, Aluminium, Accessoires	Avenue Lamine Gueye	33 835 90 42	Dakar	\N	\N	\N	f	\N
114	Grupo Numero Uno, Sng Sarl	grupo-numero-uno-sng-sarl	Commerce Textile Lot A Sud Foire En Face Liberte 6 E xtension 033 835 22 23 Dakar Ab Distribution - Suarl Commerce General	\N	2	2026-03-02 23:11:10.702	2026-03-02 23:11:10.702	Commerce Textile Lot A Sud Foire En Face Liberte 6 E xtension 033 835 22 23 Dakar Ab Distribution - Suarl Commerce General	Rue Felix Eboue	33 822 58 01	Dakar	\N	\N	\N	f	\N
115	Station Shell Rufisque 2 (Mr Hathiramani Suresh)	station-shell-rufisque-2-mr-hathiramani-suresh	Vente De Produits Petroliers Guendel,	\N	1	2026-03-02 23:11:10.704	2026-03-02 23:11:10.704	Vente De Produits Petroliers Guendel,	Bd Maurice Gue ye - Rufisque	77 588 71 71	Rufisque	\N	\N	\N	f	\N
116	Brightpoint Senegal	brightpoint-senegal	Vente Et Distribution De Materiel Informatique Boule vard Djily Mbaye	\N	2	2026-03-02 23:11:10.706	2026-03-02 23:11:10.706	Vente Et Distribution De Materiel Informatique Boule vard Djily Mbaye	Immeuble Azur 15	33 855 86 13	Dakar	\N	\N	\N	f	\N
117	Papex - Sarl (Papeterie Express)	papex-sarl-papeterie-express	Commerce Papeterie Librairie	\N	2	2026-03-02 23:11:10.708	2026-03-02 23:11:10.708	Commerce Papeterie Librairie	Rue Abdou Karim Bourgi	33 849 05 00	Dakar	\N	\N	\N	f	\N
118	Polysen Sa (Polymeres Senegal Sa	polysen-sa-polymeres-senegal-sa	Commerce General	\N	2	2026-03-02 23:11:10.71	2026-03-02 23:11:10.71	Commerce General	Avenue Leopold Sedar Senghor	33 849 63 63	Dakar	\N	\N	\N	f	\N
119	Prodas Sarl	prodas-sarl	Vente D'Aliments Et Poussins Village De Toglou Cr De Diass 0 Dakar Air Liquide Senegal - Sa (Ex Segoa ,Ste Senegalaise D'Oxygene Et D'Acetylene) Production Et Distribution De Gaz	\N	1	2026-03-02 23:11:10.712	2026-03-02 23:11:10.712	Vente D'Aliments Et Poussins Village De Toglou Cr De Diass 0 Dakar Air Liquide Senegal - Sa (Ex Segoa ,Ste Senegalaise D'Oxygene Et D'Acetylene) Production Et Distribution De Gaz	Bccd	33 821 33 45	Mbour	\N	\N	\N	f	\N
120	Station Shell Liberte 5 (Ndeye Bafou Tounkara)	station-shell-liberte-5-ndeye-bafou-tounkara	Vente De Produits Petroliers (Station D'Essence) Sicap Liberte 5 Terminus Select 33824 09 44 Dakar Nocimex - Sarl (Nouvelle Compagnie D'Import Et D'Exportation) Commerce General	\N	1	2026-03-02 23:11:10.713	2026-03-02 23:11:10.713	Vente De Produits Petroliers (Station D'Essence) Sicap Liberte 5 Terminus Select 33824 09 44 Dakar Nocimex - Sarl (Nouvelle Compagnie D'Import Et D'Exportation) Commerce General	Route De Rufisque	33 849 30 30	Dakar	\N	\N	\N	f	\N
121	Eurogerm Senegal Achat Et	eurogerm-senegal-achat-et	Vente Produits Boulangerie	\N	2	2026-03-02 23:11:10.715	2026-03-02 23:11:10.715	Vente Produits Boulangerie	Rue Mousse Diop	33 821 83 85	Dakar	\N	\N	\N	f	\N
122	Bull Senegal - Sarl	bull-senegal-sarl	Services Informatiques - Maintenance - Vente Materiels Informatiques - Services Divers	\N	2	2026-03-02 23:11:10.717	2026-03-02 23:11:10.717	Services Informatiques - Maintenance - Vente Materiels Informatiques - Services Divers	Avenue Andre Peytavin	33 824 70 96	Dakar	\N	\N	\N	f	\N
123	Papa Abdoul Aziz Dieng	papa-abdoul-aziz-dieng	Commerce General Import- Export Sicap Dieuppeul Vill a N° 2894 B 0 Dakar Epc Senegal - Sa ( Ex Senegalex (Ste Senegalaise D'Explosifs) Vente D'Explosifs - Accessoires De Tirs Et Fabrication Nitrate Fuel	\N	2	2026-03-02 23:11:10.719	2026-03-02 23:11:10.719	Commerce General Import- Export Sicap Dieuppeul Vill a N° 2894 B 0 Dakar Epc Senegal - Sa ( Ex Senegalex (Ste Senegalaise D'Explosifs) Vente D'Explosifs - Accessoires De Tirs Et Fabrication Nitrate Fuel	Avenue Bourguiba X Rue 13 Castors 1	33 869 39 00	Dakar	\N	\N	\N	f	\N
124	Polyethylene Senegal - Sarl Industrie Du Plastique (Sachets - Films - Feuilles Et Gaines En	polyethylene-senegal-sarl-industrie-du-plastique-sachets-films-feuilles-et-gaines-en	Commerce)	\N	2	2026-03-02 23:11:10.721	2026-03-02 23:11:10.721	Commerce)	Bccd X Rue 6	33 864 29 55	Dakar	\N	\N	\N	f	\N
125	Burotic Diffusion - Sarl Autres	burotic-diffusion-sarl-autres	Commerces - Ventes Materiel Informatique - Reparations	\N	2	2026-03-02 23:11:10.722	2026-03-02 23:11:10.722	Commerces - Ventes Materiel Informatique - Reparations	Avenue Albert Sarraut	33 832 04 41	Dakar	\N	\N	\N	f	\N
126	Entreprise Activité Adresse Téléphone Kaolack El Hadj Ousmane Diongue	entreprise-activite-adresse-telephone-kaolack-el-hadj-ousmane-diongue	Commerce	\N	2	2026-03-02 23:11:10.724	2026-03-02 23:11:10.724	Commerce	Rue Daloa Leona Kaolack 776370957 Kaolack Medinatoul Mounaw Ara - Sarl Commerce En Face Marche Zinc Leona 0 Dakar Elimane Abou Lame Commerce Sicap Liberte 5 Villa 5492 0 Dakar T.M.S Suarl F(Telecommunication Marketing Services) Commerce Ouagou Niayes 2 N° 8	33 821 25 27	Ville	\N	\N	\N	f	\N
127	La Pirogue Bleue - Sarl Achat -	la-pirogue-bleue-sarl-achat	Vente - Export De Pdts De La Mer	\N	2	2026-03-02 23:11:10.726	2026-03-02 23:11:10.726	Vente - Export De Pdts De La Mer	Bccd	33 825 05 50	Dakar	\N	\N	\N	f	\N
128	Batimat - Sarl Autres	batimat-sarl-autres	Commerce - Ventes Carreaux - Sanitaires - Etancheite	\N	2	2026-03-02 23:11:10.728	2026-03-02 23:11:10.728	Commerce - Ventes Carreaux - Sanitaires - Etancheite	Avenue Malick Sy - A Cote De "Colis Postaux" (Ex Immeublerue Mousse Diop (Ex - Blanchot)	33 855 79 50	Dakar	\N	\N	\N	f	\N
129	Cheikh Dieng	cheikh-dieng	Commerce Ngane Saer 0 Dakar Happy W Orld Suarl - Tradimer Commerce	\N	2	2026-03-02 23:11:10.729	2026-03-02 23:11:10.729	Commerce Ngane Saer 0 Dakar Happy W Orld Suarl - Tradimer Commerce	Avenue Georges Pompidou	33 836 07 42	Kaolack	\N	\N	\N	f	\N
130	Emg (Eminence Motors Garentee )	emg-eminence-motors-garentee	Vente De Vehicules Et Pieces Detachees	\N	2	2026-03-02 23:11:10.731	2026-03-02 23:11:10.731	Vente De Vehicules Et Pieces Detachees	Avenue Fahd Ben Abdel Aziz Echangeur Hann X Autoroute Dakar	77 636 80 75	Dakar	\N	\N	\N	f	\N
131	Neurotech Senegal	neurotech-senegal	Commerce	\N	2	2026-03-02 23:11:10.732	2026-03-02 23:11:10.732	Commerce	Bd Du Sud Point E	33 822 59 88	Dakar	\N	\N	\N	f	\N
132	Myna	myna	Distribution Technologies Sa Commerce	\N	2	2026-03-02 23:11:10.734	2026-03-02 23:11:10.734	Distribution Technologies Sa Commerce	Rue Jules Ferry 3ème Etage	33 842 80 74	Dakar	\N	\N	\N	f	\N
133	Djiby Mboup	djiby-mboup	Commerce Marche Thiaroye 0 Dakar Comptoir De Distribution De Materiaux Sarl Commerce De Metaux - Import Export	\N	2	2026-03-02 23:11:10.735	2026-03-02 23:11:10.735	Commerce Marche Thiaroye 0 Dakar Comptoir De Distribution De Materiaux Sarl Commerce De Metaux - Import Export	Bccd, Rond Point Scoa Fann Rocade	33 867 54 44	Pikine	\N	\N	\N	f	\N
134	Cfao Equipement Senegal	cfao-equipement-senegal	Commerce De Vehicules	\N	2	2026-03-02 23:11:10.737	2026-03-02 23:11:10.737	Commerce De Vehicules	Bccd	33 832 14 00	Dakar	\N	\N	\N	f	\N
135	Nsic Sarl (Nouvelle Societe D'Industrie Et De	nsic-sarl-nouvelle-societe-d-industrie-et-de	Commerce) Fabrique Et Vente De Matelas En Mousse Polyurethane Souple	\N	2	2026-03-02 23:11:10.739	2026-03-02 23:11:10.739	Commerce) Fabrique Et Vente De Matelas En Mousse Polyurethane Souple	Route De Rufisque - Diamaguene	33 849 77 33	Dakar	\N	\N	\N	f	\N
136	Sofica - Sa	sofica-sa	Vente De Produits Siderurgiques	\N	2	2026-03-02 23:11:10.741	2026-03-02 23:11:10.741	Vente De Produits Siderurgiques	Bccd	33 834 08 86	Dakar	\N	\N	\N	f	\N
137	Station Oilibya Rte Rufisque (Modou Mbacke Ndoye)	station-oilibya-rte-rufisque-modou-mbacke-ndoye	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:10.742	2026-03-02 23:11:10.742	Vente De Produits Petroliers	Route De Rufisque 0 Rufisque Ndaw Ene Commerce Industrie - Sa Vente De Marchandises Garage De Bargny	33 832 52 00	Dakar	\N	\N	\N	f	\N
138	Delta Medical - Sarl	delta-medical-sarl	Commerce Materiel Medical	\N	2	2026-03-02 23:11:10.746	2026-03-02 23:11:10.746	Commerce Materiel Medical	Rue Mousse Diop (Ex - Blan chot)	33 836 07 42	Dakar	\N	\N	\N	f	\N
139	Sarl Plastique Moderne	sarl-plastique-moderne	Fabrication - Transformation - Vente Objets Plastiques	\N	2	2026-03-02 23:11:10.748	2026-03-02 23:11:10.748	Fabrication - Transformation - Vente Objets Plastiques	Bccd	33 822 30 37	Dakar	\N	\N	\N	f	\N
140	Station Total Bourguiba (Gueth Diagne)	station-total-bourguiba-gueth-diagne	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.756	2026-03-02 23:11:10.756	Vente De Produits Petroliers (Station D'Essence)	Avenue Bourguiba	33 864 49 65	Dakar	\N	\N	\N	f	\N
141	Shell Rue 37 X Blaise Diagne (Khady Diop Sow )	shell-rue-37-x-blaise-diagne-khady-diop-sow	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.761	2026-03-02 23:11:10.761	Vente De Produits Petroliers (Station D'Essence)	Rue 37 X Blaise Diagne 33822 06 90 Dakar Station Shell Arafat (Fatou Kine Ndiaye) Vente De Produits Petroliers (Station D'Essence) Grand-Yoff Avenue Mgr Thiandoum	33 868 23 86	Dakar	\N	\N	\N	f	\N
142	Total Khar Yallah (Bassirou Ba)	total-khar-yallah-bassirou-ba	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.766	2026-03-02 23:11:10.766	Vente De Produits Petroliers (Station D'Essence)	Route Du Front De Terre	33 823 15 42	Dakar	\N	\N	\N	f	\N
144	Bakhal Sarl	bakhal-sarl	Commerce Villa N° 1090	\N	2	2026-03-02 23:11:10.776	2026-03-02 23:11:10.776	Commerce Villa N° 1090	Rue 10 Pikine Sud	77 633 88 29	Pikine	\N	\N	\N	f	\N
145	Equip Plus - Sa	equip-plus-sa	Vente De Materiels Agricoles - Industriels - Scolaires	\N	2	2026-03-02 23:11:10.78	2026-03-02 23:11:10.78	Vente De Materiels Agricoles - Industriels - Scolaires	Bccd	33 854 27 80	Dakar	\N	\N	\N	f	\N
146	Etc (Ezal Trading Company)	etc-ezal-trading-company	Commerce General	\N	2	2026-03-02 23:11:10.784	2026-03-02 23:11:10.784	Commerce General	Avenue Robert Delmas Immeuble Filfili (57 Rue Mousse Diop)	33 832 32 32	Dakar	\N	\N	\N	f	\N
147	Kkb (Holding Keur Khadim) Bpt -	kkb-holding-keur-khadim-bpt	Commerce General - Boulangerie - Mareyeur Pëche - Transport - Gestion	\N	2	2026-03-02 23:11:10.788	2026-03-02 23:11:10.788	Commerce General - Boulangerie - Mareyeur Pëche - Transport - Gestion	Immobiliere Bccd X Rue 3	33 842 41 32	Dakar	\N	\N	\N	f	\N
148	Fermon Labo Senegal - Sa	fermon-labo-senegal-sa	Commerce	\N	2	2026-03-02 23:11:10.792	2026-03-02 23:11:10.792	Commerce	Avenue Jean Jaures	33 834 02 25	Dakar	\N	\N	\N	f	\N
149	Depot Gaz De Pikine (Ndeye Khadidiatou Diallo)	depot-gaz-de-pikine-ndeye-khadidiatou-diallo	Distribution De Gaz (Depositaire De Gaz) Pikine 0 Dakar Bois Fer Trading Vente De Bois Front De Terre A Cote	\N	1	2026-03-02 23:11:10.797	2026-03-02 23:11:10.797	Distribution De Gaz (Depositaire De Gaz) Pikine 0 Dakar Bois Fer Trading Vente De Bois Front De Terre A Cote	Immeuble Milick Oumar Ndiaye	33 822 61 46	Pikine	\N	\N	\N	f	\N
150	Epc Senegal Sa (Ex Nitrokemfor Senegal)	epc-senegal-sa-ex-nitrokemfor-senegal	Commerce General	\N	2	2026-03-02 23:11:10.804	2026-03-02 23:11:10.804	Commerce General	Route De L'Aeroport - Lot N° 82 Ngor Almadies (Ex_Avenue Bourguiba X Rue 13 Castors 1	33 832 66 00	Dakar	\N	\N	\N	f	\N
151	Hind Metal Sarl	hind-metal-sarl	Commerce General Scat Urbam Villa N° B-64 0 Thies Station Oilibya(Lamine Mbodj Vente De Produits Petroliers (Station D'Essence) Thies None	\N	1	2026-03-02 23:11:10.81	2026-03-02 23:11:10.81	Commerce General Scat Urbam Villa N° B-64 0 Thies Station Oilibya(Lamine Mbodj Vente De Produits Petroliers (Station D'Essence) Thies None	Route De Polytechnique De Thies	33 869 13 44	Dakar	\N	\N	\N	f	\N
152	Etablissements Le Cayor Import-Export	etablissements-le-cayor-import-export	Commerce Fass Casier N° 54 0 Dakar Senevet - Sarl Distribution De Pdts Pharmaceutiques Veterinaires Derkle	\N	2	2026-03-02 23:11:10.815	2026-03-02 23:11:10.815	Commerce Fass Casier N° 54 0 Dakar Senevet - Sarl Distribution De Pdts Pharmaceutiques Veterinaires Derkle	Rue 3 * Z - Villa N° 1	33 951 02 90	Dakar	\N	\N	\N	f	\N
153	Entreprise Activité Adresse Téléphone Saint-Louis Station Oilibya (Babacar Dieye)	entreprise-activite-adresse-telephone-saint-louis-station-oilibya-babacar-dieye	Commerce De Produits Petroliers En Face Dispensaire	\N	1	2026-03-02 23:11:10.822	2026-03-02 23:11:10.822	Commerce De Produits Petroliers En Face Dispensaire	Route De Khor - Sor	33 824 70 87	Ville	\N	\N	\N	f	\N
154	Etablissement Touba Darou Salam(Thierno Diop)	etablissement-touba-darou-salam-thierno-diop	Commerce General Marche Central De Thies 776398790 Dakar Ndiakhate Ndiassane	\N	2	2026-03-02 23:11:10.831	2026-03-02 23:11:10.831	Commerce General Marche Central De Thies 776398790 Dakar Ndiakhate Ndiassane	(Abdoulaye Diakhate) Commerce Import-Export Rue 6 X Bd Gueule Tapee	33 961 13 59	Thies	\N	\N	\N	f	\N
155	Station Total Diamniadio (Mouhamadou W Adj)	station-total-diamniadio-mouhamadou-w-adj	Vente De Produits Petroliers (Station D'Essence) Ent ree Diamniadio 0 Dakar Computer Land Vente De Materiels Informatiques	\N	1	2026-03-02 23:11:10.838	2026-03-02 23:11:10.838	Vente De Produits Petroliers (Station D'Essence) Ent ree Diamniadio 0 Dakar Computer Land Vente De Materiels Informatiques	Avenue Andre Peytav in	77 640 22 10	Rufisque	\N	\N	\N	f	\N
156	Bonte Senegal (Succursale De Bagadiya - Brothers Pvt Ltd)	bonte-senegal-succursale-de-bagadiya-brothers-pvt-ltd	Commerce General 14 Bis	\N	2	2026-03-02 23:11:10.845	2026-03-02 23:11:10.845	Commerce General 14 Bis	Rue Berengerv Ferraud X Rue Carnot Appt 2 Em	33 849 53 99	Dakar	\N	\N	\N	f	\N
157	Omega 3 Sa	omega-3-sa	Commerce General	\N	2	2026-03-02 23:11:10.851	2026-03-02 23:11:10.851	Commerce General	Route De Rufisque	33 832 43 11	Dakar	\N	\N	\N	f	\N
158	Ts - Sarl - (Technologies	ts-sarl-technologies	Services) Representation Et Distribution De Materiels De Laboratoire : Reactifs, Consommables	\N	2	2026-03-02 23:11:10.858	2026-03-02 23:11:10.858	Services) Representation Et Distribution De Materiels De Laboratoire : Reactifs, Consommables	Rue Aime Cesair Fann Residence	33 832 92 00	Dakar	\N	\N	\N	f	\N
330	Societe Aimex Sarl Exportation Et	societe-aimex-sarl-exportation-et	Ventes De Marchandises	\N	2	2026-03-02 23:11:11.271	2026-03-02 23:11:11.271	Ventes De Marchandises	Rue Paul Holle	33 823 21 00	Dakar	\N	\N	\N	f	\N
331	L'Habitat Sarl	l-habitat-sarl	Commerce De Materiaux De Constructions	\N	2	2026-03-02 23:11:11.273	2026-03-02 23:11:11.273	Commerce De Materiaux De Constructions	Rue Felix Ebo ue	33 945 85 35	Dakar	\N	\N	\N	f	\N
332	Midis Midadi	midis-midadi	Distribution Commerce	\N	2	2026-03-02 23:11:11.275	2026-03-02 23:11:11.275	Distribution Commerce	Rue Amadou Lakhane Ndoye (Ex 36 Rue Raffenel X Grasland)	33 842 89 37	Dakar	\N	\N	\N	f	\N
333	Dioubo -Sarl	dioubo-sarl	Commerce Thor Djender - Thies 0 Dakar Senegalaise De Fournitures Services Achats Et Ventes De Marchandises 15,	\N	2	2026-03-02 23:11:11.277	2026-03-02 23:11:11.277	Commerce Thor Djender - Thies 0 Dakar Senegalaise De Fournitures Services Achats Et Ventes De Marchandises 15,	Rue Tolbiac X E scarfait 0 Dakar Agropharm Suarl Vente De Produits Phytosanitaires Ngor Virage	33 823 15 87	Thies	\N	\N	\N	f	\N
334	Ets Diagne Et Freres (Assane Diagne)	ets-diagne-et-freres-assane-diagne	Commerce De Pieces Detachees	\N	2	2026-03-02 23:11:11.279	2026-03-02 23:11:11.279	Commerce De Pieces Detachees	Rue Marsat 33823 06 08 Dakar Super Ceramique Carreaux Sanitaires Sarl Commerce / Vente De Carreaux, Sanitaire, Avenue Yaci nth Thiandoume Grand Yoff Arafat	33 855 96 44	Dakar	\N	\N	\N	f	\N
335	Mobicom - Sa (Mobilier Et Communication)	mobicom-sa-mobilier-et-communication	Commerce Import/Export De Mobilier	\N	2	2026-03-02 23:11:11.281	2026-03-02 23:11:11.281	Commerce Import/Export De Mobilier	Rue Aristide Le D antec	77 655 29 69	Dakar	\N	\N	\N	f	\N
336	2 Mdg Sarl	2-mdg-sarl	Commerce General Cite	\N	2	2026-03-02 23:11:11.283	2026-03-02 23:11:11.283	Commerce General Cite	Immorama Hann Maristes	33 842 07 77	Dakar	\N	\N	\N	f	\N
337	Soma Sarl	soma-sarl	Commerce General	\N	2	2026-03-02 23:11:11.285	2026-03-02 23:11:11.285	Commerce General	Quartier Commercial Tivaouane 0 Ville Entreprise Activité Adresse Téléphone Dakar Etaperu A.O - Sa Commerce Pieces De Vehicules - Materiel Industriel - Ateliers Bccd	33 832 26 26	Tivaouane	\N	\N	\N	f	\N
338	Ntl Sarl	ntl-sarl	Commerce	\N	2	2026-03-02 23:11:11.288	2026-03-02 23:11:11.288	Commerce	Route De Rufisque	33 831 00 77	Dakar	\N	\N	\N	f	\N
339	Dees (Dakar Express Equipement Et	dees-dakar-express-equipement-et	Services) Sarl Commerce General	\N	2	2026-03-02 23:11:11.29	2026-03-02 23:11:11.29	Services) Sarl Commerce General	Rue 2 Bis X Bourguiba	33 832 92 85	Dakar	\N	\N	\N	f	\N
340	Armena - Sa (Art Menager)	armena-sa-art-menager	Commerce Import Export	\N	2	2026-03-02 23:11:11.293	2026-03-02 23:11:11.293	Commerce Import Export	Avenue Lamine Gueye	33 842 40 20	Dakar	\N	\N	\N	f	\N
341	Etablissements Tirera Et Fils Sarl	etablissements-tirera-et-fils-sarl	Commerce	\N	2	2026-03-02 23:11:11.295	2026-03-02 23:11:11.295	Commerce	Route Nationale N°1 Richard-Toll	33 859 01 60	Richard-Toll	\N	\N	\N	f	\N
342	Quincaillerie Gaffari Et Fils - Sarl	quincaillerie-gaffari-et-fils-sarl	Commerce Quincaillerie	\N	2	2026-03-02 23:11:11.297	2026-03-02 23:11:11.297	Commerce Quincaillerie	Rue Malick Sy - Mbour	77 634 36 73	Mbour	\N	\N	\N	f	\N
343	Pres High Tech Sarl	pres-high-tech-sarl	Vente Fournitures De Bureau	\N	2	2026-03-02 23:11:11.299	2026-03-02 23:11:11.299	Vente Fournitures De Bureau	Route Du Front De Terre X Avenue Bourguiba, Cators	33 957 37 21	Dakar	\N	\N	\N	f	\N
344	Codex Sarl	codex-sarl	Commerce	\N	2	2026-03-02 23:11:11.301	2026-03-02 23:11:11.301	Commerce	Route Des Ics Mbao (Bur 40 Av Jean Jaures X Carnot Dkr)	33 957 30 56	Dakar	\N	\N	\N	f	\N
345	Smps / Societe Moderne De Pneumatique Senegalaise (Ex Scms Sa = Ste Commercialisation Michelin	smps-societe-moderne-de-pneumatique-senegalaise-ex-scms-sa-ste-commercialisation-michelin	Commerce De Pneumatiques - Importation Et Revente En Gros	\N	2	2026-03-02 23:11:11.303	2026-03-02 23:11:11.303	Commerce De Pneumatiques - Importation Et Revente En Gros	Bccd	33 853 09 21	Dakar	\N	\N	\N	f	\N
346	Mor Ndiaye	mor-ndiaye	Commerce General	\N	2	2026-03-02 23:11:11.305	2026-03-02 23:11:11.305	Commerce General	Avenue Lamine Gueye	33 849 30 70	Dakar	\N	\N	\N	f	\N
347	Tqg - Sarl (Touba Quincaillerie Generale)	tqg-sarl-touba-quincaillerie-generale	Commerce	\N	2	2026-03-02 23:11:11.308	2026-03-02 23:11:11.308	Commerce	Bccd	33 869 24 69	Dakar	\N	\N	\N	f	\N
348	Balton W Est Africa Sa Autre	balton-w-est-africa-sa-autre	Commerce	\N	2	2026-03-02 23:11:11.309	2026-03-02 23:11:11.309	Commerce	Route De L4Aeroport Carrefour Ngor Lo t N° 80	33 832 44 91	Dakar	\N	\N	\N	f	\N
349	Gee Sarl (Generale D'Equipement D'Entreprise )	gee-sarl-generale-d-equipement-d-entreprise	Vente Verre - Aluminium - Accessoires	\N	2	2026-03-02 23:11:11.312	2026-03-02 23:11:11.312	Vente Verre - Aluminium - Accessoires	Rue Bentenier - Fass Delorme	33 820 03 45	Dakar	\N	\N	\N	f	\N
350	Station Total Linguere(Fode Kamissokho)	station-total-linguere-fode-kamissokho	Vente De Produits Petroliers (Station D'Essence) Allee Linguere 775241837 Dakar Pharmacie Pasteur Vente De Produits Pharmaceutiques	\N	1	2026-03-02 23:11:11.314	2026-03-02 23:11:11.314	Vente De Produits Petroliers (Station D'Essence) Allee Linguere 775241837 Dakar Pharmacie Pasteur Vente De Produits Pharmaceutiques	Avenue Pasteur - S tation Shell	33 842 61 81	Linguere	\N	\N	\N	f	\N
351	Epicerie Du Coin (Elie Mejaes Chouery Et Fils)	epicerie-du-coin-elie-mejaes-chouery-et-fils	Commerce General Alimentaire	\N	2	2026-03-02 23:11:11.316	2026-03-02 23:11:11.316	Commerce General Alimentaire	Avenue Malick Sy - Esca le - Mbour	33 821 70 35	Mbour	\N	\N	\N	f	\N
352	Ftf (Full Technologies Formations)	ftf-full-technologies-formations	Services Informatiques (Vente De Logiciels) Fan Mermoz Fn08 X Cheikh Anta	\N	2	2026-03-02 23:11:11.318	2026-03-02 23:11:11.318	Services Informatiques (Vente De Logiciels) Fan Mermoz Fn08 X Cheikh Anta	Diop(Rue Mousse Diop - Immeuble Bits	33 957 10 25	Dakar	\N	\N	\N	f	\N
353	Sensec - Sarl (Senegal Securite) Securite Navire -	sensec-sarl-senegal-securite-securite-navire	Ventes Materiels Produits Piscine	\N	2	2026-03-02 23:11:11.32	2026-03-02 23:11:11.32	Ventes Materiels Produits Piscine	Route Des Grands Moulins X Avenue Felix Eboue - Face Ecole Mermoz	33 864 27 27	Dakar	\N	\N	\N	f	\N
354	Setabllissements Alaska Sarl	setabllissements-alaska-sarl	Commerce	\N	2	2026-03-02 23:11:11.322	2026-03-02 23:11:11.322	Commerce	Quartier Leona	33 832 07 72	Kaolack	\N	\N	\N	f	\N
178	Aarti Steel Senegal - Sa	aarti-steel-senegal-sa	Commerce General Zone Industrielle 3	\N	2	2026-03-02 23:11:10.943	2026-03-02 23:11:10.943	Commerce General Zone Industrielle 3	Rue 4 Km 3,5 Bccd0	33 832 11 77	Dakar	\N	\N	\N	f	\N
179	Godicom Sarl	godicom-sarl	Distribution De Boissons	\N	2	2026-03-02 23:11:10.945	2026-03-02 23:11:10.945	Distribution De Boissons	Avenue Lamine Gueye	33 832 62 24	Dakar	\N	\N	\N	f	\N
180	Pharmacie Du Plateau - Sau	pharmacie-du-plateau-sau	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:10.947	2026-03-02 23:11:10.947	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e	33 822 27 41	Dakar	\N	\N	\N	f	\N
181	Touba Niambour	touba-niambour	Commerce	\N	2	2026-03-02 23:11:10.949	2026-03-02 23:11:10.949	Commerce	Avenue Amadou Barro Ndieguene 0 Dakar Cempa - Sarl (Centrale D'Emballage Et De Papier) Import Export - Vente D'Emballages Et De Papiers Rue Carnot	76 831 19 02	Thies	\N	\N	\N	f	\N
182	Polyplast Sarl Transformation Produits Plastiques Et	polyplast-sarl-transformation-produits-plastiques-et	Commerce General	\N	2	2026-03-02 23:11:10.951	2026-03-02 23:11:10.951	Commerce General	Route De Rufisque 77 58 70 24 Ville Entreprise Activité Adresse Téléphone Dakar Platform Technologies Sa Commerce Materiel Informatique - Maintenance Materiel Informatique Sicap Amitie 1 X Av. Bourguiba Villa N° 3086 33 869 0140 Pikine Franvasco Import Export Sarl Vente Des Produits En Cuir Quartier Cheikh Kane - Gr and Mbao	33 951 30 30	Dakar	\N	\N	\N	f	\N
183	Station Total Route De Saint-Louis Thies (Mamadou Sarr)	station-total-route-de-saint-louis-thies-mamadou-sarr	Vente De Produits Petroliers Total	\N	1	2026-03-02 23:11:10.953	2026-03-02 23:11:10.953	Vente De Produits Petroliers Total	Route De Saint- L ouis Thies	33 889 79 40	Thies	\N	\N	\N	f	\N
184	Gatkom Limited Sarl	gatkom-limited-sarl	Commerce Ponit E	\N	2	2026-03-02 23:11:10.955	2026-03-02 23:11:10.955	Commerce Ponit E	Rue X De Kaolack 707492591 Saint-Louis Station Service Total (Pierre Poggio) Commerce De Produits Petroliers Total Charles De Gau lle 0 Matam Ste Diene Et Freres Matam Commerce Place Du Marche Matam	33 952 12 13	Dakar	\N	\N	\N	f	\N
185	Aye Societe Mame Ngounta Diop	aye-societe-mame-ngounta-diop	Commerce	\N	2	2026-03-02 23:11:10.957	2026-03-02 23:11:10.957	Commerce	Quartier Thione Samb Plle N° 519 - Guediaw Aye	33 836 00 52	Guediaw	\N	\N	\N	f	\N
186	Simpa Equipement Achat,	simpa-equipement-achat	Vente & Reparation De Machines De Conditionnement	\N	2	2026-03-02 23:11:10.959	2026-03-02 23:11:10.959	Vente & Reparation De Machines De Conditionnement	Route De Rufisque	77 515 53 38	Dakar	\N	\N	\N	f	\N
187	Pramac Lifter Afrique Trading - Sarl Negoce -	pramac-lifter-afrique-trading-sarl-negoce	Commerce Groupes Electrogenes - Transplettes Gerbeuf - Machines De Sondages Et Accessoires	\N	2	2026-03-02 23:11:10.961	2026-03-02 23:11:10.961	Commerce Groupes Electrogenes - Transplettes Gerbeuf - Machines De Sondages Et Accessoires	Route De L'Aeroport X Vdn (Ex 24 Rue Felix Eboue)	33 834 39 39	Dakar	\N	\N	\N	f	\N
188	W Imex (W Orld Import Export : Papa Alioune Thiam)	w-imex-w-orld-import-export-papa-alioune-thiam	Commerce General Fass Marigot 0 Dakar Ets Maleye Sarl Commerce Divers	\N	2	2026-03-02 23:11:10.963	2026-03-02 23:11:10.963	Commerce General Fass Marigot 0 Dakar Ets Maleye Sarl Commerce Divers	Avenue Lamine Gueye	33 869 31 21	Dakar	\N	\N	\N	f	\N
189	W Orld Vision Sn - Suarl	w-orld-vision-sn-suarl	Commerce Export	\N	2	2026-03-02 23:11:10.968	2026-03-02 23:11:10.968	Commerce Export	Bccd 0 Dakar Station Service Tall Entreprises Vente De Produits Petroliers (Station D'Essence) Patte D'Oies Builders	33 889 64 04	Dakar	\N	\N	\N	f	\N
190	Station Total Keury Kao (Nakhass Sene)	station-total-keury-kao-nakhass-sene	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.971	2026-03-02 23:11:10.971	Vente De Produits Petroliers (Station D'Essence)	Bd Maurice Gueye Keury Kao	77 567 33 03	Rufisque	\N	\N	\N	f	\N
191	Digital Planet Lamine Gueye Sarl	digital-planet-lamine-gueye-sarl	Commerce Electromenager	\N	2	2026-03-02 23:11:10.974	2026-03-02 23:11:10.974	Commerce Electromenager	Avenue President Lamine Guey e	33 836 11 48	Dakar	\N	\N	\N	f	\N
192	Senemeca - Sa Entretien Reparation De Machines Et D'Automobiles - Mecanique Generale -	senemeca-sa-entretien-reparation-de-machines-et-d-automobiles-mecanique-generale	Commerces Pieces Detachees - Travaux Des Metaux (Usinage Pieces)	\N	2	2026-03-02 23:11:10.976	2026-03-02 23:11:10.976	Commerces Pieces Detachees - Travaux Des Metaux (Usinage Pieces)	Rue Felix Eboue	33 849 59 49	Dakar	\N	\N	\N	f	\N
193	Ngom & Freres Sarl Import-Export -	ngom-freres-sarl-import-export	Vente Equipement De Peche	\N	2	2026-03-02 23:11:10.978	2026-03-02 23:11:10.978	Vente Equipement De Peche	Rue 2 Bis X Avenue Bourguiba	33 832 88 18	Dakar	\N	\N	\N	f	\N
194	Aye Station	aye-station	Service Oilibya Golf (Afrane Dione) Vente De Produits Petroliers (Station D'Essence) Sta tion Service Oilibya Golf 0 Dakar Senogano Cct Dakar - Sarl Commerce Materiel De Pêche - Import/Export	\N	1	2026-03-02 23:11:10.98	2026-03-02 23:11:10.98	Service Oilibya Golf (Afrane Dione) Vente De Produits Petroliers (Station D'Essence) Sta tion Service Oilibya Golf 0 Dakar Senogano Cct Dakar - Sarl Commerce Materiel De Pêche - Import/Export	Avenue Ge orges Pompidou	33 842 40 20	Guediaw	\N	\N	\N	f	\N
195	Chocosen Chocolaterie (52,25%) Autres	chocosen-chocolaterie-52-25-autres	Commerces (47,75%)	\N	2	2026-03-02 23:11:10.982	2026-03-02 23:11:10.982	Commerces (47,75%)	Bccd X Rue 4	33 822 47 47	Dakar	\N	\N	\N	f	\N
196	Espace Sope Naby	espace-sope-naby	Commerce	\N	2	2026-03-02 23:11:10.984	2026-03-02 23:11:10.984	Commerce	Avenue Leopold Sedar Senghor	33 877 75 98	Thies	\N	\N	\N	f	\N
197	Pico Mega - Fatou Seck	pico-mega-fatou-seck	Vente De Materiel Et Consommables Informatiques	\N	2	2026-03-02 23:11:10.989	2026-03-02 23:11:10.989	Vente De Materiel Et Consommables Informatiques	Avenue Blaise Diagne En Face Centre Culturel Douta Seck 0 Dakar Sotelmed Sa Vente De Materiels Medical & Services Afferents Rue Jules Ferry	70 100 54 80	Dakar	\N	\N	\N	f	\N
198	Station Total Km 14 (Adrienne Sarr Semedo)	station-total-km-14-adrienne-sarr-semedo	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.991	2026-03-02 23:11:10.991	Vente De Produits Petroliers (Station D'Essence)	Route De Rufisque	33 951 30 71	Dakar	\N	\N	\N	f	\N
199	Aye Station Total Guediaw Aye (Issa Diene)	aye-station-total-guediaw-aye-issa-diene	Vente De Produits Petroliers (Station D'Essence) En Face Ecole Canada 0 Dakar Station Total Centenaire Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:10.994	2026-03-02 23:11:10.994	Vente De Produits Petroliers (Station D'Essence) En Face Ecole Canada 0 Dakar Station Total Centenaire Vente De Produits Petroliers (Station D'Essence)	Bdl De Gaulle Centenaire 0 Dakar Cct Sarl (Comptoir Commercial Telecommunication Sarl) Commerce Usine Bene Tally	33 834 75 73	Guediaw	\N	\N	\N	f	\N
200	Station	station	Service Olibya Golf Vente De Produits Petroliers Golf 0 Saint-Louis Hometech Sa (Home Technologie Sa) Commerce General	\N	1	2026-03-02 23:11:10.998	2026-03-02 23:11:10.998	Service Olibya Golf Vente De Produits Petroliers Golf 0 Saint-Louis Hometech Sa (Home Technologie Sa) Commerce General	Bccd Rue N° 2	33 835 97 57	Dakar	\N	\N	\N	f	\N
201	Madeleine Diagne	madeleine-diagne	Commerce	\N	2	2026-03-02 23:11:11.001	2026-03-02 23:11:11.001	Commerce	Rue Dr Guillet Aiglon 0 Mbour Sdds (Elton Mbour) Commerce General Oncad 0 Louga Societe Dabakh Malick Suarl Commerce General Marche Central Dahra Djoloff Louga 0 Rufisque Babacar Mbow Vente De Carburant Keury Kao	33 941 21 84	Thies	\N	\N	\N	f	\N
202	Orkila Senegal Sa	orkila-senegal-sa	Commerce General Point E	\N	2	2026-03-02 23:11:11.006	2026-03-02 23:11:11.006	Commerce General Point E	Rue 3 ,Angle C	77 569 27 72	Dakar	\N	\N	\N	f	\N
203	Global Trades	global-trades	Services Suarl Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:11.009	2026-03-02 23:11:11.009	Services Suarl Commerce De Marchandises Diverses	Rue Galandou Diouf	33 825 50 51	Dakar	\N	\N	\N	f	\N
204	Soseca - Sarl (Societe Senegalaise Des Centrales D'Achat (Ex Pridoux Sarl))	soseca-sarl-societe-senegalaise-des-centrales-d-achat-ex-pridoux-sarl	Commerce General	\N	2	2026-03-02 23:11:11.013	2026-03-02 23:11:11.013	Commerce General	Avenue Lamine Gueye X Autoroute	33 832 06 49	Dakar	\N	\N	\N	f	\N
205	Joke- Cool	joke-cool	Vente De Climatiseur Nord Foire Azur 33820 50 18 Ville Entreprise Activité Adresse Téléphone Pikine Succursale Sdem Entreprise Sa Etudes Industrielles - Fabrication - Montage - Conception - Realisation Et Vente De Procedes Ou Pdts Industrielles Keur Mbaye Fall N° 64 -	\N	2	2026-03-02 23:11:11.015	2026-03-02 23:11:11.015	Vente De Climatiseur Nord Foire Azur 33820 50 18 Ville Entreprise Activité Adresse Téléphone Pikine Succursale Sdem Entreprise Sa Etudes Industrielles - Fabrication - Montage - Conception - Realisation Et Vente De Procedes Ou Pdts Industrielles Keur Mbaye Fall N° 64 -	Route De Rufisque	33 889 56 06	Dakar	\N	\N	\N	f	\N
206	Station	station-1	Service Oilibya - Relais (Ibra Ba) Vente De Produits Petroliers (Station D'Essence) Station Service Oilibya Relais	\N	1	2026-03-02 23:11:11.018	2026-03-02 23:11:11.018	Service Oilibya - Relais (Ibra Ba) Vente De Produits Petroliers (Station D'Essence) Station Service Oilibya Relais	Route De Ouakam	33 955 79 93	Dakar	\N	\N	\N	f	\N
207	Ets Babacar Samb & Fils	ets-babacar-samb-fils	Commerce	\N	2	2026-03-02 23:11:11.02	2026-03-02 23:11:11.02	Commerce	Avenue Cheikh Ahmadou Bamba	77 560 44 71	Kaolack	\N	\N	\N	f	\N
208	Import Export Transactions Immobilieres Kss	import-export-transactions-immobilieres-kss	Commerce - Transactions	\N	2	2026-03-02 23:11:11.022	2026-03-02 23:11:11.022	Commerce - Transactions	Immobilieres Yoff - Route De L'Aeroport Cite Lobatt Fall Villa N° 28	33 941 24 04	Dakar	\N	\N	\N	f	\N
209	Silcar - Sa	silcar-sa	Vente Et Location De Vehicules	\N	2	2026-03-02 23:11:11.023	2026-03-02 23:11:11.023	Vente Et Location De Vehicules	Bccd (Ex = 6 Rue Huar t X Le Dantec)	33 842 11 20	Dakar	\N	\N	\N	f	\N
210	Pharmacie De La Mosquee	pharmacie-de-la-mosquee	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.025	2026-03-02 23:11:11.025	Vente De Produits Pharmaceutiques	Rue Mohamed V X Ru e Carnot	33 859 00 80	Dakar	\N	\N	\N	f	\N
211	Ismaila Dia	ismaila-dia	Commerce Marche Tilene Medina 0 Dakar Sarl Maroc Food Commerce	\N	2	2026-03-02 23:11:11.027	2026-03-02 23:11:11.027	Commerce Marche Tilene Medina 0 Dakar Sarl Maroc Food Commerce	Rue Paul Holle	77 545 97 80	Dakar	\N	\N	\N	f	\N
212	Serigne Mboup / Ets Bara Mboup	serigne-mboup-ets-bara-mboup	Commerce General	\N	2	2026-03-02 23:11:11.029	2026-03-02 23:11:11.029	Commerce General	Rue Laprine X Tolbiac	33 842 35 11	Dakar	\N	\N	\N	f	\N
213	Pmi - Sarl (Pieces Materiels Import)	pmi-sarl-pieces-materiels-import	Commerce Pieces Et Materiels - Import/ Export	\N	2	2026-03-02 23:11:11.031	2026-03-02 23:11:11.031	Commerce Pieces Et Materiels - Import/ Export	Avenue Bourguiba	33 824 19 69	Dakar	\N	\N	\N	f	\N
214	Sdmi (La Senegalaise De	sdmi-la-senegalaise-de	Distribution De Materiels Industriels) Vente De Materiels Industriels Bopp	\N	2	2026-03-02 23:11:11.032	2026-03-02 23:11:11.032	Distribution De Materiels Industriels) Vente De Materiels Industriels Bopp	Rue 2 X Casamanc e	33 823 57 50	Dakar	\N	\N	\N	f	\N
215	Serigne Bassirou Diankha	serigne-bassirou-diankha	Commerce	\N	2	2026-03-02 23:11:11.034	2026-03-02 23:11:11.034	Commerce	Quartier Dvf Pikine	33 825 16 36	Pikine	\N	\N	\N	f	\N
216	Richard Equipement - Sa	richard-equipement-sa	Vente De Materils Electriques - D'Onduleurs Et D'Antennes	\N	2	2026-03-02 23:11:11.036	2026-03-02 23:11:11.036	Vente De Materils Electriques - D'Onduleurs Et D'Antennes	Rue Mousse Diop (Ex - Blanchot)	77 630 98 51	Dakar	\N	\N	\N	f	\N
217	La Sirene Sarl	la-sirene-sarl	Vente De Produits Halieutiques	\N	2	2026-03-02 23:11:11.037	2026-03-02 23:11:11.037	Vente De Produits Halieutiques	Bccd	33 822 56 95	Dakar	\N	\N	\N	f	\N
218	Hussein Harb	hussein-harb	Commerce	\N	2	2026-03-02 23:11:11.039	2026-03-02 23:11:11.039	Commerce	Rue Galandou Diouf	33 966 12 75	Dakar	\N	\N	\N	f	\N
219	Simep (Ste International Pour L'Import & Export Produit Divers)	simep-ste-international-pour-l-import-export-produit-divers	Commerce De Fruits	\N	2	2026-03-02 23:11:11.041	2026-03-02 23:11:11.041	Commerce De Fruits	Route De Camberene Pres Des Immeubles Maristes	33 823 83 77	Dakar	\N	\N	\N	f	\N
220	Technimex (Technique De Materiel D'Exploitation)	technimex-technique-de-materiel-d-exploitation	Vente Et Installation De Materiels Electriques	\N	2	2026-03-02 23:11:11.043	2026-03-02 23:11:11.043	Vente Et Installation De Materiels Electriques	Route Du Front De Terre	33 869 66 67	Dakar	\N	\N	\N	f	\N
221	Quality Center Sarl Tele	quality-center-sarl-tele	Services - Tele Vente - Marketing - Communicaton (Centre D'Appel)	\N	2	2026-03-02 23:11:11.045	2026-03-02 23:11:11.045	Services - Tele Vente - Marketing - Communicaton (Centre D'Appel)	Rue De Thann X Bd Djily Mbaye, Immeuble Xeew El	33 824 39 19	Dakar	\N	\N	\N	f	\N
222	Vietsen Industrie Sarl	vietsen-industrie-sarl	Commerce General	\N	2	2026-03-02 23:11:11.047	2026-03-02 23:11:11.047	Commerce General	Rue Marchand X Autoroute Prolongee	33 823 12 46	Dakar	\N	\N	\N	f	\N
223	Ege Entreprise Generale D'Equipement	ege-entreprise-generale-d-equipement	Commerce	\N	2	2026-03-02 23:11:11.049	2026-03-02 23:11:11.049	Commerce	Route Zone Industrielle 0 Kaolack Etablissement El Hadji Ousmane Diongue - Sarl Commerce Rue Marechal Bugeau Leona	33 867 46 44	Dakar	\N	\N	\N	f	\N
224	Station Shell Ads (Aminata Dieng Sarr)	station-shell-ads-aminata-dieng-sarr	Vente De Produits Petroliers (Station D'Essence) Tal ly Boumack X	\N	1	2026-03-02 23:11:11.051	2026-03-02 23:11:11.051	Vente De Produits Petroliers (Station D'Essence) Tal ly Boumack X	Route Des Niayes - Pikine 0 Dakar Cst Group Suarl Vente De Materiels Industriel Ave Lamine Gueye	33 889 16 16	Pikine	\N	\N	\N	f	\N
225	Scaf Sarl (Societe Commerciale Aidara Aidara Et Freres)	scaf-sarl-societe-commerciale-aidara-aidara-et-freres	Commerce	\N	2	2026-03-02 23:11:11.053	2026-03-02 23:11:11.053	Commerce	Avenue Amadou Gnagna Sow	78 164 61 70	Thies	\N	\N	\N	f	\N
226	Les Niayes Sarraut - Mohamed Ali Kochman	les-niayes-sarraut-mohamed-ali-kochman	Vente De Pepinieres De Fruits, Legumes Et Plantes	\N	2	2026-03-02 23:11:11.054	2026-03-02 23:11:11.054	Vente De Pepinieres De Fruits, Legumes Et Plantes	Avenue Albert Sarraut Et Km3 Bccd	33 952 27 52	Dakar	\N	\N	\N	f	\N
227	Ets Loum & Freres	ets-loum-freres	Commerce	\N	2	2026-03-02 23:11:11.056	2026-03-02 23:11:11.056	Commerce	Rue Paul Seugnet	33 823 30 16	Kaolack	\N	\N	\N	f	\N
228	Adp Sarl (Agence De	adp-sarl-agence-de	Distribution De Presse) Distribution De Presse Ecrite Locale Et Internationale	\N	2	2026-03-02 23:11:11.058	2026-03-02 23:11:11.058	Distribution De Presse) Distribution De Presse Ecrite Locale Et Internationale	Bccd	33 941 26 09	Dakar	\N	\N	\N	f	\N
229	Ineo Export Energie	ineo-export-energie	Production Et Distribution D'Energie Blvd Djily Mbay e	\N	1	2026-03-02 23:11:11.059	2026-03-02 23:11:11.059	Production Et Distribution D'Energie Blvd Djily Mbay e	Imm Pinet Laprade 0 Dakar Matelec - Sarl Commerce - Import/Export Rue Mousse Diop (Ex - Blanc hot)	33 832 02 51	Dakar	\N	\N	\N	f	\N
230	Agaz (L'Africaine De Gaz Sa)	agaz-l-africaine-de-gaz-sa	Vente De Gaz	\N	1	2026-03-02 23:11:11.062	2026-03-02 23:11:11.062	Vente De Gaz	Bd Djily Mbaye Immeuble Fahd	33 822 07 68	Dakar	\N	\N	\N	f	\N
231	Modou Cisse	modou-cisse	Commerce En Face Senelec Kaolack 0 Dakar Societe De Distribution D'Importation Et De Service s Commerce	\N	1	2026-03-02 23:11:11.064	2026-03-02 23:11:11.064	Commerce En Face Senelec Kaolack 0 Dakar Societe De Distribution D'Importation Et De Service s Commerce	Rue 21 X 18 Medina 0 Pikine Amadou Sarra Diallo Commerce Thiaroye Sur Mer Villa N° 19	33 821 94 00	Kaolack	\N	\N	\N	f	\N
232	Cosemad (Compagnie Senegalaise Mariama Dieng )	cosemad-compagnie-senegalaise-mariama-dieng	Commerce General - Alimentaire Sacre	\N	2	2026-03-02 23:11:11.066	2026-03-02 23:11:11.066	Commerce General - Alimentaire Sacre	Rue En Face Immeuble Mariama (39 X 22 Medina)	33 834 17 45	Dakar	\N	\N	\N	f	\N
233	Ernest Kastin	ernest-kastin	Vente De Produits Petroliers Mbour 706 305 373 Dakar Ems Senegal Sa (Express Mail Service) Distribution Postale Lot 49 Sodida 33 8690101 Dakar Sdd Sa (Societe Delank Distribution Sa ) Commerce General Dalifort Foirail,	\N	1	2026-03-02 23:11:11.068	2026-03-02 23:11:11.068	Vente De Produits Petroliers Mbour 706 305 373 Dakar Ems Senegal Sa (Express Mail Service) Distribution Postale Lot 49 Sodida 33 8690101 Dakar Sdd Sa (Societe Delank Distribution Sa ) Commerce General Dalifort Foirail,	Route Nationale N° 1 Face Technopole	33 821 83 86	Mbour	\N	\N	\N	f	\N
234	Electronic Corp Sarl	electronic-corp-sarl	Vente De Materiels Electroniques	\N	2	2026-03-02 23:11:11.07	2026-03-02 23:11:11.07	Vente De Materiels Electroniques	Avenue Georges Pomp idou	33 832 86 86	Dakar	\N	\N	\N	f	\N
235	Vision Multimedia	vision-multimedia	Vente De Cartes Telephoniques Rond Point Jet D'Eau -	\N	2	2026-03-02 23:11:11.071	2026-03-02 23:11:11.071	Vente De Cartes Telephoniques Rond Point Jet D'Eau -	Immeuble Liberte Appt 36	77 324 41 36	Dakar	\N	\N	\N	f	\N
236	Station Mobil Faidherbe - Charles Sagna	station-mobil-faidherbe-charles-sagna	Vente De Produits Petroliers (Station D'Essence) Sta tion Mobil Faidherbe * Blaise Diagne 0 Dakar Ibrahima Fall Commerce	\N	1	2026-03-02 23:11:11.073	2026-03-02 23:11:11.073	Vente De Produits Petroliers (Station D'Essence) Sta tion Mobil Faidherbe * Blaise Diagne 0 Dakar Ibrahima Fall Commerce	Boulevard De La Liberation	33 825 72 90	Dakar	\N	\N	\N	f	\N
237	Elie Choueri - Sarl	elie-choueri-sarl	Commerce General - Materiels Electriques	\N	2	2026-03-02 23:11:11.075	2026-03-02 23:11:11.075	Commerce General - Materiels Electriques	Rue Mousse Diop (Ex - Blanchot)	77 639 72 59	Dakar	\N	\N	\N	f	\N
238	Entreprise Activité Adresse Téléphone Rufisque Ets Ndiaye Et Freres	entreprise-activite-adresse-telephone-rufisque-ets-ndiaye-et-freres	Commerce	\N	2	2026-03-02 23:11:11.076	2026-03-02 23:11:11.076	Commerce	Rue Adama Lo X Thinck	33 822 09 30	Ville	\N	\N	\N	f	\N
239	Caa - Sarl (Compagnie Africaine Des Accumulateurs - Fulmen)	caa-sarl-compagnie-africaine-des-accumulateurs-fulmen	Commerce (Ex_Fabrique D'Accumulateur Automobile)	\N	2	2026-03-02 23:11:11.078	2026-03-02 23:11:11.078	Commerce (Ex_Fabrique D'Accumulateur Automobile)	Bccd	77 231 31 91	Rufisque	\N	\N	\N	f	\N
240	Ecopharm Senegal	ecopharm-senegal	Distribution De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.084	2026-03-02 23:11:11.084	Distribution De Produits Pharmaceutiques	Route De L'Aeroport L .Sedar Senghor Face Hangar Pelerien	33 836 33 73	Dakar	\N	\N	\N	f	\N
241	Toll Cct	toll-cct	(Commerce Et Transport Tirera) Commerce General	\N	2	2026-03-02 23:11:11.088	2026-03-02 23:11:11.088	(Commerce Et Transport Tirera) Commerce General	Route Nationale Quatier Escale	33 820 85 01	Richard	\N	\N	\N	f	\N
242	Soleil Vert Sarl	soleil-vert-sarl	Commerce De Fruits Et Legumes Reconditionnes	\N	2	2026-03-02 23:11:11.09	2026-03-02 23:11:11.09	Commerce De Fruits Et Legumes Reconditionnes	Route De Sangalkam - Gorom I	33 963 34 27	Sangalkam	\N	\N	\N	f	\N
243	Calimex Sarl (Charif Ali Import & Export)	calimex-sarl-charif-ali-import-export	Distribution /Import Export	\N	2	2026-03-02 23:11:11.093	2026-03-02 23:11:11.093	Distribution /Import Export	Rue Galandou Diouf	33 820 38 31	Dakar	\N	\N	\N	f	\N
244	W Akeur Khadimou Rassoul Samb & Freres Sarl	w-akeur-khadimou-rassoul-samb-freres-sarl	Commerce	\N	2	2026-03-02 23:11:11.095	2026-03-02 23:11:11.095	Commerce	Quartier Layenne - Thiaroye Gare Darou Salam 1	33 821 61 48	Dakar	\N	\N	\N	f	\N
245	Station Total Alassane Dione	station-total-alassane-dione	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:11.096	2026-03-02 23:11:11.096	Vente De Produits Petroliers (Station D'Essence)	Route Des Puits Bourguiba Castors	33 864 47 99	Dakar	\N	\N	\N	f	\N
246	D & D Sarl	d-d-sarl	Commerce General	\N	2	2026-03-02 23:11:11.098	2026-03-02 23:11:11.098	Commerce General	Quartier Darou Salam 2 N° 469	77 544 39 39	Dakar	\N	\N	\N	f	\N
247	Carpa Sarl	carpa-sarl	Commerce General	\N	2	2026-03-02 23:11:11.1	2026-03-02 23:11:11.1	Commerce General	Rue Galandou Diouf	33 855 93 64	Dakar	\N	\N	\N	f	\N
248	Sen-Alimentation Sarl	sen-alimentation-sarl	Commerce Produits Alimentaires	\N	2	2026-03-02 23:11:11.102	2026-03-02 23:11:11.102	Commerce Produits Alimentaires	Rue Galandou Diouf	33 822 52 35	Dakar	\N	\N	\N	f	\N
249	Mat Equip Suarl	mat-equip-suarl	Commerce Materiels Industriels Et Divers	\N	2	2026-03-02 23:11:11.11	2026-03-02 23:11:11.11	Commerce Materiels Industriels Et Divers	Bccd	33 879 16 17	Dakar	\N	\N	\N	f	\N
250	Comptoir Commercial Ya Salam (Ccys)	comptoir-commercial-ya-salam-ccys	Commerce General 257 Est Foire 0 Dakar W Ms Oil Sa Commerce Produits Petroliers Mermoz Extension Vdn	\N	1	2026-03-02 23:11:11.112	2026-03-02 23:11:11.112	Commerce General 257 Est Foire 0 Dakar W Ms Oil Sa Commerce Produits Petroliers Mermoz Extension Vdn	Immeuble Graphi Plus 2Em Etage 3B	33 832 34 55	Dakar	\N	\N	\N	f	\N
251	Winalite Senegal Sural	winalite-senegal-sural	Vente De Marchandises	\N	2	2026-03-02 23:11:11.115	2026-03-02 23:11:11.115	Vente De Marchandises	Rue Mouhamed V X Bld De La Rep ublique 0 Dakar Mamadou Yaya Diallo Commerce General Commerce General	33 825 57 07	Dakar	\N	\N	\N	f	\N
252	Technosud Sa	technosud-sa	Vente Montage Et Entretien Ascenseurs	\N	2	2026-03-02 23:11:11.117	2026-03-02 23:11:11.117	Vente Montage Et Entretien Ascenseurs	Rue De Thann	77 059 15 87	Dakar	\N	\N	\N	f	\N
253	Ets Joseda (Joseph Osei Darko)	ets-joseda-joseph-osei-darko	Vente De Materiel De Peche	\N	2	2026-03-02 23:11:11.119	2026-03-02 23:11:11.119	Vente De Materiel De Peche	Rue Tolbiac X Autoroute	33 854 97 10	Dakar	\N	\N	\N	f	\N
254	Sow Poulo Sarl	sow-poulo-sarl	Commerce	\N	2	2026-03-02 23:11:11.121	2026-03-02 23:11:11.121	Commerce	Rue Du Liban Ex Tolbiac	33 824 31 39	Dakar	\N	\N	\N	f	\N
255	Csna - Sa (Compagnie Senegalaise De Negoce Alimentaire)	csna-sa-compagnie-senegalaise-de-negoce-alimentaire	Commerce Produits Alimenatires	\N	2	2026-03-02 23:11:11.123	2026-03-02 23:11:11.123	Commerce Produits Alimenatires	Rue Huart	33 821 40 12	Dakar	\N	\N	\N	f	\N
256	Comptoir Commercial Machalla Sarl	comptoir-commercial-machalla-sarl	Commerce General Hlm Fass	\N	2	2026-03-02 23:11:11.125	2026-03-02 23:11:11.125	Commerce General Hlm Fass	Immeuble 4 Appt 4-G	33 821 04 30	Dakar	\N	\N	\N	f	\N
257	Bona Pesca Suarl	bona-pesca-suarl	Peche,Vente De Produits Halieutiques Hann Marinas,12 / A	\N	2	2026-03-02 23:11:11.126	2026-03-02 23:11:11.126	Peche,Vente De Produits Halieutiques Hann Marinas,12 / A	Rue Hb 45 Hann Bel Air	77 510 83 15	Dakar	\N	\N	\N	f	\N
258	Yannick Reverdy	yannick-reverdy	Vente De Produits Petroliers (Station D'Essence) Cap Skiring 0 Mbour Serigne Mbacke Kane Commerce Mbour 1 Thies 0 Dakar Armurerie Dakaroise Suarl Commerce De Machines Maetriels Et Autres Outils En Main	\N	1	2026-03-02 23:11:11.128	2026-03-02 23:11:11.128	Vente De Produits Petroliers (Station D'Essence) Cap Skiring 0 Mbour Serigne Mbacke Kane Commerce Mbour 1 Thies 0 Dakar Armurerie Dakaroise Suarl Commerce De Machines Maetriels Et Autres Outils En Main	Rue Joseph Gomis	33 820 96 71	Ziguinchor	\N	\N	\N	f	\N
259	Naimou Alahe Sarl	naimou-alahe-sarl	Commerce General	\N	2	2026-03-02 23:11:11.13	2026-03-02 23:11:11.13	Commerce General	Rue Grasland Dakar	33 825 97 24	Dakar	\N	\N	\N	f	\N
260	Alliance Energie Sarl	alliance-energie-sarl	Commerce General	\N	1	2026-03-02 23:11:11.132	2026-03-02 23:11:11.132	Commerce General	Bccd	33 822 43 53	Dakar	\N	\N	\N	f	\N
261	Sarl Moctar Sarr	sarl-moctar-sarr	Commerce	\N	2	2026-03-02 23:11:11.134	2026-03-02 23:11:11.134	Commerce	Avenue Amadou Gnagna Sow - Thies 0 Kaolack Station D'Essence Semou Diouf Commerce De Produits Petroliers Route De Gossas 0 Kaolack Station Ex Garage Nioro (Pape Diop Vente De Produits Petroliers (Station D'Essence) Sta tion Ex Garage Nioro 0 Dakar Aitek Senegal - Sarl Vente De Materiel Informatique - Grossiste Informatiques Sicap Amitie 3, Villa N° 910	33 832 50 04	Thies	\N	\N	\N	f	\N
262	Station Total Mamadou Lamine Badji	station-total-mamadou-lamine-badji	Vente De Produits Petroliers Koungheul 0 Dakar Global Prestige Commerce Import Export	\N	1	2026-03-02 23:11:11.136	2026-03-02 23:11:11.136	Vente De Produits Petroliers Koungheul 0 Dakar Global Prestige Commerce Import Export	Rue Aristide Le Dantec	33 869 41 00	Koungheul	\N	\N	\N	f	\N
263	L'Abreuvoir Sarl	l-abreuvoir-sarl	Vente De Boissons Rte Des Puits X	\N	2	2026-03-02 23:11:11.137	2026-03-02 23:11:11.137	Vente De Boissons Rte Des Puits X	Rue 1 Frt De Terre 0 Fatick Station Essence Ndangane (Ibrahima Thiare) Vente De Produits Petroliers (Station D'Essence) Nda ngane 0 Guediaw Aye Ibrahima Toure Vente De Carburant Station Service Oilibya Fadia	33 821 51 90	Dakar	\N	\N	\N	f	\N
264	Sepa Sarl (Societe D'Exportation De Produits Agricoles)	sepa-sarl-societe-d-exportation-de-produits-agricoles	Commerce Import Export	\N	2	2026-03-02 23:11:11.139	2026-03-02 23:11:11.139	Commerce Import Export	Rue 39X40 Colobane App C1	33 855 97 27	Dakar	\N	\N	\N	f	\N
265	Sepac - Sa (Societe Sady D'Exploitation De Produits Agricoles Et Chimiques)	sepac-sa-societe-sady-d-exploitation-de-produits-agricoles-et-chimiques	Revente De Riz	\N	2	2026-03-02 23:11:11.141	2026-03-02 23:11:11.141	Revente De Riz	Rue Tolbiac X Lamy - Derriere Hotel P acha	33 824 78 36	Dakar	\N	\N	\N	f	\N
266	Saredica	saredica	Commerce	\N	2	2026-03-02 23:11:11.143	2026-03-02 23:11:11.143	Commerce	Bd Djilly Mbaye En Face Immaculee Conception (Ex_Bd El Hadji Djily Mbaye	33 822 21 31	Dakar	\N	\N	\N	f	\N
267	Sofravin - Sa (Ste Francaise Des Vins) Importations - Conditionnement Et	sofravin-sa-ste-francaise-des-vins-importations-conditionnement-et	Ventes De Vins En Gros	\N	2	2026-03-02 23:11:11.144	2026-03-02 23:11:11.144	Ventes De Vins En Gros	Rue Des Chais - Bel-Air - Pres De Sonacos	33 849 62 22	Dakar	\N	\N	\N	f	\N
268	Mor Niang	mor-niang	Commerce General (Fripperie)	\N	2	2026-03-02 23:11:11.146	2026-03-02 23:11:11.146	Commerce General (Fripperie)	Rue 40 X 49 Colobane Da kar	33 832 25 81	Dakar	\N	\N	\N	f	\N
269	Tcs Sarl (Technologie Consulting	tcs-sarl-technologie-consulting	Services - Sarl) Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:11.148	2026-03-02 23:11:11.148	Services - Sarl) Vente De Materiels Informatiques	Rue El H. Mbaye Gue ye X Vincens	33 822 02 67	Dakar	\N	\N	\N	f	\N
270	Gie Presta Negoce	gie-presta-negoce	Commerce General	\N	2	2026-03-02 23:11:11.15	2026-03-02 23:11:11.15	Commerce General	Rue De Thiong	33 842 06 11	Dakar	\N	\N	\N	f	\N
271	Ortho International - Sarl	ortho-international-sarl	Commerce General 114,	\N	2	2026-03-02 23:11:11.151	2026-03-02 23:11:11.151	Commerce General 114,	Avenue A. Peytavin	77 558 70 24	Dakar	\N	\N	\N	f	\N
272	Imprimerie Du Centre - Sarl Travaux D'Imprimerie -	imprimerie-du-centre-sarl-travaux-d-imprimerie	Ventes De Papiers	\N	2	2026-03-02 23:11:11.153	2026-03-02 23:11:11.153	Ventes De Papiers	Avenue Mali ck Sy	33 849 44 49	Dakar	\N	\N	\N	f	\N
273	Societe 3 F - Sarl Transformation Conditionnement Et	societe-3-f-sarl-transformation-conditionnement-et	Commerce Des Pdts Chimiques Et Alimentaires(Sucre, Bicarbonnate, Autres,…) Hann -	\N	2	2026-03-02 23:11:11.155	2026-03-02 23:11:11.155	Commerce Des Pdts Chimiques Et Alimentaires(Sucre, Bicarbonnate, Autres,…) Hann -	Route De La Pharmacie Nationale -	33 849 62 49	Dakar	\N	\N	\N	f	\N
274	Derkle Materiaux - Amadou Diallo	derkle-materiaux-amadou-diallo	Commerce Materiaux De Construction Derkle -	\N	2	2026-03-02 23:11:11.156	2026-03-02 23:11:11.156	Commerce Materiaux De Construction Derkle -	Rue P X Front De Terre 33824 63 11 Ville Entreprise Activité Adresse Téléphone Dakar Serigne Abdou Lakhate Ndiaye Commerce General Rue Du Liban	33 832 01 63	Dakar	\N	\N	\N	f	\N
275	Moustapha Tall Sa	moustapha-tall-sa	Commerce Denrees Alimentaires	\N	2	2026-03-02 23:11:11.158	2026-03-02 23:11:11.158	Commerce Denrees Alimentaires	Rue Amadou Lakhsane Nd oye X Raffenel	77 638 64 14	Dakar	\N	\N	\N	f	\N
276	Carladis Int'L Sarl Autres	carladis-int-l-sarl-autres	Commerces	\N	2	2026-03-02 23:11:11.16	2026-03-02 23:11:11.16	Commerces	Rue Galandou Diouf	33 842 07 66	Dakar	\N	\N	\N	f	\N
277	Alimentation Khalifa Ababacar Sy (Oumar Diop)	alimentation-khalifa-ababacar-sy-oumar-diop	Commerce-Alimentation Marche Sor 0 Dakar Avi Senegal Sarl Commerce	\N	2	2026-03-02 23:11:11.162	2026-03-02 23:11:11.162	Commerce-Alimentation Marche Sor 0 Dakar Avi Senegal Sarl Commerce	Avenue Georges Pompidou	33 842 01 58	Saint-Louis	\N	\N	\N	f	\N
278	(Diamagueun e Ets Seye Et Fils	diamagueun-e-ets-seye-et-fils	Commerce	\N	2	2026-03-02 23:11:11.164	2026-03-02 23:11:11.164	Commerce	Quartier Samba Drame Diamaguene - Dakar	77 270 55 87	Dakar	\N	\N	\N	f	\N
279	Station Total Route De Gossass (Ousmane Badiane )	station-total-route-de-gossass-ousmane-badiane	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:11.165	2026-03-02 23:11:11.165	Vente De Produits Petroliers (Station D'Essence)	Quartier Passoire	77 656 56 06	Kaolack	\N	\N	\N	f	\N
280	Mrs (Mrs Oil And Gas Senegal Sarl)	mrs-mrs-oil-and-gas-senegal-sarl	Commerce De Carburant & Gas	\N	1	2026-03-02 23:11:11.167	2026-03-02 23:11:11.167	Commerce De Carburant & Gas	Rue Parchappe X Mayer Im meuble Dinnah	33 941 28 99	Dakar	\N	\N	\N	f	\N
281	Etablissement Dame Samb Et Freres Sarl	etablissement-dame-samb-et-freres-sarl	Commerce	\N	2	2026-03-02 23:11:11.169	2026-03-02 23:11:11.169	Commerce	Quartier Leona	33 824 34 06	Kaolack	\N	\N	\N	f	\N
282	Agro Senegal Exports - Sarl	agro-senegal-exports-sarl	Commerce Import-Export	\N	2	2026-03-02 23:11:11.171	2026-03-02 23:11:11.171	Commerce Import-Export	Rue Mohamed 5	33 941 14 53	Dakar	\N	\N	\N	f	\N
283	Staburo Sarl	staburo-sarl	Commerce Materiel Bureautique	\N	2	2026-03-02 23:11:11.173	2026-03-02 23:11:11.173	Commerce Materiel Bureautique	Rue Abdou Karim Bourgi En Face Papex	33 889 19 19	Dakar	\N	\N	\N	f	\N
284	Ka & Freres - Sarl	ka-freres-sarl	Commerce General	\N	2	2026-03-02 23:11:11.175	2026-03-02 23:11:11.175	Commerce General	Rue Poudriere Face Place De L4Ibdependance Sor	33 864 15 12	Saint-Louis	\N	\N	\N	f	\N
285	Ib Senegal (Ex Ebs (Entreprise Business Solutions)	ib-senegal-ex-ebs-entreprise-business-solutions	Commerce General	\N	2	2026-03-02 23:11:11.176	2026-03-02 23:11:11.176	Commerce General	Rue Felix Faure	33 842 28 89	Dakar	\N	\N	\N	f	\N
286	Socosen Sarl (Societe De	socosen-sarl-societe-de	Commerce Au Senegal) Commerce	\N	2	2026-03-02 23:11:11.178	2026-03-02 23:11:11.178	Commerce Au Senegal) Commerce	Rue Mousse Diop	77 540 99 79	Dakar	\N	\N	\N	f	\N
287	Fournauto Sarl (Ste Senegalaise Pour La Fourniture De Pieces Et Accessoires Automobiles)	fournauto-sarl-ste-senegalaise-pour-la-fourniture-de-pieces-et-accessoires-automobiles	Commerce Pieces Autos - Import/Export	\N	2	2026-03-02 23:11:11.18	2026-03-02 23:11:11.18	Commerce Pieces Autos - Import/Export	Avenue Lamine Gueye	33 822 46 18	Dakar	\N	\N	\N	f	\N
288	Literie Senegalaise - Sarl Autres	literie-senegalaise-sarl-autres	Commerces - Import/Export	\N	2	2026-03-02 23:11:11.182	2026-03-02 23:11:11.182	Commerces - Import/Export	Rue Galandou Diouf	33 836 03 41	Dakar	\N	\N	\N	f	\N
289	Station Total Patte D'Oie (Ex Total Route De Ouakam) / Mbor Mbengue	station-total-patte-d-oie-ex-total-route-de-ouakam-mbor-mbengue	Vente De Produits Petroliers (Station D'Essence) Patte D'Oie Ancienne	\N	1	2026-03-02 23:11:11.184	2026-03-02 23:11:11.184	Vente De Produits Petroliers (Station D'Essence) Patte D'Oie Ancienne	Route Des Niayes	33 823 05 00	Dakar	\N	\N	\N	f	\N
290	Al Houda - Sarl	al-houda-sarl	Commerce	\N	2	2026-03-02 23:11:11.186	2026-03-02 23:11:11.186	Commerce	Quartier Thialy 0 Dakar Sfs - Sarl (Senegal Free Store) Autres Commersce - Ventes Hors Douanes Rue Caille X Rue De Thann	33 569 66 67	Thies	\N	\N	\N	f	\N
291	Sitcom (Societe Immobiliere De Transport Et De	sitcom-societe-immobiliere-de-transport-et-de	Commerce) Transactions	\N	2	2026-03-02 23:11:11.188	2026-03-02 23:11:11.188	Commerce) Transactions	Immobiliere - Commerce - Services Bccd - Rue 2 Prolongee	33 821 35 47	Dakar	\N	\N	\N	f	\N
292	Ets Jean Karim Aoun	ets-jean-karim-aoun	Commerce	\N	2	2026-03-02 23:11:11.19	2026-03-02 23:11:11.19	Commerce	Rue Ernest Renan	33 832 39 05	Kaolack	\N	\N	\N	f	\N
293	Royal Ceramic (Oumar Lo)	royal-ceramic-oumar-lo	Commerce Km 11 Routr De Rufisque X	\N	2	2026-03-02 23:11:11.191	2026-03-02 23:11:11.191	Commerce Km 11 Routr De Rufisque X	Route De La Cotonniere Du Cap Vert	33 941 43 15	Dakar	\N	\N	\N	f	\N
294	Sipa (Senegalaise D'Importation De Produits D'Ameublement) Importation Et	sipa-senegalaise-d-importation-de-produits-d-ameublement-importation-et	Revente De Produits D'Ameublement	\N	2	2026-03-02 23:11:11.193	2026-03-02 23:11:11.193	Revente De Produits D'Ameublement	Rue Fleurus	33 853 01 01	Dakar	\N	\N	\N	f	\N
295	Dk Motors Sa	dk-motors-sa	Commerce Import Export & Concession Vehicule	\N	2	2026-03-02 23:11:11.195	2026-03-02 23:11:11.195	Commerce Import Export & Concession Vehicule	Bd Du Centenaire De La Commune De Dakar	33 889 08 89	Dakar	\N	\N	\N	f	\N
296	Chafic Azar & Cie - Sa	chafic-azar-cie-sa	Commerce - Import/Export	\N	2	2026-03-02 23:11:11.197	2026-03-02 23:11:11.197	Commerce - Import/Export	Rue Robert Brun	33 859 13 13	Dakar	\N	\N	\N	f	\N
297	Gmmd Sarl (Groupe Marketing Marchandising	gmmd-sarl-groupe-marketing-marchandising	Distribution) Commerce General Sacre Cœur 2	\N	2	2026-03-02 23:11:11.199	2026-03-02 23:11:11.199	Distribution) Commerce General Sacre Cœur 2	Imm Mm Senghor	33 822 26 11	Dakar	\N	\N	\N	f	\N
298	Adnan El Sayed	adnan-el-sayed	Vente De Farine Hlm Nimzath	\N	2	2026-03-02 23:11:11.201	2026-03-02 23:11:11.201	Vente De Farine Hlm Nimzath	Rue 14 X 12	33 867 77 78	Dakar	\N	\N	\N	f	\N
299	Sevam (Ste D'Equipements De Vetements Administratifs Et Militaires)	sevam-ste-d-equipements-de-vetements-administratifs-et-militaires	Commerce General (Sous Traitance Avec Des Couturiers)	\N	2	2026-03-02 23:11:11.203	2026-03-02 23:11:11.203	Commerce General (Sous Traitance Avec Des Couturiers)	Bccd	33 824 12 09	Dakar	\N	\N	\N	f	\N
300	Gie Prestagaz Saloum	gie-prestagaz-saloum	Commerce De Gaz	\N	1	2026-03-02 23:11:11.205	2026-03-02 23:11:11.205	Commerce De Gaz	Quartier Leona Rue Des Ecoles 0 Dakar Baeaubab Senegal Suarl Traitement Et Distribution D'Eau Sicap Amitie 3 En F ace	33 867 27 74	Kaolack	\N	\N	\N	f	\N
301	Imex Afric Sarl	imex-afric-sarl	Commerce Import Export	\N	2	2026-03-02 23:11:11.206	2026-03-02 23:11:11.206	Commerce Import Export	Rue Abdou Karim Bourgi	33 865 40 40	Dakar	\N	\N	\N	f	\N
302	Bijouterie 3S (Balla Thiam)	bijouterie-3s-balla-thiam	Commerce Import Export Villa N°17 Diamalaye 1 0 Dakar Dakar Distribution Commerce General	\N	2	2026-03-02 23:11:11.209	2026-03-02 23:11:11.209	Commerce Import Export Villa N°17 Diamalaye 1 0 Dakar Dakar Distribution Commerce General	Rue Du Liban Ex Tolbiac X Alfred Go ux 0 Dakar Intelma Commerce General Rue Vincens	33 835 09 45	Dakar	\N	\N	\N	f	\N
303	Exo Sarl (Mamadou Lamine Gueye)	exo-sarl-mamadou-lamine-gueye	Vente De Produits Petroliers (Station D'Essence) Exo Sarl	\N	1	2026-03-02 23:11:11.211	2026-03-02 23:11:11.211	Vente De Produits Petroliers (Station D'Essence) Exo Sarl	Rue De France	33 825 32 32	Kaolack	\N	\N	\N	f	\N
304	Ads (Aluminium Du Senegal) Menuiserie Aluminium -	ads-aluminium-du-senegal-menuiserie-aluminium	Commerce General	\N	2	2026-03-02 23:11:11.213	2026-03-02 23:11:11.213	Commerce General	Rue Felix Eb oue X Autoroute	33 941 47 57	Dakar	\N	\N	\N	f	\N
305	Ets Cheikh Diagne	ets-cheikh-diagne	Commerce General Touba Mosquee Pres De La Corniche 773606213 Dakar Cinco Sa (Compagnie Internationale De Commerce Sa) Representation De Marques Et Distribution	\N	2	2026-03-02 23:11:11.215	2026-03-02 23:11:11.215	Commerce General Touba Mosquee Pres De La Corniche 773606213 Dakar Cinco Sa (Compagnie Internationale De Commerce Sa) Representation De Marques Et Distribution	Rue Robert Brun	33 825 72 17	Diourbel	\N	\N	\N	f	\N
306	Codac - Sa	codac-sa	Commerce	\N	2	2026-03-02 23:11:11.218	2026-03-02 23:11:11.218	Commerce	Bccd	33 822 85 14	Dakar	\N	\N	\N	f	\N
307	La Dakaroise D'Equipement - Sa (Ex Socres)	la-dakaroise-d-equipement-sa-ex-socres	Vente D'Equipement Menager	\N	2	2026-03-02 23:11:11.22	2026-03-02 23:11:11.22	Vente D'Equipement Menager	Rue W Agane Diouf	33 865 25 40	Dakar	\N	\N	\N	f	\N
308	Cosedi Sarl (Compagnie Senegalaise De	cosedi-sarl-compagnie-senegalaise-de	Distribution) Commerce General	\N	2	2026-03-02 23:11:11.222	2026-03-02 23:11:11.222	Distribution) Commerce General	Rue Alfred Goux	33 823 39 51	Dakar	\N	\N	\N	f	\N
309	Dakelec Sarl (Dakar Equipement Electrique)	dakelec-sarl-dakar-equipement-electrique	Commerce Equipement Electrique	\N	2	2026-03-02 23:11:11.224	2026-03-02 23:11:11.224	Commerce Equipement Electrique	Rue Paul Holle	33 864 75 15	Dakar	\N	\N	\N	f	\N
310	Kab Gueye	kab-gueye	Commerce - Transport	\N	2	2026-03-02 23:11:11.225	2026-03-02 23:11:11.225	Commerce - Transport	Rue Mangin X Avenue Blaise Diag ne	33 822 57 17	Dakar	\N	\N	\N	f	\N
311	Rp Gedimex - Sarl	rp-gedimex-sarl	Commerce De Quincaillerie	\N	2	2026-03-02 23:11:11.227	2026-03-02 23:11:11.227	Commerce De Quincaillerie	Bccd	33 827 95 57	Dakar	\N	\N	\N	f	\N
312	Ms Suarl (Micro Solutions Suarl)	ms-suarl-micro-solutions-suarl	Vente Et Services Informatiques	\N	2	2026-03-02 23:11:11.23	2026-03-02 23:11:11.23	Vente Et Services Informatiques	Rue W Agane Diouf	33 957 12 34	Dakar	\N	\N	\N	f	\N
313	Pharmacie Gambetta "Khoury"	pharmacie-gambetta-khoury	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.232	2026-03-02 23:11:11.232	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e	33 834 09 28	Dakar	\N	\N	\N	f	\N
314	Ndogal (Makhtar Fall)	ndogal-makhtar-fall	Commerce General Marche De Mpal 0 Dakar Pharmacie Signara (Oumar Mbaye) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.234	2026-03-02 23:11:11.234	Commerce General Marche De Mpal 0 Dakar Pharmacie Signara (Oumar Mbaye) Vente De Produits Pharmaceutiques	Avenue Cheikh Anta Diop	33 853 20 33	Saint-Louis	\N	\N	\N	f	\N
315	Codistri Sarl	codistri-sarl	(Commerce Et Distribution - Sarl) Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:11.236	2026-03-02 23:11:11.236	(Commerce Et Distribution - Sarl) Commerce De Marchandises Diverses	Route De Rufisque	77 633 02 73	Dakar	\N	\N	\N	f	\N
316	Mouride Sadikh -Sarl	mouride-sadikh-sarl	Commerce Mbour 3 0 Dakar Medinatoul Rassoul Services Suarl Commerce General	\N	2	2026-03-02 23:11:11.238	2026-03-02 23:11:11.238	Commerce Mbour 3 0 Dakar Medinatoul Rassoul Services Suarl Commerce General	Avenue Malick Sy Derriere Coli Post aux	33 951 18 14	Thies	\N	\N	\N	f	\N
317	Ssc (Ste Senegalaise De	ssc-ste-senegalaise-de	Commerce) (Ex - Codaco - Mme Salman Thiam) Commerce - Import / Export	\N	2	2026-03-02 23:11:11.239	2026-03-02 23:11:11.239	Commerce) (Ex - Codaco - Mme Salman Thiam) Commerce - Import / Export	Avenue Lamine Gueye	33 821 45 52	Dakar	\N	\N	\N	f	\N
318	Aluminium Miroiterie Du Senegal	aluminium-miroiterie-du-senegal	Commerce	\N	2	2026-03-02 23:11:11.242	2026-03-02 23:11:11.242	Commerce	Quartier Medine - Mbour	33 821 42 75	Mbour	\N	\N	\N	f	\N
319	Socosti Sarl (Societe Commerciale Souleymane Tirera -Sarl)	socosti-sarl-societe-commerciale-souleymane-tirera-sarl	Commerce General	\N	2	2026-03-02 23:11:11.244	2026-03-02 23:11:11.244	Commerce General	Route Nationale N°1 Richard Toll	77 637 32 72	Saint-Louis	\N	\N	\N	f	\N
320	Ets Gueye Et Freres Sarl	ets-gueye-et-freres-sarl	Commerce	\N	2	2026-03-02 23:11:11.246	2026-03-02 23:11:11.246	Commerce	Rue Amadou Lakhsane Ndoye	33 961 22 73	Dakar	\N	\N	\N	f	\N
321	Senimport Suarl	senimport-suarl	Commerce Import Export	\N	2	2026-03-02 23:11:11.248	2026-03-02 23:11:11.248	Commerce Import Export	Avenue Georges Pompidou	33 821 57 45	Dakar	\N	\N	\N	f	\N
322	Station	station-2	Service Touba Kahone (Ibra Gueye) Vente De Produits Petroliers Passoir Ndorong 0 Dakar Mandarine Sarl Services Et Publicites (93,59%), Ventes Supports Affiches (6,41%)	\N	1	2026-03-02 23:11:11.252	2026-03-02 23:11:11.252	Service Touba Kahone (Ibra Gueye) Vente De Produits Petroliers Passoir Ndorong 0 Dakar Mandarine Sarl Services Et Publicites (93,59%), Ventes Supports Affiches (6,41%)	Rue Joseph Gomis	33 889 64 64	Kaolack	\N	\N	\N	f	\N
323	Ba Eau Bab Internationale Sa Traitement Et	ba-eau-bab-internationale-sa-traitement-et	Distribution D'Eau	\N	2	2026-03-02 23:11:11.254	2026-03-02 23:11:11.254	Distribution D'Eau	Avenue Bourguiba Fa ce Ecole Police	33 849 64 20	Dakar	\N	\N	\N	f	\N
324	Sesa Technilogies Sarl	sesa-technilogies-sarl	Commerce De Materiels Informatiques	\N	2	2026-03-02 23:11:11.257	2026-03-02 23:11:11.257	Commerce De Materiels Informatiques	Avenue Cheickh Anta Diop Sicap Mermoz Face Credit Lionais	33 823 66 77	Dakar	\N	\N	\N	f	\N
325	Pharmacie Ponty Thiong	pharmacie-ponty-thiong	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.26	2026-03-02 23:11:11.26	Vente De Produits Pharmaceutiques	Rue De Thiong X W Agane Diouf	33 864 70 89	Dakar	\N	\N	\N	f	\N
326	Station Essence Fimela (Papa Diop)	station-essence-fimela-papa-diop	Vente De Produits Petroliers (Station D'Essence) Fim ela 0 Dakar Station Total	\N	1	2026-03-02 23:11:11.263	2026-03-02 23:11:11.263	Vente De Produits Petroliers (Station D'Essence) Fim ela 0 Dakar Station Total	Rue 22 Medina (Mamadou Lamine Ndiaye) Vente De Produits Petroliers (Station D'Essence) Rue 22 Medina	33 822 47 78	Fatick	\N	\N	\N	f	\N
327	Cid Sa (Consortium D'Industries De Dakar)	cid-sa-consortium-d-industries-de-dakar	Commerce Impport (99,34%) Fabrication De Serpillere (0,66%)	\N	2	2026-03-02 23:11:11.265	2026-03-02 23:11:11.265	Commerce Impport (99,34%) Fabrication De Serpillere (0,66%)	Bccd	33 878 08 46	Dakar	\N	\N	\N	f	\N
328	Station Al Azhar Diatta Senghor	station-al-azhar-diatta-senghor	Vente De Produits Petroliers (Station D'Essence) Rou te Nationale 0 Dakar Diallo Freres Et Fils Sarl Commerce	\N	1	2026-03-02 23:11:11.267	2026-03-02 23:11:11.267	Vente De Produits Petroliers (Station D'Essence) Rou te Nationale 0 Dakar Diallo Freres Et Fils Sarl Commerce	Rue Fleurus	33 854 98 35	Fatick	\N	\N	\N	f	\N
329	Mineex Suarl	mineex-suarl	Minage-Forage-Vente Explosifs	\N	2	2026-03-02 23:11:11.269	2026-03-02 23:11:11.269	Minage-Forage-Vente Explosifs	Rue Calmette X Amadou Assane Ndoye	33 822 13 69	Dakar	\N	\N	\N	f	\N
649	Serigne Abdoulaye W Ade Suarl	serigne-abdoulaye-w-ade-suarl	Commerce	\N	2	2026-03-02 23:11:11.89	2026-03-02 23:11:11.89	Commerce	Rue Daloa Leona Kaolack	33 864 19 73	Kaolack	\N	\N	\N	f	\N
667	Racine Communication (Ndeye Thiam)	racine-communication-ndeye-thiam	Commerce De Cadeaux	\N	2	2026-03-02 23:11:11.932	2026-03-02 23:11:11.932	Commerce De Cadeaux	Avenue Jean Jaures	33 836 66 15	Dakar	\N	\N	\N	f	\N
668	Yossi	yossi	Services Sarl Vente Materiel Quincaillerie-Plomberie	\N	2	2026-03-02 23:11:11.934	2026-03-02 23:11:11.934	Services Sarl Vente Materiel Quincaillerie-Plomberie	Avenue Malick Sy	33 951 30 71	Dakar	\N	\N	\N	f	\N
669	Sodiluxe	sodiluxe	Commerce	\N	2	2026-03-02 23:11:11.936	2026-03-02 23:11:11.936	Commerce	Route Corniche Ouest Centre Commercial Sea Plaza	33 991 12 79	Dakar	\N	\N	\N	f	\N
670	General Building Surl	general-building-surl	Vente De Materiaux De Construction	\N	2	2026-03-02 23:11:11.938	2026-03-02 23:11:11.938	Vente De Materiaux De Construction	Rue Noel Balley X Tolbiac	33 864 63 63	Dakar	\N	\N	\N	f	\N
671	Tropicare W Ca	tropicare-w-ca	Vente De Materiel Et Produit Medical	\N	2	2026-03-02 23:11:11.94	2026-03-02 23:11:11.94	Vente De Materiel Et Produit Medical	Rue Hann Mariste Immeuble/O N°3Cite Geographique - Castors	33 842 58 74	Dakar	\N	\N	\N	f	\N
672	Pharmacie De L'Obelisque (Boumy Sene)	pharmacie-de-l-obelisque-boumy-sene	Vente De Produits Pharmaceutiques Colobane	\N	2	2026-03-02 23:11:11.942	2026-03-02 23:11:11.942	Vente De Produits Pharmaceutiques Colobane	Rue 13	33 835 13 13	Dakar	\N	\N	\N	f	\N
673	Arni Sarl (Agence De Represntation Et De Negoce International - Sarl)	arni-sarl-agence-de-represntation-et-de-negoce-international-sarl	Commerce General	\N	2	2026-03-02 23:11:11.944	2026-03-02 23:11:11.944	Commerce General	Rue Galandou Diouf	33 822 02 32	Dakar	\N	\N	\N	f	\N
674	Lgm - Sarl (Le Glacier Moderne)	lgm-sarl-le-glacier-moderne	Production Et Ventes De Cremes Glacees - Salon De The Patisserie -	\N	2	2026-03-02 23:11:11.946	2026-03-02 23:11:11.946	Production Et Ventes De Cremes Glacees - Salon De The Patisserie -	Avenue Georges Pompidou	33 821 54 07	Dakar	\N	\N	\N	f	\N
675	Station Star Oil (Ass Simal)	station-star-oil-ass-simal	Vente De Produits Petroliers (Station D'Essence) Esc ale Fatick 0 Dakar Pharmacie Du Potou - Chadia K. Kassem Vente De Produits Pharmaceutiques	\N	1	2026-03-02 23:11:11.948	2026-03-02 23:11:11.948	Vente De Produits Petroliers (Station D'Essence) Esc ale Fatick 0 Dakar Pharmacie Du Potou - Chadia K. Kassem Vente De Produits Pharmaceutiques	Bccd	33 822 00 01	Fatick	\N	\N	\N	f	\N
676	Pharmacie Khalifa Ababacar Sy - Sarl	pharmacie-khalifa-ababacar-sy-sarl	Vente De Produits Pharmaceutiques Lieudit Keur Mass,	\N	2	2026-03-02 23:11:11.95	2026-03-02 23:11:11.95	Vente De Produits Pharmaceutiques Lieudit Keur Mass,	Route Nationale N°2 - Tivaouane	33 832 14 99	Tivaouane	\N	\N	\N	f	\N
677	Pharmacie Serigne Dame Thiane (Dr Elhadji Fallou Mbacke Thiane)	pharmacie-serigne-dame-thiane-dr-elhadji-fallou-mbacke-thiane	Vente De Produits Pharmaceutiques Pikine	\N	2	2026-03-02 23:11:11.952	2026-03-02 23:11:11.952	Vente De Produits Pharmaceutiques Pikine	Rue 10	33 870 04 00	Pikine	\N	\N	\N	f	\N
678	Touba Mosquee Electricite Suarl	touba-mosquee-electricite-suarl	Commerce	\N	1	2026-03-02 23:11:11.954	2026-03-02 23:11:11.954	Commerce	Rue Grasland X Valmy	33 834 72 86	Dakar	\N	\N	\N	f	\N
679	Baye Computer (Cheikh Tidiane Mbaye)	baye-computer-cheikh-tidiane-mbaye	Commerce	\N	2	2026-03-02 23:11:11.957	2026-03-02 23:11:11.957	Commerce	Avenue Blaise Diagne 0 Pikine Setrad Sarl (Senegalaise De Travaux De Transport Et Distribution - Sarl) Travaux - Distribution - Transport Route De Rufisque Petit Mbao	33 823 72 37	Dakar	\N	\N	\N	f	\N
680	Pharmacie Lota Suarl	pharmacie-lota-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.959	2026-03-02 23:11:11.959	Vente De Produits Pharmaceutiques	Rue 6 X 19 Medina 33822 25 56 Dakar Pharmacie El Hadji Tamsir Samb (Khoudia Samb) Vente De Produits Pharmaceutiques Rue 67 X 54 Gueule Tapee	33 836 71 36	Dakar	\N	\N	\N	f	\N
681	Rp Tekaccess - Sa	rp-tekaccess-sa	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:11.961	2026-03-02 23:11:11.961	Vente De Materiels Informatiques	Rue Felix Faure	33 864 42 02	Dakar	\N	\N	\N	f	\N
682	Pharmacie Mame Ndiare - Mme Fatou Ndiaye Diop	pharmacie-mame-ndiare-mme-fatou-ndiaye-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.963	2026-03-02 23:11:11.963	Vente De Produits Pharmaceutiques	Route De L'Aeropor t - Dakar Yoff	33 835 00 35	Dakar	\N	\N	\N	f	\N
683	Sentinel Leather Suarl	sentinel-leather-suarl	Ventes Peaux De Moutons	\N	2	2026-03-02 23:11:11.966	2026-03-02 23:11:11.966	Ventes Peaux De Moutons	Immeuble Pyramid Villa N°7 V dn	33 820 04 16	Dakar	\N	\N	\N	f	\N
684	Negoce Echange Transport - Suarl	negoce-echange-transport-suarl	Commerce General	\N	2	2026-03-02 23:11:11.968	2026-03-02 23:11:11.968	Commerce General	Boulevard De La Liberation	77 097 36 64	Dakar	\N	\N	\N	f	\N
685	Damora - Sarl	damora-sarl	Commerce Alimentaires	\N	2	2026-03-02 23:11:11.97	2026-03-02 23:11:11.97	Commerce Alimentaires	Avenue Andre Peytavin 0 Rufisque Pharmacie Centrale - Genevieve Haddad - Rufisque Vente De Produits Pharmaceutiques Rue Ousmane Soce D iop - Rufisque	33 889 92 96	Dakar	\N	\N	\N	f	\N
686	Aog Negoce (Adja Oumy Gueye Negoce)	aog-negoce-adja-oumy-gueye-negoce	Vente De Terrain	\N	2	2026-03-02 23:11:11.971	2026-03-02 23:11:11.971	Vente De Terrain	Avenue Malick Sy	33 836 00 59	Dakar	\N	\N	\N	f	\N
355	Total Porte Du Millenium (Mbagnick Thiam)	total-porte-du-millenium-mbagnick-thiam	Vente De Produits Petroliers (Station D'Essence) Medina	\N	1	2026-03-02 23:11:11.324	2026-03-02 23:11:11.324	Vente De Produits Petroliers (Station D'Essence) Medina	Rue 5 X Corniche	33 941 18 78	Dakar	\N	\N	\N	f	\N
356	Pharmacie Teranga (Raif Kfoury)	pharmacie-teranga-raif-kfoury	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.327	2026-03-02 23:11:11.327	Vente De Produits Pharmaceutiques	Rue Dr Theze X Fel ix Faure	33 822 04 60	Dakar	\N	\N	\N	f	\N
357	Pharmacie Touba Mosquee	pharmacie-touba-mosquee	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.329	2026-03-02 23:11:11.329	Vente De Produits Pharmaceutiques	Route De Niouga Kebe X Keur Souhaïbaou Mbacke	33 827 49 64	Touba	\N	\N	\N	f	\N
358	Nabil Fardoun	nabil-fardoun	Commerce General	\N	2	2026-03-02 23:11:11.331	2026-03-02 23:11:11.331	Commerce General	Rue Galandou Diouf	33 974 89 74	Dakar	\N	\N	\N	f	\N
359	Hiperdist Senegal (High Performance	hiperdist-senegal-high-performance	Distribution Senegal) Vente De Materiels Informatiques Point E	\N	2	2026-03-02 23:11:11.333	2026-03-02 23:11:11.333	Distribution Senegal) Vente De Materiels Informatiques Point E	Rue 3 X Bd Du Sud	33 822 32 27	Dakar	\N	\N	\N	f	\N
360	Station Total Kermel (Samih Yactine)	station-total-kermel-samih-yactine	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:11.336	2026-03-02 23:11:11.336	Vente De Produits Petroliers (Station D'Essence)	Rue Des Essarts X Dagorne	33 832 12 33	Dakar	\N	\N	\N	f	\N
361	Gie Cpas (Centre De Promotion Agricole Et Sociale De Diembering)	gie-cpas-centre-de-promotion-agricole-et-sociale-de-diembering	Production Et Vente De Produits Elevage	\N	2	2026-03-02 23:11:11.338	2026-03-02 23:11:11.338	Production Et Vente De Produits Elevage	Route De Bou youye Cr De Diembering	33 821 32 06	Ziguinchor	\N	\N	\N	f	\N
362	S.C.T.N.F (Societe Commerciale Touba Nguing Fall -Sarl)	s-c-t-n-f-societe-commerciale-touba-nguing-fall-sarl	Commerce Marche Thiaroye	\N	2	2026-03-02 23:11:11.34	2026-03-02 23:11:11.34	Commerce Marche Thiaroye	Route De Diamaguene	33 993 53 37	Dakar	\N	\N	\N	f	\N
363	Stch (Societe De Travaux Publics Constructions Et Hydrauliques)	stch-societe-de-travaux-publics-constructions-et-hydrauliques	Commerce	\N	2	2026-03-02 23:11:11.343	2026-03-02 23:11:11.343	Commerce	Avenue Lamine Gueye	33 867 52 30	Dakar	\N	\N	\N	f	\N
364	W Estcan Sarl	w-estcan-sarl	Commerce	\N	2	2026-03-02 23:11:11.346	2026-03-02 23:11:11.346	Commerce	Immeuble Pyramid N° 7 Vdn Dakar	33 821 35 95	Dakar	\N	\N	\N	f	\N
365	Ibrahima Ndiaye	ibrahima-ndiaye	Commerce - Transports	\N	2	2026-03-02 23:11:11.348	2026-03-02 23:11:11.348	Commerce - Transports	Bccd Zone Industrielle	33 827 24 30	Dakar	\N	\N	\N	f	\N
366	Mcb (Materiaux De Construction & Boiseries)	mcb-materiaux-de-construction-boiseries	Vente De Bois, Ciment Et Fer	\N	2	2026-03-02 23:11:11.351	2026-03-02 23:11:11.351	Vente De Bois, Ciment Et Fer	Rue Derbezy	77 942 01 60	Rufisque	\N	\N	\N	f	\N
367	Diao Team Sarl	diao-team-sarl	Commerce Kedougou (30,	\N	2	2026-03-02 23:11:11.353	2026-03-02 23:11:11.353	Commerce Kedougou (30,	Rue Victor Hugo) 0 Dakar Pharmacie De La Republique - Sokhna Diagne Vente De Produits Pharmaceutiques Bd De La Republiqu e	33 836 33 19	Kedougou	\N	\N	\N	f	\N
368	Mohamed Fakhoury	mohamed-fakhoury	Commerce	\N	2	2026-03-02 23:11:11.356	2026-03-02 23:11:11.356	Commerce	Rue Galandou Diouf	33 821 16 63	Dakar	\N	\N	\N	f	\N
369	Station Total Charles Degaulle (Sidy Moctar Dieng)	station-total-charles-degaulle-sidy-moctar-dieng	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:11.358	2026-03-02 23:11:11.358	Vente De Produits Petroliers (Station D'Essence)	Avenue Charles Degaulle	77 636 55 26	Saint-Louis	\N	\N	\N	f	\N
370	La Maison Des Luminaires - Sarl	la-maison-des-luminaires-sarl	Vente De Luminaires Point E	\N	2	2026-03-02 23:11:11.361	2026-03-02 23:11:11.361	Vente De Luminaires Point E	Rue D X Avenue Cheikh A. Diop	33 825 22 77	Dakar	\N	\N	\N	f	\N
371	Pharmacie De L'Islam - Ifafe Attye	pharmacie-de-l-islam-ifafe-attye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.363	2026-03-02 23:11:11.363	Vente De Produits Pharmaceutiques	Avenue Emile Badia ne	33 869 28 27	Dakar	\N	\N	\N	f	\N
372	Papa Sabassy Dione	papa-sabassy-dione	Vente Carburant Station Services Oilibya	\N	1	2026-03-02 23:11:11.365	2026-03-02 23:11:11.365	Vente Carburant Station Services Oilibya	Avenue Blaise Diagne X Faidherbe	33 835 62 05	Dakar	\N	\N	\N	f	\N
373	Ams Technologies (Amadou Mansour Sane)	ams-technologies-amadou-mansour-sane	Commerce -Application Telematique Et Services	\N	2	2026-03-02 23:11:11.368	2026-03-02 23:11:11.368	Commerce -Application Telematique Et Services	Rue Sa int Michel	33 827 48 49	Dakar	\N	\N	\N	f	\N
374	Nsmtp Sa (Nouvelle Societe Des Mines Et Des Travaux Publics - Sa) Mines Et Travaux Publics	nsmtp-sa-nouvelle-societe-des-mines-et-des-travaux-publics-sa-mines-et-travaux-publics	Vente De Marbre, De Sable - Travaux Factures - Services Vendus Cices Enceinte Foire (Ex	\N	2	2026-03-02 23:11:11.371	2026-03-02 23:11:11.371	Vente De Marbre, De Sable - Travaux Factures - Services Vendus Cices Enceinte Foire (Ex	Route Du Front De Terre	77 531 01 04	Dakar	\N	\N	\N	f	\N
375	Ets Formose Mendy	ets-formose-mendy	Commerce General Grand Yoff Arafat 0 Dakar Prestatech Commerce General Liberte 6 Extension Lot F	\N	2	2026-03-02 23:11:11.373	2026-03-02 23:11:11.373	Commerce General Grand Yoff Arafat 0 Dakar Prestatech Commerce General Liberte 6 Extension Lot F	Rue 50 2è me Etage	33 827 40 94	Dakar	\N	\N	\N	f	\N
376	Soadis (Societe Africaine De	soadis-societe-africaine-de	Distribution) Commerce Articles De Peche	\N	2	2026-03-02 23:11:11.375	2026-03-02 23:11:11.375	Distribution) Commerce Articles De Peche	Rue Marchand X Autoroute	33 961 41 05	Dakar	\N	\N	\N	f	\N
377	Commodities And Logistics Sarl	commodities-and-logistics-sarl	Commerce De Marchandises Diverses	\N	2	2026-03-02 23:11:11.377	2026-03-02 23:11:11.377	Commerce De Marchandises Diverses	Route De L'Aeropor t	33 836 03 14	Dakar	\N	\N	\N	f	\N
378	Ecomar Senegal Sarl	ecomar-senegal-sarl	Commerce Place Enceinte Ex Veolia 0 Dakar Tds Suarl(Trading Distribution Senegal) Commerce Djiddah 2 Dakar 0 Saint Louis Station Total Ndioum (Ousmane Fall) Vente De Produits Petroliers Ndioum 0 Dakar Seitc (Senegal Everday International Cie) - Sarl Commerce General	\N	1	2026-03-02 23:11:11.379	2026-03-02 23:11:11.379	Commerce Place Enceinte Ex Veolia 0 Dakar Tds Suarl(Trading Distribution Senegal) Commerce Djiddah 2 Dakar 0 Saint Louis Station Total Ndioum (Ousmane Fall) Vente De Produits Petroliers Ndioum 0 Dakar Seitc (Senegal Everday International Cie) - Sarl Commerce General	Rue Mohamed 5 X Carnot	33 865 22 58	Dakar	\N	\N	\N	f	\N
379	Elias Fazah (Ets Elias Fazah)	elias-fazah-ets-elias-fazah	Commerce De Produits Alimentaire - Pdts De Boulangerie - Patisserie (Voir Si Activité 2Fff Est Uniquemement Commerce)	\N	2	2026-03-02 23:11:11.381	2026-03-02 23:11:11.381	Commerce De Produits Alimentaire - Pdts De Boulangerie - Patisserie (Voir Si Activité 2Fff Est Uniquemement Commerce)	Rue Robert Brun	33 842 57 09	Dakar	\N	\N	\N	f	\N
380	Aye Mamadou Lamarana Ba	aye-mamadou-lamarana-ba	Commerce General Cite	\N	2	2026-03-02 23:11:11.383	2026-03-02 23:11:11.383	Commerce General Cite	Abdou Diouf	33 823 36 68	Guediaw	\N	\N	\N	f	\N
381	Michel Nicolas	michel-nicolas	Commerce Escale Sud 0 Guediaw Aye Gie W Akeur Darou Salam Commerce De Fruits	\N	2	2026-03-02 23:11:11.385	2026-03-02 23:11:11.385	Commerce Escale Sud 0 Guediaw Aye Gie W Akeur Darou Salam Commerce De Fruits	Quartier Parc	33 860 92 26	Thies	\N	\N	\N	f	\N
382	Super	super	Services Sine Saloum Sarl Commerce	\N	2	2026-03-02 23:11:11.388	2026-03-02 23:11:11.388	Services Sine Saloum Sarl Commerce	Avenue John F Kennedy N° 791	77 633 19 77	Kaolack	\N	\N	\N	f	\N
383	S.S.I. (Sen	s-s-i-sen	Services Informatiques Suarl) Commerce Mat. Et Mob. De Bureaux	\N	2	2026-03-02 23:11:11.39	2026-03-02 23:11:11.39	Services Informatiques Suarl) Commerce Mat. Et Mob. De Bureaux	Avenue Blaise Diagn e X Rue 3	33 941 22 66	Dakar	\N	\N	\N	f	\N
384	Fourni Plus (Oueslati Faouzi Ben Boujemaa)	fourni-plus-oueslati-faouzi-ben-boujemaa	Commerce	\N	2	2026-03-02 23:11:11.392	2026-03-02 23:11:11.392	Commerce	Avenue Faidherbe X Mousse Diop	33 823 97 54	Dakar	\N	\N	\N	f	\N
385	Station D'Essence (Bassirou Gueye)	station-d-essence-bassirou-gueye	Vente De Produits Petroliers	\N	1	2026-03-02 23:11:11.394	2026-03-02 23:11:11.394	Vente De Produits Petroliers	Route Nationale Diourbe l	33 877 03 68	Diourbel	\N	\N	\N	f	\N
386	Snad Sarl (Societe Nvelle Africaine De	snad-sarl-societe-nvelle-africaine-de	Distribution - Sarl) Commerce General	\N	2	2026-03-02 23:11:11.396	2026-03-02 23:11:11.396	Distribution - Sarl) Commerce General	Bd G. Tapee Fass 3 X Sce Main D'Oeu	33 972 25 06	Dakar	\N	\N	\N	f	\N
387	Afrimed Suarl	afrimed-suarl	Vente Equipements Et Consommables Medicaux Bvd De L'Est - Point E 33 825/16/01 Dakar Pharmacie Medina (Adel Attye) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.398	2026-03-02 23:11:11.398	Vente Equipements Et Consommables Medicaux Bvd De L'Est - Point E 33 825/16/01 Dakar Pharmacie Medina (Adel Attye) Vente De Produits Pharmaceutiques	Avenue Blaise Diag ne X Rue 29 Medina	77 638 91 89	Dakar	\N	\N	\N	f	\N
388	Socotex - Sa (Ste Commerciale Des Textiles)	socotex-sa-ste-commerciale-des-textiles	Commerce Textile	\N	2	2026-03-02 23:11:11.399	2026-03-02 23:11:11.399	Commerce Textile	Rue De Thiong	33 860 29 92	Dakar	\N	\N	\N	f	\N
389	So Co Sis (Societe De	so-co-sis-societe-de	Commerce De Services Et D'Industrie Du Senegal) Commerce General	\N	2	2026-03-02 23:11:11.401	2026-03-02 23:11:11.401	Commerce De Services Et D'Industrie Du Senegal) Commerce General	Rue Robert Brun	33 822 11 74	Dakar	\N	\N	\N	f	\N
390	Ets Yelitaare Sarl (Amadou Sow )	ets-yelitaare-sarl-amadou-sow	Vente En Gros De Marchandises Marche Sor,	\N	2	2026-03-02 23:11:11.404	2026-03-02 23:11:11.404	Vente En Gros De Marchandises Marche Sor,	Rue Ex Son adis	33 821 78 67	Saint-Louis	\N	\N	\N	f	\N
391	Gppl - Sarl (General Pieces Poids Lourds)	gppl-sarl-general-pieces-poids-lourds	Commerce - Ventes Pieces Poids Lourds	\N	2	2026-03-02 23:11:11.406	2026-03-02 23:11:11.406	Commerce - Ventes Pieces Poids Lourds	Avenue Blaise Diagne	33 961 67 15	Dakar	\N	\N	\N	f	\N
392	Tass Diffusion Sarl	tass-diffusion-sarl	Commerce De Produits Agro Alimentaires	\N	2	2026-03-02 23:11:11.407	2026-03-02 23:11:11.407	Commerce De Produits Agro Alimentaires	Avenue Lamine Gueye	33 842 26 27	Dakar	\N	\N	\N	f	\N
393	Unibella Senegal Suarl	unibella-senegal-suarl	Commerce	\N	2	2026-03-02 23:11:11.409	2026-03-02 23:11:11.409	Commerce	Avenue Cheikh Anta Diop Ene Face Eglise St Jo	33 860 10 38	Dakar	\N	\N	\N	f	\N
394	Etablissement Camara Et Freres - Sarl	etablissement-camara-et-freres-sarl	Commerce Leona	\N	2	2026-03-02 23:11:11.411	2026-03-02 23:11:11.411	Commerce Leona	Rue Ababacar Sy N° 1037	33 823 40 80	Kaolack	\N	\N	\N	f	\N
395	Office Informatique (Cheikh Tidiane Drame)	office-informatique-cheikh-tidiane-drame	Commerce	\N	2	2026-03-02 23:11:11.413	2026-03-02 23:11:11.413	Commerce	Rue 17 X 18 Medina 0 Dakar Serigne Gueye "Nba" Commerce Hann Mariste Hlm .Villa N° 210 0 Dakar W Pc (W Est Point Computer) Commerce General Point E Rue F X 2 Bis (Face Piscine Olympique)	30 118 68 80	Dakar	\N	\N	\N	f	\N
396	a Lamarana Diallo	a-lamarana-diallo	Commerce Tamba 339812797 Dakar Elie Mejahes Chouery Et Fils Sarl Commerce General	\N	2	2026-03-02 23:11:11.414	2026-03-02 23:11:11.414	Commerce Tamba 339812797 Dakar Elie Mejahes Chouery Et Fils Sarl Commerce General	Avenue El Hadji Malick Sy - Quartie r Escale	33 864 44 40	Tambacound	\N	\N	\N	f	\N
397	Pharmacie Stella - Suarl	pharmacie-stella-suarl	Vente De Produits Pharmaceutiques Stele Mermoz	\N	2	2026-03-02 23:11:11.416	2026-03-02 23:11:11.416	Vente De Produits Pharmaceutiques Stele Mermoz	Route De Ouakam	33 957 58 57	Dakar	\N	\N	\N	f	\N
398	Arsene Lattouf	arsene-lattouf	Commerce	\N	2	2026-03-02 23:11:11.418	2026-03-02 23:11:11.418	Commerce	Rue Paul Seugnet 776458147 Rufisque Aci Sarl (Aviprest Consulting International) Commerce Cite Elh Doudou Basse Sangalkam	33 860 32 32	Kaolack	\N	\N	\N	f	\N
399	Entreprise Activité Adresse Téléphone Dakar Pharmacie Soumbedioune (Ex Pharmacie Du Secours)	entreprise-activite-adresse-telephone-dakar-pharmacie-soumbedioune-ex-pharmacie-du-secours	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.42	2026-03-02 23:11:11.42	Vente De Produits Pharmaceutiques	Rue 51 X 60 Marche Gueule Tapee	33 834 29 32	Ville	\N	\N	\N	f	\N
400	Societe Thethier Lo Suarl	societe-thethier-lo-suarl	Commerce General Medina Dahra Djolof 0 Thies Pharmacie De L'Hopital (El Hadji Malick Diop) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.422	2026-03-02 23:11:11.422	Commerce General Medina Dahra Djolof 0 Thies Pharmacie De L'Hopital (El Hadji Malick Diop) Vente De Produits Pharmaceutiques	Avenue El Hadji Ma lick Sy	33 955 16 94	Louga	\N	\N	\N	f	\N
401	Oxy Sen Sarl (L'Oxygene Du Senegal - Sarl)	oxy-sen-sarl-l-oxygene-du-senegal-sarl	Production Et Distribution De Gaz	\N	1	2026-03-02 23:11:11.424	2026-03-02 23:11:11.424	Production Et Distribution De Gaz	Route Oceanographique Quai De Peche Thiaroye 33823 48 69 Dakar Digital Planet Ngor Sarl Commerce Electromenager Ngor Route De L'Aeroport	76 669 25 28	Thiaroye	\N	\N	\N	f	\N
402	Suncard Family Market Sarl	suncard-family-market-sarl	Commerce De Produits Alimentaires Liberte Vi Extensi on,	\N	2	2026-03-02 23:11:11.426	2026-03-02 23:11:11.426	Commerce De Produits Alimentaires Liberte Vi Extensi on,	Immeuble Soda Marieme	33 820 29 97	Dakar	\N	\N	\N	f	\N
403	Negodis Suarl	negodis-suarl	Commerce Yoff Mbenguene	\N	2	2026-03-02 23:11:11.428	2026-03-02 23:11:11.428	Commerce Yoff Mbenguene	Route De L'Aeroport	33 827 19 99	Dakar	\N	\N	\N	f	\N
404	Abdou Lakhat Mbaye	abdou-lakhat-mbaye	Commerce Marche Central Bakel 0 Dakar Afrique Pare Brise Sarl Commerce General	\N	2	2026-03-02 23:11:11.429	2026-03-02 23:11:11.429	Commerce Marche Central Bakel 0 Dakar Afrique Pare Brise Sarl Commerce General	Bccd	33 836 41 02	Bakel	\N	\N	\N	f	\N
405	Codalec (Comptoir Dakarois D'Electricite)	codalec-comptoir-dakarois-d-electricite	Commerce Materiels Electriques	\N	1	2026-03-02 23:11:11.432	2026-03-02 23:11:11.432	Commerce Materiels Electriques	Rue Mousse Diop (Ex - Blanchot)	33 825 24 45	Dakar	\N	\N	\N	f	\N
406	S.F.M - Sarl (Societe De Fournitures De Materiels - Sarl)	s-f-m-sarl-societe-de-fournitures-de-materiels-sarl	Commerce Hlm Fass	\N	2	2026-03-02 23:11:11.433	2026-03-02 23:11:11.433	Commerce Hlm Fass	Immeuble Dabakh N° 66-Y	33 820 92 57	Dakar	\N	\N	\N	f	\N
407	C.I.S. Senegal (Communication Ingenierie Systemes)	c-i-s-senegal-communication-ingenierie-systemes	Commerce, Travaux Et Services Vendus Point E	\N	2	2026-03-02 23:11:11.435	2026-03-02 23:11:11.435	Commerce, Travaux Et Services Vendus Point E	Rue 5 X L	33 823 23 77	Dakar	\N	\N	\N	f	\N
408	3F Senegal Suarl	3f-senegal-suarl	Vente De Produits Alimentaires	\N	2	2026-03-02 23:11:11.437	2026-03-02 23:11:11.437	Vente De Produits Alimentaires	Quartier Boucotte Sud	33 825 00 59	Ziguinchor	\N	\N	\N	f	\N
409	Pharmacie Du Cayor	pharmacie-du-cayor	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.439	2026-03-02 23:11:11.439	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e 0 Dakar Darou Bayla Negoce Sarl Commerce General Rue Grasland X Rue Tolbiac	77 549 37 21	Thies	\N	\N	\N	f	\N
410	Hassan Zein (Cosed - Comptoir Senegalais De Droguerie)	hassan-zein-cosed-comptoir-senegalais-de-droguerie	Commerce General	\N	2	2026-03-02 23:11:11.442	2026-03-02 23:11:11.442	Commerce General	Rue Galandou Diouf	77 639 95 75	Dakar	\N	\N	\N	f	\N
411	Compudist Senegal	compudist-senegal	Commerce Materiel Informatique	\N	2	2026-03-02 23:11:11.444	2026-03-02 23:11:11.444	Commerce Materiel Informatique	Rue A X Av. Cheikh Anta Diop (Impasse Face Mobil Point E)	33 821 34 64	Dakar	\N	\N	\N	f	\N
412	Polychimie - Sa	polychimie-sa	Commerce - Import/Export - Distribution Pdts Chimiques	\N	2	2026-03-02 23:11:11.446	2026-03-02 23:11:11.446	Commerce - Import/Export - Distribution Pdts Chimiques	Bccd	33 869 11 80	Dakar	\N	\N	\N	f	\N
413	Multidis - Sarl Autres	multidis-sarl-autres	Commerce - Import/Export	\N	2	2026-03-02 23:11:11.448	2026-03-02 23:11:11.448	Commerce - Import/Export	Rue Abdou Karim Bour gi	33 825 46 21	Dakar	\N	\N	\N	f	\N
414	Ponty Excel	ponty-excel	Distribution Sarl Commerce General	\N	2	2026-03-02 23:11:11.45	2026-03-02 23:11:11.45	Distribution Sarl Commerce General	Bccd	33 823 33 90	Dakar	\N	\N	\N	f	\N
415	Mintech International Sa Consultance En Geologie (54,47%),	mintech-international-sa-consultance-en-geologie-54-47	Vente De Marchandises (45,53%) Point E -	\N	2	2026-03-02 23:11:11.452	2026-03-02 23:11:11.452	Vente De Marchandises (45,53%) Point E -	Rue 3 X Bld. De L'Est Suite N°2	33 859 77 00	Dakar	\N	\N	\N	f	\N
416	Mho - Sa (Materiel Hospitalier)	mho-sa-materiel-hospitalier	Vente Et Entretien De Materiel Hospitalier	\N	2	2026-03-02 23:11:11.454	2026-03-02 23:11:11.454	Vente Et Entretien De Materiel Hospitalier	Bd De La Republique	33 825 12 43	Dakar	\N	\N	\N	f	\N
417	Contechs Suarl (Convergence Technologique Senegal - Suarl)	contechs-suarl-convergence-technologique-senegal-suarl	Vente Materiels Informatiques-Services Informatiques Et Bureautique	\N	2	2026-03-02 23:11:11.456	2026-03-02 23:11:11.456	Vente Materiels Informatiques-Services Informatiques Et Bureautique	Quartier Notaire	33 821 53 63	Dakar	\N	\N	\N	f	\N
418	Toll Mame Cheikh Issa Suarl	toll-mame-cheikh-issa-suarl	Commerce	\N	2	2026-03-02 23:11:11.458	2026-03-02 23:11:11.458	Commerce	Quartier Darou Khoudoss - Touba	33 825 59 18	Touba	\N	\N	\N	f	\N
419	Total Fanaye(Aly Sall)	total-fanaye-aly-sall	Vente De Produits Petroliers (Station D'Essence) Fan aye Diery 0 Pikine Depot De Gaz Mandiaye Seye Commerce (Depot De Gaz)	\N	1	2026-03-02 23:11:11.46	2026-03-02 23:11:11.46	Vente De Produits Petroliers (Station D'Essence) Fan aye Diery 0 Pikine Depot De Gaz Mandiaye Seye Commerce (Depot De Gaz)	Rue Bene Baraque Quartier Al y Sene	77 569 82 82	Podor	\N	\N	\N	f	\N
420	Keur Mame Diarra (Aida Melhem)	keur-mame-diarra-aida-melhem	Commerce Pieces Detachees Auto-Scooter	\N	2	2026-03-02 23:11:11.463	2026-03-02 23:11:11.463	Commerce Pieces Detachees Auto-Scooter	Avenue Blaise Diagne	77 614 61 31	Dakar	\N	\N	\N	f	\N
421	Compagnie Commerciale Dame Diop	compagnie-commerciale-dame-diop	Commerce	\N	2	2026-03-02 23:11:11.465	2026-03-02 23:11:11.465	Commerce	Bccd	33 855 32 60	Dakar	\N	\N	\N	f	\N
422	Pharmacie Tally Icotaf - Youssef Aidibe	pharmacie-tally-icotaf-youssef-aidibe	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.467	2026-03-02 23:11:11.467	Vente De Produits Pharmaceutiques	Avenue El Hadj Mal ick Sy, Tally Icotaf - Pikine	77 571 64 40	Dakar	\N	\N	\N	f	\N
423	Sosecom Sarl	sosecom-sarl	Commerce	\N	2	2026-03-02 23:11:11.469	2026-03-02 23:11:11.469	Commerce	Avenue Ousmane Ngom	33 834 92 02	Dakar	\N	\N	\N	f	\N
424	Station Total Route De Dakar (Mamadou Ndieme Fall)	station-total-route-de-dakar-mamadou-ndieme-fall	Vente De Produits Petroliers Total	\N	1	2026-03-02 23:11:11.47	2026-03-02 23:11:11.47	Vente De Produits Petroliers Total	Route De Dakar	33 951 53 82	Thies	\N	\N	\N	f	\N
425	Pharmacie El Hadji Malick Sy - Suarl	pharmacie-el-hadji-malick-sy-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.472	2026-03-02 23:11:11.472	Vente De Produits Pharmaceutiques	Avenue Malick Sy 338222013 Dakar Soacom -Sarl (Societe Africiane De Commerce Commerce General Diacksao 1 Route De Rufisque	33 951 10 04	Dakar	\N	\N	\N	f	\N
426	L'Achat Malin	l-achat-malin	Commerce General	\N	2	2026-03-02 23:11:11.474	2026-03-02 23:11:11.474	Commerce General	Rue El H. Malick Sy (Mbour)	33 853 05 42	Mbour	\N	\N	\N	f	\N
427	Ovh Conseil Et	ovh-conseil-et	Vente Internet Telephonique Telematique Audio Visuel Hergement Site	\N	2	2026-03-02 23:11:11.476	2026-03-02 23:11:11.476	Vente Internet Telephonique Telematique Audio Visuel Hergement Site	Avenue Abdoulaye Fadiga Immeuble Lahad Mbacke 1Er Etage	33 957 10 88	Dakar	\N	\N	\N	f	\N
428	Ndiaye & Freres Sarl	ndiaye-freres-sarl	Commerce	\N	2	2026-03-02 23:11:11.477	2026-03-02 23:11:11.477	Commerce	Avenue De La Gare Marche Central 0 Ville Entreprise Activité Adresse Téléphone Dakar Ctd Sarl (Commerce Trading Distribution) Vente De Textile Ouakam - Route De L'Aeroport X Route Des Cimetieres	76 588 79 47	Thies	\N	\N	\N	f	\N
429	Seher Textile Friperie	seher-textile-friperie	Commerce	\N	2	2026-03-02 23:11:11.479	2026-03-02 23:11:11.479	Commerce	Avenue Bourguiba	33 820 86 90	Dakar	\N	\N	\N	f	\N
430	Sarl Ndiaye & Freres Autres	sarl-ndiaye-freres-autres	Commerce	\N	2	2026-03-02 23:11:11.481	2026-03-02 23:11:11.481	Commerce	Avenue Du General Degaulle 33964 12 49 Dakar Supafric Sarl Commerce Route De Ngor	33 822 14 23	Saint-Louis	\N	\N	\N	f	\N
431	Hussein Faw Az	hussein-faw-az	Commerce General	\N	2	2026-03-02 23:11:11.482	2026-03-02 23:11:11.482	Commerce General	Rue Du Liban	33 820 75 90	Dakar	\N	\N	\N	f	\N
432	Fallou Ndiaye	fallou-ndiaye	Commerce	\N	2	2026-03-02 23:11:11.484	2026-03-02 23:11:11.484	Commerce	Rue 42 X 49 Colobane 0 Dakar General Logistic Suarl Commerce General Imm 748 Rue 2 X Tour De L'Œuf Point E	33 869 62 60	Dakar	\N	\N	\N	f	\N
433	Mdt Sarl (Millenium	mdt-sarl-millenium	Distribution Technologie - Sarl ) Commerce General Bld Fass 3 Gueule Tapee Ex Service Main D'Œuvre Dak ar 0 Kaolack Bassirou Ndiaye Commerce	\N	2	2026-03-02 23:11:11.486	2026-03-02 23:11:11.486	Distribution Technologie - Sarl ) Commerce General Bld Fass 3 Gueule Tapee Ex Service Main D'Œuvre Dak ar 0 Kaolack Bassirou Ndiaye Commerce	Rue Daloa Leona Kaolack 0 Dakar Samat Sarl Commerce De Pieces Detachees Rue Felix Eboue X Autor oute	77 327 95 44	Dakar	\N	\N	\N	f	\N
434	Seafood (Senegal Seafood International -Sa)	seafood-senegal-seafood-international-sa	Vente De Poissons A L'Export	\N	2	2026-03-02 23:11:11.488	2026-03-02 23:11:11.488	Vente De Poissons A L'Export	Avenue Jean Jaures	33 821 17 76	Dakar	\N	\N	\N	f	\N
435	Buro Plus Sarl	buro-plus-sarl	Commerce	\N	2	2026-03-02 23:11:11.489	2026-03-02 23:11:11.489	Commerce	Rue Mousse Diop	33 889 35 05	Dakar	\N	\N	\N	f	\N
436	Gie Diagne Et Freres	gie-diagne-et-freres	Commerce General Medina	\N	2	2026-03-02 23:11:11.491	2026-03-02 23:11:11.491	Commerce General Medina	Rue 25 X 29 0 Dakar Distribution Agencement Services Vente De Produits Petroliers (Station D'Essence) Station Shell Yoff Diamalaye, Route De L'Aeroport	33 842 84 45	Dakar	\N	\N	\N	f	\N
437	Pharmacie Nelson Mandela - Mamadou Omar Dia	pharmacie-nelson-mandela-mamadou-omar-dia	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.493	2026-03-02 23:11:11.493	Vente De Produits Pharmaceutiques	Avenue Nelson Mand ela	33 820 53 39	Dakar	\N	\N	\N	f	\N
438	Carne Sarl	carne-sarl	Commerce Import Export	\N	2	2026-03-02 23:11:11.495	2026-03-02 23:11:11.495	Commerce Import Export	Route De Rufisque, Km 4,5 Rue 6 Dakar	33 821 21 72	Dakar	\N	\N	\N	f	\N
439	Digital Planet Pompidou Sarl	digital-planet-pompidou-sarl	Commerce Electromenager	\N	2	2026-03-02 23:11:11.497	2026-03-02 23:11:11.497	Commerce Electromenager	Avenue Georges Pompidou	33 849 15 59	Dakar	\N	\N	\N	f	\N
440	Trans	trans	Distribution Sarl Commerce General	\N	2	2026-03-02 23:11:11.498	2026-03-02 23:11:11.498	Distribution Sarl Commerce General	Boulevard Francois Xavier Ndione	33 860 25 26	Thies	\N	\N	\N	f	\N
441	Soprodal (Societe De Produits Alimentaires)	soprodal-societe-de-produits-alimentaires	Commerce	\N	2	2026-03-02 23:11:11.5	2026-03-02 23:11:11.5	Commerce	Rue Mousse Diop (Ex 67 Rue Vincens)	77 638 95 91	Dakar	\N	\N	\N	f	\N
442	Station Total Renovation (Abdoulaye Ndiaye)	station-total-renovation-abdoulaye-ndiaye	Commerce De Produits Petroliers	\N	1	2026-03-02 23:11:11.501	2026-03-02 23:11:11.501	Commerce De Produits Petroliers	Route De Dakar En Face Lycee Charles Degaulle 775763148 Dakar Sodatri (Ste Dakaroise De Transactions Internationales) Commerce General Bccd	33 842 73 18	Saint-Louis	\N	\N	\N	f	\N
443	Fina (Fary International Negoce Alimentaire)	fina-fary-international-negoce-alimentaire	Commerce	\N	2	2026-03-02 23:11:11.503	2026-03-02 23:11:11.503	Commerce	Rue Tolbiac 0 Dakar Ideal Concept Suarl Vente De Services Fournitures Et Produits Rue Carnot	33 832 10 62	Dakar	\N	\N	\N	f	\N
444	Gie Touba Taif	gie-touba-taif	Commerce General	\N	2	2026-03-02 23:11:11.505	2026-03-02 23:11:11.505	Commerce General	Route De Koki	33 842 71 16	Louga	\N	\N	\N	f	\N
445	Ebbt Entreprise Beugue Borom Touba (Serigne Fallou Mbacke)	ebbt-entreprise-beugue-borom-touba-serigne-fallou-mbacke	Commerce General Et Btp	\N	2	2026-03-02 23:11:11.506	2026-03-02 23:11:11.506	Commerce General Et Btp	Rue Fleurus X Rue Amadou L. Ndoye	33 967 22 53	Dakar	\N	\N	\N	f	\N
446	Gie Al Gassimou Et Fils	gie-al-gassimou-et-fils	Commerce	\N	2	2026-03-02 23:11:11.508	2026-03-02 23:11:11.508	Commerce	Rue Anina Fall Tamba 0 Dakar Pharmacie Soumbedioune Vente De Produits Pharmaceutiques Bd De La Gueule Ta pee	33 823 83 22	Tambacounda	\N	\N	\N	f	\N
447	Sall Et Freres - Sarl	sall-et-freres-sarl	Commerce General Gueule Tapee Marche Cantine N° 690 Cam. 0 Dakar Sf Chimie (Samir Farouk Tamim) Commerce	\N	2	2026-03-02 23:11:11.509	2026-03-02 23:11:11.509	Commerce General Gueule Tapee Marche Cantine N° 690 Cam. 0 Dakar Sf Chimie (Samir Farouk Tamim) Commerce	Route Services Geographiques Domaine Nis Derriere Soleil	33 823 88 99	Dakar	\N	\N	\N	f	\N
448	Pharmacie Africaine (Mohamed Nissr)	pharmacie-africaine-mohamed-nissr	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.511	2026-03-02 23:11:11.511	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e	77 917 77 37	Dakar	\N	\N	\N	f	\N
449	Inter	inter	Services - Sarl Commerce General	\N	2	2026-03-02 23:11:11.513	2026-03-02 23:11:11.513	Services - Sarl Commerce General	Rue De Medine	33 823 44 68	Dakar	\N	\N	\N	f	\N
450	Khalil M. Faw Az	khalil-m-faw-az	Commerce General	\N	2	2026-03-02 23:11:11.514	2026-03-02 23:11:11.514	Commerce General	Rue Galandou Diouf	33 822 93 14	Dakar	\N	\N	\N	f	\N
451	Bara Fall	bara-fall	Commerce General	\N	2	2026-03-02 23:11:11.516	2026-03-02 23:11:11.516	Commerce General	Avenue Du Senegal	33 822 08 01	Dakar	\N	\N	\N	f	\N
452	Sata Sarl (Senegal Automation Technology Assistance) Ingenierie - Montage Et Maintenance	sata-sarl-senegal-automation-technology-assistance-ingenierie-montage-et-maintenance	Commerce	\N	2	2026-03-02 23:11:11.518	2026-03-02 23:11:11.518	Commerce	Avenue Birago Diop X Rue G Point E	33 822 31 51	Dakar	\N	\N	\N	f	\N
453	Select Ngor (Mme Khady Niasse)	select-ngor-mme-khady-niasse	Commerce	\N	2	2026-03-02 23:11:11.52	2026-03-02 23:11:11.52	Commerce	Route De Ngor	33 864 26 26	Dakar	\N	\N	\N	f	\N
454	La Generale De	la-generale-de	Distribution Commerce General	\N	2	2026-03-02 23:11:11.522	2026-03-02 23:11:11.522	Distribution Commerce General	Boulevard Centenaire Commune Dakar 0 Dakar Pharmacie Thiaroye S/Mer Vente De Produits Pharmaceutiques Route De Rufisque	33 820 45 59	Dakar	\N	\N	\N	f	\N
455	Prix Bas	prix-bas	Distribution	\N	2	2026-03-02 23:11:11.524	2026-03-02 23:11:11.524	Distribution	(Abdoul Aziz Ndiaye) Commerce General Quartier Escale Mbour	33 837 74 67	Mbour	\N	\N	\N	f	\N
456	Cisse Entreprise Sarl	cisse-entreprise-sarl	Commerce	\N	2	2026-03-02 23:11:11.526	2026-03-02 23:11:11.526	Commerce	Avenue El Hadji Barro Ndieguene - Diakhao Souf 0 Dakar Pharmacie Yacine Vente De Produits Pharmaceutiques Parcelles Assainie s - Unite 17 - Villa N° 416	33 957 17 36	Thies	\N	\N	\N	f	\N
457	Station Total Sor (Daour Dieye)	station-total-sor-daour-dieye	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:11.527	2026-03-02 23:11:11.527	Vente De Produits Petroliers (Station D'Essence)	Avenue Gerneral Degaulle	33 835 78 58	Saint-Louis	\N	\N	\N	f	\N
458	Campp Sa (Cie Africaine De Motorisat° Pour Les Pirogues Et La Plaisance)	campp-sa-cie-africaine-de-motorisat-pour-les-pirogues-et-la-plaisance	Commerce General	\N	2	2026-03-02 23:11:11.529	2026-03-02 23:11:11.529	Commerce General	Bccd	33 961 19 96	Dakar	\N	\N	\N	f	\N
459	Mci (Materiels Et Consommables Informatiques	mci-materiels-et-consommables-informatiques	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:11.531	2026-03-02 23:11:11.531	Vente De Materiels Informatiques	Rue 15 X Blaise Dia gne	33 832 40 91	Dakar	\N	\N	\N	f	\N
460	Tas Sarl (Travaux Agricoles Du Fleuve (Ex Tp Besson Senegal Sarl) Travaux D'Amenagement &	tas-sarl-travaux-agricoles-du-fleuve-ex-tp-besson-senegal-sarl-travaux-d-amenagement	Services (73%) , Vente De Riz Paddy (7%)	\N	2	2026-03-02 23:11:11.532	2026-03-02 23:11:11.532	Services (73%) , Vente De Riz Paddy (7%)	Route Nationale 2, Saed, Ross Bethio	33 842 90 92	Saint-Louis	\N	\N	\N	f	\N
461	Sobel Cuisines Sarl	sobel-cuisines-sarl	Commerce General Almadies,	\N	2	2026-03-02 23:11:11.534	2026-03-02 23:11:11.534	Commerce General Almadies,	Route De Ngor	33 869 11 90	Dakar	\N	\N	\N	f	\N
462	Ibra Badiane	ibra-badiane	Commerce	\N	2	2026-03-02 23:11:11.536	2026-03-02 23:11:11.536	Commerce	Avenue Amadou Gnagna Sow Thies	33 820 12 53	Thies	\N	\N	\N	f	\N
463	Dakar	dakar	Distribution (Mohamed Kamal Yactine) Commerce	\N	2	2026-03-02 23:11:11.538	2026-03-02 23:11:11.538	Distribution (Mohamed Kamal Yactine) Commerce	Avenue Cheikh Anta Diop Derriere Snic	33 951 14 22	Dakar	\N	\N	\N	f	\N
464	Siepa - Sarl (Societe Import Export Pieces Automobiles)	siepa-sarl-societe-import-export-pieces-automobiles	Commerce Pieces Detachees Automobiles	\N	2	2026-03-02 23:11:11.54	2026-03-02 23:11:11.54	Commerce Pieces Detachees Automobiles	Avenue Lamine Gueye	33 855 54 86	Dakar	\N	\N	\N	f	\N
465	Senegalap - Sa Autres	senegalap-sa-autres	Commerces - Negoce	\N	2	2026-03-02 23:11:11.542	2026-03-02 23:11:11.542	Commerces - Negoce	Avenue Abdoulaye Fadiga, Immeuble Abdou Lahat Mbacke	33 869 88 33	Dakar	\N	\N	\N	f	\N
466	Surl Keur Faty Ndiaga Sylla	surl-keur-faty-ndiaga-sylla	Vente De Produits Alimentaires Pikine	\N	2	2026-03-02 23:11:11.544	2026-03-02 23:11:11.544	Vente De Produits Alimentaires Pikine	Route Des Niay es Plle N° 7275	33 889 14 70	Pikine	\N	\N	\N	f	\N
467	Sarl Mor Lat Sall Diop	sarl-mor-lat-sall-diop	Commerce General Saly Carrefour- Mbour 0 Kaolack Pharmacie Boubakh Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.546	2026-03-02 23:11:11.546	Commerce General Saly Carrefour- Mbour 0 Kaolack Pharmacie Boubakh Vente De Produits Pharmaceutiques	Avenue Cheikh Ibra Fall - Kaolack	77 639 28 63	Mbour	\N	\N	\N	f	\N
468	Pharmacie Gorom Suarl	pharmacie-gorom-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.547	2026-03-02 23:11:11.547	Vente De Produits Pharmaceutiques	Avenue Jean Jaures	33 941 28 29	Dakar	\N	\N	\N	f	\N
469	Treillis Et Armatures Roquisa Sarl	treillis-et-armatures-roquisa-sarl	Vente De Materiels De Constructions (Fer) 21	\N	2	2026-03-02 23:11:11.549	2026-03-02 23:11:11.549	Vente De Materiels De Constructions (Fer) 21	Avenue Faidherbe Immeuble Ges 3 Eme Etage	33 961 27 71	Dakar	\N	\N	\N	f	\N
470	Moseya Developpment Suarl	moseya-developpment-suarl	Commerce	\N	2	2026-03-02 23:11:11.551	2026-03-02 23:11:11.551	Commerce	Rue Felix Eboue	33 951 30 61	Dakar	\N	\N	\N	f	\N
471	King Cash Sarl	king-cash-sarl	Commerce	\N	2	2026-03-02 23:11:11.552	2026-03-02 23:11:11.552	Commerce	Route De Rufisque	77 517 92 47	Dakar	\N	\N	\N	f	\N
472	Pharmacie Du Ndiambour - Dr Amadou Sall Ndao	pharmacie-du-ndiambour-dr-amadou-sall-ndao	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.554	2026-03-02 23:11:11.554	Vente De Produits Pharmaceutiques	Rue Du Commerce - Louga	33 867 03 43	Louga	\N	\N	\N	f	\N
473	Cheikh Mbacke Beye	cheikh-mbacke-beye	Commerce Import-Export Produits Cosmetiques	\N	2	2026-03-02 23:11:11.556	2026-03-02 23:11:11.556	Commerce Import-Export Produits Cosmetiques	Avenue B laise Diagne X Rue 19 Tilene	33 869 60 00	Dakar	\N	\N	\N	f	\N
474	Africomm Suarl	africomm-suarl	Commerce	\N	2	2026-03-02 23:11:11.559	2026-03-02 23:11:11.559	Commerce	Rue Escarfait X Robert Brun 0 Dakar Tout Pour L'Eau - Sarl Vente D'Equipements D'Eau Et De Tout Produits Alimentaires Cite Des Impots Et Domaines	33 823 73 30	Dakar	\N	\N	\N	f	\N
475	Hygiene Plus Sarl	hygiene-plus-sarl	Commerce General	\N	2	2026-03-02 23:11:11.56	2026-03-02 23:11:11.56	Commerce General	Rue Grasland X Mousse Diop	33 855 88 55	Dakar	\N	\N	\N	f	\N
476	Daoud Bureaux Sarl (Ex Ets Daoud Bureaux)	daoud-bureaux-sarl-ex-ets-daoud-bureaux	Commerce Materiels Bureau	\N	2	2026-03-02 23:11:11.562	2026-03-02 23:11:11.562	Commerce Materiels Bureau	Rue Raffenel	33 864 56 30	Dakar	\N	\N	\N	f	\N
477	Pharmacie Mame Madia	pharmacie-mame-madia	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.564	2026-03-02 23:11:11.564	Vente De Produits Pharmaceutiques	Avenue General Deg aulle	33 822 37 19	Saint-Louis	\N	\N	\N	f	\N
478	Moustapha Fall	moustapha-fall	Commerce	\N	2	2026-03-02 23:11:11.566	2026-03-02 23:11:11.566	Commerce	Rue 19 X Avenue Blaise Diagne - Medina	33 961 12 72	Dakar	\N	\N	\N	f	\N
479	Ssbm Sarl (Ste Senegalaise De Bureautique Et De Multimedia)	ssbm-sarl-ste-senegalaise-de-bureautique-et-de-multimedia	Commerce General	\N	2	2026-03-02 23:11:11.568	2026-03-02 23:11:11.568	Commerce General	Rue W Agane Diouf	33 867 43 42	Dakar	\N	\N	\N	f	\N
480	Palu-Net - Sarl	palu-net-sarl	Distribution De Moustiquaires Impresgnees Et Produi ts Phyto Cite Sipres 1 0 Dakar Pharmacie Avicenne - Fatme Nazzal Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.569	2026-03-02 23:11:11.569	Distribution De Moustiquaires Impresgnees Et Produi ts Phyto Cite Sipres 1 0 Dakar Pharmacie Avicenne - Fatme Nazzal Vente De Produits Pharmaceutiques	Rue Mousse Diop	33 821 29 31	Dakar	\N	\N	\N	f	\N
481	Intex Sa	intex-sa	Vente De Marchandises	\N	2	2026-03-02 23:11:11.571	2026-03-02 23:11:11.571	Vente De Marchandises	Avenue Du Senegal X Blaise Dia gne	33 823 54 93	Dakar	\N	\N	\N	f	\N
482	Ibrahima N'Diaye	ibrahima-n-diaye	Commerce General Niary Tally 0 Dakar Tarou Electromenager Du Senegal Commerce	\N	2	2026-03-02 23:11:11.573	2026-03-02 23:11:11.573	Commerce General Niary Tally 0 Dakar Tarou Electromenager Du Senegal Commerce	Avenue Cheikh Anta Diop	77 644 08 27	Dakar	\N	\N	\N	f	\N
483	Libre	libre	Service Le Virage (Ramzie Yassine) Commerce	\N	2	2026-03-02 23:11:11.575	2026-03-02 23:11:11.575	Service Le Virage (Ramzie Yassine) Commerce	Quartier Toundopp Rya N° 24	77 212 75 63	Dakar	\N	\N	\N	f	\N
484	Pharmacie Du Guet - Mohamed Ghandour (Ex - Khady Bao)	pharmacie-du-guet-mohamed-ghandour-ex-khady-bao	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.576	2026-03-02 23:11:11.576	Vente De Produits Pharmaceutiques	Rue Huart - Immeub le Faycal	76 683 38 29	Dakar	\N	\N	\N	f	\N
485	Pharmacie Aline Sitoe Diatta (Madiamba Niabaly)	pharmacie-aline-sitoe-diatta-madiamba-niabaly	Vente De Produits Pharmaceutiques Boucotte Sud	\N	2	2026-03-02 23:11:11.578	2026-03-02 23:11:11.578	Vente De Produits Pharmaceutiques Boucotte Sud	Route De L'Hopital Regional De Ziguinc hor 0 Kaolack Station Papa Ndao Commerce De Carburant Avenue John Fkennedy	33 821 68 20	Ziguinchor	\N	\N	\N	f	\N
486	Famous International	famous-international	Vente Import - Export	\N	2	2026-03-02 23:11:11.58	2026-03-02 23:11:11.58	Vente Import - Export	Rue Raffenel X Abdou Karim Bou rgi 0 Dakar Jihad Saleh Commerce Rue Galandou Diouf 0 Dakar Editions Des Trois Fleuves Librairie - Vente De Livre De Collection Point E - Bd De L'Est X Avenue Cheikh Anta Diop	33 837 26 56	Dakar	\N	\N	\N	f	\N
487	Sagra (Societe Africaine Des Corps Gras)	sagra-societe-africaine-des-corps-gras	Commerce-Import & Export	\N	2	2026-03-02 23:11:11.581	2026-03-02 23:11:11.581	Commerce-Import & Export	Rue Vincens Dakar	33 855 13 79	Dakar	\N	\N	\N	f	\N
488	Pharmacie Conseil (Crespin Gustave Mandiouba)	pharmacie-conseil-crespin-gustave-mandiouba	Vente De Produits Pharmaceutiques Cite Sonatel 2 N° 45 - Sud Foire 0 Dakar Sysaid Telecoms Sarl Commerce Materiels Telecoms - Energie Et Informatique Vdn	\N	1	2026-03-02 23:11:11.583	2026-03-02 23:11:11.583	Vente De Produits Pharmaceutiques Cite Sonatel 2 N° 45 - Sud Foire 0 Dakar Sysaid Telecoms Sarl Commerce Materiels Telecoms - Energie Et Informatique Vdn	Immeuble Mariama Apt 3	33 991 13 11	Dakar	\N	\N	\N	f	\N
489	Darou Salam Suarl	darou-salam-suarl	Commerce Saly Carrefour 0 Dakar Ssipc Sarl (Ste Senegalaise D'Import Export Commercial) Commerce General - Import/Export	\N	2	2026-03-02 23:11:11.585	2026-03-02 23:11:11.585	Commerce Saly Carrefour 0 Dakar Ssipc Sarl (Ste Senegalaise D'Import Export Commercial) Commerce General - Import/Export	Avenue Blaise Diagn e X 3, Avenue Du Senegal	33 867 23 03	Mbour	\N	\N	\N	f	\N
490	Skl Sarl	skl-sarl	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:11.586	2026-03-02 23:11:11.586	Commerce De Produits Alimentaires	Rue Robert Brun	77 560 57 13	Dakar	\N	\N	\N	f	\N
491	Dismat	dismat	(Distribution De Materiels Informatiques) Commerce De Materiels Informatiques & Bureautiques	\N	2	2026-03-02 23:11:11.588	2026-03-02 23:11:11.588	(Distribution De Materiels Informatiques) Commerce De Materiels Informatiques & Bureautiques	Avenue Jean Jaures Immeuble Aly Ibrahim	77 680 04 65	Dakar	\N	\N	\N	f	\N
492	Entreprise Activité Adresse Téléphone Dakar Pharmacie Sandiniery	entreprise-activite-adresse-telephone-dakar-pharmacie-sandiniery	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.592	2026-03-02 23:11:11.592	Vente De Produits Pharmaceutiques	Rue Sandiniery X R affenel 0 Saint-Louis Etablissement Niang Et Fils Commerce General Rue Ex Sonadis Marche Sor	77 631 63 35	Ville	\N	\N	\N	f	\N
493	Station	station-3	Service Oilibya Diacksao (Karba Traore) Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:11.598	2026-03-02 23:11:11.598	Service Oilibya Diacksao (Karba Traore) Vente De Produits Petroliers (Station D'Essence)	Route De Rufisque Diacksao	33 961 22 07	Rufisque	\N	\N	\N	f	\N
494	Epicerie Libre	epicerie-libre	Service "Le Ngor" (Khalil Nadine) Commerce Ouakam,	\N	2	2026-03-02 23:11:11.6	2026-03-02 23:11:11.6	Service "Le Ngor" (Khalil Nadine) Commerce Ouakam,	Route De Ngor	77 569 08 31	Dakar	\N	\N	\N	f	\N
495	Pharmacie Du Boulevard Du Sud (Amadou Mamadou Alpha Dia)	pharmacie-du-boulevard-du-sud-amadou-mamadou-alpha-dia	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.601	2026-03-02 23:11:11.601	Vente De Produits Pharmaceutiques	Boulevard Abdoulay e Mar Diop	33 820 75 90	Saint-Louis	\N	\N	\N	f	\N
496	Medical Partner Suarl	medical-partner-suarl	Vente De Materiaux Medicaux	\N	2	2026-03-02 23:11:11.603	2026-03-02 23:11:11.603	Vente De Materiaux Medicaux	Rue Carnot	33 821 10 64	Dakar	\N	\N	\N	f	\N
497	Entreprise Touba Khaira (El Hadji Gueye Dieng) Prestations De	entreprise-touba-khaira-el-hadji-gueye-dieng-prestations-de	Services - Commerce Escale Fatick 0 Dakar Pharmacie Patte D'Oie - Mme Marie Laure Sy Nee Konate Vente De Produits Pharmaceutiques Ancienne	\N	2	2026-03-02 23:11:11.605	2026-03-02 23:11:11.605	Services - Commerce Escale Fatick 0 Dakar Pharmacie Patte D'Oie - Mme Marie Laure Sy Nee Konate Vente De Produits Pharmaceutiques Ancienne	Route Des Niayes - Grand Yoff	33 823 01 24	Fatick	\N	\N	\N	f	\N
498	Societe Dabo Sarl	societe-dabo-sarl	Commerce Escale	\N	2	2026-03-02 23:11:11.607	2026-03-02 23:11:11.607	Commerce Escale	Avenue General Degaulle	33 824 34 06	Thies	\N	\N	\N	f	\N
499	Thocomar Shipping Agency & Cie Shipchandler -	thocomar-shipping-agency-cie-shipchandler	Commerce Maritme - Avitaillement Navires	\N	2	2026-03-02 23:11:11.608	2026-03-02 23:11:11.608	Commerce Maritme - Avitaillement Navires	Rue Mage X Parchappe	33 951 17 72	Dakar	\N	\N	\N	f	\N
500	Somisen - Sarl	somisen-sarl	Commerce General	\N	2	2026-03-02 23:11:11.61	2026-03-02 23:11:11.61	Commerce General	Route Des Brasseries - Villa Soboa	33 961 31 74	Dakar	\N	\N	\N	f	\N
501	Ccss Sarl (Compagnie Commercial Du Sine Saloum	ccss-sarl-compagnie-commercial-du-sine-saloum	Commerce	\N	2	2026-03-02 23:11:11.612	2026-03-02 23:11:11.612	Commerce	Rue John F.Kennedy X Amilcar 0 Dakar Pharmacie Diamalaye Vente De Produits Pharmaceutiques Route De Rufisque	33 832 46 22	Kaolack	\N	\N	\N	f	\N
502	Mamadou Cire Diallo	mamadou-cire-diallo	Commerce De Produits Alimentaires	\N	2	2026-03-02 23:11:11.614	2026-03-02 23:11:11.614	Commerce De Produits Alimentaires	Rue Grasland	33 834 05 92	Dakar	\N	\N	\N	f	\N
503	Arc + Sa Gestion De Portefeuille - Approvisionnements Industriels Et Logistique - Prestation De	arc-sa-gestion-de-portefeuille-approvisionnements-industriels-et-logistique-prestation-de	Services - Commerce	\N	2	2026-03-02 23:11:11.616	2026-03-02 23:11:11.616	Services - Commerce	Rue Zola - 1Er Etage	33 823 18 14	Dakar	\N	\N	\N	f	\N
504	Station Total Africom (Mame Aly Gueye)	station-total-africom-mame-aly-gueye	Vente De Produits Petroliers (Station D'Essence)	\N	1	2026-03-02 23:11:11.617	2026-03-02 23:11:11.617	Vente De Produits Petroliers (Station D'Essence)	Avenue John F. Kennedy	33 823 64 14	Kaolack	\N	\N	\N	f	\N
505	Station Total Eladji Kalado Maiga	station-total-eladji-kalado-maiga	Vente De Produits Petroliers (Station D'Essence) Total	\N	1	2026-03-02 23:11:11.619	2026-03-02 23:11:11.619	Vente De Produits Petroliers (Station D'Essence) Total	Rue De Paris	33 834 37 21	Thies	\N	\N	\N	f	\N
506	Sisme Sarl (Societe Italo- Senegalaise Des Machines Europeennes)	sisme-sarl-societe-italo-senegalaise-des-machines-europeennes	Vente De Materiel De Btp Cite Sagef Ouest Foire (Ex 628 X Vdn	\N	2	2026-03-02 23:11:11.621	2026-03-02 23:11:11.621	Vente De Materiel De Btp Cite Sagef Ouest Foire (Ex 628 X Vdn	Route De L'Aeroport)	77 655 74 52	Dakar	\N	\N	\N	f	\N
507	Socofi Sa	socofi-sa	Commerce De Gros D'Autres Equipements Industriels Et Fournitures 21 Rez De Chaussee	\N	2	2026-03-02 23:11:11.623	2026-03-02 23:11:11.623	Commerce De Gros D'Autres Equipements Industriels Et Fournitures 21 Rez De Chaussee	Imm Ndindy Rue Marchand X Tolbiac	33 820 70 82	Dakar	\N	\N	\N	f	\N
508	Liaison Commerciale Du Senegal, Lcs (Mouhamadoul Habib Thiam) Achats Et	liaison-commerciale-du-senegal-lcs-mouhamadoul-habib-thiam-achats-et	Ventes D'Arachides Camberene	\N	2	2026-03-02 23:11:11.625	2026-03-02 23:11:11.625	Ventes D'Arachides Camberene	Quartier Degg o Dakar	33 821 13 04	Dakar	\N	\N	\N	f	\N
509	Amafrique Suarl Representation Dans Les Engrais	amafrique-suarl-representation-dans-les-engrais	(Commerce De Produits Chiamiques)	\N	2	2026-03-02 23:11:11.627	2026-03-02 23:11:11.627	(Commerce De Produits Chiamiques)	Rue Parent X Abdoulaye Fadiga	77 532 79 00	Dakar	\N	\N	\N	f	\N
510	Satac Sa (Societe Africaine De Traitement Anti-Corrosif) Traitement Anticorrosif -	satac-sa-societe-africaine-de-traitement-anti-corrosif-traitement-anticorrosif	Vente De Peintures	\N	2	2026-03-02 23:11:11.629	2026-03-02 23:11:11.629	Vente De Peintures	Bccd	33 842 40 43	Dakar	\N	\N	\N	f	\N
511	Pharmacie De L'Emmanuel (Risque Germaine Ch. Sagbo)	pharmacie-de-l-emmanuel-risque-germaine-ch-sagbo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.631	2026-03-02 23:11:11.631	Vente De Produits Pharmaceutiques	Rue A X Abebe Biki la Grand Dakar	33 849 10 01	Dakar	\N	\N	\N	f	\N
512	Pharmacie Boisson - Mohamed Farhat	pharmacie-boisson-mohamed-farhat	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.633	2026-03-02 23:11:11.633	Vente De Produits Pharmaceutiques	Rue Parent	33 864 44 03	Dakar	\N	\N	\N	f	\N
513	Pharmacie Djadine Suarl	pharmacie-djadine-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.634	2026-03-02 23:11:11.634	Vente De Produits Pharmaceutiques	Avenue Sidya Ndatt e Yalla - Dagana	33 820 04 16	Dagana	\N	\N	\N	f	\N
514	Groupe Sigma	groupe-sigma	Commerce Import-Export Sacre Cœur Vdn Villa 10162 0 Dakar Sen Pieces Auto Sarl Vente De Pieces Detachees Auto	\N	2	2026-03-02 23:11:11.636	2026-03-02 23:11:11.636	Commerce Import-Export Sacre Cœur Vdn Villa 10162 0 Dakar Sen Pieces Auto Sarl Vente De Pieces Detachees Auto	Avenue Blaise Diagne	33 963 11 09	Dakar	\N	\N	\N	f	\N
515	Ets Natack Suarl (Pape Leopold Natack)	ets-natack-suarl-pape-leopold-natack	Commerce General	\N	2	2026-03-02 23:11:11.638	2026-03-02 23:11:11.638	Commerce General	Rue 30 X 43 Medina	33 822 83 27	Dakar	\N	\N	\N	f	\N
516	Pharmacie Du Centenaire - Magatte Mbaye Fall	pharmacie-du-centenaire-magatte-mbaye-fall	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.64	2026-03-02 23:11:11.64	Vente De Produits Pharmaceutiques	Bd Du General De G aulle	33 853 29 00	Dakar	\N	\N	\N	f	\N
517	Cvs (Comptoir Des Vins Du Senegal)	cvs-comptoir-des-vins-du-senegal	Commerce	\N	2	2026-03-02 23:11:11.642	2026-03-02 23:11:11.642	Commerce	Rue Hipodrome	33 822 99 07	Dakar	\N	\N	\N	f	\N
518	Comptoirs Des Vins Du Senegal	comptoirs-des-vins-du-senegal	Commerce	\N	2	2026-03-02 23:11:11.645	2026-03-02 23:11:11.645	Commerce	Rue Hipodrome	33 836 38 55	Dakar	\N	\N	\N	f	\N
519	Cipa (Consortium Africain D'Industrie Et De Plomberie - Fallou Mbaye)	cipa-consortium-africain-d-industrie-et-de-plomberie-fallou-mbaye	Commerce	\N	2	2026-03-02 23:11:11.647	2026-03-02 23:11:11.647	Commerce	Rue Fleurus	33 836 38 55	Dakar	\N	\N	\N	f	\N
520	Pallene - Sarl (Import - Export - Industrie) Autres	pallene-sarl-import-export-industrie-autres	Commerce - Import/Export (Tomate Concentree)	\N	2	2026-03-02 23:11:11.649	2026-03-02 23:11:11.649	Commerce - Import/Export (Tomate Concentree)	Rue Raffenel	77 570 12 12	Dakar	\N	\N	\N	f	\N
521	Pharmacie Du Port	pharmacie-du-port	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.651	2026-03-02 23:11:11.651	Vente De Produits Pharmaceutiques	Bd De L'Arsenal X Bccd - Face Grande Gare	33 822 89 99	Dakar	\N	\N	\N	f	\N
522	Etablissement Modou Cheikh Babou Sarl	etablissement-modou-cheikh-babou-sarl	Commerce General	\N	2	2026-03-02 23:11:11.654	2026-03-02 23:11:11.654	Commerce General	Rue Daloi Leona 0 Tamba Pharmacie Thiaala (Dr Salif Samba Diallo) Vente De Produits Pharmaceutiques Avenue Leopold S. Senghor - Tambacounda	33 878 10 02	Kaolack	\N	\N	\N	f	\N
523	Le Tigre -Sarl	le-tigre-sarl	Commerce Escale	\N	2	2026-03-02 23:11:11.655	2026-03-02 23:11:11.655	Commerce Escale	Rue Birane Yacine Boubou	33 842 50 57	Thies	\N	\N	\N	f	\N
524	Coimex Sarl (Cote Ouest Import Export) Import-Export	coimex-sarl-cote-ouest-import-export-import-export	Commerce General	\N	2	2026-03-02 23:11:11.657	2026-03-02 23:11:11.657	Commerce General	Avenue Peytavin	33 951 63 80	Dakar	\N	\N	\N	f	\N
525	Gie Jappo	gie-jappo	Commerce Dialegne 0 Dakar Ibrahima Dia Commerce General Tally Bou Mack Villa 4183 0 Kaffrine Pharmacie Ndoucoumane (Moustapha Diop) Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.659	2026-03-02 23:11:11.659	Commerce Dialegne 0 Dakar Ibrahima Dia Commerce General Tally Bou Mack Villa 4183 0 Kaffrine Pharmacie Ndoucoumane (Moustapha Diop) Vente De Produits Pharmaceutiques	Quartier Escale	33 867 07 01	Kaolack	\N	\N	\N	f	\N
526	Pharmacie Du Point E - Dieynaba Diaka Bocoum Soumare	pharmacie-du-point-e-dieynaba-diaka-bocoum-soumare	Vente De Produits Pharmaceutiques Point E -	\N	2	2026-03-02 23:11:11.661	2026-03-02 23:11:11.661	Vente De Produits Pharmaceutiques Point E -	Bd De L' Est	33 855 31 90	Dakar	\N	\N	\N	f	\N
527	Pharmacie Drugstore - Solange Decupper	pharmacie-drugstore-solange-decupper	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.663	2026-03-02 23:11:11.663	Vente De Produits Pharmaceutiques	Avenue Georges Pom pidou	77 728 32 29	Dakar	\N	\N	\N	f	\N
528	Ets Diallo Et Freres	ets-diallo-et-freres	Commerce	\N	2	2026-03-02 23:11:11.664	2026-03-02 23:11:11.664	Commerce	Avenue Dial Diop Sicap,Rue 10	33 822 22 27	Dakar	\N	\N	\N	f	\N
529	Entreprise Activité Adresse Téléphone Dakar Ets Djibril Ndiaye	entreprise-activite-adresse-telephone-dakar-ets-djibril-ndiaye	Commerce General	\N	2	2026-03-02 23:11:11.666	2026-03-02 23:11:11.666	Commerce General	Rue Grasland X Rue Du Diaraf M. Pay e	33 825 82 38	Ville	\N	\N	\N	f	\N
530	Station	station-4	Service Oilibya	\N	1	2026-03-02 23:11:11.671	2026-03-02 23:11:11.671	Service Oilibya	Rue 9Xcanal 4 Point E Vente De Produits Petroliers (Station D'Essence) Rue 9 X Canal 4 Point E	33 823 72 37	Dakar	\N	\N	\N	f	\N
531	W Akeur Elh Serigne Ousseynou Sylla Diw Ane	w-akeur-elh-serigne-ousseynou-sylla-diw-ane	Commerce	\N	2	2026-03-02 23:11:11.673	2026-03-02 23:11:11.673	Commerce	Route Ogo Carrefour Ourossogui	33 825 92 03	Ourosogui	\N	\N	\N	f	\N
532	Corelec	corelec	Commerce General / Importation De Materiel Electriq ue	\N	2	2026-03-02 23:11:11.674	2026-03-02 23:11:11.674	Commerce General / Importation De Materiel Electriq ue	Immeuble Cafe De Rome 4° Etage 0 Dakar Clean Espace Senegal (Jean Claude Monteiro) Commerce Rue Felix Faure	70 202 32 04	Dakar	\N	\N	\N	f	\N
533	Immo Senegal	immo-senegal	Commerce General Saly Portudal 0 Dakar Djeukene Sarl Commerce Fripperie	\N	2	2026-03-02 23:11:11.676	2026-03-02 23:11:11.676	Commerce General Saly Portudal 0 Dakar Djeukene Sarl Commerce Fripperie	Rue 44 X 49 Colobane Plle09 0 Dakar Somodisen Commerce General Rue Raffenel	77 634 85 55	Dakar	\N	\N	\N	f	\N
534	Multi Jetables Au Senegal(Mjs)	multi-jetables-au-senegal-mjs	Commerce General	\N	2	2026-03-02 23:11:11.678	2026-03-02 23:11:11.678	Commerce General	Rue Marsat - Dakar 0 Dakar Mamadou Fall Commerce Rue Galandou Diouf	33 832 40 00	Dakar	\N	\N	\N	f	\N
535	Pharmacie Centrale - Aliou Camara - Diourbel	pharmacie-centrale-aliou-camara-diourbel	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.68	2026-03-02 23:11:11.68	Vente De Produits Pharmaceutiques	Quartier Thierno K andji, Rue D'Avignon	33 822 89 99	Diourbel	\N	\N	\N	f	\N
536	Superette Sara (Mohamar Soraya Sara)	superette-sara-mohamar-soraya-sara	Commerce General (Superette)	\N	2	2026-03-02 23:11:11.681	2026-03-02 23:11:11.681	Commerce General (Superette)	Rue Lieutenant Lemoine Escale Ziguinchor	33 879 14 95	Ziguinchor	\N	\N	\N	f	\N
537	Medisys Sarl (Medical Systems Sarl)	medisys-sarl-medical-systems-sarl	Vente De Materiel Medical Poiint E X	\N	2	2026-03-02 23:11:11.683	2026-03-02 23:11:11.683	Vente De Materiel Medical Poiint E X	Avenue Cheikh A nta Diop	33 991 41 18	Dakar	\N	\N	\N	f	\N
538	Promo Import Sarl	promo-import-sarl	Commerce General - Import Export -	\N	2	2026-03-02 23:11:11.685	2026-03-02 23:11:11.685	Commerce General - Import Export -	Avenue Georges Po mpidou	33 868 11 80	Dakar	\N	\N	\N	f	\N
539	Moussa Gueye	moussa-gueye	Commerce General	\N	2	2026-03-02 23:11:11.686	2026-03-02 23:11:11.686	Commerce General	Rue 25 X 22 Medina,Dakar 0 Tambacound a Pharmacie Providence(Anne Marie Diouf) Vente De Produits Pharmaceutiques Tamba	33 889 00 77	Dakar	\N	\N	\N	f	\N
540	Gie Yaakaar	gie-yaakaar	Commerce De Fruits	\N	2	2026-03-02 23:11:11.688	2026-03-02 23:11:11.688	Commerce De Fruits	Rue El Hadji Mbaye Gueye	77 332 02 52	Dakar	\N	\N	\N	f	\N
541	Issa Diagne Laye	issa-diagne-laye	Commerce General	\N	2	2026-03-02 23:11:11.69	2026-03-02 23:11:11.69	Commerce General	Route Du Cimetiere Yoff Layenne 0 Dakar Pharmacie Ndeye Ngatou Ba (Mme Sara El Ali Nee Boumoujheid) Vente De Produits Pharmaceutiques Route De Yeumbel - Thiaroye	77 633 19 77	Dakar	\N	\N	\N	f	\N
542	Aye Sdt (Saidou Demba Tall)	aye-sdt-saidou-demba-tall	Commerce Guediaw Aye	\N	2	2026-03-02 23:11:11.691	2026-03-02 23:11:11.691	Commerce Guediaw Aye	-Quartier Demba Talla W Khinane Golf No rd 0 Dakar Privilege (Mohamed El Ali) Commerce General Ngor X Route Diarama En Face Axa	33 837 81 35	Guediaw	\N	\N	\N	f	\N
543	Gie Diapo Prestation De	gie-diapo-prestation-de	Service & Commerce	\N	2	2026-03-02 23:11:11.694	2026-03-02 23:11:11.694	Service & Commerce	Quartier Thierno Ka ndji N°1659 775557581 Guediaw Aye Jpm Suarl (Jean Pierre Mendy) Commerce (Depot Boissons) Nimzatt Quartier Mbaye Fal l Plle N° 963	33 955 51 50	Diourbel	\N	\N	\N	f	\N
544	Getamic Sarl (General D'Equipement & De Travaux Appliques En Matiere D'Industrie Et De	getamic-sarl-general-d-equipement-de-travaux-appliques-en-matiere-d-industrie-et-de	Commerce) Commerce Et Prestations De Services Residence Hacienda N° 13	\N	2	2026-03-02 23:11:11.695	2026-03-02 23:11:11.695	Commerce) Commerce Et Prestations De Services Residence Hacienda N° 13	Route De Camberene 33 8326405 Dakar Pharmacie Baol ( El Hadji Babou Ciss) Vente De Produits Pharmaceutiques Route De L'Aeropor t Cite Mame Rane 0 Kaolack Etablissement Diacksao Suarl Commerce Rue Daloi N° 588	33 877 60 34	Dakar	\N	\N	\N	f	\N
545	Moi Senegal - Suarl	moi-senegal-suarl	Commerce Derkle Villa N°106 0 Dakar Ets Ismail Kassir Commerce Import-Export	\N	2	2026-03-02 23:11:11.697	2026-03-02 23:11:11.697	Commerce Derkle Villa N°106 0 Dakar Ets Ismail Kassir Commerce Import-Export	Avenue Lamine Gueye 0 Mbour Polaquad Sarl Commerce De Pieces Detachees Et D'Accessoires Autom obiles Quartier Cite Lagune N°44 0 Tambacounda Demba Mbow Commerce Rue Ainina Fall Tambacounda 0 Dakar Eicop Sarl (Entreprise Internationale De Commerce Et De Prestations - Sarl) Commerce De Viande De Desosse, Foie De Bœuf Congelee Desosse Ouest Foire En Face Cices 1Er Etage 33820 15 98 Kaolack Sami Dagher Commerce General Quartier Leona	77 515 24 89	Dakar	\N	\N	\N	f	\N
546	Mor Maty Sarr	mor-maty-sarr	Commerce	\N	2	2026-03-02 23:11:11.699	2026-03-02 23:11:11.699	Commerce	Avenue Andre Peytavin	33 832 50 80	Dakar	\N	\N	\N	f	\N
547	Seniran Auto	seniran-auto	Vente De Vehicules Et Pieces Detachees	\N	2	2026-03-02 23:11:11.701	2026-03-02 23:11:11.701	Vente De Vehicules Et Pieces Detachees	Bccd	33 821 27 47	Dakar	\N	\N	\N	f	\N
548	L'Essentiel (Issaga Bah)	l-essentiel-issaga-bah	Commerce General Mermoz	\N	2	2026-03-02 23:11:11.704	2026-03-02 23:11:11.704	Commerce General Mermoz	Route De Ouakam Immeuble Sap hir	33 859 54 54	Dakar	\N	\N	\N	f	\N
549	Cheikh Diagne	cheikh-diagne	Commerce General	\N	2	2026-03-02 23:11:11.706	2026-03-02 23:11:11.706	Commerce General	Rue Abdou Karim Bourgi 0 Pikine Mor Fall Commerce Fass Mbao Tally Mame Diarra Yeumbeul	77 430 73 08	Dakar	\N	\N	\N	f	\N
550	Global Pharma Suarl Importation Et	global-pharma-suarl-importation-et	Distribution De Produits Et Equipement De Sante Fenetre Mermoz	\N	2	2026-03-02 23:11:11.708	2026-03-02 23:11:11.708	Distribution De Produits Et Equipement De Sante Fenetre Mermoz	Immeuble Tours	33 854 16 90	Dakar	\N	\N	\N	f	\N
551	Dakar Shipping	dakar-shipping	Services Sarl Commerce	\N	2	2026-03-02 23:11:11.71	2026-03-02 23:11:11.71	Services Sarl Commerce	Rue Marchand X Lamine Gueye	33 860 36 22	Dakar	\N	\N	\N	f	\N
552	Cafe Layal (Mme Rabab Jaber Nee Kassem) Restauration (50), Import Export,	cafe-layal-mme-rabab-jaber-nee-kassem-restauration-50-import-export	Vente Cafe & Divers (30%), Boulangerie (20%)	\N	2	2026-03-02 23:11:11.712	2026-03-02 23:11:11.712	Vente Cafe & Divers (30%), Boulangerie (20%)	Rue Paul Holle	33 848 06 79	Dakar	\N	\N	\N	f	\N
553	Ibrahima Badiane	ibrahima-badiane	Commerce General	\N	2	2026-03-02 23:11:11.714	2026-03-02 23:11:11.714	Commerce General	Rue Fleurus 0 Dakar Burotech Sa Commerce General Almadies En Face Casino Dakar City	33 822 99 62	Dakar	\N	\N	\N	f	\N
554	Gie Touba Diene	gie-touba-diene	Commerce General Plles Assainies Unite 15 0 Dakar Dv Fashion Suarl Vente De Chaussures Central Park,	\N	2	2026-03-02 23:11:11.715	2026-03-02 23:11:11.715	Commerce General Plles Assainies Unite 15 0 Dakar Dv Fashion Suarl Vente De Chaussures Central Park,	Avenue Malick Sy X Autoroute Boutique N°217	33 868 28 67	Dakar	\N	\N	\N	f	\N
555	Pharmacie Moderne - Farid Boulos Chami	pharmacie-moderne-farid-boulos-chami	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.717	2026-03-02 23:11:11.717	Vente De Produits Pharmaceutiques	Rue Ousmane Soce Diop - Keury Souf - Rufisque	33 842 09 19	Rufisque	\N	\N	\N	f	\N
556	Modou Fall	modou-fall	Commerce Village De Keur Baaba Seye 0 Tivaouane Modou Fall Commerce Village De Keur Baba Seye Tivaouane 0 Dakar Albilad Trading Company Suarl Commerce General	\N	2	2026-03-02 23:11:11.719	2026-03-02 23:11:11.719	Commerce Village De Keur Baaba Seye 0 Tivaouane Modou Fall Commerce Village De Keur Baba Seye Tivaouane 0 Dakar Albilad Trading Company Suarl Commerce General	Rue Robert Brun 0 Ville Entreprise Activité Adresse Téléphone Dakar Seseck Distribution Suarl Commerce General Parcelles 8444 Bis Route Des Niayes Pikine 0 Dakar Pharmacie Teranga (Madeleine Diallo) Vente De Produits Pharmaceutiques Rue Du Docteur The ze	33 836 22 98	Tivaouane	\N	\N	\N	f	\N
557	Ets Hassan Attye	ets-hassan-attye	Commerce General	\N	2	2026-03-02 23:11:11.721	2026-03-02 23:11:11.721	Commerce General	Rue Galandou Diouf	33 822 13 17	Dakar	\N	\N	\N	f	\N
558	Aye Mamadou Lamine Niang	aye-mamadou-lamine-niang	Commerce General	\N	2	2026-03-02 23:11:11.723	2026-03-02 23:11:11.723	Commerce General	Quartier Angle Mousse Guediaw Aye	33 834 69 23	Guediaw	\N	\N	\N	f	\N
559	Ets Deggo	ets-deggo	Multiservices - Mamadou Kane Vente D'Aliments De Betail Et Produits Boulangerie	\N	2	2026-03-02 23:11:11.724	2026-03-02 23:11:11.724	Multiservices - Mamadou Kane Vente D'Aliments De Betail Et Produits Boulangerie	Quartier Santa Yalla N°16 Rufisque	33 824 04 64	Rufisque	\N	\N	\N	f	\N
560	Dap	dap	(Distribution Agroaliment Plus) Sarl Commerce General	\N	2	2026-03-02 23:11:11.726	2026-03-02 23:11:11.726	(Distribution Agroaliment Plus) Sarl Commerce General	Rue Marche Gueule Tapee Guediaw Aye	33 889 90 50	Dakar	\N	\N	\N	f	\N
561	Canex Suarl (Compagnie Africaine De Negoce Et D'Exportation)	canex-suarl-compagnie-africaine-de-negoce-et-d-exportation	Commerce-Btp Sacre Cœur Ii	\N	2	2026-03-02 23:11:11.728	2026-03-02 23:11:11.728	Commerce-Btp Sacre Cœur Ii	Imm Sokhna Astou Lo	33 836 46 16	Dakar	\N	\N	\N	f	\N
562	Cayor Technoplus Suarl	cayor-technoplus-suarl	Vente De Meubles Neufs Importes Liberte Vi Extension Not N° 18	\N	2	2026-03-02 23:11:11.73	2026-03-02 23:11:11.73	Vente De Meubles Neufs Importes Liberte Vi Extension Not N° 18	Route Du Front De Terre	77 666 38 87	Dakar	\N	\N	\N	f	\N
563	Pharmacie Arc En Ciel	pharmacie-arc-en-ciel	Vente De Produits Pharmaceutiques Ngor Almadies 0 Dakar Arpan Sarl Commerce Divers Sicap Liberte 6 0 Dakar Diami Suarl Commerce	\N	2	2026-03-02 23:11:11.731	2026-03-02 23:11:11.731	Vente De Produits Pharmaceutiques Ngor Almadies 0 Dakar Arpan Sarl Commerce Divers Sicap Liberte 6 0 Dakar Diami Suarl Commerce	Rue 9 X Canal 4 Point E	33 867 73 79	Dakar	\N	\N	\N	f	\N
564	Pharmacie Liberte (Magatte Ndiaye)	pharmacie-liberte-magatte-ndiaye	Vente De Produits Pharmaceutiques Sicap Liberte 3	\N	2	2026-03-02 23:11:11.733	2026-03-02 23:11:11.733	Vente De Produits Pharmaceutiques Sicap Liberte 3	Immeuble G Rond Point Jet D'Eau 33824 08 21 Dakar M Massamba Ndiaye Commerce Rue 39 X 34 Medina Dakar	33 837 75 26	Dakar	\N	\N	\N	f	\N
565	Pharmacie Carrefour - Medoune Thiam	pharmacie-carrefour-medoune-thiam	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.735	2026-03-02 23:11:11.735	Vente De Produits Pharmaceutiques	Avenue Bourguiba X Ch. A. Bamba - Castors	33 821 25 48	Dakar	\N	\N	\N	f	\N
566	Cadabra Shop Sarl	cadabra-shop-sarl	Commerce General - Habillement	\N	2	2026-03-02 23:11:11.737	2026-03-02 23:11:11.737	Commerce General - Habillement	Avenue Malick Sy	33 820 85 56	Dakar	\N	\N	\N	f	\N
567	Pharmacie Hafia - Ahmeth Diop	pharmacie-hafia-ahmeth-diop	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.738	2026-03-02 23:11:11.738	Vente De Produits Pharmaceutiques	Quartier Sinthia H oulata - Velingara	33 835 41 11	Velingara	\N	\N	\N	f	\N
568	Kassem Bazzouni	kassem-bazzouni	Commerce De Detergent Et Cosmetiques	\N	2	2026-03-02 23:11:11.74	2026-03-02 23:11:11.74	Commerce De Detergent Et Cosmetiques	Rue Galandou Di ouf	33 983 11 38	Dakar	\N	\N	\N	f	\N
569	Senegal Equip - Sarl	senegal-equip-sarl	Commerce De Mobilier De Bureau Canal Iv X	\N	2	2026-03-02 23:11:11.742	2026-03-02 23:11:11.742	Commerce De Mobilier De Bureau Canal Iv X	Avenue Che ikh Anta Diop	33 822 02 88	Dakar	\N	\N	\N	f	\N
570	Ets Hartmann Realisation Reparation	ets-hartmann-realisation-reparation	Vente Location Maintenance Compresseurs	\N	2	2026-03-02 23:11:11.743	2026-03-02 23:11:11.743	Vente Location Maintenance Compresseurs	Grue Chariot Eleveur Groupes Electrogenes Vehicules Travaux Publics Agricole Bccd	33 823 34 17	Dakar	\N	\N	\N	f	\N
571	Agrice Sarl Autres	agrice-sarl-autres	Commerces Hann Plage 0 Thies Surl Au Bon Marche (Alain Consol) Commerce	\N	2	2026-03-02 23:11:11.745	2026-03-02 23:11:11.745	Commerces Hann Plage 0 Thies Surl Au Bon Marche (Alain Consol) Commerce	Avenue General Degaulle - Thies	33 832 20 35	Dakar	\N	\N	\N	f	\N
572	Euro Meubles - Sarl	euro-meubles-sarl	Commerce De Meubles - Marchandises Diverses	\N	2	2026-03-02 23:11:11.747	2026-03-02 23:11:11.747	Commerce De Meubles - Marchandises Diverses	Avenue Lamine Gueye	33 951 18 24	Dakar	\N	\N	\N	f	\N
573	Youssoupha Lo	youssoupha-lo	Commerce General	\N	2	2026-03-02 23:11:11.748	2026-03-02 23:11:11.748	Commerce General	Rue 45 X 22 Medina 0 Saint-Louis Ste Diop Et Fils Sarl (Societe Diop Et Fils) Commerce Marche Sor 0 Dakar Carreaux Design - Suarl Commerce General Cite Cpi Vdn Comico Immeuble Toure	33 821 71 88	Dakar	\N	\N	\N	f	\N
574	Etablissement Gagni Cisse Sarl	etablissement-gagni-cisse-sarl	Commerce En Face Ex Garage Nioro Kaolack 0 Dakar Ets Js Keur Baba Laye (Jamal Mohamed Saleh) Commerce General	\N	2	2026-03-02 23:11:11.75	2026-03-02 23:11:11.75	Commerce En Face Ex Garage Nioro Kaolack 0 Dakar Ets Js Keur Baba Laye (Jamal Mohamed Saleh) Commerce General	Rue Galandou Diouf	33 867 95 80	Kaolack	\N	\N	\N	f	\N
575	Emc Suarl (Etablissements Mouride Construction - Suarl)	emc-suarl-etablissements-mouride-construction-suarl	Commerce General Camberene Croisement X	\N	2	2026-03-02 23:11:11.752	2026-03-02 23:11:11.752	Commerce General Camberene Croisement X	Autoroute	77 561 69 89	Dakar	\N	\N	\N	f	\N
576	Louzina Negoce	louzina-negoce	Distribution Commerce	\N	2	2026-03-02 23:11:11.753	2026-03-02 23:11:11.753	Distribution Commerce	Avenue Lamine Gueye	33 835 69 55	Dakar	\N	\N	\N	f	\N
577	Diaw Niang	diaw-niang	Commerce General	\N	2	2026-03-02 23:11:11.755	2026-03-02 23:11:11.755	Commerce General	Rue 62X63 Gueule Tapee 776455003 Kaolack Boutique Sami Dagher Commerce Leona Kaolack	33 842 56 00	Dakar	\N	\N	\N	f	\N
578	N'Ice Cream Sarl	n-ice-cream-sarl	Production Et Ventes De Cremes Glacees	\N	2	2026-03-02 23:11:11.757	2026-03-02 23:11:11.757	Production Et Ventes De Cremes Glacees	Avenue Andre Peytavin Immeuble Kebe	33 957 10 03	Dakar	\N	\N	\N	f	\N
579	Gie Keur Mame Samba	gie-keur-mame-samba	Vente De Gaz Grand-Yoff	\N	1	2026-03-02 23:11:11.758	2026-03-02 23:11:11.758	Vente De Gaz Grand-Yoff	Quartier Djeddah N° 831	33 824 34 34	Dakar	\N	\N	\N	f	\N
580	Bat Pres Suarl	bat-pres-suarl	Commerce General	\N	2	2026-03-02 23:11:11.76	2026-03-02 23:11:11.76	Commerce General	Bd Balley X Rue Administration N° 1 /B 0 Dakar Pharmacie Dial Diop (Dr Mame Anta Gueye) Vente De Produits Pharmaceutiques Parcelles Assainies Keur Massar - Unite 5 N° 120	33 835 00 27	Dakar	\N	\N	\N	f	\N
581	Entreprise Activité Adresse Téléphone Dakar W Akeur Borom Daradji (El Hadji Amar Diaw )	entreprise-activite-adresse-telephone-dakar-w-akeur-borom-daradji-el-hadji-amar-diaw	Commerce	\N	2	2026-03-02 23:11:11.762	2026-03-02 23:11:11.762	Commerce	Avenue General Degaulle	33 878 71 83	Ville	\N	\N	\N	f	\N
582	Pharmacie Du Boulevard (Dr Assane Diop)	pharmacie-du-boulevard-dr-assane-diop	Vente De Produits Pharmaceutiques Medina	\N	2	2026-03-02 23:11:11.763	2026-03-02 23:11:11.763	Vente De Produits Pharmaceutiques Medina	Rue 22X45	33 951 12 21	Dakar	\N	\N	\N	f	\N
583	Fb Sarl	fb-sarl	Commerce General	\N	2	2026-03-02 23:11:11.765	2026-03-02 23:11:11.765	Commerce General	Route Des Almadies	77 644 86 72	Dakar	\N	\N	\N	f	\N
584	W Akeur Khadim Suarl	w-akeur-khadim-suarl	Commerce General	\N	2	2026-03-02 23:11:11.767	2026-03-02 23:11:11.767	Commerce General	Avenue Blaise Diagne 33824 27 36 Thies Islam - Suarl Commerce Quartier Som 0 Dakar Pharmacie Ouakam (Nour Sarl ) Vente De Produits Pharmaceutiques Avenue Cheikh Anta Diop - Ouakam	33 820 65 54	Dakar	\N	\N	\N	f	\N
585	Aziz Business Company Suarl	aziz-business-company-suarl	Commerce	\N	2	2026-03-02 23:11:11.768	2026-03-02 23:11:11.768	Commerce	Quartier Mbode 2 Guediaw Aye	33 820 05 07	Dakar	\N	\N	\N	f	\N
586	Scpme Senegal Sarl	scpme-senegal-sarl	(Services Et Conseils Pour Mieux Entreprendre) Commerce D'Agendas & D'Objets D'Affaires	\N	2	2026-03-02 23:11:11.77	2026-03-02 23:11:11.77	(Services Et Conseils Pour Mieux Entreprendre) Commerce D'Agendas & D'Objets D'Affaires	Avenue Bour guiba	33 822 43 34	Dakar	\N	\N	\N	f	\N
587	Pharmacie Du Plateau - Georges Layousse	pharmacie-du-plateau-georges-layousse	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.772	2026-03-02 23:11:11.772	Vente De Produits Pharmaceutiques	Avenue Lamine Guey e X Carnot	77 572 06 21	Dakar	\N	\N	\N	f	\N
588	Pharmacie Mame Seynabou Diagne (Dr Moussa Alassane Gueye)	pharmacie-mame-seynabou-diagne-dr-moussa-alassane-gueye	Vente De Produits Pharmaceutiques Ouakam	\N	2	2026-03-02 23:11:11.774	2026-03-02 23:11:11.774	Vente De Produits Pharmaceutiques Ouakam	Quartier Bi ra	33 822 37 46	Dakar	\N	\N	\N	f	\N
589	Essarts Participations Autres	essarts-participations-autres	Commerce	\N	2	2026-03-02 23:11:11.776	2026-03-02 23:11:11.776	Commerce	Rue Ramez Bourgi 0 Dakar Centralvet Sarl Commerce General Sicap Dieuppeul 2 33 82512 64 Dakar Etablissement Ali & Freres Commerce General Rue Robert Brun 0 Dakar Sosachim Sarl Commerce General Route De Rufisque	33 820 67 53	Dakar	\N	\N	\N	f	\N
590	Apostrophe Senegal	apostrophe-senegal	Distribution Faconnage Decoupage Papiers	\N	2	2026-03-02 23:11:11.778	2026-03-02 23:11:11.778	Distribution Faconnage Decoupage Papiers	Avenue Mali ck Sy	33 821 68 63	Dakar	\N	\N	\N	f	\N
591	Balla Kebe	balla-kebe	Vente De Produits Finis Bambilor	\N	2	2026-03-02 23:11:11.78	2026-03-02 23:11:11.78	Vente De Produits Finis Bambilor	Quartier Ndiassane	33 825 65 92	Rufisque	\N	\N	\N	f	\N
592	Esc (Ets Soumare Et Compagnie)	esc-ets-soumare-et-compagnie	Commerce	\N	2	2026-03-02 23:11:11.782	2026-03-02 23:11:11.782	Commerce	Rue Raffenel	77 658 32 50	Dakar	\N	\N	\N	f	\N
593	Pharmacie Centrale (Ousmane Bao)	pharmacie-centrale-ousmane-bao	Vente De Produits Pharmaceutiques Nord	\N	2	2026-03-02 23:11:11.783	2026-03-02 23:11:11.783	Vente De Produits Pharmaceutiques Nord	Rue Khalifa A babacar Sy	33 823 41 08	Saint-Louis	\N	\N	\N	f	\N
594	Mme Veuve Saheli - Ets Mariam Daher Saheli	mme-veuve-saheli-ets-mariam-daher-saheli	Commerce General	\N	2	2026-03-02 23:11:11.785	2026-03-02 23:11:11.785	Commerce General	Rue Tolbiac	33 961 33 27	Dakar	\N	\N	\N	f	\N
595	Aye Pharmacie Thierno Seydou Mouhamadou Ba (Dr Aw A Ba)	aye-pharmacie-thierno-seydou-mouhamadou-ba-dr-aw-a-ba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.787	2026-03-02 23:11:11.787	Vente De Produits Pharmaceutiques	Quartier Notaire Face Centre De Sante Roi Baudoin	33 821 72 20	Guediaw	\N	\N	\N	f	\N
596	Aly Mohamed Kalach	aly-mohamed-kalach	Commerce	\N	2	2026-03-02 23:11:11.788	2026-03-02 23:11:11.788	Commerce	Avenue Lamine Gueye	33 822 73 93	Dakar	\N	\N	\N	f	\N
597	Tgi Suarl (Technic Graphic International)	tgi-suarl-technic-graphic-international	Vente De Produits D'Arts Graphiques Hlm Fass Paillot te Bat 6B 0 Dakar Serigne Naury Gaye Commerce	\N	2	2026-03-02 23:11:11.79	2026-03-02 23:11:11.79	Vente De Produits D'Arts Graphiques Hlm Fass Paillot te Bat 6B 0 Dakar Serigne Naury Gaye Commerce	Rue Fleurus 0 Dakar V.M Import Export Suarl Commerce General Route De L'Aeroport Est Almadies Lo t N° 180 0 Dakar Pharmacie Ibrahima - Amy Thiam Vente De Produits Pharmaceutiques Hlm Grand Yoff	33 835 52 90	Dakar	\N	\N	\N	f	\N
598	Socitech Senegal (Societe Internationale De Technologie)	socitech-senegal-societe-internationale-de-technologie	Vente Et Installation Du Système Informatique Allee Sacre Cœur 2 N° 8651	\N	2	2026-03-02 23:11:11.792	2026-03-02 23:11:11.792	Vente Et Installation Du Système Informatique Allee Sacre Cœur 2 N° 8651	Imm Mamou	33 827 94 83	Dakar	\N	\N	\N	f	\N
599	Senegal Negoce - Sarl	senegal-negoce-sarl	Commerce Pieces Detachees Automobiles	\N	2	2026-03-02 23:11:11.794	2026-03-02 23:11:11.794	Commerce Pieces Detachees Automobiles	Rue Felix Ebou e X Autoroute	33 949 13 68	Dakar	\N	\N	\N	f	\N
600	Egc (Entreprise Generale De	egc-entreprise-generale-de	Commerce - Papa Amadou Diop) Commerce General	\N	2	2026-03-02 23:11:11.796	2026-03-02 23:11:11.796	Commerce - Papa Amadou Diop) Commerce General	Quartier Takhikao	33 822 11 65	Thies	\N	\N	\N	f	\N
601	Pharmacie Mame Diarra (Arona Diakhate)	pharmacie-mame-diarra-arona-diakhate	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.798	2026-03-02 23:11:11.798	Vente De Produits Pharmaceutiques	Route De Dara Djol of Gouye Mbinde - Touba 0 Dakar B2G Industries Sa Commerce Materiels Electriques Et Electroniques Villa 110A, 1Er Etage Immeuble Bicis Hanne Mariste	33 952 22 52	Touba	\N	\N	\N	f	\N
602	Sbma (Societe Bara Mboup Alimentaire)	sbma-societe-bara-mboup-alimentaire	Commerce General	\N	2	2026-03-02 23:11:11.799	2026-03-02 23:11:11.799	Commerce General	Rue Robert Brun X Alfred Goux	33 832 87 57	Dakar	\N	\N	\N	f	\N
603	Genecom - Sarl (La Generale De	genecom-sarl-la-generale-de	Commerce) Commerce General	\N	2	2026-03-02 23:11:11.801	2026-03-02 23:11:11.801	Commerce) Commerce General	Rue Mbaye Gueye	33 834 22 97	Dakar	\N	\N	\N	f	\N
604	Ets Lo Bois Mouridoulahi (Gora Lo)	ets-lo-bois-mouridoulahi-gora-lo	Vente De Bois Et Derives Medina	\N	2	2026-03-02 23:11:11.803	2026-03-02 23:11:11.803	Vente De Bois Et Derives Medina	Rue 11 X Corniche Et 13 Medina	33 822 16 64	Dakar	\N	\N	\N	f	\N
605	Egb "Digital Store"	egb-digital-store	Vente De Materiels Et Consommables Informatique	\N	2	2026-03-02 23:11:11.805	2026-03-02 23:11:11.805	Vente De Materiels Et Consommables Informatique	Avenue Bourguiba Sicap Amitie N° 3082	33 860 53 52	Dakar	\N	\N	\N	f	\N
606	Pharmacie Front De Terre (Birane Ba)	pharmacie-front-de-terre-birane-ba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.807	2026-03-02 23:11:11.807	Vente De Produits Pharmaceutiques	Route Du Front De Terre - Face Gendarmerie	33 951 14 37	Dakar	\N	\N	\N	f	\N
607	Pharmacie Limamoulaye (Dr Maimouna Diop Diakite)	pharmacie-limamoulaye-dr-maimouna-diop-diakite	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.808	2026-03-02 23:11:11.808	Vente De Produits Pharmaceutiques	Quartier W Akhinan e - Guediaw Aye	33 825 57 06	Dakar	\N	\N	\N	f	\N
608	Sodeci - Sa (Ste De Developpement Economique Commerciale Et Industrielle)	sodeci-sa-ste-de-developpement-economique-commerciale-et-industrielle	Vente De Materiels D'Incendie	\N	2	2026-03-02 23:11:11.81	2026-03-02 23:11:11.81	Vente De Materiels D'Incendie	Bccd	33 824 07 74	Dakar	\N	\N	\N	f	\N
609	Station Total Podor (Papa Mar)	station-total-podor-papa-mar	Commerce De Produits Petroliers Podor 775351170 Ville Entreprise Activité Adresse Téléphone Dakar Soni Suarl Commerce General Place De L'Independance 0 Dakar Autocam Surl Vente De Pieces Detachees Automobiles	\N	1	2026-03-02 23:11:11.812	2026-03-02 23:11:11.812	Commerce De Produits Petroliers Podor 775351170 Ville Entreprise Activité Adresse Téléphone Dakar Soni Suarl Commerce General Place De L'Independance 0 Dakar Autocam Surl Vente De Pieces Detachees Automobiles	Rbccd, Route D u Service Geographique	33 825 09 02	Podor	\N	\N	\N	f	\N
610	Prosys Sarl	prosys-sarl	Commerce Divers	\N	2	2026-03-02 23:11:11.815	2026-03-02 23:11:11.815	Commerce Divers	Rue Felix Faure 33842 29 28 Pikine Socosen Sa (Societe Des Eaux De Consommation Du Senegal Sa) Exploitation Et Distribution D'Eau En Sachets Route De Rufisque	33 832 36 66	Dakar	\N	\N	\N	f	\N
611	Daara Sope Nabi	daara-sope-nabi	Commerce General Castors	\N	2	2026-03-02 23:11:11.817	2026-03-02 23:11:11.817	Commerce General Castors	Rue Ax4	33 853 23 42	Dakar	\N	\N	\N	f	\N
612	Pyramid Trading Sa	pyramid-trading-sa	Commerce General	\N	2	2026-03-02 23:11:11.819	2026-03-02 23:11:11.819	Commerce General	Bccd	33 824 59 74	Dakar	\N	\N	\N	f	\N
613	Mohamadou Diaw Ara	mohamadou-diaw-ara	Commerce	\N	2	2026-03-02 23:11:11.822	2026-03-02 23:11:11.822	Commerce	Rue Grasland X Petersen	33 823 24 14	Dakar	\N	\N	\N	f	\N
614	Pharmacie Ngor Oasis - Fatou Ndiaye	pharmacie-ngor-oasis-fatou-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.824	2026-03-02 23:11:11.824	Vente De Produits Pharmaceutiques	Route De Ngor - Ng or Oasis	77 572 02 54	Dakar	\N	\N	\N	f	\N
615	Pharmacie Du Marche - Mamadou W Aly Zoumarou	pharmacie-du-marche-mamadou-w-aly-zoumarou	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.826	2026-03-02 23:11:11.826	Vente De Produits Pharmaceutiques	Quartier Nord - Ta mbacounda 0 Dakar Salim Attype Ipub Commerce Ave Lamine Gueye	33 820 39 00	Tamba	\N	\N	\N	f	\N
616	Univers Communication Suarl	univers-communication-suarl	Vente De Marchandises	\N	2	2026-03-02 23:11:11.827	2026-03-02 23:11:11.827	Vente De Marchandises	Avenue Faidherbe	33 837 75 75	Dakar	\N	\N	\N	f	\N
617	Mfk Glace (Kayere Fatou) Fabrique Et	mfk-glace-kayere-fatou-fabrique-et	Commerce De Glace	\N	2	2026-03-02 23:11:11.829	2026-03-02 23:11:11.829	Commerce De Glace	Avenue Dodds Bar Ndar Toute	33 867 36 24	Saint-Louis	\N	\N	\N	f	\N
618	Quincaillerie De L'Etoile (Succession Feu Ahmed Chemali)	quincaillerie-de-l-etoile-succession-feu-ahmed-chemali	Commerce Quincaillerie	\N	1	2026-03-02 23:11:11.831	2026-03-02 23:11:11.831	Commerce Quincaillerie	Rue Fleurus	33 867 26 26	Dakar	\N	\N	\N	f	\N
619	Ets Ikary (Maurice Ikary Autres	ets-ikary-maurice-ikary-autres	Commerces - Quincaillerie Et Boulangerie	\N	2	2026-03-02 23:11:11.832	2026-03-02 23:11:11.832	Commerces - Quincaillerie Et Boulangerie	Rue Raffenel	33 835 59 95	Dakar	\N	\N	\N	f	\N
620	Pharmacie Nouvelle (Dr El Hadji Abdoulaye Dieng Pha rmacien)	pharmacie-nouvelle-dr-el-hadji-abdoulaye-dieng-pha-rmacien	Vente De Produits Pharmaceutiques Leona Kaolack 0 Dakar Enercom Afrique Suarl Vente De Materiel D'Energie	\N	1	2026-03-02 23:11:11.834	2026-03-02 23:11:11.834	Vente De Produits Pharmaceutiques Leona Kaolack 0 Dakar Enercom Afrique Suarl Vente De Materiel D'Energie	Avenue Cheikh A. Diop Imm. Rose Hall N°4 Mermoz	77 421 53 34	Kaolack	\N	\N	\N	f	\N
621	La Source Sarl (Ex - Daniel Gaffari)	la-source-sarl-ex-daniel-gaffari	Commerce	\N	2	2026-03-02 23:11:11.836	2026-03-02 23:11:11.836	Commerce	Rue Victor Hugo X Gomis	33 837 26 56	Dakar	\N	\N	\N	f	\N
622	Pharmacie Mere Bity (Dr Mamour Gaye)	pharmacie-mere-bity-dr-mamour-gaye	Vente De Produits Pharmaceutiques Parcelles Assainie s Unite 12 338227393 Dakar Soconed - Sarl (Societe Commerciale De Negoce Et De Distribution) Commerce General Grand	\N	2	2026-03-02 23:11:11.838	2026-03-02 23:11:11.838	Vente De Produits Pharmaceutiques Parcelles Assainie s Unite 12 338227393 Dakar Soconed - Sarl (Societe Commerciale De Negoce Et De Distribution) Commerce General Grand	Avenue Dial Diop	33 822 00 68	Dakar	\N	\N	\N	f	\N
623	Ahmadou Ka	ahmadou-ka	Vente De Marchandises	\N	2	2026-03-02 23:11:11.84	2026-03-02 23:11:11.84	Vente De Marchandises	Rue Poudriere Sor Saint Louis 0 Dakar Pharmacie Mame Diarra Bousso (Dr Amy Dieng Niang) Vente De Produits Pharmaceutiques Cite Soprim - Daka r	77 655 37 17	Saint-Louis	\N	\N	\N	f	\N
624	Kima Health Partner	kima-health-partner	Vente D'Equipements Produits Dispositifs Accessoire s Medicaux	\N	2	2026-03-02 23:11:11.842	2026-03-02 23:11:11.842	Vente D'Equipements Produits Dispositifs Accessoire s Medicaux	Rue 03 Mamelles Elevage Ouakam 0 Thies Etablissement Mohamed Ali Meroueh Commerce Rue Du Docteur Guillet - Thies	33 835 78 88	Dakar	\N	\N	\N	f	\N
625	Pharmacie Mabousso Thiam (Youga Fally Thiam)	pharmacie-mabousso-thiam-youga-fally-thiam	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.844	2026-03-02 23:11:11.844	Vente De Produits Pharmaceutiques	Route Du Front De Terre N° 11	33 955 50 87	Dakar	\N	\N	\N	f	\N
626	Pharmacie Renaissance - Suarl	pharmacie-renaissance-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.846	2026-03-02 23:11:11.846	Vente De Produits Pharmaceutiques	Quartier Santhiaba Ouakam Face Centre De Sante	33 827 40 68	Dakar	\N	\N	\N	f	\N
627	Plomberie Et Sanitaire (Radw Ane Darw Iche)	plomberie-et-sanitaire-radw-ane-darw-iche	Commerce General	\N	2	2026-03-02 23:11:11.847	2026-03-02 23:11:11.847	Commerce General	Rue Abdou Karim Bourgi	33 864 23 51	Dakar	\N	\N	\N	f	\N
628	Pharmacie Serigne Sohaibou Mbacke (Dr Mme Annette Seck Ndiaye)	pharmacie-serigne-sohaibou-mbacke-dr-mme-annette-seck-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.849	2026-03-02 23:11:11.849	Vente De Produits Pharmaceutiques	Avenue Cheikh Ahmadou Bamba X Rue G - Bopp	33 823 27 49	Dakar	\N	\N	\N	f	\N
629	Pharmacie Boury (Aly Cotto Ndiaye)	pharmacie-boury-aly-cotto-ndiaye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.852	2026-03-02 23:11:11.852	Vente De Produits Pharmaceutiques	Quartier Escale - Place Du Marche	33 824 68 17	Fatick	\N	\N	\N	f	\N
630	Certec Sa	certec-sa	Commerce General	\N	2	2026-03-02 23:11:11.854	2026-03-02 23:11:11.854	Commerce General	Rue 10 X Bourguiba ( Ex 6Rue Victor Hugo)	33 949 14 35	Dakar	\N	\N	\N	f	\N
631	Pharmacie Coope Suarl	pharmacie-coope-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.856	2026-03-02 23:11:11.856	Vente De Produits Pharmaceutiques	Quartier Usine Ben e Tally	33 822 05 17	Dakar	\N	\N	\N	f	\N
632	Pharmacie Dabakh Malick (Ndeye Marieme Gueye)	pharmacie-dabakh-malick-ndeye-marieme-gueye	Vente De Produits Pharmaceutiques Colobane -	\N	2	2026-03-02 23:11:11.858	2026-03-02 23:11:11.858	Vente De Produits Pharmaceutiques Colobane -	Route D e La Gendarmerie	33 820 07 32	Dakar	\N	\N	\N	f	\N
633	Dakar Chrono Sarl	dakar-chrono-sarl	Vente De Materiels Electriques Et Electroniques Aven ue Seydina Limamoulaye Foff 33820 66 56 Dakar Ets	\N	2	2026-03-02 23:11:11.86	2026-03-02 23:11:11.86	Vente De Materiels Electriques Et Electroniques Aven ue Seydina Limamoulaye Foff 33820 66 56 Dakar Ets	Abdoulaye Fall Et Fils (Abdoulaye Fall ) Commerce General Sicap Mermoz	33 824 03 06	Dakar	\N	\N	\N	f	\N
634	Deco Meubles - Mohamed Toufic Zeitoun Autres	deco-meubles-mohamed-toufic-zeitoun-autres	Commerces - Ammeublements - Equipements Et Pdts Menagers	\N	2	2026-03-02 23:11:11.861	2026-03-02 23:11:11.861	Commerces - Ammeublements - Equipements Et Pdts Menagers	Avenue Lamine Gueye	33 994 12 27	Dakar	\N	\N	\N	f	\N
635	Lpe (Le Professionnel De L'Electricite)	lpe-le-professionnel-de-l-electricite	Commerce	\N	1	2026-03-02 23:11:11.863	2026-03-02 23:11:11.863	Commerce	Rue Galandou Diouf	33 877 13 00	Dakar	\N	\N	\N	f	\N
636	Sedimel Sarl	sedimel-sarl	Distribution De Materiel Electriques	\N	2	2026-03-02 23:11:11.866	2026-03-02 23:11:11.866	Distribution De Materiel Electriques	Rue Fleurus X G alandou Diouf	77 645 67 41	Dakar	\N	\N	\N	f	\N
637	General Supply Company Sarl	general-supply-company-sarl	Commerce	\N	2	2026-03-02 23:11:11.868	2026-03-02 23:11:11.868	Commerce	Route De Ngor	33 822 96 40	Dakar	\N	\N	\N	f	\N
638	Entreprise Activité Adresse Téléphone Dakar Pharmacie Mourtala Falilou (Marie X. C. Edouard Ndiaye)	entreprise-activite-adresse-telephone-dakar-pharmacie-mourtala-falilou-marie-x-c-edouard-ndiaye	Vente De Produits Pharmaceutiques Ex	\N	2	2026-03-02 23:11:11.87	2026-03-02 23:11:11.87	Vente De Produits Pharmaceutiques Ex	Route De Camber ene X Autoroute Dalifort	33 820 81 38	Ville	\N	\N	\N	f	\N
639	Ets Assane Fardoune (Brahim S/C Hassane Fardoune)	ets-assane-fardoune-brahim-s-c-hassane-fardoune	Commerce	\N	2	2026-03-02 23:11:11.872	2026-03-02 23:11:11.872	Commerce	Rue Galandou Diouf	33 832 51 41	Dakar	\N	\N	\N	f	\N
640	Sirtex Surl	sirtex-surl	Commerce General	\N	2	2026-03-02 23:11:11.874	2026-03-02 23:11:11.874	Commerce General	Rue 17 X 22 Medina 0 Dakar Pharmacie Guediaw Aye - Abdoul Karim Safiedine Vente De Produits Pharmaceutiques Guediaw Aye - Parc elle 1225	33 822 98 25	Dakar	\N	\N	\N	f	\N
641	Pharmacie Aicha (Aissatou Gueye)	pharmacie-aicha-aissatou-gueye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.875	2026-03-02 23:11:11.875	Vente De Produits Pharmaceutiques	Route De Rufisque - W Akhinane 3 - Villa N° 292	33 820 55 81	Dakar	\N	\N	\N	f	\N
642	Ets Talla Kane (Moustapha Kane)	ets-talla-kane-moustapha-kane	Commerce Medina	\N	2	2026-03-02 23:11:11.877	2026-03-02 23:11:11.877	Commerce Medina	Rue 21 X 18 0 Pikine Pharmacie Nouvelle De Pikine (Ndeye Dieynaba Fall) Vente De Produits Pharmaceutiques Route Des Niayes Pikine Tally Tally Boumack Parcelle N° 1835	33 834 31 00	Dakar	\N	\N	\N	f	\N
643	Pharmacie El Mansour (Marianne Lo)	pharmacie-el-mansour-marianne-lo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.879	2026-03-02 23:11:11.879	Vente De Produits Pharmaceutiques	Bd Dial Diop - Gra nd Dakar	33 834 00 51	Dakar	\N	\N	\N	f	\N
644	Aziz Seck	aziz-seck	Vente De Marchandises	\N	2	2026-03-02 23:11:11.88	2026-03-02 23:11:11.88	Vente De Marchandises	Rue Faidherbe - Rufisque	33 824 91 25	Rufisque	\N	\N	\N	f	\N
645	Pharmacie Du Fleuve - Odile W Ehbe	pharmacie-du-fleuve-odile-w-ehbe	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.882	2026-03-02 23:11:11.882	Vente De Produits Pharmaceutiques	Avenue Moustapha Malick Gaye (Ex Route De Leybar) - Quartier Sor	33 827 32 71	Saint-Louis	\N	\N	\N	f	\N
646	Nsaap (Nouvelle Societe D'Assistance Et D'Approvisi onnement)	nsaap-nouvelle-societe-d-assistance-et-d-approvisi-onnement	Commerce Point E	\N	2	2026-03-02 23:11:11.884	2026-03-02 23:11:11.884	Commerce Point E	Rue 4 X A 0 Dakar Daroul Karim Surl Commerce Parcelles Assainies Unite 25 N° 395	33 961 11 30	Dakar	\N	\N	\N	f	\N
647	Pharmacie Serigne Abdou Khadre Mbacke	pharmacie-serigne-abdou-khadre-mbacke	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.885	2026-03-02 23:11:11.885	Vente De Produits Pharmaceutiques	Bd Maurice Gueye X Ousmane Soce Diop	33 835 84 64	Dakar	\N	\N	\N	f	\N
648	Pharmacie Du Rail (Joseph Sayegh)	pharmacie-du-rail-joseph-sayegh	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.887	2026-03-02 23:11:11.887	Vente De Produits Pharmaceutiques	Avenue Leopold Sed ar Senghor	33 944 74 36	Thies	\N	\N	\N	f	\N
650	Monsieur Mohamed Derw Iche	monsieur-mohamed-derw-iche	Commerce	\N	2	2026-03-02 23:11:11.892	2026-03-02 23:11:11.892	Commerce	Rue Galandou Diouf	33 835 97 83	Dakar	\N	\N	\N	f	\N
651	Comptoir Commercial Borom Darou	comptoir-commercial-borom-darou	Commerce General	\N	2	2026-03-02 23:11:11.894	2026-03-02 23:11:11.894	Commerce General	Rue Tolbiac	33 836 57 60	Dakar	\N	\N	\N	f	\N
652	Ripaille Sarl	ripaille-sarl	Production Et Distribution D'Œufs	\N	2	2026-03-02 23:11:11.896	2026-03-02 23:11:11.896	Production Et Distribution D'Œufs	Route De Thies	33 835 58 43	Dakar	\N	\N	\N	f	\N
653	Ibrahima Toure	ibrahima-toure-1	Commerce	\N	2	2026-03-02 23:11:11.899	2026-03-02 23:11:11.899	Commerce	Rue Fleurus 0 Thies Pharmacie Khadim Rassoul Vente De Produits Pharmaceutiques Thies 0 Dakar Europe Baches Sarl Commerce Rue Felix Eboue	77 639 42 20	Dakar	\N	\N	\N	f	\N
654	Pharmacie Mouminine	pharmacie-mouminine	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.901	2026-03-02 23:11:11.901	Vente De Produits Pharmaceutiques	Rue Max Berthet X Dispensaire (Ex = Rue El Hadj Sylla)	77 537 37 58	Diourbel	\N	\N	\N	f	\N
655	Pharmacie Bourguiba	pharmacie-bourguiba	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.904	2026-03-02 23:11:11.904	Vente De Produits Pharmaceutiques	Avenue Bourguiba	33 832 96 01	Dakar	\N	\N	\N	f	\N
656	Restofair Senegal Sarl	restofair-senegal-sarl	Commerce General	\N	2	2026-03-02 23:11:11.908	2026-03-02 23:11:11.908	Commerce General	Bccd 0 Dakar El Hadj Modou Anta Diop Commerce General Parc Lambaye Face Entree Pikine	33 824 59 92	Dakar	\N	\N	\N	f	\N
657	Gie Afrodis (Africaine De Representation Et De	gie-afrodis-africaine-de-representation-et-de	Distribution) Distribution Keur Massar	\N	2	2026-03-02 23:11:11.91	2026-03-02 23:11:11.91	Distribution) Distribution Keur Massar	Rue Khanue	33 834 03 25	Pikine	\N	\N	\N	f	\N
658	Pharmacie Daya (Dr Lanto Harivony Ravelona Rasoanaivo)	pharmacie-daya-dr-lanto-harivony-ravelona-rasoanaivo	Vente De Produits Pharmaceutiques Sicap Baobab -	\N	2	2026-03-02 23:11:11.912	2026-03-02 23:11:11.912	Vente De Produits Pharmaceutiques Sicap Baobab -	Rue Daya X Rue 10 -	77 426 54 93	Dakar	\N	\N	\N	f	\N
659	Ssb (Societe Senegalaise De Bureautique)	ssb-societe-senegalaise-de-bureautique	Commerce - Services Aux Entreprises Point E N° 1	\N	2	2026-03-02 23:11:11.914	2026-03-02 23:11:11.914	Commerce - Services Aux Entreprises Point E N° 1	Rue Des Ecrivains X Bd De L'Est	33 864 14 12	Dakar	\N	\N	\N	f	\N
660	Cleandis Suarl	cleandis-suarl	Commerce	\N	2	2026-03-02 23:11:11.916	2026-03-02 23:11:11.916	Commerce	Rue Mousse Diop	33 869 26 71	Dakar	\N	\N	\N	f	\N
661	Pms Suarl	pms-suarl	Commerce General	\N	2	2026-03-02 23:11:11.918	2026-03-02 23:11:11.918	Commerce General	Rue Sandiniery X Tolbiac	33 821 34 78	Dakar	\N	\N	\N	f	\N
662	Quincaillerie Khadim Rassoul (Mor Sall)	quincaillerie-khadim-rassoul-mor-sall	Commerce De Quincaillerie	\N	2	2026-03-02 23:11:11.92	2026-03-02 23:11:11.92	Commerce De Quincaillerie	Rue Fleurus X Ely Manel Fa ll Cantine N°105	33 827 54 76	Dakar	\N	\N	\N	f	\N
663	Pharmacie Mbouroise	pharmacie-mbouroise	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.922	2026-03-02 23:11:11.922	Vente De Produits Pharmaceutiques	Route De L'Hopital 0 Dakar Umt Technologies Sa Vente De Systemes De Traitement D'Eau Vdn Cite Des Jeunes Cadres Lebous - Liberte 6 Extension	33 822 96 40	Mbour	\N	\N	\N	f	\N
664	Pharmacie Dabakh Malick Gd Suarl	pharmacie-dabakh-malick-gd-suarl	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.925	2026-03-02 23:11:11.925	Vente De Produits Pharmaceutiques	Rue Abebe Bikila G rand Dakar 33824 70 90 Dakar Horizon Industries Commerce Liberte 6 Extention, Villa 03B 338279759 Dakar Pharmacie Biscuiterie (Rene Jean Carvalho) Vente De Produits Pharmaceutiques Niary Tally En Fac e Marche Nguellaw	33 867 13 90	Dakar	\N	\N	\N	f	\N
665	Papeterie Mokhtar Gueye	papeterie-mokhtar-gueye	Commerce General	\N	2	2026-03-02 23:11:11.927	2026-03-02 23:11:11.927	Commerce General	Rue 14 Colobane	33 864 43 38	Dakar	\N	\N	\N	f	\N
666	Diappo Sellal Ligguey Sarl	diappo-sellal-ligguey-sarl	Commerce	\N	2	2026-03-02 23:11:11.929	2026-03-02 23:11:11.929	Commerce	Rue Grasland X Fleurus Dakar	33 824 12 21	Dakar	\N	\N	\N	f	\N
714	Novosen Sa	novosen-sa	Commerce Materiel Informatique Point E -	\N	2	2026-03-02 23:11:12.058	2026-03-02 23:11:12.058	Commerce Materiel Informatique Point E -	Rue 4 Angle A -	33 821 82 35	Dakar	\N	\N	\N	f	\N
687	Boubacar Ndior (Geni)	boubacar-ndior-geni	Commerce General Sicap Liberte 1 N° 1317B 0 Dakar Sinpac Sarl (Societe D'Informatique De Papeterie Et De Commerce) Vente De Materiels Informatiques Et Audiovisuels Place De L'Independance 1Er Etage Porte	\N	2	2026-03-02 23:11:11.973	2026-03-02 23:11:11.973	Commerce General Sicap Liberte 1 N° 1317B 0 Dakar Sinpac Sarl (Societe D'Informatique De Papeterie Et De Commerce) Vente De Materiels Informatiques Et Audiovisuels Place De L'Independance 1Er Etage Porte	Immeuble Allumettes	33 823 39 50	Dakar	\N	\N	\N	f	\N
688	Pharmacie Du Saloum - Dame Mboup Seck	pharmacie-du-saloum-dame-mboup-seck	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:11.975	2026-03-02 23:11:11.975	Vente De Produits Pharmaceutiques	Avenue John F. Ken nedy - Kaolack	33 823 16 30	Kaolack	\N	\N	\N	f	\N
689	Sogemac (Sciete De Gestion Et D'Execution Des Marches)	sogemac-sciete-de-gestion-et-d-execution-des-marches	Commerce	\N	2	2026-03-02 23:11:11.978	2026-03-02 23:11:11.978	Commerce	Immeuble Fahd 6ème Étage, Bd El Hadji Djily Mbaye Immeuble Fahd 6ème Etage	77 637 67 70	Dakar	\N	\N	\N	f	\N
690	Mohamed Baroud	mohamed-baroud	Commerce Textile - Import/Export	\N	2	2026-03-02 23:11:11.98	2026-03-02 23:11:11.98	Commerce Textile - Import/Export	Avenue Lamine Gueye	33 823 94 52	Dakar	\N	\N	\N	f	\N
691	Mboubene Transport International Et Negoce	mboubene-transport-international-et-negoce	Commerce General 47,	\N	2	2026-03-02 23:11:11.981	2026-03-02 23:11:11.981	Commerce General 47,	Route Tivaoune Diacsao Poste Th iaroye 0 Rufisque Pharmacie Aliou Balde (Dr Abdoulaye Balde) Vente De Produits Pharmaceutiques Darou Salam - Sebi kotane 0 Saint-Louis Scmdf Sarl (Societe Commerciale Mamadou Diop Et Fils) Commerce General Marche Sor	33 835 00 35	Pikine	\N	\N	\N	f	\N
692	Fisapac Afrique Suarl	fisapac-afrique-suarl	Commerce Cite Comico Vdn	\N	2	2026-03-02 23:11:11.983	2026-03-02 23:11:11.983	Commerce Cite Comico Vdn	Immeuble N°6	33 961 35 92	Dakar	\N	\N	\N	f	\N
693	Gie L'Espoir De La Residence	gie-l-espoir-de-la-residence	Commerce	\N	2	2026-03-02 23:11:11.985	2026-03-02 23:11:11.985	Commerce	Quartier Leona 0 Dakar E.T.P (El Hadj Seck) Commerce General Et Btp Grand-Yoff Scat Urbam N° 16	33 827 27 71	Kaolack	\N	\N	\N	f	\N
694	Negosen Sarl	negosen-sarl	Commerce	\N	2	2026-03-02 23:11:11.987	2026-03-02 23:11:11.987	Commerce	Rue Robert Brun	77 638 74 25	Dakar	\N	\N	\N	f	\N
695	Moussa Sow "Fabemo"	moussa-sow-fabemo	Commerce	\N	2	2026-03-02 23:11:11.988	2026-03-02 23:11:11.988	Commerce	Rue 25 X 10 Medina 0 Kaolack Pharmacie Coumba Ndoffene Diouf (Khar Diouf) Vente De Produits Pharmaceutiques Quartier Boustane - Lot N° 1961	33 842 81 42	Dakar	\N	\N	\N	f	\N
696	Ets Alfa Umaro Djalo	ets-alfa-umaro-djalo	Commerce General	\N	2	2026-03-02 23:11:11.991	2026-03-02 23:11:11.991	Commerce General	Rue Reims X Mangin	33 941 52 37	Dakar	\N	\N	\N	f	\N
697	Super Utiles (Georges Cyrilles Ibanez)	super-utiles-georges-cyrilles-ibanez	Commerce	\N	2	2026-03-02 23:11:11.994	2026-03-02 23:11:11.994	Commerce	Route De Ngor Face Station Shell 0 Dakar Pharmacie De La Rue 6 Vente De Produits Pharmaceutiques Medina Rue 6 X 7	77 107 50 98	Dakar	\N	\N	\N	f	\N
698	Alimentation Produits Divers (Nasrine W Azni)	alimentation-produits-divers-nasrine-w-azni	Vente De Produits Divers	\N	2	2026-03-02 23:11:11.996	2026-03-02 23:11:11.996	Vente De Produits Divers	Rue Raffenel	33 821 14 48	Dakar	\N	\N	\N	f	\N
699	Agroseed (Ex Interface Trading)	agroseed-ex-interface-trading	Commerce De Semences	\N	2	2026-03-02 23:11:11.998	2026-03-02 23:11:11.998	Commerce De Semences	Rue 39 X Bd General De Gaulle (Immeuble Adja Mame Ndiaye - Rond Point Canal 4 Fass Paillote	33 823 91 86	Dakar	\N	\N	\N	f	\N
700	Laser Bureau Informatique	laser-bureau-informatique	Vente De Materiels Informatiques	\N	2	2026-03-02 23:11:12.001	2026-03-02 23:11:12.001	Vente De Materiels Informatiques	Immeuble Brachet Av Faidherbe X Dial Diop (Ex Rue El Hadji Mbaye Gueye)	33 822 85 52	Dakar	\N	\N	\N	f	\N
701	Sene Djeune - Sarl	sene-djeune-sarl	Commerce De Produits Halieutique Usine Ikagel Mballi ng	\N	2	2026-03-02 23:11:12.006	2026-03-02 23:11:12.006	Commerce De Produits Halieutique Usine Ikagel Mballi ng	Route De Joal Mbour	33 864 65 64	Mbour	\N	\N	\N	f	\N
702	Bss Sarl (Blue Skies Senegal Sarl)	bss-sarl-blue-skies-senegal-sarl	Commerce De Produits Agricoles	\N	2	2026-03-02 23:11:12.009	2026-03-02 23:11:12.009	Commerce De Produits Agricoles	Rue Galandou Diouf 0 Rufisque Pharmacie Astele Vente De Produits Pharmaceutiques Boulevard Maurice Gueye	33 957 39 39	Dakar	\N	\N	\N	f	\N
703	Eurotex (Lubna Gozaelle)	eurotex-lubna-gozaelle	Commerce	\N	2	2026-03-02 23:11:12.012	2026-03-02 23:11:12.012	Commerce	Avenue Blaise Diagne	33 878 12 34	Dakar	\N	\N	\N	f	\N
704	Harmattan Senegal Sarl	harmattan-senegal-sarl	Distribution De Livres Villa Rose	\N	2	2026-03-02 23:11:12.024	2026-03-02 23:11:12.024	Distribution De Livres Villa Rose	Rue De Diourbel X G Point E	33 823 27 17	Dakar	\N	\N	\N	f	\N
705	Informatique Expert	informatique-expert	Vente De Materiels Informatique	\N	2	2026-03-02 23:11:12.029	2026-03-02 23:11:12.029	Vente De Materiels Informatique	Boulevard Djily Mbay e Xrobert Delmas	33 836 30 44	Dakar	\N	\N	\N	f	\N
706	Pharmacie Demba Koita	pharmacie-demba-koita	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.032	2026-03-02 23:11:12.032	Vente De Produits Pharmaceutiques	Immeuble Hermes 1 App 3	33 842 97 27	Dakar	\N	\N	\N	f	\N
707	Ait Senegal	ait-senegal	Distribution Priduits Boulangers	\N	2	2026-03-02 23:11:12.035	2026-03-02 23:11:12.035	Distribution Priduits Boulangers	Route De Rufisque	33 834 80 67	Dakar	\N	\N	\N	f	\N
708	Pharmacie Salve Regina	pharmacie-salve-regina	Vente De Produits Pahrmaceutiques	\N	2	2026-03-02 23:11:12.039	2026-03-02 23:11:12.039	Vente De Produits Pahrmaceutiques	Route Du Golf Saly	33 820 70 73	Mbour	\N	\N	\N	f	\N
709	Pharmacie Du Boulevard (Mamadou Saliou Diallo)	pharmacie-du-boulevard-mamadou-saliou-diallo	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.043	2026-03-02 23:11:12.043	Vente De Produits Pharmaceutiques	Boulevard Cheikh I brahima Niass	33 951 14 23	Kaolack	\N	\N	\N	f	\N
710	Pharmacie Ly Dior	pharmacie-ly-dior	Vente De Produits Pharmaceutiques Vdn	\N	2	2026-03-02 23:11:12.046	2026-03-02 23:11:12.046	Vente De Produits Pharmaceutiques Vdn	Immeuble Maria ma X Sacre Cœur 3 Dakar 0 Dakar Esri Senegal Commerce General A1, Residence Asdi, 4421 Sicap Amit ie Iii	33 836 49 99	Dakar	\N	\N	\N	f	\N
711	Pharmacie Mama Nguedj	pharmacie-mama-nguedj	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.049	2026-03-02 23:11:12.049	Vente De Produits Pharmaceutiques	Quartier Afdaye - Joal	33 961 23 32	Joal	\N	\N	\N	f	\N
712	Pharmacie Ngorba (Dr Ngane Gueye)	pharmacie-ngorba-dr-ngane-gueye	Vente De Produits Pharmaceutiques	\N	2	2026-03-02 23:11:12.052	2026-03-02 23:11:12.052	Vente De Produits Pharmaceutiques	Rue Vincens X Esca rfait	33 957 62 35	Dakar	\N	\N	\N	f	\N
713	Centrale Papetiere - Elie Sabbagh	centrale-papetiere-elie-sabbagh	Commerce Papeterie	\N	2	2026-03-02 23:11:12.055	2026-03-02 23:11:12.055	Commerce Papeterie	Rue Assane Ndoye	33 955 20 25	Dakar	\N	\N	\N	f	\N
715	Didactika Sarl	didactika-sarl	Vente De Livres, De Materiels Didactiques Et De Supports Pedagogiques	\N	2	2026-03-02 23:11:12.061	2026-03-02 23:11:12.061	Vente De Livres, De Materiels Didactiques Et De Supports Pedagogiques	Rue Leo Frobenius X Ave Cheikh Anta Diop- Imm Seydi Djamil-Rez De Chaussee	33 982 21 60	Dakar	\N	\N	\N	f	\N
716	Sopasec Sarl	sopasec-sarl	Commerce	\N	2	2026-03-02 23:11:12.064	2026-03-02 23:11:12.064	Commerce	Rue Vincens	33 825 02 30	Dakar	\N	\N	\N	f	\N
\.


--
-- Data for Name: CompanyLocation; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."CompanyLocation" (id, "companyId", region, department, city, address, lat, lng, "isPrimary", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: CompanyScore; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."CompanyScore" (id, "companyId", "globalScore", "trustIndex", "totalReviews", "lastUpdated", "createdAt") FROM stdin;
\.


--
-- Data for Name: JobOffer; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."JobOffer" (id, title, description, salary, location, "companyId", "isActive", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: RatingCriteria; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."RatingCriteria" (id, name, description, weight, "isActive", "createdAt", "updatedAt") FROM stdin;
1	Qualité du service	Évaluation de la qualité globale du service fourni	1.5	t	2026-02-01 00:54:14.354	2026-02-01 00:54:14.354
2	Prix	Rapport qualité-prix des produits ou services	1	t	2026-02-01 00:54:14.354	2026-02-01 00:54:14.354
3	Transparence	Clarté et honnêteté dans les communications et transactions	1.3	t	2026-02-01 00:54:14.354	2026-02-01 00:54:14.354
4	Respect des délais	Capacité à respecter les délais convenus	1.2	t	2026-02-01 00:54:14.354	2026-02-01 00:54:14.354
5	Service client	Qualité de l'assistance et du support client	1.4	t	2026-02-01 00:54:14.354	2026-02-01 00:54:14.354
\.


--
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."Review" (id, rating, comment, "userId", "companyId", upvotes, downvotes, "createdAt", "updatedAt", context, status) FROM stdin;
4	1	Pas top	7	2850	3	2	2026-03-03 11:18:08.396	2026-03-03 11:18:19.716	CLIENT	PENDING
5	5	Good Job	7	1798	0	0	2026-03-03 11:18:49.048	2026-03-03 11:18:49.048	CLIENT	PENDING
6	4	Good	7	1269	0	0	2026-03-03 11:19:18.018	2026-03-03 11:19:18.018	CLIENT	PENDING
7	2	Pas top	5	2178	0	0	2026-03-03 11:52:18.942	2026-03-03 11:52:18.942	CLIENT	PENDING
8	2	Good.	5	2178	0	0	2026-03-03 11:53:32.73	2026-03-03 11:53:32.73	CLIENT	PENDING
9	2	Good	8	2225	0	0	2026-03-03 15:00:24.619	2026-03-03 15:00:24.619	CLIENT	PENDING
\.


--
-- Data for Name: ReviewScore; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."ReviewScore" (id, "reviewId", "criteriaId", score, "createdAt") FROM stdin;
\.


--
-- Data for Name: Subscription; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."Subscription" (id, "companyId", plan, "startDate", "endDate", "isActive", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."User" (id, username, email, password, role, "createdAt", "updatedAt", phone, "isVerified") FROM stdin;
1	trefle	trefle@email.com	$2b$10$XGxLcHbSocj42CUDqCHyZ.g5kALADFMBWP4tPkvJ6dAKU1oN/ch8e	USER	2026-01-31 00:20:37.529	2026-01-31 00:20:37.529	\N	f
2	malaw	sdndiaye01@gmail.com	$2b$10$kBDnNinM3N9OmjB4mQoNK.loL.BWnou2LBcIM6rCwfOmu9qIsecBi	USER	2026-02-01 13:31:06.538	2026-02-01 13:31:06.538	\N	f
3	Ngone 	mangonei3101@gmail.com	$2b$10$vwZ8qD6Ed87Cu/kgiZyiZe8.jKDoM9W/78JI5tr8OAY/gtrBsTc.y	USER	2026-02-02 17:14:52.062	2026-02-02 17:14:52.062	\N	f
4	Anna98	anna98@email.com	$2b$10$gfZdau.0VPFtWFFxAT/tpuNvhAhpxuO.WrZCUXvztheQ6Ks3B/.HS	USER	2026-02-04 09:15:01.897	2026-02-04 09:15:01.897	\N	f
5	Tijani	sdndiaye02@gmail.com	$2b$10$PbHAu198AyRl1Ws/DRHXouxQl3WgOdP03YsLKElhukAnayZ05ZL5W	USER	2026-03-03 06:20:05.806	2026-03-03 06:20:05.806	\N	f
6	myName	djibsone51@gmail.com	$2b$10$v7zoNaTwQJlwXM4Gi/xkH.3U8mBjOJJ.P/P0rQtahpIhxrCDM6TAa	USER	2026-03-03 08:04:59.146	2026-03-03 08:04:59.146	\N	f
7	LLM	djibril.ndiaye@uadb.edu.sn	$2b$10$2aZ9LaUe9D6SMXJHRLStO.FZAIauIVo4KjyzKufQ/2S7j6TKWm/le	USER	2026-03-03 11:09:11.465	2026-03-03 11:09:11.465	\N	f
8	007	anna@email.com	$2b$10$Kj1fC6iaxi7MDAuiS0rl.enahl/crYMCo1YWlTYP6YEUzG/eNmYCq	USER	2026-03-03 14:59:44.381	2026-03-03 14:59:44.381	\N	f
\.


--
-- Data for Name: UserProfile; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public."UserProfile" (id, "userId", "fullName", "profileType", "trustScore", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: echowork
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
3af86c0b-b988-46e5-b74b-85d711ccb7ee	ee9ace46968066b05c3acc5a1e30558b06072f68bf048beda3d44430031b8cd2	2026-01-30 20:50:34.494749+01	20260127202849_init	\N	\N	2026-01-30 20:50:34.455668+01	1
ee1ed3e2-e50e-4e7d-9df5-cff9572d9957	4b68ce7fdff4f35ff0338c4a8fcce4ca3e385cedfba4f10daeb4a4304a0249c3	2026-01-30 20:50:34.498867+01	20260127225049_init	\N	\N	2026-01-30 20:50:34.495948+01	1
14ebacc0-5f9a-4671-86ca-9468645ce7e0	9d510678f8d8b061bd2943cfea340293373af960e2b7a66e50a261053d131eea	2026-01-30 20:50:34.503305+01	20260128170642_make_email_required	\N	\N	2026-01-30 20:50:34.499489+01	1
8a350168-ac81-46b4-9b5c-9154067aa022	204f4b934f7efdc7a1993044d3454b2b22eef8275cd0f8b32d98c98df3b03d0d	2026-02-01 00:54:14.867754+01	20260131180900_restructure_database	\N	\N	2026-02-01 00:54:14.351479+01	1
2b38819c-b155-4e90-84df-a5613ff33e0b	0b77e58d6c1f73b651a0cd2786a52a0d89e594ed998ef62aab3e737c63cc3247	2026-03-03 00:03:46.665094+01	20260131190658_init	\N	\N	2026-03-03 00:03:46.627513+01	1
\.


--
-- Name: Advertisement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."Advertisement_id_seq"', 1, false);


--
-- Name: CategoryKeyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."CategoryKeyword_id_seq"', 1, false);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."Category_id_seq"', 15, true);


--
-- Name: CompanyLocation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."CompanyLocation_id_seq"', 5216, true);


--
-- Name: CompanyScore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."CompanyScore_id_seq"', 5216, true);


--
-- Name: Company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."Company_id_seq"', 3066, true);


--
-- Name: JobOffer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."JobOffer_id_seq"', 1, false);


--
-- Name: RatingCriteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."RatingCriteria_id_seq"', 5, true);


--
-- Name: ReviewScore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."ReviewScore_id_seq"', 1, false);


--
-- Name: Review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."Review_id_seq"', 9, true);


--
-- Name: Subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."Subscription_id_seq"', 5216, true);


--
-- Name: UserProfile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."UserProfile_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: echowork
--

SELECT pg_catalog.setval('public."User_id_seq"', 8, true);


--
-- Name: Advertisement Advertisement_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Advertisement"
    ADD CONSTRAINT "Advertisement_pkey" PRIMARY KEY (id);


--
-- Name: CategoryKeyword CategoryKeyword_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CategoryKeyword"
    ADD CONSTRAINT "CategoryKeyword_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: CompanyLocation CompanyLocation_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CompanyLocation"
    ADD CONSTRAINT "CompanyLocation_pkey" PRIMARY KEY (id);


--
-- Name: CompanyScore CompanyScore_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CompanyScore"
    ADD CONSTRAINT "CompanyScore_pkey" PRIMARY KEY (id);


--
-- Name: Company Company_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);


--
-- Name: JobOffer JobOffer_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."JobOffer"
    ADD CONSTRAINT "JobOffer_pkey" PRIMARY KEY (id);


--
-- Name: RatingCriteria RatingCriteria_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."RatingCriteria"
    ADD CONSTRAINT "RatingCriteria_pkey" PRIMARY KEY (id);


--
-- Name: ReviewScore ReviewScore_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."ReviewScore"
    ADD CONSTRAINT "ReviewScore_pkey" PRIMARY KEY (id);


--
-- Name: Review Review_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_pkey" PRIMARY KEY (id);


--
-- Name: Subscription Subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Subscription"
    ADD CONSTRAINT "Subscription_pkey" PRIMARY KEY (id);


--
-- Name: UserProfile UserProfile_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."UserProfile"
    ADD CONSTRAINT "UserProfile_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Advertisement_companyId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Advertisement_companyId_idx" ON public."Advertisement" USING btree ("companyId");


--
-- Name: Advertisement_isActive_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Advertisement_isActive_idx" ON public."Advertisement" USING btree ("isActive");


--
-- Name: Advertisement_startDate_endDate_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Advertisement_startDate_endDate_idx" ON public."Advertisement" USING btree ("startDate", "endDate");


--
-- Name: Advertisement_status_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Advertisement_status_idx" ON public."Advertisement" USING btree (status);


--
-- Name: Advertisement_type_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Advertisement_type_idx" ON public."Advertisement" USING btree (type);


--
-- Name: CategoryKeyword_categoryId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "CategoryKeyword_categoryId_idx" ON public."CategoryKeyword" USING btree ("categoryId");


--
-- Name: CategoryKeyword_keyword_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "CategoryKeyword_keyword_idx" ON public."CategoryKeyword" USING btree (keyword);


--
-- Name: Category_parentId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Category_parentId_idx" ON public."Category" USING btree ("parentId");


--
-- Name: Category_slug_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Category_slug_idx" ON public."Category" USING btree (slug);


--
-- Name: Category_slug_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "Category_slug_key" ON public."Category" USING btree (slug);


--
-- Name: CompanyLocation_city_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "CompanyLocation_city_idx" ON public."CompanyLocation" USING btree (city);


--
-- Name: CompanyLocation_companyId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "CompanyLocation_companyId_idx" ON public."CompanyLocation" USING btree ("companyId");


--
-- Name: CompanyLocation_region_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "CompanyLocation_region_idx" ON public."CompanyLocation" USING btree (region);


--
-- Name: CompanyScore_companyId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "CompanyScore_companyId_idx" ON public."CompanyScore" USING btree ("companyId");


--
-- Name: CompanyScore_companyId_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "CompanyScore_companyId_key" ON public."CompanyScore" USING btree ("companyId");


--
-- Name: CompanyScore_globalScore_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "CompanyScore_globalScore_idx" ON public."CompanyScore" USING btree ("globalScore");


--
-- Name: CompanyScore_trustIndex_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "CompanyScore_trustIndex_idx" ON public."CompanyScore" USING btree ("trustIndex");


--
-- Name: Company_categoryId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Company_categoryId_idx" ON public."Company" USING btree ("categoryId");


--
-- Name: Company_claimedByUserId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Company_claimedByUserId_idx" ON public."Company" USING btree ("claimedByUserId");


--
-- Name: Company_isVerified_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Company_isVerified_idx" ON public."Company" USING btree ("isVerified");


--
-- Name: Company_name_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Company_name_idx" ON public."Company" USING btree (name);


--
-- Name: Company_ninea_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Company_ninea_idx" ON public."Company" USING btree (ninea);


--
-- Name: Company_ninea_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "Company_ninea_key" ON public."Company" USING btree (ninea);


--
-- Name: Company_slug_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Company_slug_idx" ON public."Company" USING btree (slug);


--
-- Name: Company_slug_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "Company_slug_key" ON public."Company" USING btree (slug);


--
-- Name: JobOffer_companyId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "JobOffer_companyId_idx" ON public."JobOffer" USING btree ("companyId");


--
-- Name: JobOffer_isActive_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "JobOffer_isActive_idx" ON public."JobOffer" USING btree ("isActive");


--
-- Name: RatingCriteria_isActive_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "RatingCriteria_isActive_idx" ON public."RatingCriteria" USING btree ("isActive");


--
-- Name: ReviewScore_criteriaId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "ReviewScore_criteriaId_idx" ON public."ReviewScore" USING btree ("criteriaId");


--
-- Name: ReviewScore_reviewId_criteriaId_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "ReviewScore_reviewId_criteriaId_key" ON public."ReviewScore" USING btree ("reviewId", "criteriaId");


--
-- Name: ReviewScore_reviewId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "ReviewScore_reviewId_idx" ON public."ReviewScore" USING btree ("reviewId");


--
-- Name: ReviewScore_score_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "ReviewScore_score_idx" ON public."ReviewScore" USING btree (score);


--
-- Name: Review_companyId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Review_companyId_idx" ON public."Review" USING btree ("companyId");


--
-- Name: Review_context_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Review_context_idx" ON public."Review" USING btree (context);


--
-- Name: Review_rating_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Review_rating_idx" ON public."Review" USING btree (rating);


--
-- Name: Review_status_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Review_status_idx" ON public."Review" USING btree (status);


--
-- Name: Review_userId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Review_userId_idx" ON public."Review" USING btree ("userId");


--
-- Name: Subscription_companyId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Subscription_companyId_idx" ON public."Subscription" USING btree ("companyId");


--
-- Name: Subscription_companyId_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "Subscription_companyId_key" ON public."Subscription" USING btree ("companyId");


--
-- Name: Subscription_endDate_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Subscription_endDate_idx" ON public."Subscription" USING btree ("endDate");


--
-- Name: Subscription_isActive_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Subscription_isActive_idx" ON public."Subscription" USING btree ("isActive");


--
-- Name: Subscription_plan_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "Subscription_plan_idx" ON public."Subscription" USING btree (plan);


--
-- Name: UserProfile_trustScore_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "UserProfile_trustScore_idx" ON public."UserProfile" USING btree ("trustScore");


--
-- Name: UserProfile_userId_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "UserProfile_userId_idx" ON public."UserProfile" USING btree ("userId");


--
-- Name: UserProfile_userId_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "UserProfile_userId_key" ON public."UserProfile" USING btree ("userId");


--
-- Name: User_email_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "User_email_idx" ON public."User" USING btree (email);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_username_idx; Type: INDEX; Schema: public; Owner: echowork
--

CREATE INDEX "User_username_idx" ON public."User" USING btree (username);


--
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: echowork
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- Name: Advertisement Advertisement_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Advertisement"
    ADD CONSTRAINT "Advertisement_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CategoryKeyword CategoryKeyword_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CategoryKeyword"
    ADD CONSTRAINT "CategoryKeyword_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Category Category_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CompanyLocation CompanyLocation_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CompanyLocation"
    ADD CONSTRAINT "CompanyLocation_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CompanyScore CompanyScore_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."CompanyScore"
    ADD CONSTRAINT "CompanyScore_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Company Company_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Company Company_claimedByUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_claimedByUserId_fkey" FOREIGN KEY ("claimedByUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: JobOffer JobOffer_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."JobOffer"
    ADD CONSTRAINT "JobOffer_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ReviewScore ReviewScore_criteriaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."ReviewScore"
    ADD CONSTRAINT "ReviewScore_criteriaId_fkey" FOREIGN KEY ("criteriaId") REFERENCES public."RatingCriteria"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ReviewScore ReviewScore_reviewId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."ReviewScore"
    ADD CONSTRAINT "ReviewScore_reviewId_fkey" FOREIGN KEY ("reviewId") REFERENCES public."Review"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Review Review_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Review Review_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Subscription Subscription_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."Subscription"
    ADD CONSTRAINT "Subscription_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public."Company"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserProfile UserProfile_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: echowork
--

ALTER TABLE ONLY public."UserProfile"
    ADD CONSTRAINT "UserProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict ALPqOyVp7chy3YUjZWNv33E80LfUJqP6UmXQrMYkA7WZgE8LbCEd5hbaqwVthsQ

