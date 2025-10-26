locals {
  resource_group_name = "thekra-k8s-assn"
  vnet_name           = "vnet"
  location            = "UAE North"

  tags = {
    assignment = "k8s"
  }

  address_space = ["10.0.0.0/16"]

  subnet = {
    db_subnet = {
      address_space = ["10.0.0.0/24"]
    }
    aks_subnet = {
      address_space = ["10.0.2.0/24"]
    }
  }

  sql = {
    db_name        = "ecommerce"
    admin_user     = "sqladmin"
    admin_password = "StrongP@ssw0rd123!"
    db_port        = 1433
  }
}
