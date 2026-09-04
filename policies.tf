resource "azurerm_policy_definition" "required_tags" {
  name         = "require-vm-security-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require security tags on virtual machines"

  policy_rule = <<POLICY
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Compute/virtualMachines"
      },
      {
        "anyOf": [
          {
            "field": "tags['Environment']",
            "exists": "false"
          },
          {
            "field": "tags['Owner']",
            "exists": "false"
          },
          {
            "field": "tags['CostCenter']",
            "exists": "false"
          },
          {
            "field": "tags['Project']",
            "exists": "false"
          }
        ]
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
POLICY

  metadata = <<METADATA
{
  "category": "Security"
}
METADATA
}
resource "azurerm_policy_definition" "no_public_ip" {
  name         = "deny-public-ip-vm"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deny public IP association to virtual machines"

  policy_rule = <<POLICY
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Network/networkInterfaces"
      },
      {
        "field": "Microsoft.Network/networkInterfaces/ipconfigurations[*].publicIpAddress.id",
        "exists": "true"
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
POLICY

  metadata = <<METADATA
{
  "category": "Security"
}
METADATA
}
