resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storageacc" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "svcplan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "elastic"
  sku {
    tier = "WorkflowStandard"
    size = "WS1"
  }
}

resource "azurerm_logic_app_standard" "logicapp" {
  name                       = var.logic_app_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.svcplan.id
  storage_account_name       = azurerm_storage_account.storageacc.name
  storage_account_access_key = azurerm_storage_account.storageacc.primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"              = "node"
    "FUNCTIONS_EXTENSION_VERSION"              = "~4"
    "WEBSITE_NODE_DEFAULT_VERSION"          = "~12"
    "subscription"                          = data.azurerm_subscription.current.subscription_id
    "resource_group"                        = azurerm_resource_group.rg.name
    "arm_connection_runtime_url"            = jsondecode(azurerm_resource_group_template_deployment.arm_api_connection.output_content).connectionRuntimeUrl.value
    "slack_connection_runtime_url"          = jsondecode(azurerm_resource_group_template_deployment.slack_api_connection.output_content).connectionRuntimeUrl.value
  }
  site_config {
    ftps_state             = "Disabled"
    vnet_route_all_enabled = true
  }
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_resource_group_template_deployment" "arm_api_connection" {
  name                = "arm-api-connection"
  resource_group_name = azurerm_resource_group.rg.name
  template_content = data.local_file.arm_api_connection.content
  parameters_content = jsonencode({
    "subscription" = {
      value = data.azurerm_subscription.current.subscription_id 
    }
  })
  deployment_mode = "Incremental"
}
resource "azurerm_resource_group_template_deployment" "slack_api_connection" {
  name                = "slack-api-connection"
  resource_group_name = azurerm_resource_group.rg.name
  template_content = data.local_file.slack_api_connection.content
  parameters_content = jsonencode({
    "subscription" = {
      value = data.azurerm_subscription.current.subscription_id 
    }
  })
  deployment_mode = "Incremental"
}
resource "azurerm_resource_group_template_deployment" "slack_api_connection_access_policy" {
  name                = "slack-api-connection-access-policy"
  resource_group_name = azurerm_resource_group.rg.name

  template_content = data.local_file.slack_access_policy.content

  parameters_content = jsonencode({
    "servicePrincipalId" = {
      value = azurerm_logic_app_standard.logicapp.identity.0.principal_id
    },
    "servicePrincipalTenantId" = {
      value = azurerm_logic_app_standard.logicapp.identity.0.tenant_id
    }
  })
  deployment_mode = "Incremental"
}

resource "azurerm_resource_group_template_deployment" "arm_api_connection_access_policy" {
  name                = "arm-api-connection-access-policy"
  resource_group_name = azurerm_resource_group.rg.name
  template_content = data.local_file.arm_access_policy.content
  parameters_content = jsonencode({
    "servicePrincipalId" = {
      value = azurerm_logic_app_standard.logicapp.identity.0.principal_id
    },
    "servicePrincipalTenantId" = {
      value = azurerm_logic_app_standard.logicapp.identity.0.tenant_id
    }
  })
  deployment_mode = "Incremental"
}
