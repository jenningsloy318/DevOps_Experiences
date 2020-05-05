
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
  
}

