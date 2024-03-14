
BEGIN;

CREATE SCHEMA IF NOT EXISTS essential;

CREATE TABLE IF NOT EXISTS essential.break
(
    "breakID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "breakName" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "breakStartTime" time without time zone NOT NULL,
    "breakEndTime" time without time zone NOT NULL,
    "shiftID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT break_pkey PRIMARY KEY ("breakID")
);

CREATE TABLE IF NOT EXISTS essential.department
(
    "departmentID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "departmentName" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT department_pkey PRIMARY KEY ("departmentID")
);

CREATE TABLE IF NOT EXISTS essential.shift
(
    "shiftID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "shiftName" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "shiftStartTime" time without time zone NOT NULL,
    "shiftEndTime" time without time zone NOT NULL,
    "subDepartmentID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT shift_pkey PRIMARY KEY ("shiftID")
);

CREATE TABLE IF NOT EXISTS essential."subDepartment"
(
    "subDepartmentID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "subDepartmentName" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "departmentID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT "subDepartment_pkey" PRIMARY KEY ("subDepartmentID")
);

ALTER TABLE IF EXISTS essential.break
    ADD CONSTRAINT fk_break_shift FOREIGN KEY ("shiftID")
    REFERENCES essential.shift ("shiftID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential.shift
    ADD CONSTRAINT fk_shift_subdepartment FOREIGN KEY ("subDepartmentID")
    REFERENCES essential."subDepartment" ("subDepartmentID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential."subDepartment"
    ADD CONSTRAINT fk_subdepartment_department FOREIGN KEY ("departmentID")
    REFERENCES essential.department ("departmentID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;