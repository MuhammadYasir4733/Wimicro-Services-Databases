BEGIN;

CREATE SCHEMA IF NOT EXISTS essential;

CREATE TABLE IF NOT EXISTS essential."appVersion"
(
    "appVersionID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    version character varying(10) COLLATE pg_catalog."default" NOT NULL,
    address character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "appType" character varying(24) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_appversion PRIMARY KEY ("appVersionID")
);

CREATE TABLE IF NOT EXISTS essential.box
(
    "boxID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "boxCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "issueDate" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "currentAddress" integer NOT NULL,
    "zoneTopic" character varying(32) COLLATE pg_catalog."default",
    CONSTRAINT pk_boxid PRIMARY KEY ("boxID"),
    CONSTRAINT uq_boxcode UNIQUE ("boxCode")
);

CREATE TABLE IF NOT EXISTS essential.department
(
    "departmentID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "departmentName" character varying(40) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_department PRIMARY KEY ("departmentID"),
    CONSTRAINT uq_department_departmentname UNIQUE ("departmentName")
);

CREATE TABLE IF NOT EXISTS essential.fault
(
    "faultID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "faultCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "faultDescription" character varying(256) COLLATE pg_catalog."default" NOT NULL,
    "sectionID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_faultid PRIMARY KEY ("faultID"),
    CONSTRAINT uq_section_faultcode UNIQUE ("sectionID", "faultCode")
);

CREATE TABLE IF NOT EXISTS essential.line
(
    "lineID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "lineCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "lineDescription" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_lineid PRIMARY KEY ("lineID"),
    CONSTRAINT uq_linecode UNIQUE ("lineCode")
);

CREATE TABLE IF NOT EXISTS essential.machine
(
    "machineID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "machineCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "machineDescription" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "imageUpdatedAt" timestamp without time zone,
    "machineTypeID" integer NOT NULL,
    "activeWorkerID" integer,
    "lineID" integer,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "boxID" integer,
    "isMachineDown" boolean,
    CONSTRAINT pk_machineid PRIMARY KEY ("machineID"),
    CONSTRAINT uq_machine_machineid_boxid UNIQUE ("machineID", "boxID"),
    CONSTRAINT uq_machinecode UNIQUE ("machineCode")
);

CREATE TABLE IF NOT EXISTS essential."machineType"
(
    "machineTypeID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "machineTypeCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "machineTypeDescription" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    allowance double precision NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_machinetypeid PRIMARY KEY ("machineTypeID"),
    CONSTRAINT uq_machinetypecode UNIQUE ("machineTypeCode")
);

CREATE TABLE IF NOT EXISTS essential.module
(
    "moduleID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "moduleCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_moduleid PRIMARY KEY ("moduleID"),
    CONSTRAINT uq_modulecode UNIQUE ("moduleCode")
);

CREATE TABLE IF NOT EXISTS essential.operation
(
    "operationID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "operationCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "operationName" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "operationDescription" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "pieceRate" double precision,
    "operationType" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "imageUpdatedAt" timestamp without time zone,
    "sectionID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "departmentID" integer,
    "SMV" double precision,
    CONSTRAINT pk_operationid PRIMARY KEY ("operationID"),
    CONSTRAINT uq_operationcode UNIQUE ("operationCode")
);

CREATE TABLE IF NOT EXISTS essential.section
(
    "sectionID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "sectionCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "sectionDescription" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_sectionid PRIMARY KEY ("sectionID"),
    CONSTRAINT uq_sectioncode UNIQUE ("sectionCode")
);

CREATE TABLE IF NOT EXISTS essential."sectionMapping"
(
    "sectionMappingID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "sectionID" integer NOT NULL,
    "mappedSectionID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_sectionmapping PRIMARY KEY ("sectionMappingID")
);

CREATE TABLE IF NOT EXISTS essential.shift
(
    "shiftID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "shiftName" character varying(32) COLLATE pg_catalog."default" NOT NULL,
    "startTime" time without time zone,
    "endTime" time without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_shift PRIMARY KEY ("shiftID")
);

CREATE TABLE IF NOT EXISTS essential."user"
(
    "userID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "userName" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    password character varying(1024) COLLATE pg_catalog."default" NOT NULL,
    "userType" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "imageUpdatedAt" timestamp without time zone,
    "lineID" integer NOT NULL,
    "sectionID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_userid PRIMARY KEY ("userID"),
    CONSTRAINT uq_username UNIQUE ("userName")
);

CREATE TABLE IF NOT EXISTS essential."userPermission"
(
    "userPermissionID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "userID" integer NOT NULL,
    "moduleID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    CONSTRAINT pk_userpermissionid PRIMARY KEY ("userPermissionID"),
    CONSTRAINT uq_userpermission UNIQUE ("userID", "moduleID")
);

CREATE TABLE IF NOT EXISTS essential.worker
(
    "workerID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "workerCode" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "workerDescription" character varying(64) COLLATE pg_catalog."default" NOT NULL,
    "imageUpdatedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT '2023-03-17 12:45:48.525131'::timestamp without time zone,
    "todayCheckin" timestamp without time zone,
    "todayProduction" integer,
    "workerType" character varying(64) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Operator'::character varying,
    CONSTRAINT pk_workerid PRIMARY KEY ("workerID"),
    CONSTRAINT uq_workercode UNIQUE ("workerCode")
);

ALTER TABLE IF EXISTS essential.fault
    ADD CONSTRAINT fk_fault_section FOREIGN KEY ("sectionID")
    REFERENCES essential.section ("sectionID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential.machine
    ADD CONSTRAINT fk_machine_activeworker FOREIGN KEY ("activeWorkerID")
    REFERENCES essential.worker ("workerID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential.machine
    ADD CONSTRAINT fk_machine_box FOREIGN KEY ("boxID")
    REFERENCES essential.box ("boxID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential.machine
    ADD CONSTRAINT fk_machine_line FOREIGN KEY ("lineID")
    REFERENCES essential.line ("lineID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential.machine
    ADD CONSTRAINT fk_machine_machinetype FOREIGN KEY ("machineTypeID")
    REFERENCES essential."machineType" ("machineTypeID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential.operation
    ADD CONSTRAINT fk_operation_department FOREIGN KEY ("departmentID")
    REFERENCES essential.department ("departmentID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential.operation
    ADD CONSTRAINT fk_operation_section FOREIGN KEY ("sectionID")
    REFERENCES essential.section ("sectionID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential."sectionMapping"
    ADD CONSTRAINT fk_sectionmapping_section FOREIGN KEY ("sectionID")
    REFERENCES essential.section ("sectionID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential."user"
    ADD CONSTRAINT fk_user_line FOREIGN KEY ("lineID")
    REFERENCES essential.line ("lineID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential."user"
    ADD CONSTRAINT fk_user_section FOREIGN KEY ("sectionID")
    REFERENCES essential.section ("sectionID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential."userPermission"
    ADD CONSTRAINT fk_userpermission_module FOREIGN KEY ("moduleID")
    REFERENCES essential.module ("moduleID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential."userPermission"
    ADD CONSTRAINT fk_userpermission_user FOREIGN KEY ("userID")
    REFERENCES essential."user" ("userID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;