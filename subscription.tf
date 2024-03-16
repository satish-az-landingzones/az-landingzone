module "lz_vending" {
  source  = "Azure/lz-vending/azurerm"
  version = "4.0.2" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  # Set the default location for resources
  location = var.default_location

  # subscription variables
  subscription_alias_enabled = true
  subscription_alias_name    = "app1_Subscription"
  subscription_display_name  = "App1 Subscription"
  subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/c3e4d4fd-a248-5faf-65ad-faca35ed9980:cb1a0f0b-ef62-4e9c-ac1d-6b1159aadeec_2019-05-31/billingProfiles/5MI2-CB77-BG7-PGB/invoiceSections/TPUJ-JTMZ-PJA-PGB"
  subscription_workload      = "Production"

  subscription_management_group_id                  = "app1"
  subscription_management_group_association_enabled = true
}