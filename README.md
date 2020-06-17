# Gaz vert

Dans le cadre du développement des énergies vertes, voici l'ensemble des éléments constituant la mise en oeuvre de la base de données urbanisées sur les thématiques environnement, économique ainsi que l'exploitation de ces données dans les différentes applications :

* Statut
  - [ ] à rédiger
  - [x] en cours de rédaction
  - [ ] relecture
  - [ ] finaliser
  - [ ] révision

- Script d'initialisation de la base de données 
  * [Suivi des modifications](sql/gaz_vert_00_trace.sql)
  * [Création  de la structure initiale](sql/gaz_vert_10_structure.sql)
  * [Création des vues de gestion](sql/gaz_vert_20_vues_gestion.sql)
  * [Création des vues applicatives](sql/gaz_vert_21_vues_xapps.sql)
  * [Création des vues applicatives gd public](sql/gaz_vert_22_vues_xapps_public.sql)
  * [Création des vues open data](sql/gaz_vert_23_vues_xopendata.sql)
  * [Création des privilèges](sql/gaz_vert_99_droit.sql)
  

# Construction de la données par Solagro - https://solagro.org/

"Nous avons utilisé les PSEUDO-CANTON, c’est-à-dire que l’INSEE propose un regroupement des cantons administratifs qui ne comprennent pas un nombre entier de communes sous le nom de Pseudo-cantons.
C’est cette liste que nous avons utilisées et que nous avons constituée à partir du fichier « Communes existantes au 1er janvier 2010 » accessible ici : https://www.insee.fr/fr/information/2560630
 
Pour chaque commune, le code canton (pseudo-canton) est indiqué dans le fichier insee ; ce sont ces cantons que nous avons utilisés.
Les cantons xx99,xx98,xx97 correspondent aux communes marquées « cdc » par l’insee soit « Découpage de la commune en cantonse ».
 
Pour chaque commune, le nom du canton (pseudo-canton) n’est pas indiqué : nous l’avons construit de la façon suivante :
Si « CDC » = 0 ; nom_pseudo_canton = nom du canton provenant du fichier «Cantons au 1er janvier 2010 ». Dispo ici :  https://www.insee.fr/fr/information/2560630
Si « CDC » = 1 ; nom_pseudo_canton  = nom de la commune.
 
Nous avons dû utiliser les pseudos-cantons car sinon les contours des communes et des cantons ne pouvaient pas se superposer. 
Sans, cela, il n’aurait pas été possible de gérer des données à la fois communales et cantons, car elles ne pourraient pas « s’emboîter ».
Nous avons utilisé le découpage 2010 car c’est la date du dernier recensement agricole.
"
