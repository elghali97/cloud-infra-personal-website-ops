#####################################
########### REMOTE-STATE ############
#####################################

# We need to define a remote state in S3 bucket in order to save the state

terraform {
  backend "remote" {}
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.6"
    }
  }
}