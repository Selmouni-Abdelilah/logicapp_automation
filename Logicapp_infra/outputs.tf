output "resourcegrpname"{
    value = azurerm_resource_group.rg.name
}
output "logicappname" {
    value = azurerm_logic_app_standard.logicapp.name
}