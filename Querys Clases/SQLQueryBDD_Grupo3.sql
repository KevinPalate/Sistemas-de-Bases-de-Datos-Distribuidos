-- GRUPO N°: 3
-- INTEGRANTES: ASES JEREMY, PALATE KEVIN, Poveda William, Pullupaxi Daniel

-- BASE DE DATOS
CREATE DATABASE PRUEBA_PARCIAL;
GO
USE PRUEBA_PARCIAL;
GO


-- ESQUEMAS
CREATE SCHEMA Huachi;
GO
CREATE SCHEMA Ingahurco;
GO
CREATE SCHEMA Querochaca;
GO


-- TABLAS DE LA SEDE HUACHI
CREATE TABLE Huachi.Alumnos_V1 (
AlumnoId INT PRIMARY KEY,
Cedula VARCHAR(10) NOT NULL,
Nombres VARCHAR(30) NOT NULL,
Apellidos VARCHAR(30) NOT NULL,
Email VARCHAR(50),
Telefono VARCHAR(10),
Sede VARCHAR(30) NOT NULL);

CREATE TABLE Huachi.Alumnos_V2 (
AlumnoId INT REFERENCES Huachi.ALUMNOS_V1(AlumnoId),
Carrera VARCHAR(50),
Ciudad VARCHAR(50),
FechaIngreso DATE);

-- TABLAS DE LA SEDE INGAHURCO
CREATE TABLE Ingahurco.Alumnos_V1 (
AlumnoId INT PRIMARY KEY,
Cedula VARCHAR(10) NOT NULL,
Nombres VARCHAR(30) NOT NULL,
Apellidos VARCHAR(30) NOT NULL,
Email VARCHAR(50),
Telefono VARCHAR(10),
Sede VARCHAR(30) NOT NULL);

CREATE TABLE Ingahurco.Alumnos_V2 (
AlumnoId INT REFERENCES Ingahurco.ALUMNOS_V1(AlumnoId),
Carrera VARCHAR(50),
Ciudad VARCHAR(50),
FechaIngreso DATE);

-- TABLAS DE LA SEDE QUEROCHACA
CREATE TABLE Querochaca.Alumnos_V1 (
AlumnoId INT PRIMARY KEY,
Cedula VARCHAR(10) NOT NULL,
Nombres VARCHAR(30) NOT NULL,
Apellidos VARCHAR(30) NOT NULL,
Email VARCHAR(50),
Telefono VARCHAR(10),
Sede VARCHAR(30) NOT NULL);

CREATE TABLE Querochaca.Alumnos_V2 (
AlumnoId INT REFERENCES Querochaca.ALUMNOS_V1(AlumnoId),
Carrera VARCHAR(50),
Ciudad VARCHAR(50),
FechaIngreso DATE);
GO

-- DATOS EN LOS FRAGMENTOS DE HUACHI
INSERT INTO Huachi.Alumnos_V1 (AlumnoID, Cedula, Nombres, Apellidos, Email, Telefono, Sede)
VALUES (1, '1800000001', 'Kevin', 'Palate', 'kevin.palate@huachi.edu.ec', '0999999991', 'Huachi'),
(4,'1800000004','Ana','Lopez','ana.lopez@huachi.edu.ec','0998888884','Huachi'),
(5,'1800000005','Pedro','Ramirez','pedro.ramirez@huachi.edu.ec','0998888885','Huachi'),
(6,'1800000006','Lucia','Torres','lucia.torres@huachi.edu.ec','0998888886','Huachi'),
(7,'1800000007','Mateo','Sanchez','mateo.sanchez@huachi.edu.ec','0998888887','Huachi'),
(8,'1800000008','Sofia','Vega','sofia.vega@huachi.edu.ec','0998888888','Huachi'),
(9,'1800000009','Diego','Mora','diego.mora@huachi.edu.ec','0998888889','Huachi'),
(10,'1800000010','Valentina','Rios','valentina.rios@huachi.edu.ec','0998888890','Huachi'),
(11,'1800000011','Javier','Cruz','javier.cruz@huachi.edu.ec','0998888891','Huachi'),
(12,'1800000012','Camila','Paredes','camila.paredes@huachi.edu.ec','0998888892','Huachi'),
(13,'1800000013','Andres','Lopez','andres.lopez@huachi.edu.ec','0998888893','Huachi');

INSERT INTO Huachi.Alumnos_V2 (AlumnoID, Carrera, Ciudad, FechaIngreso)
VALUES (1, 'Tecnologias de la Informacion', 'Ambato', '2022-09-01'),
(4,'Medicina','Ambato','2021-09-01'),
(5,'Ingenieria','Ambato','2022-01-15'),
(6,'Derecho','Ambato','2021-06-20'),
(7,'Arquitectura','Ambato','2022-03-10'),
(8,'Psicologia','Ambato','2021-11-05'),
(9,'Contabilidad','Ambato','2022-02-25'),
(10,'Biologia','Ambato','2021-12-12'),
(11,'Economia','Ambato','2022-05-18'),
(12,'Veterinaria','Ambato','2021-08-30'),
(13,'Ingenieria','Ambato','2023-01-08');

-- DATOS EN LOS FRAGMENTOS DE INGAHURCO
INSERT INTO Ingahurco.Alumnos_V1 (AlumnoID, Cedula, Nombres, Apellidos, Email, Telefono, Sede)
VALUES (2, '1800000002', 'Maria', 'Gomez', 'maria.gomez@ingahurco.edu.ec', '0999999992', 'Ingahurco'),
(14,'1800000014','Fernando','Castillo','fernando.castillo@ingahurco.edu.ec','0988888814','Ingahurco'),
(15,'1800000015','Paula','Gutierrez','paula.gutierrez@ingahurco.edu.ec','0988888815','Ingahurco'),
(16,'1800000016','Sebastian','Ortega','sebastian.ortega@ingahurco.edu.ec','0988888816','Ingahurco'),
(17,'1800000017','Daniela','Mendez','daniela.mendez@ingahurco.edu.ec','0988888817','Ingahurco'),
(18,'1800000018','Carlos','Alvarez','carlos.alvarez@ingahurco.edu.ec','0988888818','Ingahurco'),
(19,'1800000019','Mariana','Lopez','mariana.lopez@ingahurco.edu.ec','0988888819','Ingahurco'),
(20,'1800000020','Ricardo','Suarez','ricardo.suarez@ingahurco.edu.ec','0988888820','Ingahurco'),
(21,'1800000021','Natalia','Perez','natalia.perez@ingahurco.edu.ec','0988888821','Ingahurco'),
(22,'1800000022','Luis','Diaz','luis.diaz@ingahurco.edu.ec','0988888822','Ingahurco'),
(23,'1800000023','Gabriela','Vargas','gabriela.vargas@ingahurco.edu.ec','0988888823','Ingahurco');

INSERT INTO Ingahurco.Alumnos_V2 (AlumnoID, Carrera, Ciudad, FechaIngreso)
VALUES (2, 'Derecho', 'Ambato', '2022-09-01'),
(14,'Ingenieria','Cuenca','2022-02-01'),
(15,'Derecho','Cuenca','2021-09-15'),
(16,'Medicina','Cuenca','2022-03-10'),
(17,'Arquitectura','Cuenca','2021-06-12'),
(18,'Psicologia','Cuenca','2022-08-20'),
(19,'Contabilidad','Cuenca','2022-05-05'),
(20,'Biologia','Cuenca','2021-12-18'),
(21,'Economia','Cuenca','2022-01-28'),
(22,'Ingenieria','Cuenca','2023-03-02'),
(23,'Medicina','Cuenca','2022-07-15');

-- DATOS EN LOS FRAGMENTOS DE QUEROCHACA
INSERT INTO Querochaca.Alumnos_V1 (AlumnoID, Cedula, Nombres, Apellidos, Email, Telefono, Sede)
VALUES (3, '1800000003', 'Carlos', 'Lopez', 'carlos.lopez@querochaca.edu.ec', '0999999993', 'Querochaca'),
(24,'1800000024','Adrian','Reyes','adrian.reyes@querochaca.edu.ec','0978888824','Querochaca'),
(25,'1800000025','Florencia','Cortes','florencia.cortes@querochaca.edu.ec','0978888825','Querochaca'),
(26,'1800000026','Johan','Mora','johan.mora@querochaca.edu.ec','0978888826','Querochaca'),
(27,'1800000027','Camilo','Hernandez','camilo.hernandez@querochaca.edu.ec','0978888827','Querochaca'),
(28,'1800000028','Daniel','Ponce','daniel.ponce@querochaca.edu.ec','0978888828','Querochaca'),
(29,'1800000029','Laura','Ramirez','laura.ramirez@querochaca.edu.ec','0978888829','Querochaca'),
(30,'1800000030','Felipe','Castro','felipe.castro@querochaca.edu.ec','0978888830','Querochaca'),
(31,'1800000031','Valeria','Torres','valeria.torres@querochaca.edu.ec','0978888831','Querochaca'),
(32,'1800000032','Esteban','Lopez','esteban.lopez@querochaca.edu.ec','0978888832','Querochaca'),
(33,'1800000033','Paola','Gomez','paola.gomez@querochaca.edu.ec','0978888833','Querochaca');

INSERT INTO Querochaca.Alumnos_V2 (AlumnoID, Carrera, Ciudad, FechaIngreso)
VALUES (3, 'Veterinaria', 'Quero', '2024-09-01'),
(24,'Derecho','Riobamba','2022-01-15'),
(25,'Ingenieria','Riobamba','2021-03-12'),
(26,'Arquitectura','Riobamba','2023-05-08'),
(27,'Medicina','Riobamba','2020-09-18'),
(28,'Contabilidad','Riobamba','2023-02-20'),
(29,'Psicologia','Riobamba','2022-06-25'),
(30,'Biologia','Riobamba','2021-12-12'),
(31,'Economia','Riobamba','2020-08-30'),
(32,'Ingenieria','Riobamba','2023-03-01'),
(33,'Medicina','Riobamba','2022-07-15');
GO

-- VISTAS LOCALES (UNE FRAGMENTOS VERTICALES)
CREATE VIEW Huachi.Alumnos_Local AS
SELECT 
    V1.AlumnoID, V1.Cedula, V1.Nombres, V1.Apellidos, V1.Email, V1.Telefono, V1.Sede,
    V2.Carrera, V2.Ciudad, V2.FechaIngreso
FROM Huachi.Alumnos_V1 V1
JOIN Huachi.Alumnos_V2 V2 ON V1.AlumnoID = V2.AlumnoID;
GO

CREATE VIEW Ingahurco.Alumnos_Local AS
SELECT 
    V1.AlumnoID, V1.Cedula, V1.Nombres, V1.Apellidos, V1.Email, V1.Telefono, V1.Sede,
    V2.Carrera, V2.Ciudad, V2.FechaIngreso
FROM Ingahurco.Alumnos_V1 V1
JOIN Ingahurco.Alumnos_V2 V2 ON V1.AlumnoID = V2.AlumnoID;
GO

CREATE VIEW Querochaca.Alumnos_Local AS
SELECT 
    V1.AlumnoID, V1.Cedula, V1.Nombres, V1.Apellidos, V1.Email, V1.Telefono, V1.Sede,
    V2.Carrera, V2.Ciudad, V2.FechaIngreso
FROM Querochaca.Alumnos_V1 V1
JOIN Querochaca.Alumnos_V2 V2 ON V1.AlumnoID = V2.AlumnoID;
GO

-- VISTA GLOBAL (UNE TODOS LOS FRAGMENTOS PARA LA TRANSPARENCIA)
CREATE VIEW Alumnos_Global AS
SELECT * FROM Huachi.Alumnos_Local
UNION ALL
SELECT * FROM Ingahurco.Alumnos_Local
UNION ALL
SELECT * FROM Querochaca.Alumnos_Local;
GO

-- 1. VERIFICACI�N: Contar las filas en cada fragmento
SELECT 'Huachi' AS Sede, COUNT(*) AS TotalAlumnos FROM Huachi.Alumnos_V1;
SELECT 'Ingahurco' AS Sede, COUNT(*) AS TotalAlumnos FROM Ingahurco.Alumnos_V1;
SELECT 'Querochaca' AS Sede, COUNT(*) AS TotalAlumnos FROM Querochaca.Alumnos_V1;

-- 2. DEMOSTRACI�N DE TRANSPARENCIA: Consulta a la vista global
-- (El usuario no sabe que los datos est�n fragmentados)
SELECT * FROM Alumnos_Global;

-- 3. Consulta con filtro para demostrar la uni�n de datos de sedes
SELECT Nombres, Apellidos, Sede, Carrera FROM Alumnos_Global WHERE Sede = 'Huachi';