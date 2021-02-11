data "terraform_remote_state" "service_account" {
  backend = "gcs"

  config = {
    bucket  = "terraformiacc"
    prefix  = "terraform/statesa"
  }
}

provider "kubernetes" {
  host  = "https://kubernetes.docker.internal:6443"
  token = data.terraform_remote_state.service_account.outputs.token
  insecure = true
}

module "deployment_nonprod" {
  source = "git@github.com:alejandromarin7/lktrz-tf-02-deploy-module.git?ref=v1.0.0"

  message = "Hello Krollege From PROD!"
  environ = "prod"
}