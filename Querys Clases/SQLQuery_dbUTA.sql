 

/* ======================================================================= 
   UTA_Distribuida – Universidad Técnica de Ambato (transparencia distribuida) 
   Sitios: HUACHI, INGAHURCO, QUEROCHACA 
   Motor: SQL Server (T-SQL) 
   Autor: Jose Caiza 
   Concepto docente: simular sedes (schemas) y ofrecer capa GLOBAL (vistas) 
                     que ocultan localización/fragmentación/replicación. 
   ======================================================================= */ 

-- Limpieza opcional 

IF DB_ID('UTA_Distribuida') IS NOT NULL 
BEGIN 
    ALTER DATABASE UTA_Distribuida SET SINGLE_USER WITH ROLLBACK IMMEDIATE; 
    DROP DATABASE UTA_Distribuida; 
END 
GO 


CREATE DATABASE UTA_Distribuida; 
GO 


USE UTA_Distribuida; 
GO 

  
/* ========================= 
   ESQUEMAS (sitios físicos) 
   ========================= */ 

CREATE SCHEMA global AUTHORIZATION dbo; 
GO

CREATE SCHEMA site_huachi AUTHORIZATION dbo; 
GO

CREATE SCHEMA site_ingahurco AUTHORIZATION dbo; 
GO

CREATE SCHEMA site_querochaca AUTHORIZATION dbo; 
GO 

  
/* ================================================================== 
   MODELO LÓGICO 
   - carreras: REPLICADA en los 3 sitios 
   - extensiones: FRAGMENTADA horizontalmente (una por sitio) 
   - oferta_carrera: FRAGMENTADA horizontalmente por extensión 
   ================================================================== */ 

-- Carreras (replicada) 

CREATE TABLE site_huachi.carreras ( 
    carrera_id    INT          NOT NULL PRIMARY KEY, 
    nombre        VARCHAR(100) NOT NULL, 
    nivel         VARCHAR(30)  NOT NULL,   -- Pregrado/Postgrado 
    modalidad     VARCHAR(30)  NOT NULL,   -- Presencial/En línea/Híbrida 
    codigo_sniese VARCHAR(20)  NULL, 
    duracion_sem  TINYINT      NOT NULL 
); 

CREATE TABLE site_ingahurco.carreras ( 
    carrera_id    INT          NOT NULL PRIMARY KEY, 
    nombre        VARCHAR(100) NOT NULL, 
    nivel         VARCHAR(30)  NOT NULL, 
    modalidad     VARCHAR(30)  NOT NULL, 
    codigo_sniese VARCHAR(20)  NULL, 
    duracion_sem  TINYINT      NOT NULL 
); 

CREATE TABLE site_querochaca.carreras ( 
    carrera_id    INT          NOT NULL PRIMARY KEY, 
    nombre        VARCHAR(100) NOT NULL, 
    nivel         VARCHAR(30)  NOT NULL, 
    modalidad     VARCHAR(30)  NOT NULL, 
    codigo_sniese VARCHAR(20)  NULL, 
    duracion_sem  TINYINT      NOT NULL 
); 

-- Semillas (idénticas en los 3 sitios) 

INSERT INTO site_huachi.carreras VALUES 
(1,'Ingeniería en Sistemas',     'Pregrado','Presencial','UTA-IS',10), 
(2,'Ingeniería Civil',           'Pregrado','Presencial','UTA-IC',10), 
(3,'Administración de Empresas', 'Pregrado','Híbrida',   'UTA-AE',8), 
(4,'Enfermería',                 'Pregrado','Presencial','UTA-ENF',10); 

INSERT INTO site_ingahurco.carreras SELECT * FROM site_huachi.carreras; 

INSERT INTO site_querochaca.carreras SELECT * FROM site_huachi.carreras; 

  
-- Extensiones (fragmentación horizontal: una fila por sede) 

CREATE TABLE site_huachi.extensiones ( 
    extension_id INT          NOT NULL PRIMARY KEY, -- 100–199 
    nombre       VARCHAR(120) NOT NULL, 
    campus       VARCHAR(40)  NOT NULL,             -- Huachi / Ingahurco / Querochaca 
    ciudad       VARCHAR(60)  NOT NULL, 
    direccion    VARCHAR(160) NULL, 
    telefono     VARCHAR(30)  NULL 
); 

CREATE TABLE site_ingahurco.extensiones ( 
    extension_id INT          NOT NULL PRIMARY KEY, -- 200–299 
    nombre       VARCHAR(120) NOT NULL, 
    campus       VARCHAR(40)  NOT NULL, 
    ciudad       VARCHAR(60)  NOT NULL, 
    direccion    VARCHAR(160) NULL, 
    telefono     VARCHAR(30)  NULL 
); 

CREATE TABLE site_querochaca.extensiones ( 
    extension_id INT          NOT NULL PRIMARY KEY, -- 300–399 
    nombre       VARCHAR(120) NOT NULL, 
    campus       VARCHAR(40)  NOT NULL, 
    ciudad       VARCHAR(60)  NOT NULL, 
    direccion    VARCHAR(160) NULL, 
    telefono     VARCHAR(30)  NULL 
); 

-- Semillas por sede 

INSERT INTO site_huachi.extensiones VALUES 
(101,'Universidad Técnica de Ambato - Campus Huachi','Huachi','Ambato','Av. Los Chasquis s/n','(03) 299-0001');

INSERT INTO site_ingahurco.extensiones VALUES 
(201,'Universidad Técnica de Ambato - Campus Ingahurco','Ingahurco','Ambato','Av. Colombia y Chile','(03) 299-0002'); 

INSERT INTO site_querochaca.extensiones VALUES 
(301,'Universidad Técnica de Ambato - Campus Querochaca','Querochaca','Cevallos','Vía a Quero km 2','(03) 299-0003'); 


-- Oferta de carreras (fragmentada por extensión/sitio) 

CREATE TABLE site_huachi.oferta_carrera ( 
    oferta_id    INT         NOT NULL PRIMARY KEY, 
    extension_id INT         NOT NULL, 
    carrera_id   INT         NOT NULL, 
    jornada      VARCHAR(20) NOT NULL, -- Matutina/Vespertina/Nocturna 
    cupo         INT         NOT NULL, 
    estado       VARCHAR(15) NOT NULL, -- Activa/Inactiva 
    CONSTRAINT FK_ofh_ext FOREIGN KEY (extension_id) REFERENCES site_huachi.extensiones(extension_id), 
    CONSTRAINT FK_ofh_car FOREIGN KEY (carrera_id)   REFERENCES site_huachi.carreras(carrera_id) 
); 

CREATE TABLE site_ingahurco.oferta_carrera ( 
    oferta_id    INT         NOT NULL PRIMARY KEY, 
    extension_id INT         NOT NULL, 
    carrera_id   INT         NOT NULL, 
    jornada      VARCHAR(20) NOT NULL, 
    cupo         INT         NOT NULL, 
    estado       VARCHAR(15) NOT NULL, 
    CONSTRAINT FK_ofi_ext FOREIGN KEY (extension_id) REFERENCES site_ingahurco.extensiones(extension_id), 
    CONSTRAINT FK_ofi_car FOREIGN KEY (carrera_id)   REFERENCES site_ingahurco.carreras(carrera_id) 
); 

CREATE TABLE site_querochaca.oferta_carrera ( 
    oferta_id    INT         NOT NULL PRIMARY KEY, 
    extension_id INT         NOT NULL, 
    carrera_id   INT         NOT NULL, 
    jornada      VARCHAR(20) NOT NULL, 
    cupo         INT         NOT NULL, 
    estado       VARCHAR(15) NOT NULL, 
    CONSTRAINT FK_ofq_ext FOREIGN KEY (extension_id) REFERENCES site_querochaca.extensiones(extension_id), 
    CONSTRAINT FK_ofq_car FOREIGN KEY (carrera_id)   REFERENCES site_querochaca.carreras(carrera_id) 
); 

-- Semillas de oferta por sede 

INSERT INTO site_huachi.oferta_carrera VALUES 
(1101,101,1,'Matutina',60,'Activa'), 
(1102,101,3,'Nocturna',40,'Activa'); 

INSERT INTO site_ingahurco.oferta_carrera VALUES 
(2101,201,2,'Matutina',50,'Activa'), 
(2102,201,1,'Vespertina',45,'Activa'); 

INSERT INTO site_querochaca.oferta_carrera VALUES 
(3101,301,4,'Vespertina',35,'Activa'), 
(3102,301,3,'Nocturna',30,'Activa');
GO

/* =============================================================== 
   CAPA GLOBAL – Transparencia de acceso/localización/fragmentación 
   =============================================================== */ 

-- Unifica extensiones (fragmentación H)

CREATE VIEW global.extensiones AS 
    SELECT * FROM site_huachi.extensiones 
    UNION ALL 
    SELECT * FROM site_ingahurco.extensiones 
    UNION ALL 
    SELECT * FROM site_querochaca.extensiones; 
GO 

-- Unifica oferta (fragmentación H) 

CREATE VIEW global.oferta_carrera AS 
    SELECT * FROM site_huachi.oferta_carrera 
    UNION ALL 
    SELECT * FROM site_ingahurco.oferta_carrera 
    UNION ALL 
    SELECT * FROM site_querochaca.oferta_carrera; 
GO 

-- Carreras replicada: elegimos copia de HUACHI como autoritativa 

CREATE VIEW global.carreras AS 
    SELECT * FROM site_huachi.carreras; 
GO 

SELECT * FROM SITE_HUACHI.CARRERAS;
SELECT * FROM SITE_INGAHURCO.CARRERAS;
SELECT * FROM SITE_QUEROCHACA.CARRERAS;

SELECT * FROM site_huachi.extensiones;
SELECT * FROM site_ingahurco.extensiones;
SELECT * FROM site_querochaca.extensiones;

SELECT * FROM site_huachi.oferta_carrera;
SELECT * FROM site_ingahurco.oferta_carrera;
SELECT * FROM site_querochaca.oferta_carrera;

SELECT * FROM global.extensiones;
SELECT * FROM global.oferta_carrera;
SELECT * FROM global.carreras;