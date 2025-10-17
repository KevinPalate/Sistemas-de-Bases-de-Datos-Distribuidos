-- Crear base de datos
CREATE DATABASE Universidad;
GO

-- Usar la base de datos
USE Universidad;
GO

-- Tabla: student
CREATE TABLE Student (
    id INT PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    email VARCHAR(128) NOT NULL,
    birth_date DATE NOT NULL,
    start_date DATE NOT NULL
);
GO

-- Tabla: academic_semester
CREATE TABLE Academic_Semester (
    id INT PRIMARY KEY,
    calendar_year INT NOT NULL,
    term VARCHAR(128) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);
GO

-- Tabla: course
CREATE TABLE Course (
    id INT PRIMARY KEY,
    title VARCHAR(128) NOT NULL,
    learning_path VARCHAR(128) NOT NULL,
    short_description VARCHAR(1200),
    lecture_hours INT NOT NULL,
    tutorial_hours INT NOT NULL,
    ects_points INT NOT NULL,
    has_exam BIT NOT NULL, 
    has_project BIT NOT NULL
);
GO

-- Tabla: lecturer
CREATE TABLE Lecturer (
    id INT PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    degreee VARCHAR(32) NOT NULL,
    email VARCHAR(128)
);
GO

-- Tabla: course_edition
CREATE TABLE Course_Edition (
    id INT PRIMARY KEY,
    course_id INT NOT NULL,
    academic_semester_id INT NOT NULL,
    lecturer_id INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Course(id),
    FOREIGN KEY (academic_semester_id) REFERENCES Academic_Semester(id),
    FOREIGN KEY (lecturer_id) REFERENCES Lecturer(id)
);
GO

-- Tabla: course_enrollment
CREATE TABLE Course_Enrollment (
    course_edition_id INT NOT NULL,
    student_id INT NOT NULL,
    midterm_grade DECIMAL(5,2),
    final_grade DECIMAL(5,2),
    course_letter_grade VARCHAR(3),
    passed BIT,  
    PRIMARY KEY (course_edition_id, student_id),
    FOREIGN KEY (course_edition_id) REFERENCES Course_Edition(id),
    FOREIGN KEY (student_id) REFERENCES Student(id)
);
GO

-- Insercion de Datos en la tabla Students
INSERT INTO Student VALUES
(1, 'Kevin', 'Palate', 'kevin@uni.edu.ec', '2002-01-10', '2022-09-01'),
(2, 'Jeremy', 'Ases', 'jeremy@uni.edu.ec', '2001-05-22', '2022-09-01');
SELECT * FROM Student;

-- Insercion de Datos en la tabla Academic_Semester
INSERT INTO Academic_Semester VALUES
(1, 2025, 'AGO-ENE', '2025-08-01', '2026-01-31'),
(2, 2026, 'FEB-JUL', '2026-02-01', '2026-07-31');
SELECT * FROM Academic_Semester;

-- Insercion de Datos en la tabla Course
INSERT INTO Course VALUES
(1, 'Sistemas de Bases de Datos Distribuidos', 'Tecnolog as de la Informaci n',
 'Curso sobre transacciones, replicaci n y consistencia en BDD.', 
 40, 10, 6, 1, 1),
(2, 'Programaci n Avanzada', 'Tecnolog as de la Informaci n',
 'Programaci n orientada a objetos y patrones de dise o.', 
 50, 12, 5, 1, 1);
SELECT * FROM Course;

-- Insercion de Datos en la tabla Students
INSERT INTO Lecturer VALUES
(1, 'Mar a', 'Zamora', 'MSc', 'mzamora@uni.edu.ec'),
(2, 'Carlos', 'Jim nez', 'PhD', 'cjimenez@uni.edu.ec');
SELECT * FROM Lecturer;

INSERT INTO Course_Edition VALUES
(1, 1, 1, 1), -- Curso 1, Semestre 1, Docente 1
(2, 2, 2, 2); -- Curso 2, Semestre 2, Docente 2
SELECT * FROM Course_Edition;




-- Prueba de integridad referencial (error intencional)
INSERT INTO Course_Edition VALUES
(3, 99, 1, 1); -- Error ya que el curso 99 no existe

INSERT INTO Course_Enrollment VALUES
(1, 1, 8.5, 9.0, 'A', 1),
(1, 2, 7.0, 8.0, 'B', 1),
(2, 2, 6.0, 4.0, 'F', 0);
SELECT * FROM Course_Enrollment;


-- Prueba de error (violando integridad)
INSERT INTO Course_Enrollment VALUES
(5, 1, 9.0, 9.5, 'A', 1);  -- Course_Edition 5 no existe





-- Iniciamos la transacci n
BEGIN TRANSACTION;

-- Insertamos un nuevo curso y su edici n
INSERT INTO Course VALUES
(3, 'Conmutaci n y Enrutamiento B sico', 'Tecnolog as de la Informaci n',
 'Curso sobre redes TCP/IP, routers y seguridad en redes.', 
 45, 15, 6, 1, 0);

INSERT INTO Course_Edition VALUES
(3, 3, 1, 2);  -- curso_id = 3, semestre_id = 1, docente_id = 2

-- Confirmamos los cambios
COMMIT;

-- Verificamos que se guardaron correctamente
SELECT * FROM Course;
SELECT * FROM Course_Edition;




-- Iniciamos una nueva transacci n
BEGIN TRANSACTION;

-- Intentamos insertar un curso y una edici n con error referencial
INSERT INTO Course VALUES
(4, 'Inteligencia Artificial', 'Ciencias Computacionales',
 'Curso sobre algoritmos inteligentes y aprendizaje autom tico.', 
 40, 10, 5, 1, 1);

-- Esta l nea generar  un error porque el docente 99 no existe
INSERT INTO Course_Edition VALUES
(4, 4, 1, 99);

-- Si ocurre un error, revertimos los cambios
ROLLBACK;

-- Verificamos si se guardaron los datos (no deber an aparecer)
SELECT * FROM Course WHERE id = 4;
SELECT * FROM Course_Edition WHERE id = 4;


-- sesion 1


USE Universidad;
GO


BEGIN TRANSACTION;

-- Actualizamos la nota final de Kevin
UPDATE Course_Enrollment
SET final_grade = 10.0,
    course_letter_grade = 'A+',
    passed = 1
WHERE student_id = 1;

-- No hacemos COMMIT todav a

COMMIT TRANSACTION;



--sesion2
SELECT * FROM Course;
SELECT * FROM Course_Edition;
SELECT * FROM Course_Enrollment;
SELECT * FROM Lecturer;
SELECT * FROM Student;

SELECT student_id, final_grade, course_letter_grade, passed
FROM Course_Enrollment
WHERE student_id = 1;






-- Activamos XACT_ABORT
SET XACT_ABORT ON;
GO

BEGIN TRANSACTION;

-- Inserci n v lida
INSERT INTO Course VALUES
(7, 'Big Data', 'Tecnolog as de la Informaci n',
 'Curso sobre an lisis de grandes vol menes de datos.', 
 40, 10, 6, 1, 0);

-- Inserci n con error: el semestre 99 no existe
INSERT INTO Course_Edition VALUES
(7, 7, 1, 1);

-- Commit (no llegar  a ejecutarse si hay error)
COMMIT;

-- Verificamos si el curso fue guardado
SELECT * FROM Course WHERE id = 7;
SELECT * FROM Course_Edition WHERE id = 7;



BEGIN TRY
    BEGIN TRANSACTION;

    -- Inserci n v lida
    INSERT INTO Course VALUES
    (8, 'Machine Learning', 'Tecnolog as de la Informaci n',
     'Curso sobre algoritmos de ML y AI aplicada.', 
     35, 8, 5, 1, 1);

    -- Error intencional: docente 99 no existe
    INSERT INTO Course_Edition VALUES
    (8, 8, 1, 2);

    COMMIT; -- Solo si no hay errores
END TRY
BEGIN CATCH
    PRINT 'Error detectado: ' + ERROR_MESSAGE();
    ROLLBACK;
END CATCH;

-- Verificamos los datos
SELECT * FROM Course WHERE id = 8;
SELECT * FROM Course_Edition WHERE id = 8;



BEGIN TRANSACTION;

-- Inserci n de curso
INSERT INTO Course VALUES
(11, 'Gesti n de Proyectos TI', 'Tecnolog as de la Informaci n',
 'Curso administraci n de Proyectos TI', 
 40, 10, 5, 1, 1);

-- Forzamos un error si el curso ya existe (simulaci n)
IF EXISTS (SELECT 1 FROM Course WHERE id = 9)
BEGIN
    RAISERROR ('El curso ya existe. Transacci n revertida.', 16, 1);
END

-- Commit
COMMIT;




