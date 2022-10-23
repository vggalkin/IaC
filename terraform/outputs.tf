
#output "external_ip_address_front-balancer" {
#  description = "Listener info"
#  value = yandex_lb_network_load_balancer.front-balancer.listener.*.external_address_spec
#}