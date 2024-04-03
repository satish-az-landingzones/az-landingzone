# Grant Contributor access at subscription level
resource "azurerm_role_assignment" "hub_to_hub" {
  scope                = "/subscriptions/${var.hub_subscription}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.hub.object_id
}

resource "azurerm_role_assignment" "hub_to_spoke" {
  scope                = "/subscriptions/${var.spoke_subscription}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.hub.object_id
}

resource "azurerm_role_assignment" "spoke_to_hub" {
  scope                = "/subscriptions/${var.hub_subscription}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.spoke.object_id
}

resource "azurerm_role_assignment" "spoke_to_spoke" {
  scope                = "/subscriptions/${var.spoke_subscription}" # Replace with the subscription ID
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.spoke.object_id
}
