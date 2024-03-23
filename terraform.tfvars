subscriptions = [
  {
    subscription_alias_name          = "hub_subscription_01"
    subscription_display_name        = "hub_subscription_01"
    subscription_workload            = "DevTest"
    subscription_management_group_id = "es-connectivity"
    subscription_billing_scope       = "/providers/Microsoft.Billing/billingAccounts/c3e4d4fd-a248-5faf-65ad-faca35ed9980:cb1a0f0b-ef62-4e9c-ac1d-6b1159aadeec_2019-05-31/billingProfiles/5MI2-CB77-BG7-PGB/invoiceSections/TPUJ-JTMZ-PJA-PGB"
  },
  {
    subscription_alias_name          = "spoke_subscription_01"
    subscription_display_name        = "spoke_subscription_01"
    subscription_workload            = "DevTest"
    subscription_management_group_id = "app1"
    subscription_billing_scope       = "/providers/Microsoft.Billing/billingAccounts/c3e4d4fd-a248-5faf-65ad-faca35ed9980:cb1a0f0b-ef62-4e9c-ac1d-6b1159aadeec_2019-05-31/billingProfiles/5MI2-CB77-BG7-PGB/invoiceSections/TPUJ-JTMZ-PJA-PGB"
  }
]

spoke_subscription = "caa318eb-1d1b-4015-b096-195726de1378"
hub_subscription = "56b22e13-1830-4b38-b369-319d290c3237"