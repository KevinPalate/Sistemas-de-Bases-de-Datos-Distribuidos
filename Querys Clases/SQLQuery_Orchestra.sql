-- Database: orquesta

-- DROP DATABASE IF EXISTS orquesta;

CREATE DATABASE orquesta
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Ecuador.1252'
    LC_CTYPE = 'Spanish_Ecuador.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

create table orchestras (
id int primary key,
name varchar(32) not null,
rating decimal not null,
city_origin varchar(32) not null,
country_origin varchar(32) not null,
year int not null);

create table members (
id int primary key,
name varchar(64) not null,
position varchar(32) not null,
experience int not null,
orchestra_id int not null references orchestras(id),
wage int not null);

create table concerts (
id int primary key,
city varchar(64) not null,
country varchar(32) not null,
year int not null,
rating decimal not null,
orchestra_id int not null references orchestras(id));

-- 5 ORCHESTRAS
INSERT INTO orchestras (id, name, rating, city_origin, country_origin, year) VALUES
(1, 'Sinfonietta Quito', 4.5, 'Quito', 'Ecuador', 1990),
(2, 'Filarmónica Guayaquil', 4.8, 'Guayaquil', 'Ecuador', 1985),
(3, 'Orquesta Andes', 4.2, 'Cuenca', 'Ecuador', 2000),
(4, 'Orquesta Nacional de Quito', 4.9, 'Quito', 'Ecuador', 1975),
(5, 'Orquesta del Pacífico', 4.3, 'Guayaquil', 'Ecuador', 1995);

-- 20 MEMBERS distribuidos entre 5 orquestas
INSERT INTO members (id, name, position, experience, orchestra_id, wage) VALUES
(1, 'Juan Pérez', 'Violin', 10, 1, 1500),
(2, 'Ana Torres', 'Cello', 12, 1, 1600),
(3, 'Carlos López', 'Flute', 8, 1, 1400),
(4, 'María Fernández', 'Viola', 15, 1, 1700),
(5, 'Luis García', 'Trumpet', 7, 2, 1300),
(6, 'Sofía Castro', 'Timpani', 9, 2, 1350),
(7, 'David Morales', 'Oboe', 11, 2, 1550),
(8, 'Lucía Ramos', 'Clarinet', 13, 2, 1650),
(9, 'Enrique Ruiz', 'Bass', 6, 3, 1250),
(10, 'Carla Gómez', 'Horn', 8, 3, 1400),
(11, 'Fernando Díaz', 'Violin', 14, 3, 1750),
(12, 'Valentina Rojas', 'Cello', 10, 3, 1500),
(13, 'Miguel Suárez', 'Flute', 9, 4, 1450),
(14, 'Isabel León', 'Trombone', 7, 4, 1300),
(15, 'Diego Paredes', 'Percussion', 12, 4, 1600),
(16, 'Camila Ortega', 'Harp', 6, 4, 1200),
(17, 'José Cabrera', 'Violin', 15, 5, 1800),
(18, 'Natalia Vega', 'Clarinet', 11, 5, 1550),
(19, 'Ricardo Andrade', 'Trumpet', 13, 5, 1650),
(20, 'Paula Méndez', 'Oboe', 9, 5, 1450);

-- 5 CONCERTS, uno por cada orquesta
INSERT INTO concerts (id, city, country, year, rating, orchestra_id) VALUES
(1, 'Quito', 'Ecuador', 2023, 4.5, 1),
(2, 'Guayaquil', 'Ecuador', 2023, 4.6, 2),
(3, 'Cuenca', 'Ecuador', 2023, 4.2, 3),
(4, 'Quito', 'Ecuador', 2023, 4.8, 4),
(5, 'Guayaquil', 'Ecuador', 2023, 4.3, 5);

-- EJ. 1
select name from orchestras
where city_origin = (select city from concerts
	where year = 2013);

--EJ. 2
select name, position from members
where experience > 10 and
orchestra_id not in (select id from orchestras
	where rating <8);

-- EJ. 3
select name, position from members
where wage > (select avg(wage) from members
	where position = 'Violin');

-- EJ. 4
select name from orchestras
where year > (select year from orchestras
	where name = 'Orquesta de Cámara') and
rating > 7.5;

--Ej. 5
select o.name, count(o.id) num_mem
from orchestras o
join members m on o.id = m.orchestra_id
group by o.name
having count(o.id) > (select avg(cant_mem) prom from
	(select count(*) cant_mem from members
	group by orchestra_id));

select * from orchestras;
select * from members;
select * from concerts;
