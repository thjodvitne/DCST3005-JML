locals {
  # Navnekonvensjon: <ressurstype>-<owner>-<workload>-<environment>[-<del>]
  base_name = "${var.owner}-${var.workload}-${var.environment}"

  names = {
    resource_group = "rg-${local.base_name}"
    vnet           = "vnet-${local.base_name}"
    subnet_prefix  = "snet-${local.base_name}"
    nsg_prefix     = "nsg-${local.base_name}"
  }

  # Hvert miljø får sitt eget adresseområde; resten er felles logikk.
  address_spaces = {
    dev  = "10.10.0.0/16"
    test = "10.20.0.0/16"
    prod = "10.30.0.0/16"
  }
  address_space = local.address_spaces[var.environment]

  subnet_names = ["web", "app", "data"]
  subnets = {
    for idx, name in local.subnet_names :
    name => { address_prefixes = [cidrsubnet(local.address_space, 8, idx)] }
  }

  tags = {
    owner       = var.owner
    workload    = var.workload
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_resource_group" "this" {
  name     = local.names.resource_group
  location = var.location
  tags     = local.tags
}

module "network" {
  source = "../../modules/network"

  name                = local.names.vnet
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [local.address_space]
  subnets             = local.subnets
  subnet_name_prefix  = local.names.subnet_prefix
  nsg_name_prefix     = local.names.nsg_prefix
  tags                = local.tags
}
