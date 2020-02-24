variable "github_token" {
  description = "The GitHub Token to be used for the CodePipeline"
  type        = "string"
}

variable "account_id" {
  description = "id of the active account"
  type        = "string"
}

variable "region" {
  description = "region to deploy to"
  type        = "string"
}

variable "repository_url" {
  description = "Please provide repository URL"
  type        = "string"
}


provider "aws" {
  region  = "${var.region}"
  version = "2.7"
}
