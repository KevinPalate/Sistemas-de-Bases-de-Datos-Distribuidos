-- Database: FragmentacionEjemplo

-- DROP DATABASE IF EXISTS "FragmentacionEjemplo";

CREATE DATABASE "FragmentacionEjemplo"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Ecuador.1252'
    LC_CTYPE = 'Spanish_Ecuador.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE Empleados ( 
    ID INT PRIMARY KEY, 
    Nombre VARCHAR(100), 
    Apellido VARCHAR(100), 
    Departamento VARCHAR(50), 
    Salario DECIMAL(10, 2), 
    Direccion VARCHAR(200), 
    Telefono VARCHAR(20) 
); 

INSERT INTO Empleados VALUES 
(1, 'Ana', 'Perez', 'TI', 1200.00, 'Calle 1', '099111111'), 
(2, 'Luis', 'Soto', 'Marketing', 1100.00, 'Calle 2', '099222222'), 
(3, 'Marta', 'Lopez', 'TI', 1250.00, 'Calle 3', '099333333'), 
(4, 'Carlos', 'Gomez', 'RRHH', 1000.00, 'Calle 4', '099444444'); 

-- Fragmentación Vertical 
-- Fragmento 1: Información personal 
CREATE TABLE Empleados_Personal (
    ID INT PRIMARY KEY, 
    Nombre VARCHAR(100), 
    Apellido VARCHAR(100), 
    Direccion VARCHAR(200), 
    Telefono VARCHAR(20) 
); 

-- Fragmento 2: Información laboral 
CREATE TABLE Empleados_Laboral ( 
    ID INT PRIMARY KEY, 
    Departamento VARCHAR(50), 
    Salario DECIMAL(10, 2) 
); 

-- Insertamos los datos (puede ser con SELECT INTO o INSERT SELECT) 

INSERT INTO Empleados_Personal 
SELECT ID, Nombre, Apellido, Direccion, Telefono FROM Empleados; 


INSERT INTO Empleados_Laboral 
SELECT ID, Departamento, Salario FROM Empleados;

-- Puedes hacer un JOIN si necesitas reconstruir la tabla original: 
SELECT * 
FROM Empleados_Personal EP 
JOIN Empleados_Laboral EL ON EP.ID = EL.ID; 

-- Fragmento para TI 
CREATE TABLE Empleados_Laboral_TI ( 
    ID INT PRIMARY KEY, 
    Departamento VARCHAR(50), 
    Salario DECIMAL(10, 2) 
); 

-- Fragmento para otros departamentos 
CREATE TABLE Empleados_Laboral_Otros ( 
    ID INT PRIMARY KEY, 
    Departamento VARCHAR(50), 
    Salario DECIMAL(10, 2) 
); 

-- Insertamos según condición 
INSERT INTO Empleados_Laboral_TI 
SELECT * FROM Empleados_Laboral WHERE Departamento = 'TI'; 
  
INSERT INTO Empleados_Laboral_Otros 
SELECT * FROM Empleados_Laboral WHERE Departamento <> 'TI'; 

CREATE VIEW vista_1 AS
SELECT * FROM Empleados_Laboral_TI
UNION ALL
SELECT * FROM Empleados_Laboral_Otros;

SELECT * FROM vista_1;
