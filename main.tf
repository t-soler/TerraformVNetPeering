# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
  
  cloud {
    organization = "COMPANY"
    workspaces {
      name = "WORKSPACE"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create resource group A
resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location
  
  tags = {
    Environment = "Infrastructure"
	  Type = "Network"
	}
}

# Create virtual network A
resource "azurerm_virtual_network" "vnetA" {
  name                = var.vnetFirstName
  address_space       = [var.vnetFirstAddressPrefix]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet vnet A
resource "azurerm_subnet" "vnetAsubnet" {
  address_prefixes      = [var.vnetFirstSubnetDefaultAddressPrefix]
  name                  = var.vnetFirstSubnetDefaultName
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnetA.name
}

# Create virtual network B
resource "azurerm_virtual_network" "vnetB" {
  name                = var.vnetSecondName
  address_space       = [var.vnetSecondAddressPrefix]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet vnet B
resource "azurerm_subnet" "vnetBsubnet" {
  address_prefixes      = [var.vnetSecondSubnetDefaultAddressPrefix]
  name                  = var.vnetSecondSubnetDefaultName
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnetB.name
}

# Create vnet peering between A and B
resource "azurerm_virtual_network_peering" "vnetAToB" {
  name                         = "${var.vnetFirstName}-${var.vnetSecondName}"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnetA.name
  remote_virtual_network_id    = azurerm_virtual_network.vnetB.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

# Create vnet peering between B and A
resource "azurerm_virtual_network_peering" "vnetBToA" {
  name                         = "${var.vnetSecondName}-${var.vnetFirstName}"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnetB.name
  remote_virtual_network_id    = azurerm_virtual_network.vnetA.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}