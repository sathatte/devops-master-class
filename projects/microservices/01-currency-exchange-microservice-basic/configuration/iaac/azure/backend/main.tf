provider "azurerm" {
  //version = "~>2.0.0"
  features {}
  client_id       = var.client_id     # ENVIRONMENT VARIABLE
  client_secret   = var.client_secret # ENVIRONMENT VARIABLE
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group}_${var.environment}"
  location = var.location
  tags = {
    environment = var.environment
    yor_trace   = "7404165d-e421-4a1a-b6e4-f81d0596ba08"
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.environment}terraformstatestorage"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
    yor_trace   = "64a54fa4-d5f8-4431-9e40-5677c9e24ffa"
  }
}

resource "azurerm_storage_container" "storage_container" {
  name                 = "${var.environment}terraformstatestoragecontainer"
  storage_account_name = azurerm_storage_account.storage_account.name
}