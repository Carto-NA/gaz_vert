/* GAZ VERT V1.0 */
/* Creation de la structure des données (schéma, tables, séquences, triggers,...) */
/* gaz_vert_10_structure.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */

------------------------------------------------------------------------ 
-- Schéma : Création du schéma
------------------------------------------------------------------------

-- Schema: met_env
CREATE SCHEMA IF NOT EXISTS met_env;

COMMENT ON SCHEMA met_env IS 'Schéma pour les données métiers sur l''environnemen';


------------------------------------------------------------------------ 
-- Tables : Création des tables
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_unites_metha

-- DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_unites_metha;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_unites_metha (
	id serial NOT NULL,
	id_metha varchar(8),
	scenario varchar(10),
	canton varchar(4),
	tailleuunit varchar(4),
	injection boolean default false,
	annee_cible numeric,
	coge boolean DEFAULT false,
	power2gas boolean DEFAULT false,
	niveau varchar(10),
	techno varchar(50),
	levee_contrainte varchar(100),
  div_commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
  geom_valide  boolean DEFAULT false,
  geom geometry(POINT, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_unites_metha_pkey PRIMARY KEY (id),
  CONSTRAINT m_env_gaz_vert_au_r6_d1_unites_metha_uniq UNIQUE (id_metha)
);
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_unites_metha_geom ON met_env.m_env_gaz_vert_au_r6_d1_unites_metha USING gist (geom);


------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_reseau_transport

-- DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport (
	id varchar NOT NULL,
	scenario varchar(10),
  div_commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
  geom_valide  boolean DEFAULT false,
  geom geometry(MULTIPOLYGON, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_transport_pkey PRIMARY KEY (id)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport IS 'Resau de transport du gaz vert en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.id IS 'Identifiant';


--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_reseau_transport_geom ON met_env.m_env_gaz_vert_au_r6_d1_reseau_transport USING gist (geom);


------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_rebours_crees

-- DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees (
	id serial NOT NULL, -- Identifiant
  code varchar(10), -- Code du rebour
	scenario varchar(10), -- Nom du scénario
  statut varchar(10), -- Statut du rebours (en fonctionnement/à créer/Non renseigné)
	enfant varchar(80), --Enfant du rebour
	parent varchar(80), -- Parent du rebour
	type_rebour varchar(80), -- Type de rebour
	annee_cible numeric,
	prepositio varchar(80),
  commentaires text, -- Commentaires
	annee_donnees varchar(4), -- Année de la données
	date_import date, -- Date d'import de la données
	date_maj date, -- Date de mise à jour de la données
  geom_valide  boolean DEFAULT false, -- La géometrie est-elle validée
  geom geometry(POINT, 2154), -- Géometrie : point
	CONSTRAINT m_env_gaz_vert_au_r6_d1_rebours_crees_pkey PRIMARY KEY (id)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees IS 'Localisation des rebours en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_eco.m_eco_methanisation_na_geo.id IS 'Identifiant';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_rebours_crees_geom ON met_env.m_env_gaz_vert_au_r6_d1_rebours_crees USING gist (geom);


------------------------------------------------------------------------
-- Table: met_env.


------------------------------------------------------------------------
-- Table: met_env.
