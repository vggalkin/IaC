output "internal_ip_address_vm" {
  value = yandex_compute_instance.vm.network_interface.0.ip_address
}

output "subnet_id_vm" {
  value = yandex_compute_instance.vm.network_interface.0.subnet_id
}

output "external_ip_address_vm" {
  value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}