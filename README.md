# Terraform

## What is terraform
Terraform provides a common configuration to launch infrastructure — from physical and virtual servers to email and DNS providers. Once launched, Terraform safely and efficiently changes infrastructure as the configuration is evolved.

Simple file based configuration gives you a single view of your entire infrastructure.

https://www.terraform.io/

## Our infrastructure
This terraform repository is used to have a complete and accurate description of our organization's infrastructure, stored in a repository where it can be safely retrieved and updated at will.

The current configuration aims to generate:
- a [Heroku pipeline](https://devcenter.heroku.com/articles/pipelines) with 2 environments ([staging]() & [production]()), with [Review Apps]() available and the following add-ons enabled:
    * [Papertrail](https://papertrailapp.com/) for cloud-hosted log management
- 2 [CloudFront CDN](https://aws.amazon.com/fr/cloudfront/) (staging & environment) used to offload static file hosting to a distributed storage system.
