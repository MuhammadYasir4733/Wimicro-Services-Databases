
BEGIN;

CREATE SCHEMA IF NOT EXISTS essential;

CREATE TABLE IF NOT EXISTS essential."styleOutput"
(
    "styleTemplateID" integer NOT NULL,
    "styleTemplateCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "styleTemplateDetailID" integer NOT NULL,
    "operationID" integer NOT NULL,
    "operationSequence" integer NOT NULL,
    "scanType" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "isFirst" boolean NOT NULL,
    "isLast" boolean NOT NULL,
    "machineTypeID" integer NOT NULL,
    "SMV" integer NOT NULL,
    "pieceRate" integer NOT NULL,
    "isCritical" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT styleoutput_pkey PRIMARY KEY ("styleTemplateDetailID", "styleTemplateID")
);

CREATE TABLE IF NOT EXISTS essential."styleTemplate"
(
    "styleTemplateID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "styleTemplateCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT "styleTemplate_pkey" PRIMARY KEY ("styleTemplateID")
);

CREATE TABLE IF NOT EXISTS essential."styleTemplateDetail"
(
    "styleTemplateDetailID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "styleTemplateID" integer NOT NULL,
    "operationID" integer NOT NULL,
    "operationSequence" integer NOT NULL,
    "scanType" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "isFirst" boolean NOT NULL,
    "isLast" boolean NOT NULL,
    "machineTypeID" integer NOT NULL,
    "SMV" double precision NOT NULL,
    "pieceRate" double precision NOT NULL,
    "isCritical" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT "styleTemplateDetail_pkey" PRIMARY KEY ("styleTemplateDetailID")
);

ALTER TABLE IF EXISTS essential."styleTemplateDetail"
    ADD CONSTRAINT fk_styletemplatedetail_styletemplate FOREIGN KEY ("styleTemplateID")
    REFERENCES essential."styleTemplate" ("styleTemplateID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;