#####################################
################ APPS ###############
#####################################

#### STAGING ########################
resource "heroku_app" "app_staging" {
  name   = "${var.app_name}-staging"
  region = var.heroku_app_region

  config_vars = {
    APP_ENVIRONMENT = "staging"
  }
}

resource "heroku_addon" "papertrail" {
  app  = heroku_app.app_staging.name
  plan = "papertrail:choklad"
}

resource "heroku_pipeline_coupling" "coupling_staging" {
  app      = heroku_app.app_staging.id
  pipeline = heroku_pipeline.main_pipeline.id
  stage    = "staging"
}


#### PROD ############################

resource "heroku_app" "app_prod" {
  name   = "${var.app_name}-prod"
  region = var.heroku_app_region

  config_vars = {
    APP_ENVIRONMENT = "prod"
  }
}

resource "heroku_addon_attachment" "papertrail_attachment" {
  app_id   = heroku_app.app_prod.id
  addon_id = heroku_addon.papertrail.id
  name     = "PAPERTRAIL"
}

resource "heroku_domain" "domain_prod" {
  app      = heroku_app.app_prod.name
  hostname = var.app_url
}

resource "heroku_pipeline_coupling" "coupling_prod" {
  app      = heroku_app.app_prod.id
  pipeline = heroku_pipeline.main_pipeline.id
  stage    = "production"
}
