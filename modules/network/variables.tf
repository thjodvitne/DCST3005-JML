variable "name" {
  description = "Navn på virtual network."
  type        = string
}

variable "location" {
  description = "Azure-region ressursene opprettes i."
  type        = string
}

variable "resource_group_name" {
  description = "Navn på resource group nettverket opprettes i."
  type        = string
}

variable "address_space" {
  description = "Adresseområder (CIDR) for virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Map av subnett. Nøkkelen er et kort navn (f.eks. web), verdien har address_prefixes."
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "subnet_name_prefix" {
  description = "Prefiks for subnettnavn. Fullt navn blir <prefiks>-<nøkkel>."
  type        = string
}

variable "nsg_name_prefix" {
  description = "Prefiks for NSG-navn. Fullt navn blir <prefiks>-<nøkkel>."
  type        = string
}

variable "tags" {
  description = "Tags som settes på alle ressurser som støtter det."
  type        = map(string)
  default     = {}
}
