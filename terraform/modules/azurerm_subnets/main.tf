resource "azurerm_subnet" "subnet" {
  resource_group_name  = var.resource_group_name
  name                 = var.name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_network_security_group" "nsg" {
  count               = length(var.nsg_rules) > 0 ? 1 : 0
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "rules" {
  count                      = length(var.nsg_rules)
  name                       = var.nsg_rules[count.index].name
  priority                   = var.nsg_rules[count.index].priority
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = var.nsg_rules[count.index].protocol
  source_port_range          = "*"
  destination_port_range     = tostring(var.nsg_rules[count.index].destination_port_range)
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  resource_group_name        = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[0].name
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  count                     = length(var.nsg_rules) > 0 ? 1 : 0
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
}