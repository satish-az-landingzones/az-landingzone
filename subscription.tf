module "lz_vending" {
  source  = "Azure/lz-vending/azurerm"
  version = "4.0.2" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  # Set the default location for resources
  location = var.default_location

  for_each = var.subscriptions
  # subscription variables
  subscription_alias_enabled = true
  subscription_alias_name    = each.subscription_alias_name
  subscription_display_name  = each.subscription_display_name
  subscription_billing_scope = var.subscription_billing_scope
  subscription_workload      = each.subscription_workload

  subscription_management_group_id                  = each.subscription_management_group_id
  subscription_management_group_association_enabled = true
}