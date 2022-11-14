terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }
}

data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}

resource "yandex_compute_instance" "vm" {
  name = "${var.instance_name}"

  resources {
    cores  = 4
    memory = 8
    core_fraction=100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size = 50
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = "${var.nat}"
  }

  scheduling_policy {
    preemptible = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../id_rsa.pub")}"
  }
}