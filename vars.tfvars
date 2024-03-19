subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/c3e4d4fd-a248-5faf-65ad-faca35ed9980:cb1a0f0b-ef62-4e9c-ac1d-6b1159aadeec_2019-05-31/billingProfiles/5MI2-CB77-BG7-PGB/invoiceSections/TPUJ-JTMZ-PJA-PGB"

subscriptions = [
  {
    subscription_alias_name   = "hub_subscription"
    subscription_display_name = "Hub Subscription"
    subscription_workload     = "Production"
    management_group_id = "es-connectivity"
  },
  {
    subscription_alias_name   = "spoke_subscription"
    subscription_display_name = "Spoke Subscription"
    subscription_workload     = "Production"
    management_group_id = "app1"
  }
]