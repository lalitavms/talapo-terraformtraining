variable "env_prefix" {
  type    = string
  default = "tftest"
}

variable "location" {
  type    = string
  default = "eastasia"
}

variable "vm_localadmin_password" {
  description = "Initial password for vm localadmin"
  type        = string
  sensitive   = true
}

