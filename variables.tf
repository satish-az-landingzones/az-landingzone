# Use variables to customize the deployment

variable "root_id" {
  type    = string
  default = "es"
}

variable "root_name" {
  type    = string
  default = "Myle-Solutions"
}

variable "default_location" {
  type    = string
  default = "eastus"
}


variable "subscriptions" {
  type = list(object({
    subscription_alias_name   = string
    subscription_display_name = string
    subscription_workload     = string
    subscription_management_group_id       = string
    subscription_billing_scope = string
  }))
}