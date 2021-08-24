#####################################
############# VARIABLES #############
#####################################

# General settings
variable "app_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "app_url" {
  type = string
}

variable "heroku_app_region" {
  type = string
}

variable "environments" {
  type        = list(string)
  description = "Pipeline configuration to define each environments"
}

locals {
  tags = {
    "ebench:git-user" = "elghali97",
    "ebench:git-repo" = var.project_name,
    "ebench:project"  = var.project_name,
    "ebench:app"      = var.app_name,
    "ebench:region"   = var.heroku_app_region
  }

  env = { for elem in var.environments : elem => "${var.app_name}-${elem}" }
  env_mapping = {
    dta  = "staging",
    prod = "production"
  }
}