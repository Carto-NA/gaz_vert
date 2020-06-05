/* GAZ VERT V1.0 */
/* Creation des droits sur l'ensemble des objets */
/* gaz_vert_99_droit.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */

------------------------------------------------------------------------ 
-- Grant : Droits des éléments
------------------------------------------------------------------------

-- Tables : met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo TO "pre-sig-usr";
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_unites_metha_geo TO "pre-sig-ro";

-- Tables : met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo TO "pre-sig-usr";
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_transport_geo TO "pre-sig-ro";

-- Tables : met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo TO "pre-sig-usr";
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_rebours_crees_geo TO "pre-sig-ro";

-- Tables : met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo TO "pre-sig-usr";
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpb_geo TO "pre-sig-ro";

-- Tables : met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo TO "pre-sig-usr";
GRANT ALL ON TABLE met_env.m_env_gaz_vert_au_r6_d1_reseau_mpc_geo TO "pre-sig-ro";
