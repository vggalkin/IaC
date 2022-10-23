
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }
    backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-state-bucket-sf-diploma"
    region     = "ru-central1-a"
    key        = "issue/sf_diploma.tfstate"
    access_key = "<access_key>"
    secret_key = "<secret_key>"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "sf_diploma_network" {
  name = "sf_diploma_network"
}

resource "yandex_vpc_subnet" "sf_diploma_subnet" {
  name           = "sf_diploma_subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.sf_diploma_network.id
  v4_cidr_blocks = ["192.168.13.0/24"]
}


module "vm_1" {
  instance_name		= "k8s-master"
  source                = "./modules/instance"
  instance_family_image = "ubuntu-2004-lts"
  vpc_subnet_id         = yandex_vpc_subnet.sf_diploma_subnet.id
  nat                   = true
}

module "vm_2" {
  instance_name		= "k8s-worker"
  source                = "./modules/instance"
  instance_family_image = "ubuntu-2004-lts"
  vpc_subnet_id         = yandex_vpc_subnet.sf_diploma_subnet.id
  nat                   = true
}

module "vm_3" {
  instance_name		= "srv"
  source                = "./modules/instance"
  instance_family_image = "ubuntu-2004-lts"
  vpc_subnet_id         = yandex_vpc_subnet.sf_diploma_subnet.id
  nat                   = true
}


data "template_file" "ansible_inventory" {
  template = file("./inventory.ini.tpl")
  vars = {
    vm1_internal_ip  = "${module.vm_1.internal_ip_address_vm}"
    vm2_internal_ip  = "${module.vm_2.internal_ip_address_vm}"
    vm3_external_ip  = "${module.vm_3.external_ip_address_vm}"
  }
}

resource "null_resource" "update_inventory" {
 triggers = {
    template = data.template_file.ansible_inventory.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.ansible_inventory.rendered}' > ../inventory.ini"
  }
}

data "template_file" "k8s_inventory" {
  template = file("./k8s_inventory.ini.tpl")
  vars = {
    vm1_internal_ip  = "${module.vm_1.internal_ip_address_vm}"
    vm2_internal_ip  = "${module.vm_2.internal_ip_address_vm}"
  }
}

resource "null_resource" "update_k8s_inventory" {
 triggers = {
    template = data.template_file.k8s_inventory.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.k8s_inventory.rendered}' > ../k8s_inventory.ini"
  }
}
