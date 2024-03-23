## This will create app_registration for spoke, add feration identity, creates service principal and assigns contributor role


# Create an app registration
resource "azuread_application_registration" "spoke" {
  display_name = "GitHub Terraform - Spoke Creation"
}

resource "azuread_application_federated_identity_credential" "spoke" {
  application_id = azuread_application_registration.spoke.id
  display_name   = "GH-TF-Spoke-FedID"
  description    = "GitHub Deployments for Spoke using Terraform"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:satish-az-landingzones/az-landingzone:environment:Dev"
}

#Create Service Principal
resource "azuread_service_principal" "spoke" {
  client_id = azuread_application_registration.spoke.client_id
}

# Grant Contributor access at subscription level
resource "azurerm_role_assignment" "spoke" {
  scope                = "/subscriptions/${var.spoke_subscription}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.spoke.object_id
}

output "spoke_client_id" {
  value = azuread_application_registration.spoke.client_id
}
