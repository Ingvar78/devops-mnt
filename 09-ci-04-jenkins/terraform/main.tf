provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone
}

data "yandex_compute_image" "centos" {
  family = "centos-7"
}

locals {
  vm_image_map = data.yandex_compute_image.centos.id
  vm_name      = toset(["jenkins-main", "jenkins-agent"])
}


resource "yandex_compute_instance" "vm" {
  for_each    = local.vm_name
  name        = "${var.vm_prefix}-${each.key}"
  hostname    = "${var.vm_prefix}-${each.value}.local"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 4
  }


  boot_disk {
    initialize_params {
      image_id = local.vm_image_map
      type     = "network-hdd"
      size     = 20
    }
  }


  network_interface {
    subnet_id = yandex_vpc_subnet.vpcsubnet.id
    nat       = true
    ipv6      = false
  }

  # https://cloud.yandex.ru/docs/compute/concepts/vm-metadata

  metadata = {
    #user-data = "${file("../YC/metadata")}"
    user-data = "${file(var.metadata_file)}"
  }



}
