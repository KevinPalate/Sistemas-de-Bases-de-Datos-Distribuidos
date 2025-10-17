-- Database: uni

-- DROP DATABASE IF EXISTS uni;

CREATE DATABASE uni
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Ecuador.1252'
    LC_CTYPE = 'Spanish_Ecuador.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE Estudiantes ( 
    id INT PRIMARY KEY, 
    nombre VARCHAR(50), 
    carrera VARCHAR(50), 
    ciudad VARCHAR(50) 
); 

CREATE TABLE Estudiantes_Quito ( 
    id INT PRIMARY KEY, 
    nombre VARCHAR(50), 
    carrera VARCHAR(50), 
    ciudad VARCHAR(50) 
); 

INSERT INTO Estudiantes_Quito VALUES
(1, 'Ana Pérez', 'Ingeniería', 'Quito'),
(3, 'Carla Ruiz', 'Ingeniería', 'Quito'),
(7, 'Diego Torres', 'Arquitectura', 'Quito'),
(8, 'María Gómez', 'Psicología', 'Quito'),
(9, 'Fernando Álvarez', 'Medicina', 'Quito'),
(10, 'Patricia Silva', 'Ingeniería', 'Quito'),
(11, 'Hugo Castillo', 'Derecho', 'Quito'),
(12, 'Daniela Paredes', 'Economía', 'Quito'),
(13, 'Esteban Chávez', 'Ingeniería', 'Quito'),
(14, 'Lucía Herrera', 'Educación', 'Quito');

CREATE TABLE Estudiantes_Ambato ( 
    id INT PRIMARY KEY, 
    nombre VARCHAR(50), 
    carrera VARCHAR(50), 
    ciudad VARCHAR(50) 
); 

INSERT INTO Estudiantes_Ambato VALUES
(2, 'Luis Mora', 'Medicina', 'Ambato'),
(5, 'Rosa Vega', 'Medicina', 'Ambato'),
(15, 'Carlos Medina', 'Ingeniería', 'Ambato'),
(16, 'Gabriela López', 'Derecho', 'Ambato'),
(17, 'Julio Ramírez', 'Arquitectura', 'Ambato'),
(18, 'Andrea Córdova', 'Medicina', 'Ambato'),
(19, 'Santiago Villacís', 'Economía', 'Ambato'),
(20, 'Paola Andrade', 'Psicología', 'Ambato'),
(21, 'David Molina', 'Ingeniería', 'Ambato'),
(22, 'Natalia Jiménez', 'Educación', 'Ambato');

CREATE TABLE Estudiantes_Cuenca ( 
    id INT PRIMARY KEY, 
    nombre VARCHAR(50), 
    carrera VARCHAR(50), 
    ciudad VARCHAR(50) 
); 

INSERT INTO Estudiantes_Cuenca VALUES
(4, 'Mario León', 'Derecho', 'Cuenca'),
(6, 'J. Ortega', 'Derecho', 'Cuenca'),
(23, 'Sofía Muñoz', 'Ingeniería', 'Cuenca'),
(24, 'Cristian Flores', 'Arquitectura', 'Cuenca'),
(25, 'Isabel Romero', 'Economía', 'Cuenca'),
(26, 'Mateo Salazar', 'Derecho', 'Cuenca'),
(27, 'Valeria Chávez', 'Educación', 'Cuenca'),
(28, 'Andrés Gutiérrez', 'Medicina', 'Cuenca'),
(29, 'Mónica Viteri', 'Ingeniería', 'Cuenca'),
(30, 'Francisco Torres', 'Psicología', 'Cuenca');

CREATE VIEW Estudiantes_Todos AS 
SELECT * FROM Estudiantes_Quito 
UNION ALL 
SELECT * FROM Estudiantes_Ambato 
UNION ALL 
SELECT * FROM Estudiantes_Cuenca; 

SELECT * FROM Estudiantes_Todos;

