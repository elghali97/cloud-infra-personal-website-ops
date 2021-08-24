#####################################
############# VARIABLES #############
#####################################

# General settings
variable "app_name" {
    type = string
    default = "forumorg"
}

variable "app_url" {
    type = string
    default = "www.forumorg.org"
}

variable "heroku_app_region" {
    type = string
    default = "eu"
}