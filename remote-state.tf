#####################################
########### REMOTE-STATE ############
#####################################

# We need to define a remote state in S3 bucket in order to save the state

terraform{
    backend "s3"{}
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
        heroku = {
            source = "heroku/heroku"
            version = "~> 4.6"
        }
    }
}