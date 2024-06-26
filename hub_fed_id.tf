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
  subject        = "repo:satish-az-landingzones/satish-az-lz-hub:environment:Production"
}

#Create Service Principal
resource "azuread_service_principal" "hub" {
  client_id = azuread_application_registration.hub.client_id
}

output "hub_client_id" {
  value = azuread_application_registration.hub.client_id
}
