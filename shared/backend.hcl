# Eneste sted storage account-navnet står. Fyll inn dine verdier.
# "key" settes per stack og miljø via -backend-config="key=..."
resource_group_name  = "rg-jml-tfstate"
storage_account_name = "stjmltfstate16050"
container_name       = "tfstate"
use_azuread_auth     = true

