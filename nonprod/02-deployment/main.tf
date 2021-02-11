terraform {
   backend "azurerm" {  
    resource_group_name  = "alejandro-padilla"
    storage_account_name = "fiac"
    container_name       = "first"
    key                  = "prod.st.terraform.tfstate"
  }
}

data "terraform_remote_state" "service_account" {
  backend = "azurerm"

  config = {
    resource_group_name  = "alejandro-padilla"
    storage_account_name = "fiac"
    container_name       = "first"
    key                  = "prod.sa.terraform.tfstate"
  }
}

provider "kubernetes" {
  host  = "https://kubernetes.docker.internal:6443"
  token = data.terraform_remote_state.service_account.outputs.token
  insecure = true
}

module "deployment_nonprod" {
  source = "git@github.com:alejandromarin7/lktrz-tf-02-deploy-module.git?ref=v1.0.0"

  message = "Hello Krollege!"
}