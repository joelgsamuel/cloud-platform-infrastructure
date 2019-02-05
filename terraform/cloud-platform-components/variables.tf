variable "pagerduty_config" {
  description = "Add PagerDuty key to allow integration with a PD service."
}

variable "slack_config" {
  description = "Add Slack webhook API URL and channel for integration with slack."
}

variable "github_client_id" {
  description = "ClientID of GitHub Oauth application"
}

variable "github_client_secret" {
  description = "Client secret of GitHub Oauth application"
}

variable "github_secret_key" {
  description = "Client secret of GitHub Oauth application"
}
