variable "owner" {
  description = "Ditt kortnavn. Brukes i alle ressursnavn fordi tenanten er delt."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{2,8}$", var.owner))
    error_message = "owner må være 2-8 små bokstaver/tall."
  }
}

variable "workload" {
  description = "Kort navn på arbeidslasten, brukes i ressursnavn."
  type        = string
  default     = "oblig"
}

variable "environment" {
  description = "Miljønavn. Styrer navn, adresseplan og state-key."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment må være dev, test eller prod."
  }
}

variable "location" {
  description = "Azure-region."
  type        = string
  default     = "norwayeast"
}
