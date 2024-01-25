data "local_file" "arm_api_connection" {
  filename = "${path.module}/api-arm-connection.json"
}
data "local_file" "slack_api_connection" {
  filename = "${path.module}/api-connection-slack.json"
}
data "local_file" "slack_access_policy" {
  filename = "${path.module}/slack_access_policy.json"
}
data "local_file" "arm_access_policy" {
  filename = "${path.module}/arm_access_policy.json"
}
data "azurerm_subscription" "current" {
}
