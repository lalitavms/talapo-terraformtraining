variable "env_prefix" {
  type    = string
  default = "tftest"
}

variable "location" {
  type    = string
  default = "eastasia"
}

variable "virtual_networks" {
  type = map(any)
  default = {
    virtual_network_aus = {
      vnetname      = "vnet-aus"
      location      = "australiaeast"
      address_space = ["192.168.1.0/24"]
      subnets = {
        subnet01 = {
          subnetname    = "subnet01"
          address_space = ["192.168.1.0/26"]
        }
        subnet02 = {
          subnetname    = "subnet02"
          address_space = ["192.168.1.64/26"]
        }
      }
      peerings = {
        virtual_network_asia = {
          peeringname                  = "aus-to-asia"
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
          allow_gateway_transit        = true
          #use_remote_gateways = true  
        }
        virtual_network_us = {
          peeringname                  = "aus-to-us"
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
          #allow_gateway_transit = true  
          #use_remote_gateways = true 
        }
      }
    }
    virtual_network_asia = {
      vnetname      = "vnet-asia"
      location      = "eastasia"
      address_space = ["192.168.2.0/24"]
      subnets = {
        subnet01 = {
          subnetname    = "subnet01"
          address_space = ["192.168.2.0/26"]
        }
        subnet02 = {
          subnetname    = "subnet02"
          address_space = ["192.168.2.64/26"]
        }
      }
      peerings = {
        virtual_network_aus = {
          peeringname = "asia-to-aus"
        }
        virtual_network_us = {
          peeringname = "asia-to-us"
        }
      }
    }
    virtual_network_us = {
      vnetname      = "vnet-us"
      location      = "eastus"
      address_space = ["192.168.3.0/24"]
      subnets = {
        subnet01 = {
          subnetname    = "subnet01"
          address_space = ["192.168.3.0/26"]
        }
        subnet02 = {
          subnetname    = "subnet02"
          address_space = ["192.168.3.64/26"]
        }
      }
      peerings = {
        virtual_network_aus = {
          peeringname = "us-to-aus"
        }
        virtual_network_asia = {
          peeringname = "us-to-asia"
        }
      }
    }
  }
}