terraform {
   backend "azurerm" {  
    resource_group_name  = "alejandro-padilla"
    storage_account_name = "fiac"
    container_name       = "first"
    key                  = "prod.helmm.st.terraform.tfstate"
  }
}

provider "helm" {
    kubernetes {
    config_path = "~/.kube/config"
  }
}

module "helm_release" {
  source         = "git@github.com:alejandromarin7/lktrz-tf-03-helm-module.git?ref=v1.0.21"
  name_helm  = "wordhelm"
  name_chart = "wordpress"
  create_namespace = "true"

  set = [
    {
      name  = "wordpressBlogName"
      value = "helmterraform"
    },
    {
      name  = "wordpressEmail"
      value = "admin@admin.com"
    }    
  ]
}
