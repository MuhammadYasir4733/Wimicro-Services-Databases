BEGIN;

CREATE SCHEMA IF NOT EXISTS essential;

CREATE TABLE IF NOT EXISTS essential."cutJob"
(
    "cutJobID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "cutJobCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "productionOrderID" integer NOT NULL,
    plies integer NOT NULL,
    "markerID" integer,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT cutjob_pkey PRIMARY KEY ("cutJobID")
);

CREATE TABLE IF NOT EXISTS essential."cutReport"
(
    "cutReportID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "bundleCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    size character varying(60) COLLATE pg_catalog."default" NOT NULL,
    color character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "bundleQuantity" integer NOT NULL,
    "cutJobID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT cutreport_pkey PRIMARY KEY ("cutReportID")
);

CREATE TABLE IF NOT EXISTS essential."cuttingOutput"
(
    "markerID" integer NOT NULL,
    "markerCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "cutJobID" integer NOT NULL,
    "cutJobCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "productionOrderID" integer NOT NULL,
    plies integer NOT NULL,
    "cutReportID" integer NOT NULL,
    "bundleCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    size character varying(60) COLLATE pg_catalog."default" NOT NULL,
    color character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "bundleQuantity" integer NOT NULL,
    "pieceCutReportID" integer NOT NULL,
    "pieceCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT cuttingoutput_pkey PRIMARY KEY ("markerID", "cutJobID", "cutReportID", "pieceCutReportID")
);

CREATE TABLE IF NOT EXISTS essential."cuttingOutputFiltered"
(
    "cutJobID" integer NOT NULL,
    "cutJobCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "cutReportID" integer NOT NULL,
    "bundleCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    pieces json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "productionOrderID" integer NOT NULL,
    size character varying(60) COLLATE pg_catalog."default" NOT NULL,
    color character varying(60) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_cuttingoutputfiltered PRIMARY KEY ("cutJobID", "cutReportID")
);

CREATE TABLE IF NOT EXISTS essential.marker
(
    "markerID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "markerCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "productionOrderID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    mappings json NOT NULL,
    CONSTRAINT marker_pkey PRIMARY KEY ("markerID")
);

CREATE TABLE IF NOT EXISTS essential."pieceCutReport"
(
    "pieceCutReportID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "pieceCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "cutReportID" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT piececutreport_pkey PRIMARY KEY ("pieceCutReportID")
);

ALTER TABLE IF EXISTS essential."cutJob"
    ADD CONSTRAINT fk_cutjob_marker FOREIGN KEY ("markerID")
    REFERENCES essential.marker ("markerID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential."cutReport"
    ADD CONSTRAINT fk_cutreport_cutjob FOREIGN KEY ("cutJobID")
    REFERENCES essential."cutJob" ("cutJobID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS essential."pieceCutReport"
    ADD CONSTRAINT fk_piececutreport_cutreport FOREIGN KEY ("cutReportID")
    REFERENCES essential."cutReport" ("cutReportID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;