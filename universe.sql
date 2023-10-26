--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(255) NOT NULL,
    size_ly numeric(10,2),
    distance_mly numeric(10,2),
    confirmed_life boolean
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(255) NOT NULL,
    planet_id integer,
    periapsis_km integer,
    apoapsis_km integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(255) NOT NULL,
    star_id integer,
    distance_from_star numeric(10,2),
    distance_from_earth numeric(10,2),
    in_habitable_zone boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: COLUMN planet.distance_from_star; Type: COMMENT; Schema: public; Owner: freecodecamp
--

COMMENT ON COLUMN public.planet.distance_from_star IS 'Distance in millions of kilometers';


--
-- Name: COLUMN planet.distance_from_earth; Type: COMMENT; Schema: public; Owner: freecodecamp
--

COMMENT ON COLUMN public.planet.distance_from_earth IS 'Distance in millions of kilometers';


--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(255) NOT NULL,
    galaxy_id integer,
    star_type_id integer,
    age_by numeric(5,1)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: star_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star_type (
    star_type_id integer NOT NULL,
    name character varying(1) NOT NULL,
    chromacity text
);


ALTER TABLE public.star_type OWNER TO freecodecamp;

--
-- Name: TABLE star_type; Type: COMMENT; Schema: public; Owner: freecodecamp
--

COMMENT ON TABLE public.star_type IS 'Based on Harvard classification';


--
-- Name: star_types_star_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_types_star_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_types_star_type_id_seq OWNER TO freecodecamp;

--
-- Name: star_types_star_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_types_star_type_id_seq OWNED BY public.star_type.star_type_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: star_type star_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type ALTER COLUMN star_type_id SET DEFAULT nextval('public.star_types_star_type_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (7, 'Comet Galaxy', 600000.00, 3800000.00, false);
INSERT INTO public.galaxy VALUES (6, 'Messier 82', 40800.00, 11.40, false);
INSERT INTO public.galaxy VALUES (5, 'Cartwheel Galaxy', 144300.00, 500.00, false);
INSERT INTO public.galaxy VALUES (4, 'Messier 81', 96000.00, NULL, false);
INSERT INTO public.galaxy VALUES (3, 'Black Eye Galaxy', 53800.00, 17.30, false);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 152000.00, 2.50, false);
INSERT INTO public.galaxy VALUES (1, 'The Milky Way', 87400.00, NULL, true);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Phobos', 4, 9234, 9517);
INSERT INTO public.moon VALUES (2, 'Deimos', 4, 23455, 23470);
INSERT INTO public.moon VALUES (3, 'Luna', 1, 362600, 405400);
INSERT INTO public.moon VALUES (4, 'Epimetheus', 6, NULL, NULL);
INSERT INTO public.moon VALUES (5, 'Narvi', 6, NULL, NULL);
INSERT INTO public.moon VALUES (6, 'Mimas', 6, 181902, 189176);
INSERT INTO public.moon VALUES (7, 'Siarnaq', 6, NULL, NULL);
INSERT INTO public.moon VALUES (8, 'Greip', 6, NULL, NULL);
INSERT INTO public.moon VALUES (9, 'Janus', 6, NULL, NULL);
INSERT INTO public.moon VALUES (10, 'Satuungr', 6, NULL, NULL);
INSERT INTO public.moon VALUES (11, 'Pallene', 6, NULL, NULL);
INSERT INTO public.moon VALUES (12, 'Hyrrokkin', 6, NULL, NULL);
INSERT INTO public.moon VALUES (13, 'Aegir', 6, NULL, NULL);
INSERT INTO public.moon VALUES (14, 'Daphnis', 6, NULL, NULL);
INSERT INTO public.moon VALUES (15, 'Fenrir', 6, NULL, NULL);
INSERT INTO public.moon VALUES (16, 'Bergelmir', 6, NULL, NULL);
INSERT INTO public.moon VALUES (17, 'Bebhionn', 6, NULL, NULL);
INSERT INTO public.moon VALUES (18, 'Pandora', 6, NULL, NULL);
INSERT INTO public.moon VALUES (19, 'Iapetus', 6, NULL, NULL);
INSERT INTO public.moon VALUES (20, 'Helene', 6, NULL, NULL);
INSERT INTO public.moon VALUES (21, 'Aegaeon', 6, NULL, NULL);
INSERT INTO public.moon VALUES (22, 'Dione', 6, NULL, NULL);
INSERT INTO public.moon VALUES (23, 'Tethys', 6, NULL, NULL);
INSERT INTO public.moon VALUES (24, 'Calypso', 6, NULL, NULL);
INSERT INTO public.moon VALUES (25, 'Titan', 6, 1186680, 1257060);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 3, 149.60, 0.00, true);
INSERT INTO public.planet VALUES (2, 'Mercury', 3, 57.90, 82.50, false);
INSERT INTO public.planet VALUES (3, 'Venus', 3, 108.20, 39.79, false);
INSERT INTO public.planet VALUES (5, 'Jupiter', 3, 778.60, 591.70, false);
INSERT INTO public.planet VALUES (6, 'Saturn', 3, 1433.50, 1204.24, false);
INSERT INTO public.planet VALUES (7, 'Uranus', 3, 2872.50, 2586.88, false);
INSERT INTO public.planet VALUES (8, 'Neptune', 3, 4495.10, 4311.02, false);
INSERT INTO public.planet VALUES (4, 'Mars', 3, 227.90, 55.65, true);
INSERT INTO public.planet VALUES (9, 'Kepler-62f', 2, 107.40, NULL, true);
INSERT INTO public.planet VALUES (10, 'Kepler-186f', 8, 64.00, NULL, true);
INSERT INTO public.planet VALUES (11, 'Kepler-62e', 2, 62.83, NULL, true);
INSERT INTO public.planet VALUES (12, 'Kepler-62b', 2, 8.27, NULL, false);
INSERT INTO public.planet VALUES (13, 'Kepler-62c', 2, 13.90, NULL, false);
INSERT INTO public.planet VALUES (14, 'Kepler-62d', 2, 17.90, NULL, false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'S Monocerotis', 1, 1, NULL);
INSERT INTO public.star VALUES (2, 'Kepler-62', 1, 6, NULL);
INSERT INTO public.star VALUES (4, 'Rigel', 1, 2, NULL);
INSERT INTO public.star VALUES (5, 'Vega', 1, 3, NULL);
INSERT INTO public.star VALUES (6, 'Procyon', 1, 4, NULL);
INSERT INTO public.star VALUES (7, 'Betelgeuse', 1, 7, NULL);
INSERT INTO public.star VALUES (3, 'Sun', 1, 5, NULL);
INSERT INTO public.star VALUES (8, 'Kepler-186', 1, 7, NULL);


--
-- Data for Name: star_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star_type VALUES (1, 'O', 'blue');
INSERT INTO public.star_type VALUES (2, 'B', 'deep bluish white');
INSERT INTO public.star_type VALUES (3, 'A', 'bluish white');
INSERT INTO public.star_type VALUES (4, 'F', 'white');
INSERT INTO public.star_type VALUES (5, 'G', 'yellowish white');
INSERT INTO public.star_type VALUES (6, 'K', 'pale yellowish orange');
INSERT INTO public.star_type VALUES (7, 'M', 'light orangish red');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 7, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 25, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 14, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 8, true);


--
-- Name: star_types_star_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_types_star_type_id_seq', 7, true);


--
-- Name: star_type class; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT class UNIQUE (name);


--
-- Name: galaxy galaxy_names; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_names UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_names; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_names UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_names; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_names UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_names; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_names UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star_type star_types_class_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_types_class_key UNIQUE (name);


--
-- Name: star_type star_types_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_types_pkey PRIMARY KEY (star_type_id);


--
-- Name: star unique_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star star_star_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_star_type_id_fkey FOREIGN KEY (star_type_id) REFERENCES public.star_type(star_type_id);


--
-- PostgreSQL database dump complete
--

