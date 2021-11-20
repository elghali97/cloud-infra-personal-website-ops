#####################################
################ APPS ###############
#####################################

######## GENERATE REVIEW APP ########

resource "heroku_review_app_config" "review_app_config" {
  pipeline_id = heroku_pipeline.main_pipeline.id
  org_repo    = "${local.tags["ebench:git-user"]}/${local.tags["ebench:git-repo"]}"
  base_name   = var.project_name

  automatic_review_apps = true
  destroy_stale_apps    = true

  stale_days = 5

  deploy_target {
    id   = var.heroku_app_region
    type = "region"
  }
}

############ GENERATE APPS ##########
resource "heroku_app" "app" {
  for_each = local.env
  name     = each.value
  region   = var.heroku_app_region

  config_vars = {
    APP_ENVIRONMENT = each.key
  }
}

resource "heroku_build" "app_build" {
  for_each   = heroku_app.app
  app        = each.value.id
  buildpacks = ["heroku/nodejs", "https://github.com/heroku/heroku-buildpack-static"]

  source {
    # This app uses a community buildpack, set it in `buildpacks` above.
    url     = "https://github.com/heroku/heroku-buildpack-static/archive/refs/tags/v7.tar.gz"
    version = "v7"
  }
}

resource "heroku_pipeline_coupling" "coupling" {
  for_each = heroku_app.app
  app      = each.value.id
  pipeline = heroku_pipeline.main_pipeline.id
  stage    = local.env_mapping[each.value.config_vars["APP_ENVIRONMENT"]]
}