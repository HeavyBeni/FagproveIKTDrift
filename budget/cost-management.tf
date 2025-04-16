resource "azurerm_consumption_budget_subscription" "budget" {
  name            = "ullandtech-budget"
  subscription_id = var.subscription_id
  amount          = 1500
  time_grain      = "Monthly"

  time_period {
    start_date = "2025-04-14"
    end_date   = "2025-05-14"
  }

  notification {
    enabled         = true
    threshold       = 80
    operator        = "EqualTo"
    contact_emails  = ["admin@ullandtech.no"]
  }
}s