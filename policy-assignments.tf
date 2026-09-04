resource "azurerm_resource_group_policy_assignment" "required_tags" {
  name                 = "require-vm-security-tags"
  resource_group_id    = azurerm_resource_group.main.id
  policy_definition_id = azurerm_policy_definition.required_tags.id

  description = "Require Environment, Owner, CostCenter and Project tags"
}
resource "azurerm_resource_group_policy_assignment" "no_public_ip" {
  name                 = "deny-vm-public-ip"
  resource_group_id    = azurerm_resource_group.main.id
  policy_definition_id = azurerm_policy_definition.no_public_ip.id

  description = "Prevent public IP exposure"
}

