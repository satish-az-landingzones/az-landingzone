# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  # cloud {
  #   organization = "tf-az-landingzone"

  #   workspaces {
  #     name = "tf-workspace-az-landingzone"
  #   }
  # }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.74.0"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id = "4af0ab13-4255-4a00-9f28-95ec4d87ed1a"
}

# Get the current client configuration from the AzureRM provider.
# This is used to populate the root_parent_id variable with the
# current Tenant ID used as the ID for the "Tenant Root Group"
# management group.

data "azurerm_client_config" "core" {}



# Declare the Azure landing zones Terraform module
# and provide a base configuration.

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "5.1.0" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  default_location = var.default_location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name
  library_path   = "${path.root}/lib"

  custom_landing_zones = {
    "app1" = {
      display_name               = "app1"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "customer_online"
        parameters     = {}
        access_control = {}
      }
    }
  }
}

# data "azurerm_management_group" "source" {
#   name = "app1"
# }

# data "azurerm_management_group" "target" {
#   name = "Platform"
# }

# output "subscription" {
#   value = data.azurerm_management_group.source.all_subscription_ids
# }

# output "subscription" {
#   value = data.azurerm_management_group.target.all_subscription_ids
# }