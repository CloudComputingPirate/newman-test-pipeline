provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tstate11724"
    container_name       = "tstate"
    access_key           = "dDOCw6SS1kA+1MZknscQp5pxUVfXo6U3H3m58+9f1VPlwiJ2hGGO3tcuhywiNEx6HGKLK9Otf5Re87E+Yc0oDw=="
  }
}
locals {
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }
}
module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${module.resource_group.resource_group_name}"
  tags             = "${local.tags}"
}