terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}