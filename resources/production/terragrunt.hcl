remote_state {
  backend = "gcs"
  config = {
    bucket      = "vechr-iiot-tf-state-prod"
    prefix      = "${path_relative_to_include()}/terraform.tfstate"
    credentials = "/Users/zulfikar4568/Downloads/production-creds.json"
    skip_bucket_creation = true
  }
}

inputs = {
  #################################################### Configure your Project ####################################################
  project_id         = "vechr-iiot-prod"
  region             = "asia-southeast2"
  credentials        = "/Users/zulfikar4568/Downloads/production-creds.json"
  environment        = "prod"
  organization       = "vechr"
  application_code   = "iiot"
  zone               = "asia-southeast2-a"
}