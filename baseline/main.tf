provider "azurerm" {
  features {}
}

provider "random" {
}

provider "local" {
}

data "azurerm_subscription" "current" {
}


resource "azurerm_resource_group" "main" {
  name = var.rgname
  location = var.location

resource "azurerm_storage_account" "baseline_storage" {
  name = var.saname
  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_resource_group.main.location
  account_tier              = "Standard"
  account_replication_type  = "ZRS"
  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "tf_states" {
  name                  = "tfstates"
  storage_account_name  = azurerm_storage_account.baseline_storage.name
  container_access_type = "private"
}