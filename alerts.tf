resource "azurerm_monitor_metric_alert" "high_cpu" {
  name                = "alert-vm-high-cpu"
  resource_group_name = azurerm_resource_group.main.name

  scopes = [
    azurerm_linux_virtual_machine.vm.id
  ]

  description = "Alert when VM CPU exceeds 80 percent"

  severity    = 2
  frequency   = "PT5M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = local.common_tags
}
