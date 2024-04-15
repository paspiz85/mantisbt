
CREATE VIEW mantis_project_user_list_recursive_table AS
WITH RECURSIVE cte (project_id, parent_id, user_id, access_level) AS (
  SELECT    mantis_project_user_list_table.project_id,
            mantis_project_hierarchy_table.parent_id,
            mantis_project_user_list_table.user_id,
            mantis_project_user_list_table.access_level
  FROM      mantis_project_user_list_table
  LEFT JOIN mantis_project_hierarchy_table ON mantis_project_hierarchy_table.child_id = mantis_project_user_list_table.project_id
  UNION ALL
  SELECT    mantis_project_hierarchy_table.child_id AS project_id,
            mantis_project_hierarchy_table.parent_id,
            cte.user_id,
            IFNULL(mantis_project_user_list_table.access_level,cte.access_level) AS access_level
  FROM      mantis_project_hierarchy_table
  INNER JOIN cte ON mantis_project_hierarchy_table.parent_id = cte.project_id
  LEFT JOIN mantis_project_user_list_table ON mantis_project_user_list_table.project_id = mantis_project_hierarchy_table.child_id
            AND mantis_project_user_list_table.user_id = cte.user_id
)
SELECT DISTINCT project_id, user_id, access_level FROM cte;
