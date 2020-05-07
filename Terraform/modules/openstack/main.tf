
# this validate is a third party plugin, https://github.com/craigmonson/terraform-provider-validate
provider "validate" {}

data "validate" "os_image_name" {
  val   = var.openstack_image_name
  regex = "^[Uu]buntu"
}





data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config" 
    content      = data.validate.os_image_name.error_msg  == null ? "${file("${path.module}/userdata-ubuntu.yaml")}" :  "${file("${path.module}/userdata-rhel.yaml")}"
  }

}

data "openstack_images_image_v2" "os_vm_image" {
  name        = var.openstack_image_name
}

resource "openstack_blockstorage_volume_v2" "os_vm_data_volume" {
  count = var.openstack_instance_count
  name        = format("%s-%d-vol%d", var.openstack_instance_name,count.index + 1, 1)
  description = format("%s-%d-vol%d", var.openstack_instance_name,count.index + 1, 1)
  size        = var.openstack_data_volume_size
  availability_zone = var.openstack_availability_zone_name
}

resource "openstack_networking_floatingip_v2" "os_vm_flp_address" {
  count = var.openstack_instance_count
  description = format("%s-%d-floatingip-%d", var.openstack_instance_name,count.index + 1, 1)
  pool = var.openstack_flp_network
}


resource "openstack_compute_instance_v2" "os_vm_instance" {
  count = var.openstack_instance_count
  name=  format("%s-%d", var.openstack_instance_name,count.index + 1)
  image_id   = data.openstack_images_image_v2.os_vm_image.id
  flavor_name = var.openstack_flavor
  availability_zone = var.openstack_availability_zone_name
  key_pair = var.openstack_keypair
  security_groups = [var.openstack_secgroup_name,"default"]
  network {
    name = var.openstack_private_network_name
  }
  user_data = data.template_cloudinit_config.config.rendered

  timeouts {
    create = "60m"
    delete = "2h"
  }

}

resource "openstack_compute_volume_attach_v2" "attach_data_volume" {
  count       = var.openstack_instance_count
  instance_id = openstack_compute_instance_v2.os_vm_instance[count.index].id
  volume_id   = openstack_blockstorage_volume_v2.os_vm_data_volume[count.index].id
}

resource "openstack_compute_floatingip_associate_v2" "os_vm_flp_association" {
  count       = var.openstack_instance_count
  instance_id = openstack_compute_instance_v2.os_vm_instance[count.index].id
  floating_ip = openstack_networking_floatingip_v2.os_vm_flp_address[count.index].address
}
