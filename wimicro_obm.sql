
BEGIN;

CREATE SCHEMA IF NOT EXISTS essential;

CREATE TABLE IF NOT EXISTS essential.color
(
    "colorID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "colorCode" character varying(12) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT color_pkey PRIMARY KEY ("colorID")
);

CREATE TABLE IF NOT EXISTS essential."obmOutput"
(
    "saleOrderID" integer NOT NULL,
    "saleOrderCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "saleOrderQuantity" integer NOT NULL,
    "productionOrderID" integer NOT NULL,
    "productionOrderCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "productionOrderQuantity" integer NOT NULL,
    "isClosed" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    mappings json,
    CONSTRAINT pk_obm_output PRIMARY KEY ("saleOrderID", "productionOrderID")
);

CREATE TABLE IF NOT EXISTS essential."productionOrder"
(
    "productionOrderID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
    "saleOrderID" integer NOT NULL,
    "productionOrderCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "productionOrderQuantity" integer NOT NULL,
    "isClosed" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    mappings json,
    CONSTRAINT "productionOrder_pkey" PRIMARY KEY ("productionOrderID")
);

CREATE TABLE IF NOT EXISTS essential."saleOrder"
(
    "saleOrderID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "saleOrderCode" character varying(60) COLLATE pg_catalog."default" NOT NULL,
    "saleOrderQuantity" integer NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT "saleOrder_pkey" PRIMARY KEY ("saleOrderID")
);

CREATE TABLE IF NOT EXISTS essential.size
(
    "sizeID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "sizeCode" character varying(12) COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    "updatedAt" timestamp without time zone NOT NULL DEFAULT 'now()',
    CONSTRAINT size_pkey PRIMARY KEY ("sizeID")
);

ALTER TABLE IF EXISTS essential."productionOrder"
    ADD CONSTRAINT fk_productionorder_saleorder FOREIGN KEY ("saleOrderID")
    REFERENCES essential."saleOrder" ("saleOrderID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;