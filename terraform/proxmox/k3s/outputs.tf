output "k3s_vm_ids" {
  value = {
    for name, vm in proxmox_virtual_environment_vm.k3s_nodes :
    name => vm.vm_id
  }
}

output "k3s_vm_names" {
  value = keys(proxmox_virtual_environment_vm.k3s_nodes)
}

output "k3s_ipv4_addresses" {
  value = {
    for name, vm in proxmox_virtual_environment_vm.k3s_nodes :
    name => vm.ipv4_addresses
  }
}
