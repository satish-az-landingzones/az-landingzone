# module "lz_vending" {
#   source  = "Azure/lz-vending/azurerm"
#   version = "4.0.2" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

#   # Set the default location for resources
#   location = var.default_location

#   for_each = { for sub in var.subscriptions : sub.subscription_alias_name => sub }
#   # subscription variables
#   subscription_alias_enabled = true
#   subscription_alias_name    = each.value.subscription_alias_name
#   subscription_display_name  = each.value.subscription_display_name
#   subscription_billing_scope = each.value.subscription_billing_scope
#   subscription_workload      = each.value.subscription_workload

#   subscription_management_group_id                  = each.value.subscription_management_group_id
#   subscription_management_group_association_enabled = true
# }

###################################################################################################################

# Create an app registration
resource "azuread_application_registration" "hub" {
  display_name = "GitHub Terraform - Hub Creation"
}


resource "azuread_application_federated_identity_credential" "hub" {
  application_id = azuread_application_registration.hub.id
  display_name   = "GitHub Terraform - Hub FedID"
  description    = "GitHub Deployments for Hub using Terraform"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:satish-az-landingzones/az-landingzone:environment:Dev"
}

# Assign federation credential to GitHub organization and project
# You'll need to use Azure CLI or PowerShell to perform this step as Terraform doesn't directly support GitHub organization and project assignments.


data "azurerm_management_group" "hub" {
  name = "es-connectivity"
}

data "azurerm_billing_mca_account_scope" "hub" {
  billing_account_name = "c3e4d4fd-a248-5faf-65ad-faca35ed9980:cb1a0f0b-ef62-4e9c-ac1d-6b1159aadeec_2019-05-31"
  billing_profile_name = "5MI2-CB77-BG7-PGB"
  invoice_section_name = "TPUJ-JTMZ-PJA-PGB"
}

resource "azurerm_subscription" "hub" {
  subscription_name = "Hub Subscription 2"
  billing_scope_id  = data.azurerm_billing_mca_account_scope.hub.id
}


# Grant Contributor access at subscription level
resource "azurerm_role_assignment" "contributor_assignment" {
  scope                = "/subscriptions/${resource.azurerm_subscription.hub.subscription_id}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = resource.azurerm_application.github_subscription_creation.object_id
}

output "client_id" {
  value = azuread_application_registration.hub.client_id
}

output "subscription_id" {
  value = resource.azurerm_subscription.hub.subscription_id # Replace with the subscription ID
}

output "tenant_id" {
  value = data.azurerm_client_config.core.tenant_id
}

