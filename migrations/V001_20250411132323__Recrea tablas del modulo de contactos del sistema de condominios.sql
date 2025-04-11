-- Table: condominio.tipo_entidad

DROP TABLE IF EXISTS condominio.tipo_entidad;

CREATE TABLE IF NOT EXISTS condominio.tipo_entidad
(
    tipo_entidad_id integer NOT NULL,
    tipo_entidad_descripcion character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT tipo_entidad_pkey PRIMARY KEY (tipo_entidad_id)
);

-- Table: condominio.tipo_identificacion

DROP TABLE IF EXISTS condominio.tipo_identificacion;

CREATE TABLE IF NOT EXISTS condominio.tipo_identificacion
(
    tipo_identificacion_id integer NOT NULL,
    tipo_identificacion_descripcion character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT tipo_identificacion_pkey PRIMARY KEY (tipo_identificacion_id)
);

-- Table: condominio.estado

DROP TABLE IF EXISTS condominio.estado;

CREATE TABLE IF NOT EXISTS condominio.estado
(
    estado_id integer NOT NULL,
    estado_descripcion character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT estado_pkey PRIMARY KEY (estado_id)
);

-- Table: condominio.nacionalidad

DROP TABLE IF EXISTS condominio.nacionalidad;

CREATE TABLE IF NOT EXISTS condominio.nacionalidad
(
    nacionalidad_id integer NOT NULL,
    nacionalidad_descripcion character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT nacionalidad_pkey PRIMARY KEY (nacionalidad_id)
);

-- Table: condominio.inquilino

DROP TABLE IF EXISTS condominio.inquilino;

CREATE TABLE IF NOT EXISTS condominio.inquilino
(
    inquilino_id integer NOT NULL,
    inquilino_nombre1 character varying(250) COLLATE pg_catalog."default" NOT NULL,
    inquilino_nombre2 character varying(250) COLLATE pg_catalog."default",
    inquilino_apellido1 character varying(250) COLLATE pg_catalog."default" NOT NULL,
    inquilino_apellido2 character varying(250) COLLATE pg_catalog."default",
    inquilino_fecha_nacimiento date NOT NULL,
    inquilino_nacionalidad_id integer NOT NULL,
    inquilino_tipo_identificacion_id integer NOT NULL,
    inquilino_identificacion character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT inquilino_pkey PRIMARY KEY (inquilino_id),
    CONSTRAINT inquilino_inquilino_nacionalidad_id_fkey FOREIGN KEY (inquilino_nacionalidad_id)
        REFERENCES condominio.nacionalidad (nacionalidad_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT inquilino_inquilino_tipo_identificacion_id_fkey FOREIGN KEY (inquilino_tipo_identificacion_id)
        REFERENCES condominio.tipo_identificacion (tipo_identificacion_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: condominio.propietario

DROP TABLE IF EXISTS condominio.propietario;

CREATE TABLE IF NOT EXISTS condominio.propietario
(
    propietario_id integer NOT NULL,
    propietario_nombre1 character varying(250) COLLATE pg_catalog."default" NOT NULL,
    propietario_nombre2 character varying(250) COLLATE pg_catalog."default",
    propietario_apellido1 character varying(250) COLLATE pg_catalog."default" NOT NULL,
    propietario_apellido2 character varying(250) COLLATE pg_catalog."default",
    propietario_fecha_nacimiento date NOT NULL,
    propietario_nacionalidad_id integer NOT NULL,
    propietario_tipo_identificacion_id integer NOT NULL,
    propietario_identificacion character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT propietario_pkey PRIMARY KEY (propietario_id),
    CONSTRAINT propietario_propietario_nacionalidad_id_fkey FOREIGN KEY (propietario_nacionalidad_id)
        REFERENCES condominio.nacionalidad (nacionalidad_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT propietario_propietario_tipo_identificacion_id_fkey FOREIGN KEY (propietario_tipo_identificacion_id)
        REFERENCES condominio.tipo_identificacion (tipo_identificacion_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: condominio.residencial

DROP TABLE IF EXISTS condominio.residencial;

CREATE TABLE IF NOT EXISTS condominio.residencial
(
    residencial_id integer NOT NULL,
    residencial_nombre character varying(200) COLLATE pg_catalog."default" NOT NULL,
    residencial_rnc character(9) COLLATE pg_catalog."default" NOT NULL,
    residencial_direccion character varying(250) COLLATE pg_catalog."default" NOT NULL,
    residencial_estado_id integer,
    CONSTRAINT residencial_pkey PRIMARY KEY (residencial_id),
    CONSTRAINT residencial_residencial_rnc_key UNIQUE (residencial_rnc),
    CONSTRAINT residencial_residencial_estado_id_fkey FOREIGN KEY (residencial_estado_id)
        REFERENCES condominio.estado (estado_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: condominio.telefono

DROP TABLE IF EXISTS condominio.telefono;

CREATE TABLE IF NOT EXISTS condominio.telefono
(
    telefono_id integer NOT NULL,
    telefono_entidad_id integer NOT NULL,
    telefono_tipo_entidad_id integer NOT NULL,
    telefono_area integer NOT NULL,
    telefono_num integer NOT NULL,
    CONSTRAINT telefono_pkey PRIMARY KEY (telefono_id),
    CONSTRAINT telefono_telefono_entidad_id_fkey FOREIGN KEY (telefono_entidad_id)
        REFERENCES condominio.propietario (propietario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT telefono_telefono_entidad_id_fkey1 FOREIGN KEY (telefono_entidad_id)
        REFERENCES condominio.inquilino (inquilino_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT telefono_telefono_entidad_id_fkey2 FOREIGN KEY (telefono_entidad_id)
        REFERENCES condominio.residencial (residencial_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT telefono_telefono_tipo_entidad_id_fkey FOREIGN KEY (telefono_tipo_entidad_id)
        REFERENCES condominio.tipo_entidad (tipo_entidad_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: condominio.correo_electronico

DROP TABLE IF EXISTS condominio.correo_electronico;

CREATE TABLE IF NOT EXISTS condominio.correo_electronico
(
    correo_electronico_id integer NOT NULL,
    correo_electronico_entidad_id integer NOT NULL,
    correo_electronico_tipo_entidad_id integer NOT NULL,
    correo_electronico_correo character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT correo_electronico_pkey PRIMARY KEY (correo_electronico_id),
    CONSTRAINT correo_electronico_correo_electronico_entidad_id_fkey FOREIGN KEY (correo_electronico_entidad_id)
        REFERENCES condominio.propietario (propietario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT correo_electronico_correo_electronico_entidad_id_fkey1 FOREIGN KEY (correo_electronico_entidad_id)
        REFERENCES condominio.inquilino (inquilino_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT correo_electronico_correo_electronico_tipo_entidad_id_fkey FOREIGN KEY (correo_electronico_tipo_entidad_id)
        REFERENCES condominio.tipo_entidad (tipo_entidad_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: condominio.edificio

DROP TABLE IF EXISTS condominio.edificio;

CREATE TABLE IF NOT EXISTS condominio.edificio
(
    edificio_id integer NOT NULL,
    edificio_residencial_id integer,
    edificio_nombre character varying(250) COLLATE pg_catalog."default",
    edificio_comentario character varying(550) COLLATE pg_catalog."default",
    CONSTRAINT edificio_pkey PRIMARY KEY (edificio_id),
    CONSTRAINT edificio_edificio_residencial_id_fkey FOREIGN KEY (edificio_residencial_id)
        REFERENCES condominio.residencial (residencial_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: condominio.departamento

DROP TABLE IF EXISTS condominio.departamento;

CREATE TABLE IF NOT EXISTS condominio.departamento
(
    departamento_id integer NOT NULL,
    departamento_edificio_id integer NOT NULL,
    departamento_piso integer NOT NULL,
    departamento_numero integer NOT NULL,
    departamento_inquilino_id integer,
    CONSTRAINT departamento_pkey PRIMARY KEY (departamento_id),
    CONSTRAINT departamento_departamento_edificio_id_fkey FOREIGN KEY (departamento_edificio_id)
        REFERENCES condominio.edificio (edificio_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT departamento_departamento_inquilino_id_fkey FOREIGN KEY (departamento_inquilino_id)
        REFERENCES condominio.inquilino (inquilino_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Table: condominio.departamento_propietario

DROP TABLE IF EXISTS condominio.departamento_propietario;

CREATE TABLE IF NOT EXISTS condominio.departamento_propietario
(
    departamento_propietario_id integer NOT NULL,
    departamento_propietario_propietario_id integer NOT NULL,
    departamento_propietario_departamento_id integer NOT NULL,
    CONSTRAINT departamento_propietario_pkey PRIMARY KEY (departamento_propietario_id),
    CONSTRAINT departamento_propietario_departamento_propietario_propietar_key UNIQUE (departamento_propietario_propietario_id, departamento_propietario_departamento_id),
    CONSTRAINT departamento_propietario_departamento_propietario_departam_fkey FOREIGN KEY (departamento_propietario_departamento_id)
        REFERENCES condominio.departamento (departamento_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT departamento_propietario_departamento_propietario_propieta_fkey FOREIGN KEY (departamento_propietario_propietario_id)
        REFERENCES condominio.propietario (propietario_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);