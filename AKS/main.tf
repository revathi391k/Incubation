terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  client_id       = "xxx"
	client_secret   = "XXX"
	tenant_id       = "b41b72d0-4e9f-4c26-8a69-f949f367c91d"
  subscription_id = "a5917f77-047e-4ec0-bbf9-49b052c5ee62"
  features{}
}

data "azurerm_key_vault" "azure_vault" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg
}

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = var.sshkvsecret
  key_vault_id = data.azurerm_key_vault.azure_vault.id
}

data "azurerm_key_vault_secret" "spn_id" {
  name         = var.clientidkvsecret
  key_vault_id = data.azurerm_key_vault.azure_vault.id
}
data "azurerm_key_vault_secret" "spn_secret" {
  name         = var.spnkvsecret
  key_vault_id = data.azurerm_key_vault.azure_vault.id
}

data "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = var.aks_vnet_name
  resource_group_name = var.resource_group
  location            = var.azure_region
  address_space       = var.vnetcidr
} 

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks_subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes       = var.subnetcidr
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = var.azure_region
  resource_group_name = var.resource_group
  dns_prefix          = var.dns_name


  default_node_pool {
    name            = var.agent_pools.name
    node_count      = var.agent_pools.count
    vm_size         = var.agent_pools.vm_size
    os_disk_size_gb = var.agent_pools.os_disk_size_gb
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = data.azurerm_key_vault_secret.ssh_public_key.value
    }
  }

  azure_active_directory_role_based_access_control {
    managed = true
  }

  service_principal {
    client_id     = data.azurerm_key_vault_secret.spn_id.value
    client_secret = data.azurerm_key_vault_secret.spn_secret.value
  }

  tags = {
    Environment = "Demo"
  }
}
