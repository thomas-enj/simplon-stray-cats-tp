




## APPS 

module "mon_apm" {
  source = "./modules/app_insight"
}

module "network" {
  source = "./modules/network"

  owner    = var.owner
  location = var.owner
}


