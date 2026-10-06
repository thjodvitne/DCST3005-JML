data "terraform_remote_state" "network" {
  backend = "azurerm"

  config = {
    storage_account_name = var.state_storage_account
    container_name       = var.state_container
    key                  = "network-${var.environment}.tfstate"
    use_azuread_auth     = true
  }
}

locals {
  base_name = "${var.owner}-${var.workload}-${var.environment}"

  names = {
    nic = "nic-${local.base_name}-app"
  }

  # Verdier hentet fra network-stacken
  network = data.terraform_remote_state.network.outputs

  tags = {
    owner       = var.owner
    workload    = var.workload
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Gratis ressurs som er avhengig av nettverket. Bytt gjerne ut med en VM senere.
resource "azurerm_network_interface" "app" {
  name                = local.names.nic
  location            = local.network.location
  resource_group_name = local.network.resource_group_name
  tags                = local.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = local.network.subnet_ids["app"]
    private_ip_address_allocation = "Dynamic"
  }
}
