## This will create app_registration for hub, add feration identity, creates service principal and assigns contributor role

# Create an app registration
resource "azuread_application_registration" "hub" {
  display_name = "GitHub Terraform - Hub Creation"
}

resource "azuread_application_federated_identity_credential" "hub" {
  application_id = azuread_application_registration.hub.id
  display_name   = "GH-TF-Hub-FedID"
  description    = "GitHub Deployments for Hub using Terraform"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:satish-az-landingzones/az-landingzone:environment:Dev"
}

#Create Service Principal
resource "azuread_service_principal" "hub" {
  client_id = azuread_application_registration.hub.client_id
}

# Assign federation credential to GitHub organization and project
# You'll need to use Azure CLI or PowerShell to perform this step as Terraform doesn't directly support GitHub organization and project assignments.

data "azurerm_management_group" "hub" {
  name = "app1"
}

# Grant Contributor access at subscription level
resource "azurerm_role_assignment" "hub" {
  scope                = "/subscriptions/${var.hub_subscription}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.hub.object_id
}

output "hub_client_id" {
  value = azuread_application_registration.hub.client_id
}
