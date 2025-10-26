output "resource_group_name" {
  value = module.resource_group.resource_group
}

output "db_host" {
  value = module.sql.db_host
}

output "db_name" {
  value = module.sql.db_name
}

output "sql_fqdn_private" {
  value = module.sql.sql_fqdn_private
}

output "kube_config" {
  value = module.aks.kube_config
  sensitive = true
}

output "cluster_name" {
  value = module.aks.cluster_name
}
