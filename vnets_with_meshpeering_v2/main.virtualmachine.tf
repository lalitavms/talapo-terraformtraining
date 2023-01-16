module "virtual_machine" {
  source          = "./module/virtual_machine"
  virtual_machine = local.virtual_machine
  #virtual_networks = module.virtual_network
  depends_on = [module.virtual_network]
}

output "virtual_machine_out" {
  value = module.virtual_machine
}