module "lz_vending" {
  source  = "Azure/lz-vending/azurerm"
  version = "4.0.2" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  # Set the default location for resources
  location = var.default_location

  for_each = { for sub in var.subscriptions : sub.subscription_alias_name => sub }
  # subscription variables
  subscription_alias_enabled = true
  subscription_alias_name    = each.value.subscription_alias_name
  subscription_display_name  = each.value.subscription_display_name
  subscription_billing_scope = each.value.subscription_billing_scope
  subscription_workload      = each.value.subscription_workload

  subscription_management_group_id                  = each.value.subscription_management_group_id
  subscription_management_group_association_enabled = true
}