-- Database: Empresa

-- DROP DATABASE IF EXISTS "Empresa";

CREATE DATABASE "Empresa"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Ecuador.1252'
    LC_CTYPE = 'Spanish_Ecuador.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE departamentos (
    id INT PRIMARY KEY, 
    nombre VARCHAR(50) 
);

CREATE TABLE empleados ( 
    id INT PRIMARY KEY, 
    nombre VARCHAR(50),
    salario DECIMAL(10,2), 
    departamento_id INT, 
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id) 
); 

CREATE TABLE proyectos ( 
    id INT PRIMARY KEY, 
    nombre VARCHAR(50), 
    departamento_id INT, 
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id) 
); 

-- Departamentos
INSERT INTO departamentos (id, nombre) VALUES
(1, 'Recursos Humanos'),
(2, 'Finanzas'),
(3, 'Tecnología'),
(4, 'Marketing'),
(5, 'Legal');

-- Empleados
INSERT INTO empleados (id, nombre, salario, departamento_id) VALUES
(1, 'Ana Pérez', 1200.00, 1),
(2, 'Luis Gómez', 1500.00, 1),
(3, 'María Torres', 1800.00, 2),
(4, 'Carlos Ruiz', 2200.00, 2),
(5, 'Sofía López', 2500.00, 3),
(6, 'Pedro Martínez', 3000.00, 3),
(7, 'Lucía Herrera', 1700.00, 3),
(8, 'Jorge Castillo', 1300.00, 4),
(9, 'Valeria Chávez', 1400.00, 4);


-- Proyectos
INSERT INTO proyectos (id, nombre, departamento_id) VALUES
(1, 'Reclutamiento', 1),
(2, 'Auditoría', 2),
(3, 'Sistema ERP', 3),
(4, 'Campaña Publicitaria', 4),
(5, 'Asesoría Legal', 5);

-- EJ 1: Empleado con salario mayor al promedio: 
-- Obtén todos los empleados cuyo salario es mayor al salario promedio de todos los empleados. 
-- (Subconsulta en WHERE con función de agregación) 

CREATE VIEW empleados_mejor_pagados AS
SELECT * FROM empleados
WHERE salario > (SELECT AVG(salario) FROM empleados);

SELECT * FROM empleados_mejor_pagados;

-- EJ 2: Departamentos sin empleados. 
-- Lista los nombres de los departamentos que no tienen empleados asignados. 
-- (Subconsulta en NOT IN)

CREATE VIEW departamentos_sin_empleados AS
SELECT nombre FROM departamentos
WHERE id not in (SELECT DISTINCT departamento_id FROM empleados);

SELECT * FROM departamentos_sin_empleados;


-- EJ 3: Empleado con salario más alto. 
-- Muestra el nombre y salario del empleado que gana más. 
-- (Subconsulta escalar en WHERE o SELECT) 

CREATE VIEW empleado_mejor_pagado AS
SELECT nombre, salario FROM empleados
WHERE salario = (SELECT MAX(salario) FROM empleados);

SELECT * FROM empleado_mejor_pagado;

-- EJ 4: Salario promedio por departamento. 
-- Para cada empleado, muestra: nombre, salario y el salario promedio de su departamento. 
-- (Subconsulta correlacionada que compare empleados.departamento_id) 

CREATE VIEW empleados_salario_prom AS
SELECT nombre, salario, (SELECT AVG(salario) FROM empleados
						WHERE departamento_id =e.departamento_id)
FROM empleados e;

SELECT * FROM empleados_salario_prom;


-- EJ 5: Departamentos con promedio mayor al promedio general. 
-- Lista los departamentos cuyo promedio de salario es mayor al promedio general de la empresa. 
-- (Subconsulta en HAVING o FROM) 

CREATE VIEW departamentos_salario_pro_mas_alto AS
SELECT * FROM departamentos
WHERE id IN (
SELECT departamento_id FROM empleados
GROUP BY departamento_id
HAVING AVG(salario) > (SELECT AVG(salario) FROM empleados));

SELECT * FROM departamentos_salario_pro_mas_alto;

  
SELECT * FROM departamentos;
SELECT * FROM empleados;
SELECT * FROM proyectos;
