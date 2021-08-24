#####################################
############# PIPELINE ##############
#####################################

resource "heroku_pipeline" "main_pipeline" {
  name = var.app_name
}
