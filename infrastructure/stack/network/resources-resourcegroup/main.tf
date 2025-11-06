module "avm_res_resources_resourcegroup" {
  source = "git::ssh://git@github.com/Azure/terraform-azurerm-avm-res-resources-resourcegroup.git?ref=0.2.1"

  enable_telemetry = var.enable_telemetry
  tags             = local.tags


  name     = local.name
  location = local.location

  lock             = local.lock
  role_assignments = local.role_assignments
}