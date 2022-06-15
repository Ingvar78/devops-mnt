output "internal_ip" {
  value = { for k, v in yandex_compute_instance.vm : k => v.network_interface[*].ip_address }
}

output "nat_ip" {
  value = { for k, v in yandex_compute_instance.vm : k => v.network_interface[*].nat_ip_address }
}


# output "internal_ip" {
#   value = toset([
#     for instance in yandex_compute_instance.vm : instance.network_interface.0.ip_address
#   ])
# }

# output "nat_ip" {
#   value = toset([
#     for instance in yandex_compute_instance.vm : instance.network_interface.0.nat_ip_address
#   ])
# }

# output "external_name" {
#   value = toset([
#     for instance in yandex_compute_instance.vm : instance.name
#   ])
# }