-- Database: universidad

-- DROP DATABASE IF EXISTS universidad;

CREATE DATABASE universidad
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Ecuador.1252'
    LC_CTYPE = 'Spanish_Ecuador.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
create table student (
id int primary key,
first_name varchar(128) not null,
last_name varchar(128) not null,
email varchar(128) not null,
birth_date date not null,
start_date date not null);

create table academic_semester (
id int primary key,
calendar_year int not null,
term varchar(128) not null,
start_date date not null,
end_date date not null);

create table course (
id int primary key,
title varchar (128) not null,
learning_path varchar(128) not null,
short_description varchar(1200),
lecture_hours int not null,
tutorial_hours int not null,
ects_points int not null,
has_exam boolean not null,
has_project boolean not null);

create table lecturer (
id int primary key,
first_name varchar(128) not null,
last_name varchar(128) not null,
degreee varchar(32) not null,
email varchar(128));

create table course_edition (
id int primary key,
course_id int not null references course(id),
academic_semester_id int not null references academic_semester(id),
lecturer_id int not null references lecturer(id));

create table course_enrollment (
course_edition_id int not null references course_edition(id),
student_id int not null references student(id),
midterm_grade decimal(5,2),
final_grade decimal(5,2),
course_letter_grade varchar(3),
passed boolean);

-- SEMESTRES
INSERT INTO academic_semester (id, calendar_year, term, start_date, end_date) VALUES
(1, 2024, 'Spring', '2024-01-15', '2024-06-30'),
(2, 2024, 'Fall',   '2024-08-15', '2024-12-20'),
(3, 2025, 'Spring', '2025-01-15', '2025-06-30'),
(4, 2025, 'Fall',   '2025-08-15', '2025-12-20');

-- CURSOS
INSERT INTO course (id, title, learning_path, short_description, lecture_hours, tutorial_hours, ects_points, has_exam, has_project) VALUES
(1, 'Databases', 'Computer Science', 'Intro to relational databases', 40, 20, 6, true, false),
(2, 'Algorithms', 'Computer Science', 'Data structures and algorithms', 50, 20, 7, true, true),
(3, 'Networks', 'Computer Science', 'Basics of computer networks', 40, 15, 5, true, false),
(4, 'Math I', 'Mathematics', 'Linear algebra and calculus', 60, 30, 8, true, false),
(5, 'AI Fundamentals', 'Computer Science', 'Introduction to AI', 40, 20, 6, true, true);

-- PROFESORES
INSERT INTO lecturer (id, first_name, last_name, degreee, email) VALUES
(1, 'Alice', 'Smith', 'PhD', 'alice.smith@uni.edu'),
(2, 'Bob', 'Johnson', 'MSc', 'bob.johnson@uni.edu'),
(3, 'Clara', 'Brown', 'PhD', 'clara.brown@uni.edu');

-- ESTUDIANTES
INSERT INTO student (id, first_name, last_name, email, birth_date, start_date) VALUES
(1, 'Juan', 'Perez', 'juan.perez@uni.edu', '2002-03-10', '2021-09-01'),
(2, 'Maria', 'Lopez', 'maria.lopez@uni.edu', '2001-07-20', '2021-09-01'),
(3, 'Carlos', 'Ramirez', 'carlos.ramirez@uni.edu', '2003-11-05', '2022-09-01'),
(4, 'Ana', 'Torres', 'ana.torres@uni.edu', '2002-05-14', '2021-09-01'),
(5, 'Diego', 'Morales', 'diego.morales@uni.edu', '2000-09-22', '2020-09-01');

-- EDICIONES DE CURSO (ligadas a semestre y profesor)
INSERT INTO course_edition (id, course_id, academic_semester_id, lecturer_id) VALUES
(1, 1, 1, 1), -- Databases en Spring 2024 con Alice
(2, 2, 1, 2), -- Algorithms en Spring 2024 con Bob
(3, 3, 2, 2), -- Networks en Fall 2024 con Bob
(4, 4, 3, 3), -- Math I en Spring 2025 con Clara
(5, 5, 4, 1); -- AI Fundamentals en Fall 2025 con Alice

-- INSCRIPCIONES (con notas y si pasó o no)
INSERT INTO course_enrollment (course_edition_id, student_id, midterm_grade, final_grade, course_letter_grade, passed) VALUES
(1, 1, 70, 80, 'B', true),   -- Juan aprobó Databases
(1, 2, 60, 50, 'D', false), -- Maria reprobó Databases
(1, 3, 85, 90, 'A', true),  -- Carlos aprobó
(2, 1, 55, 65, 'C', true),  -- Juan aprobó Algorithms
(2, 2, 40, 45, 'F', false), -- Maria reprobó Algorithms
(2, 4, 88, 92, 'A', true),  -- Ana aprobó
(3, 5, 75, 80, 'B', true),  -- Diego aprobó Networks
(3, 3, 50, 55, 'D', false), -- Carlos reprobó Networks
(4, 2, 90, 95, 'A', true),  -- Maria aprobó Math I
(4, 4, 65, 70, 'C', true),  -- Ana aprobó
(4, 5, 45, 50, 'E', false), -- Diego reprobó
(5, 1, 78, 82, 'B', true),  -- Juan aprobó AI
(5, 3, 92, 96, 'A', true);  -- Carlos aprobó AI

-- EJ. 6
select id, title from course
where id in (select course_id from course_edition
	where academic_semester_id in (select id from academic_semester
			where term = 'Spring'));

-- EJ. 7
select id, first_name, last_name from student
where id in (select student_id from course_enrollment
	group by student_id
	having count(passed)>1);

-- EJ. 8
select l.first_name, l.last_name, count(ce.id) no_of_courses
from lecturer l
join course_edition ce on l.id = ce.lecturer_id
group by l.id
having count (ce.id) = (select min(num_cur)
			from (select count(id) num_cur from course_edition
						group by lecturer_id));
-- EJ. 9
select e.id, e.first_name, e.last_name, count(ce.course_edition_id) no_of_course_ed 
from student e
join course_enrollment ce on e.id = ce.student_id
group by e.id
having count(ce.course_edition_id) = (select max(num_cur) from
		(select count(course_edition_id) num_cur
		from course_enrollment
		group by student_id));

select * from student;
select * from academic_semester;
select * from course;
select * from lecturer;
select * from course_edition;
select * from course_enrollment;

