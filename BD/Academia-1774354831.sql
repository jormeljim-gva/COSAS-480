CREATE TABLE IF NOT EXISTS "Curso" (
	"id" serial NOT NULL UNIQUE,
	"asignatura" varchar(255) NOT NULL,
	"alumno" varchar(255) NOT NULL,
	"profesor" varchar(255) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Asignatura" (
	"id" serial NOT NULL UNIQUE,
	"nombre" varchar(255) NOT NULL,
	"anyo_lectivo" bigint NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Profesor" (
	"id" serial NOT NULL UNIQUE,
	"user" varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
	"nombre" varchar(255) NOT NULL,
	"apellido_1" varchar(255) NOT NULL,
	"apellido_2" varchar(255) NOT NULL,
	"mail" varchar(255) NOT NULL,
	"telefono" bigint NOT NULL,
	"fecha_creacion" date NOT NULL,
	"fecha_actualizacion" date NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Alumno" (
	"id" serial NOT NULL UNIQUE,
	"user" varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
	"nombre" varchar(255) NOT NULL,
	"apellido_1" varchar(255) NOT NULL,
	"apellido_2" varchar(255) NOT NULL,
	"mail" varchar(255) NOT NULL,
	"telefono" bigint NOT NULL,
	"fecha_creacion" date NOT NULL,
	"fecha_actualizacion" date NOT NULL,
	"centro" bigint NOT NULL,
	"num_asistencia" bigint NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Centro" (
	"id" serial NOT NULL UNIQUE,
	"tipo" varchar(255) NOT NULL,
	"nombre" varchar(255) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Curso-Alumnos" (
	"id_curso" serial NOT NULL UNIQUE,
	"id_alumno" serial NOT NULL UNIQUE,
	PRIMARY KEY ("id_curso", "id_alumno")
);

CREATE TABLE IF NOT EXISTS "Curso-Profesores" (
	"id_curso" serial NOT NULL UNIQUE,
	"id_profesor" serial NOT NULL UNIQUE,
	PRIMARY KEY ("id_curso", "id_profesor")
);

CREATE TABLE IF NOT EXISTS "Alumno-Centro" (
	"id_alumno" bigint NOT NULL UNIQUE,
	"id_centro" bigint NOT NULL UNIQUE,
	PRIMARY KEY ("id_alumno", "id_centro")
);

ALTER TABLE "Curso" ADD CONSTRAINT "Curso_fk1" FOREIGN KEY ("asignatura") REFERENCES "Asignatura"("id");




ALTER TABLE "Curso-Alumnos" ADD CONSTRAINT "Curso-Alumnos_fk0" FOREIGN KEY ("id_curso") REFERENCES "Curso"("id");

ALTER TABLE "Curso-Alumnos" ADD CONSTRAINT "Curso-Alumnos_fk1" FOREIGN KEY ("id_alumno") REFERENCES "Alumno"("id");
ALTER TABLE "Curso-Profesores" ADD CONSTRAINT "Curso-Profesores_fk0" FOREIGN KEY ("id_curso") REFERENCES "Curso"("id");

ALTER TABLE "Curso-Profesores" ADD CONSTRAINT "Curso-Profesores_fk1" FOREIGN KEY ("id_profesor") REFERENCES "Profesor"("id");
ALTER TABLE "Alumno-Centro" ADD CONSTRAINT "Alumno-Centro_fk0" FOREIGN KEY ("id_alumno") REFERENCES "Alumno"("id");

ALTER TABLE "Alumno-Centro" ADD CONSTRAINT "Alumno-Centro_fk1" FOREIGN KEY ("id_centro") REFERENCES "Centro"("id");