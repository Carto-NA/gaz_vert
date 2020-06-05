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
	annee_cible numeric,
	taille_unite varchar(4),
	taille_unite_libelle varchar(4),
	injection boolean default false,
	cogeneration boolean DEFAULT false,
	power2gas boolean DEFAULT false,
	niveau varchar(10),
	techno varchar(50),
	levee_contrainte varchar(100),
  	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
  	geom_valide  boolean DEFAULT false,
  	geom geometry(POINT, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_unites_metha_pkey PRIMARY KEY (id),
  	CONSTRAINT m_env_gaz_vert_au_r6_d1_unites_metha_uniq UNIQUE (id_metha)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_unites_metha IS 'Resau de transport du gaz vert en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.id_metha IS 'Identifiant de l''unité de méthanisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.scenario IS 'Scénario';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.canton IS 'Canon d''appartenance';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.annee_cible IS 'Année de mise en oeuvre';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.taille_unite IS 'Taille de l''unité';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.taille_unite_libelle IS 'Libellé de la taille de l''unité';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.injection IS 'Unité en injection';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.cogeneration IS 'Unité cogénératrice';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.power2gas IS 'Convertion éléctrique en gaz';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.niveau IS 'Niveau';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.techno IS 'Technologie';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.levee_contrainte IS 'Levée de contrainte';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.geom_valide IS 'Géométrie validée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha.geom IS 'Géométrie point';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_unites_metha_geom ON met_env.m_env_gaz_vert_au_r6_d1_unites_metha USING gist (geom);





------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_reseau_transport

-- DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport (
	id serial NOT NULL,
	scenario varchar(10),
  	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
  	geom_valide  boolean DEFAULT false,
  	geom geometry(MULTIPOLYGON, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_transport_pkey PRIMARY KEY (id)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport IS 'Reseau de transport du gaz vert en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.scenario IS 'Scénario';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.geom_valide IS 'Géométrie validée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport.geom IS 'Géométrie polygone';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_reseau_transport_geom ON met_env.m_env_gaz_vert_au_r6_d1_reseau_transport USING gist (geom);


------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_rebours_crees

-- DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees (
	id serial NOT NULL,
	code varchar(10),
	scenario varchar(10),
	statut varchar(10),
	enfant varchar(80),
	parent varchar(80),
	type_rebour varchar(80),
	annee_cible numeric,
	preposition varchar(80),
 	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
	geom_valide  boolean DEFAULT false,
  	geom geometry(POINT, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_rebours_crees_pkey PRIMARY KEY (id)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees IS 'Localisation des rebours en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.code IS 'Code du rebour';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.scenario IS 'Scénario';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.statut IS 'Statut du rebours (en fonctionnement/à créer/Non renseigné)';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.enfant IS 'Enfant du rebour';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.parent IS 'Parent du rebour';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.type_rebour IS 'Type de rebour';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.annee_cible IS 'Année de mise en oeuvre';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.preposition IS '';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.geom_valide IS 'Géométrie validée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees.geom IS 'Géométrie polygone';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_rebours_crees_geom ON met_env.m_env_gaz_vert_au_r6_d1_rebours_crees USING gist (geom);

-- On ajout les données
INSERT INTO met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo (code, scenario, statut, enfant, parent, type_rebour, annee_cible, preposition, 
commentaires, annee_donnees, date_import, date_maj, geom_valide, geom) 
SELECT 'NA2020'||id, scenario, null, enfant, parent, typerebour, annee_cibl, prepositio, 
null, '2020', now(), null, false, geom
FROM z_maj.au_r6_d1_rebours_crees;


------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb

-- DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo (
	id serial NOT NULL,
	scenario varchar(10),
 	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
	geom_valide  boolean DEFAULT false,
	geom geometry(MULTIPOLYGON, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_mpb_geo_pkey PRIMARY KEY (id)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo IS 'Réseau de transport MPB en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo.scenario IS 'Scénario';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo.geom_valide IS 'Géométrie validée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo.geom IS 'Géométrie polygone';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_reseau_mpb_geo_geom ON met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo USING gist (geom);

-- On ajout les données
INSERT INTO met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo (
scenario, commentaires, annee_donnees, date_import, date_maj, geom_valide, geom)
SELECT scenario, null, '2020', now(), null, false, geom 
FROM z_maj.au_r6_d1_reseau_mpb;


------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo

DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo (
	id serial NOT NULL,
	scenario varchar(10),
	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
	geom_valide  boolean DEFAULT false,
	geom geometry(MULTIPOLYGON, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_mpc_geo_pkey PRIMARY KEY (id)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo IS 'Réseau de transport MPC en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo.scenario IS 'Scénario';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo.geom_valide IS 'Géométrie validée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo.geom IS 'Géométrie polygone';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_reseau_mpc_geo_geom ON met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo USING gist (geom);

-- On ajout les données
INSERT INTO met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo (
scenario, commentaires, annee_donnees, date_import, date_maj, geom_valide, geom) 
SELECT scenario, null, '2020', now(), null, false, geom FROM z_maj.au_r6_d1_reseau_mpc;
