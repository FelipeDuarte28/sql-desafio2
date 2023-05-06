--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

-- Started on 2023-05-06 16:27:08

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

DROP DATABASE "desafio2-felipe-duarte-123";
--
-- TOC entry 3308 (class 1262 OID 24582)
-- Name: desafio2-felipe-duarte-123; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "desafio2-felipe-duarte-123" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';


ALTER DATABASE "desafio2-felipe-duarte-123" OWNER TO postgres;

\connect -reuse-previous=on "dbname='desafio2-felipe-duarte-123'"

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
-- TOC entry 209 (class 1259 OID 24583)
-- Name: inscritos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscritos (
    cantidad integer,
    fecha date,
    fuente character varying
);


ALTER TABLE public.inscritos OWNER TO postgres;

--
-- TOC entry 3302 (class 0 OID 24583)
-- Dependencies: 209
-- Data for Name: inscritos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (44, '2021-01-01', 'Blog');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (56, '2021-01-01', 'Página');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (39, '2021-02-01', 'Blog');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (81, '2021-02-01', 'Página');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (12, '2021-03-01', 'Blog');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (91, '2021-03-01', 'Página');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (48, '2021-04-01', 'Blog');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (45, '2021-04-01', 'Página');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (55, '2021-05-01', 'Blog');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (33, '2021-05-01', 'Página');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (18, '2021-06-01', 'Blog');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (12, '2021-06-01', 'Página');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (34, '2021-07-01', 'Blog');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (24, '2021-07-01', 'Página');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (83, '2021-08-01', 'Blog');
INSERT INTO public.inscritos (cantidad, fecha, fuente) VALUES (99, '2021-08-01', 'Página');


-- Completed on 2023-05-06 16:27:08

--
-- PostgreSQL database dump complete
--

-- 1 ¿Cuántos registros hay?
SELECT COUNT(*) 
FROM inscritos;

-- 2 ¿Cuántos inscritos hay en total?
SELECT SUM(cantidad) 
FROM inscritos;

-- 3 ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT * 
FROM inscritos
WHERE fecha = (SELECT MIN(fecha) 
			   FROM inscritos);

-- 4 ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)
SELECT SUM(cantidad), fecha 
FROM inscritos 
GROUP BY fecha;

-- 5 ¿Cuántos inscritos hay por fuente?
SELECT SUM(cantidad), fuente 
FROM inscritos 
GROUP BY fuente;

-- 6 ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?
SELECT SUM(cantidad) AS cant, fecha 
FROM inscritos 
GROUP BY fecha
ORDER BY cant DESC
LIMIT 1;

-- 7 ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas personas fueron?
SELECT SUM(cantidad) AS cant, fecha, fuente 
FROM inscritos
WHERE fuente = 'Blog'
GROUP BY fecha, fuente
ORDER BY cant DESC
LIMIT 1;

-- 8 ¿Cuántas personas en promedio se inscriben en un día?
SELECT AVG(cant) AS promedio_dia
FROM (SELECT SUM(cantidad) AS cant, fecha 
	  FROM inscritos 
	  GROUP BY fecha) AS cantidad_por_dia;

-- 9 ¿Qué días se inscribieron más de 50 personas?
SELECT SUM(cantidad) AS sum_cantidad, fecha 
FROM inscritos 
GROUP BY fecha
HAVING SUM(cantidad) > 50
ORDER BY sum_cantidad DESC;

-- 10 ¿Cuántas personas se registraron en promedio cada día a partir del tercer día?
SELECT AVG(cant) AS promedio_dia
FROM (SELECT SUM(cantidad) AS cant, fecha 
	  FROM inscritos
	  WHERE fecha >= '01/03/2021'
	  GROUP BY fecha) AS cantidad_por_dia;