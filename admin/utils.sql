
/* visualizzazione di tutti i permessi */

SELECT mantis_project_user_list_recursive_table.*
  ,ph.name AS parent_name
  ,p.name AS project_name
  ,mantis_user_table.username
  ,mantis_project_user_list_table.user_id
FROM mantis_project_user_list_recursive_table
LEFT OUTER JOIN mantis_project_table as p ON p.id = mantis_project_user_list_recursive_table.project_id
LEFT OUTER JOIN mantis_project_hierarchy_table ON mantis_project_hierarchy_table.child_id = mantis_project_user_list_recursive_table.project_id
LEFT OUTER JOIN mantis_project_table as ph ON ph.id = mantis_project_hierarchy_table.parent_id
LEFT OUTER JOIN mantis_user_table ON mantis_user_table.id = mantis_project_user_list_recursive_table.user_id
LEFT OUTER JOIN mantis_project_user_list_table ON mantis_project_user_list_table.project_id = mantis_project_user_list_recursive_table.project_id
  AND mantis_project_user_list_table.user_id = mantis_project_user_list_recursive_table.user_id
ORDER BY ph.name,p.name,mantis_user_table.username
