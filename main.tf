terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id = "7840d2bf-c2bd-4e73-be23-f8ce0e1d040c"
  client_secret = "FRo8Q~PMkau3DtIUZJkFvdE.sGv12oa755.pQbTb"
  tenant_id = "1a7535f7-cf5d-4503-83b8-6db5338b59a1"
  subscription_id = "292c7310-8d4b-40aa-a9a1-6ea06d5e2c45"
}

# Defined backend resouce as Azure Storage account to store the terraform state file
# To manage the state of infrastructure centrally

terraform {
  backend "azurerm" {
    resource_group_name   = local.resource_group_name
    storage_account_name  = "storgeaccount23091998343"
    container_name        = "terraform-state"
    key                   = "terraform.tfstate"
  }
}

locals {
  resource_group_name="AZ-305-RG"
  location="North Europe"

  virtual_network={
    name="App-VNET"
    address_space="10.0.0.0/16"
  }

  subnet = [
    {
      name="SubnetA"
      address_prefix="10.0.1.0/24"
    },
    {
      name="SubnetB"
      address_prefix="10.0.2.0/24"
    }
  ]
}

#creation of Resource Group
resource "azurerm_resource_group" "AZ-305-RG" {
  name     = local.resource_group_name
  location = local.location
}

# Create Virtual Network
resource "azurerm_virtual_network" "App-VNET" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = ["10.0.0.0/16"]
  depends_on = [ azurerm_resource_group.AZ-305-RG ]

}

