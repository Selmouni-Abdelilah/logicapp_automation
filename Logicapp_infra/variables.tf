variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "la-tfdeploy-rg"
}

variable "location" {
  description = "Azure region for resources"
  default     = "East US"
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  default     = "logicapptestsa"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  default     = "logicapp-test-service-plan"
}

variable "logic_app_name" {
  description = "Name of the Logic App"
  default     = "logicapp-test-huidong"
}

variable "app_settings" {
  description = "App settings for the Logic App"
  type        = map(string)
  default = {
    "FUNCTIONS_WORKER_RUNTIME"               = "node"
    "WEBSITE_NODE_DEFAULT_VERSION"           = "~16"
  }
}
