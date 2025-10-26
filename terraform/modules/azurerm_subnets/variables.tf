variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "name" {
  description = "Subnet name"
}

variable "vnet_name" {
  description = "Name of the virtual network"
}

variable "address_prefixes" {
  description = "Address prefixes for the subnet"
  default     = []
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default     = []
  description = "NSG rules"
}


