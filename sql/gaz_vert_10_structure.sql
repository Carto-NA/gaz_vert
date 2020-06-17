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

--DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo (
	id serial NOT NULL,
	id_metha varchar(8) NULL,
	scenario varchar(10) NULL,
	canton varchar(4) NULL,
	annee_cible numeric NULL,
	taille_unite varchar(4) NULL,
	taille_unite_libelle varchar(150) NULL,
	injection bool NULL DEFAULT false,
	cogeneration bool NULL DEFAULT false,
	power2gas bool NULL DEFAULT false,
	niveau varchar(10) NULL,
	techno varchar(50) NULL,
	levee_contrainte varchar(100) NULL,
	commentaires text NULL,
	annee_donnees varchar(4) NULL,
	date_import date NULL,
	date_maj date NULL,
	geom_valide bool NULL DEFAULT false,
	geom geometry(POINT, 2154) NULL,
	CONSTRAINT m_env_gaz_vert_au_r6_d1_unites_metha_geo_pkey PRIMARY KEY (id),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_unites_metha_geo_uniq UNIQUE (id_metha)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo IS 'Resau de transport du gaz vert en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.id_metha IS 'Identifiant de l''unité de méthanisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.scenario IS 'Scénario';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.canton IS 'Canon d''appartenance';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.annee_cible IS 'Année de mise en oeuvre';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.taille_unite IS 'Taille de l''unité';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.taille_unite_libelle IS 'Libellé de la taille de l''unité';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.injection IS 'Unité en injection';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.cogeneration IS 'Unité cogénératrice';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.power2gas IS 'Convertion éléctrique en gaz';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.niveau IS 'Niveau';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.techno IS 'Technologie';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.levee_contrainte IS 'Levée de contrainte';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.geom_valide IS 'Géométrie validée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo.geom IS 'Géométrie point';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_unites_metha_geo_geom ON met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo USING gist (geom);

-- Ajout de données
INSERT INTO met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo (
id_metha, scenario, canton, annee_cible, taille_unite, taille_unite_libelle, injection, cogeneration, power2gas, 
niveau, techno, levee_contrainte, commentaires, annee_donnees, date_import, date_maj, geom_valide, geom) 
SELECT 
id_metha, scenario, canton, anneecible, tailleunit, null, cast(injection as boolean), cast(coge as boolean), cast(power2gas as boolean), 
niveau, techno, leveecontr, null, '2020', now(), null, false, geom 
FROM z_maj.au_r6_d1_unites_metha;

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='Moins de 80 m3/h'
WHERE taille_unite in ('U1','U2','U3','U4');


UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='80 m3/h'
WHERE taille_unite = 'U5';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='160 m3/h'
WHERE taille_unite = 'U6';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='270 m3/h'
WHERE taille_unite = 'U7';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='380 m3/h'
WHERE taille_unite = 'U8';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='490 m3/h'
WHERE taille_unite = 'U9';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='600 m3/h'
WHERE taille_unite = 'U10';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='710 m3/h'
WHERE taille_unite = 'U11';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='810 m3/h'
WHERE taille_unite = 'U12';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='920 m3/h'
WHERE taille_unite = 'U13';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='1030 m3/h'
WHERE taille_unite = 'U14';

UPDATE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo 
SET taille_unite_libelle='1190 m3/h'
WHERE taille_unite = 'U15';

------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo

--DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo (
	id varchar NOT NULL,
	scenario varchar(10) NULL,
	commentaires text NULL,
	annee_donnees varchar(4) NULL,
	date_import date NULL,
	date_maj date NULL,
	geom_valide bool NULL DEFAULT false,
	geom geometry(MULTIPOLYGON, 2154) NULL,
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_transport_geo_pkey PRIMARY KEY (id),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_transport_geo_uniq UNIQUE (id,annee_donnees)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo IS 'Reseau de transport du gaz vert en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo.scenario IS 'Scénario';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo.geom_valide IS 'Géométrie validée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo.geom IS 'Géométrie polygone';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_reseau_transport_geo_geom ON met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo USING gist (geom);

-- Ajout de données
INSERT INTO met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo (
scenario, commentaires, annee_donnees, date_import, date_maj, geom_valide, geom) 
SELECT scenario, null, '2020', now(), null, false, geom
FROM z_maj.au_r6_d1_reseau_transport;

------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_rebours_crees

-- DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo (
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
	CONSTRAINT m_env_gaz_vert_au_r6_d1_rebours_crees_geo_pkey PRIMARY KEY (id)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo IS 'Localisation des rebours en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.code IS 'Code du rebour';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.scenario IS 'Scénario';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.statut IS 'Statut du rebours (en fonctionnement/à créer/Non renseigné)';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.enfant IS 'Enfant du rebour';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.parent IS 'Parent du rebour';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.type_rebour IS 'Type de rebour';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.annee_cible IS 'Année de mise en oeuvre';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.preposition IS '';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.geom_valide IS 'Géométrie validée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo.geom IS 'Géométrie polygone';

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_rebours_crees_geo_geom ON met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo USING gist (geom);

--
CREATE INDEX sidx_m_env_gaz_vert_au_r6_d1_rebours_crees_geom ON met_env.m_env_gaz_vert_au_r6_d1_rebours_crees USING gist (geom);

-- On ajout les données
INSERT INTO met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo (code, scenario, statut, enfant, parent, type_rebour, annee_cible, preposition, 
commentaires, annee_donnees, date_import, date_maj, geom_valide, geom) 
SELECT 'NA2020'||id, scenario, null, enfant, parent, typerebour, annee_cibl, prepositio, 
null, '2020', now(), null, false, geom
FROM z_maj.au_r6_d1_rebours_crees;


------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo

-- DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo (
	id varchar NOT NULL,
	scenario varchar(10),
 	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
	geom_valide  boolean DEFAULT false,
	geom geometry(MULTIPOLYGON, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_mpb_geo_pkey PRIMARY KEY (id),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_mpb_geo_uniq UNIQUE (id, annee_donnees)
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
id, scenario, commentaires, annee_donnees, date_import, date_maj, geom_valide, geom)
SELECT id, scenario, null, '2020', now(), null, false, geom 
FROM z_maj.au_r6_d1_reseau_mpb;


------------------------------------------------------------------------
-- Table: met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo

DROP TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo;
CREATE TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo (
	id varchar NOT NULL,
	scenario varchar(10),
	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
	geom_valide  boolean DEFAULT false,
	geom geometry(MULTIPOLYGON, 2154),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_mpc_geo_pkey PRIMARY KEY (id),
	CONSTRAINT m_env_gaz_vert_au_r6_d1_reseau_mpc_geo_uniq UNIQUE (id, annee_donnees)
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
id, scenario, commentaires, annee_donnees, date_import, date_maj, geom_valide, geom) 
SELECT id, scenario, null, '2020', now(), null, false, geom FROM z_maj.au_r6_d1_reseau_mpc;


------------------------------------------------------------------------
-- DROP TABLE met_env.m_env_gaz_vert_etat_commune;
CREATE TABLE met_env.m_env_gaz_vert_etat_commune (
	id serial NOT NULL,
	nomcom character varying(150),
	numcom character varying(5),
	code_postal character varying(5),
	commune_desservie_grd boolean DEFAULT false,
	commune_traversee_grt boolean DEFAULT false,
	commune_desservie_scenario_gaz_vert boolean DEFAULT false,
	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
	CONSTRAINT m_env_gaz_vert_etat_commune_pkey PRIMARY KEY (id),
	CONSTRAINT m_env_gaz_vert_etat_commune_uniq UNIQUE (numcom, code_postal)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_etat_commune IS 'Etat de raccordement des communes concernés';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.nomcom IS 'Nom de commune';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.numcom IS 'Code INSEE de la commune';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.code_postal IS 'Code postal de la commune';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.commune_desservie_grd IS 'Commune raccordée au réseau par un GRDF';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.commune_traversee_grt IS 'Commune traversée par un GRT';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.commune_desservie_scenario_gaz_vert IS 'Commune raccordée grâce au scénario Gaz Vert';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_etat_commune.date_maj IS 'Date de mise à jour de la donnée';

--
INSERT INTO met_env.m_env_gaz_vert_etat_commune (
	nomcom, numcom, code_postal, 
	commune_desservie_grd, commune_traversee_grt, commune_desservie_scenario_gaz_vert, annee_donnees, date_import
)
SELECT 
	DISTINCT nom_com, trim(cast(code_commune_insee as varchar)), null,
	CASE "commune déjà desservie par un grd" WHEN 'OUI' THEN true WHEN 'NON' THEN false ELSE null END,
	CASE "commune traversée par un grt" WHEN 'OUI' THEN true WHEN 'NON' THEN false ELSE null END,
	CASE "commune nouvellement desservie grace au scénario 100% gaz vert" WHEN 'OUI' THEN true WHEN 'NON' THEN false ELSE null END,
	'2020', now()
FROM z_maj."20200611 Fichier carto_raccordement_commune"
inner join ref_adminexpress.r_admexp_commune_fr 
on cast(code_commune_insee as varchar) = insee_com;


------------------------------------------------------------------------
-- DROP TABLE met_env.m_env_gaz_vert_canton_ressource;
CREATE TABLE met_env.m_env_gaz_vert_canton_ressource (
	id serial NOT NULL,
	numreg character varying(2),
	numdep character varying(2),
	numcan character varying(4),
	nomcan character varying(150),
	dejection_animale numeric,
	residu_culture numeric,
	cimse numeric,
	residu_iaa numeric,
	biodechet numeric,
	herbe numeric,
	algues numeric,
	commentaires text,
	annee_donnees varchar(4),
	date_import date,
	date_maj date,
	CONSTRAINT m_env_gaz_vert_canton_ressource_pkey PRIMARY KEY (id),
	CONSTRAINT m_env_gaz_vert_canton_ressource_uniq UNIQUE (numcan, annee_donnees)
);

-- 
COMMENT ON TABLE met_env.m_env_gaz_vert_canton_ressource IS 'Réseau de transport MPC en Nouvelle-Aquitaine';

--
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.numreg IS 'Code de la région';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.numdep IS 'Code du département';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.numcan IS 'Code du canton';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.nomcan IS 'Nom du canton';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.dejection_animale IS 'Ressource méthanisation en déjéction animale';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.residu_culture IS 'Ressource méthanisation en résidu de culture';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.cimse IS 'Ressource méthanisation en CIMSE';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.residu_iaa IS 'Ressource méthanisation en résidu IAA';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.biodechet IS 'Ressource méthanisation en biodéchet';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.herbe IS 'Ressource méthanisation en herbe';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.algues IS 'Ressource méthanisation en algues';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.annee_donnees IS 'Année de la données pour l''historisation';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_gaz_vert_canton_ressource.date_maj IS 'Date de mise à jour de la donnée';

--
--TRUNCATE TABLE met_env.m_env_gaz_vert_canton_ressource;
INSERT INTO met_env.m_env_gaz_vert_canton_ressource (
	numreg, numdep, numcan, 
	dejection_animale, residu_culture, cimse, residu_iaa, 
	biodechet, herbe, algues, 
	annee_donnees, date_import
) 
SELECT 
	"code.region", code_departement, canton, 
	cast(replace("déjections animales",',','.') as numeric), cast(replace("résidus de cultre",',','.') as numeric), 
	cast(replace(cimse,',','.') as numeric), cast(replace("résidus d'iaa",',','.') as numeric), 
	cast(replace(biodéchets,',','.') as numeric), cast(replace(herbe,',','.') as numeric), 
	cast(replace(algues,',','.') as numeric),
	'2020', now() 
FROM z_maj."20200611 Fichier carto_ressource_metha_canton";
