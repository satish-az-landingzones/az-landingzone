# Create an app registration
resource "azuread_application_registration" "spoke" {
  display_name = "GitHub Terraform - Spoke Creation"
}

resource "azuread_application_federated_identity_credential" "spoke" {
  application_id = azuread_application_registration.spoke.id
  display_name   = "GitHub Terraform - Spoke FedID"
  description    = "GitHub Deployments for Spoke using Terraform"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:satish-az-landingzones/az-landingzone:environment:Dev"
}

# Assign federation credential to GitHub organization and project
# You'll need to use Azure CLI or PowerShell to perform this step as Terraform doesn't directly support GitHub organization and project assignments.

data "azurerm_management_group" "spoke" {
  name = "app1"
}


# data "azurerm_billing_mca_account_scope" "spoke" {
#   billing_account_name = "c3e4d4fd-a248-5faf-65ad-faca35ed9980:cb1a0f0b-ef62-4e9c-ac1d-6b1159aadeec_2019-05-31"
#   billing_profile_name = "5MI2-CB77-BG7-PGB"
#   invoice_section_name = "TPUJ-JTMZ-PJA-PGB"
# }

# resource "azurerm_subscription" "spoke" {
#   subscription_name = "Spoke Subscription"
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.spoke.id
# }

# Grant Contributor access at subscription level
resource "azurerm_role_assignment" "spoke_contributor_assignment" {
  scope                = "/subscriptions/spoke_subscription_01}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = azuread_application_registration.spoke.object_id
}

output "spoke_client_id" {
  value = azuread_application_registration.spoke.client_id
}

