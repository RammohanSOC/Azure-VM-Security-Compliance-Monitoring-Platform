resource "azurerm_monitor_action_group" "main" {
  name                = "ag-vm-compliance"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "VMCompliance"

  email_receiver {
    name                    = "CloudAdmin"
    email_address           = var.alert_email
    use_common_alert_schema = true
  }

  tags = local.common_tags
}
