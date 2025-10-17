USE CentroMedicoDB;
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Insercion de un dato con especialidad inexistente
INSERT INTO Medicos (Nombre, Apellido, EspecialidadID, CentroID, Email, Telefono) 
VALUES ('Kevin', 'Palate', 6, 1, 'kevin@mail.com', '0987654321'); 

-- Insercion de un dato con especialidad existente
INSERT INTO Medicos (Nombre, Apellido, EspecialidadID, CentroID, Email, Telefono) 
VALUES ('Kevin', 'Palate', 1, 1, 'kevin@mail.com', '0987654321'); 
SELECT * FROM Medicos WHERE Nombre = 'Kevin' AND Apellido = 'Palate';

--
DELETE FROM Especialidades WHERE EspecialidadID = 1; 



BEGIN TRANSACTION;
INSERT INTO CentrosMedicos (Nombre, Ciudad, Direccion, Telefono) 
VALUES ('Clínica Privada', 'Ambato', 'Av. los Chasquis', '0999999912'); 
DECLARE @NuevoCentroID INT = SCOPE_IDENTITY(); 
INSERT INTO Medicos (Nombre, Apellido, EspecialidadID, CentroID, Email) 
VALUES ('Daniel', 'Pullupaxi', 2, @NuevoCentroID, 'daniel@clinicacentral.ec'); 
COMMIT TRANSACTION; -- Verificar datos 
SELECT * FROM CentrosMedicos WHERE Nombre = 'Clínica Privada'; 
SELECT * FROM Medicos WHERE Nombre = 'Daniel';

BEGIN TRANSACTION; 
DELETE FROM Especialidades WHERE EspecialidadID = 2; -- Especialidad en uso por "Daniel Pullupaxi" 
ROLLBACK TRANSACTION; -- Revierte la operación

SET IMPLICIT_TRANSACTIONS OFF;
GO

BEGIN TRANSACTION; 
UPDATE Medicos SET Email = 'daniel.nuevo@clinicacentral.ec' WHERE Nombre = 
'Daniel'; -- Mantener la transacción abierta (sin COMMIT) 


BEGIN TRY 
BEGIN TRANSACTION; 
INSERT INTO Consultas (MedicoID, ClienteID, FechaConsulta) 
VALUES (1, 10, GETDATE()); -- Cliente 10 que no esta creado
COMMIT TRANSACTION; 
END TRY 
BEGIN CATCH 
ROLLBACK TRANSACTION; 
PRINT 'Error: ' + ERROR_MESSAGE(); 
END CATCH; 

-- Verificar el nuevo centro médico 
SELECT * FROM CentrosMedicos WHERE Nombre = 'Clínica Privada'; -- Verificar el médico asignado al nuevo centro 
SELECT * FROM Medicos WHERE Nombre = 'Daniel' AND Apellido = 'Pullupaxi'; 
