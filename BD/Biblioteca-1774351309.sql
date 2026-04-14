CREATE TABLE IF NOT EXISTS "Libro" (
	"id" serial NOT NULL UNIQUE,
	"titulo" varchar(255) NOT NULL,
	"num_paginas" bigint NOT NULL,
	"editorial" varchar(255) NOT NULL,
	"escritor" varchar(255) NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Escritor" (
	"id" serial NOT NULL UNIQUE,
	"nombre" varchar(255) NOT NULL,
	"telefono" bigint NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Socio" (
	"id" serial NOT NULL UNIQUE,
	"nombre" varchar(255) NOT NULL,
	"apaellido_1" varchar(255) NOT NULL,
	"apellido_2" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"telefono" bigint NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Empleado" (
	"id" serial NOT NULL UNIQUE,
	"nombre" varchar(255) NOT NULL,
	"apaellido_1" varchar(255) NOT NULL,
	"apellido_2" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"telefono" bigint NOT NULL,
	"fecha_incorporación" date NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Prestamo" (
	"id" serial NOT NULL UNIQUE,
	"libro" bigint NOT NULL,
	"socio" varchar(255) NOT NULL,
	"empleado" varchar(255) NOT NULL,
	"fecha_inicio" date NOT NULL,
	"fecha_devolucion" date NOT NULL,
	"dias_retraso" bigint NOT NULL,
	PRIMARY KEY ("id")
);

ALTER TABLE "Libro" ADD CONSTRAINT "Libro_fk4" FOREIGN KEY ("escritor") REFERENCES "Escritor"("id");



ALTER TABLE "Prestamo" ADD CONSTRAINT "Prestamo_fk1" FOREIGN KEY ("libro") REFERENCES "Libro"("id");

ALTER TABLE "Prestamo" ADD CONSTRAINT "Prestamo_fk2" FOREIGN KEY ("socio") REFERENCES "Socio"("id");

ALTER TABLE "Prestamo" ADD CONSTRAINT "Prestamo_fk3" FOREIGN KEY ("empleado") REFERENCES "Empleado"("id");