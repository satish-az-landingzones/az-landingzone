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
  subscription_name = "Hub Subscription 3"
  billing_scope_id  = data.azurerm_billing_mca_account_scope.hub.id

  timeouts {
    create = "10m" # Timeout for resource creation (default is "5m")
    update = "5m"  # Timeout for resource updates (default is "0", meaning no timeout)
    delete = "15m" # Timeout for resource deletion (default is "5m")
  }
}


# Grant Contributor access at subscription level
resource "azurerm_role_assignment" "hub_contributor_assignment" {
  scope                = "/subscriptions/${resource.azurerm_subscription.hub.subscription_id}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = azuread_application_registration.hub.object_id
}

output "hub_client_id" {
  value = azuread_application_registration.hub.client_id
}

output "hub_subscription_id" {
  value = azurerm_subscription.hub.subscription_id # Replace with the subscription ID
}
