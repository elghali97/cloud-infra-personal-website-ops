#####################################
################ APPS ###############
#####################################

############ GENERATE APPS ##########
resource "heroku_app" "app" {
  for_each = local.env
  name     = each.value
  region   = var.heroku_app_region

  config_vars = {
    APP_ENVIRONMENT = each.key
  }
}

resource "heroku_pipeline_coupling" "coupling" {
  for_each = heroku_app.app
  app      = each.value.id
  pipeline = heroku_pipeline.main_pipeline.id
  stage    = local.env_mapping[each.value.config_vars["APP_ENVIRONMENT"]]
}