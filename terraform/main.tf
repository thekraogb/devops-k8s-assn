module "resource_group" {
  source   = "./modules/azurerm_resource_group"
  name     = local.resource_group_name
  location = local.location
}

module "vnet" {
  source              = "./modules/azurerm_vnet"
  name                = local.vnet_name
  resource_group_name = module.resource_group.resource_group
  location            = local.location
  address_space       = local.address_space
}

module "subnets" {
  source              = "./modules/azurerm_subnets"
  for_each            = local.subnet
  name                = each.key
  resource_group_name = module.resource_group.resource_group
  vnet_name           = module.vnet.virtual_network
  address_prefixes    = each.value.address_space
  location            = local.location
  nsg_rules           = lookup(each.value, "nsg_rules", [])
}

module "sql" {
  source              = "./modules/azurerm_sql"
  resource_group_name = module.resource_group.resource_group
  location            = local.location
  db_name             = local.sql.db_name
  admin_login         = local.sql.admin_user
  admin_password      = local.sql.admin_password
  subnet_id           = module.subnets["db_subnet"].id
  vnet_id             = module.vnet.virtual_network_id
}

module "aks" {
  source              = "./modules/azurerm_aks" 
  prefix              = "aks"
  location            = local.location
  vm_size             = "Standard_B2s"
  default_node_pool_name = "nodepool"
  resource_group_name = module.resource_group.resource_group
  aks_subnet_id       = module.subnets["aks_subnet"].id
}


