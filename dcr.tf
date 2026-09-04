resource "azurerm_monitor_data_collection_rule" "linux" {
  name                = "dcr-vm-compliance-linux"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  destinations {
    log_analytics {
      name                  = "law-destination"
      workspace_resource_id = azurerm_log_analytics_workspace.main.id
    }
  }

  data_flow {
    streams      = ["Microsoft-Perf"]
    destinations = ["law-destination"]
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["law-destination"]
  }

  data_sources {
    performance_counter {
      name                          = "linux-performance"
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60

      counter_specifiers = [
        "\\Processor(_Total)\\% Processor Time",
        "\\Memory\\Available MBytes",
        "\\LogicalDisk(_Total)\\% Free Space"
      ]
    }

    syslog {
      name    = "linux-syslog"
      streams = ["Microsoft-Syslog"]

      facility_names = [
        "auth",
        "authpriv",
        "daemon",
        "syslog"
      ]

      log_levels = [
        "Warning",
        "Error",
        "Critical"
      ]
    }
  }

  tags = local.common_tags
}
resource "azurerm_monitor_data_collection_rule_association" "vm" {
  name                    = "dcr-vm-compliance-association"
  target_resource_id      = azurerm_linux_virtual_machine.vm.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.linux.id

  description = "Associates Linux VM with compliance monitoring DCR"

  depends_on = [
    azurerm_virtual_machine_extension.ama
  ]
}
