resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.prefix}-dns"

  node_resource_group = "${var.prefix}-aks-node"

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = 2
    vm_size    = var.vm_size
    vnet_subnet_id  = var.aks_subnet_id
    type       = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

    network_profile {
    network_plugin    = "azure"           # Azure CNI (overlay)
    service_cidr      = "10.0.3.0/24"     
    dns_service_ip    = "10.0.3.10"       # From service_cidr IP range
  }

}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id   = azurerm_kubernetes_cluster.aks.identity[0].principal_id 
  role_definition_name = "AcrPull"                                        
  scope           = var.acr_id                  
}
