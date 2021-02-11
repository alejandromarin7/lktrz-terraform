terraform {
  backend "gcs" {
    bucket  = "terraformiacc"
    prefix  = "terraform/statesa"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

module "service_account_nonprod" {
  source = "git@github.com:alejandromarin7/lktrz-tf-01-sa-module.git?ref=v1.0.0"

  environment = "prod"
}