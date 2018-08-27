
data "openstack_networking_subnet_v2" "fip_subnet_1" {
  name = "${var.openstack_flp_subnetwork_name}"
}


resource "openstack_networking_floatingip_v2" "floatip_1" {
  subnet_id = "${data.openstack_networking_subnet_v2.fip_subnet_1.id}"
  pool = "${var.openstack_flp_network_name}"
}

resource "openstack_compute_instance_v2" "instance_1" {
  name = "${var.openstack_instance_name}"
  image_name = "${var.openstack_image_name}"
  flavor_name = "${var.openstack_flavor}"
  key_pair = "${var.openstack_keypair}"
  security_groups = ["${var.openstack_secgroup_name}","default"]
  network {
    name = "${var.openstack_tenant_network_name}"
  }
  user_data       = "${var.userdata}"
  
}
resource "openstack_blockstorage_volume_v2" "volume_1" {
  name        = "${var.openstack_instance_name}_volume"
  description = "volume for instance ${var.openstack_instance_name}"
  size        = "${var.openstack_volume_size}"
  availability_zone= "${openstack_compute_instance_v2.instance_1.availability_zone}"
}

resource "openstack_compute_volume_attach_v2" "volume_attach" {
  instance_id = "${openstack_compute_instance_v2.instance_1.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.volume_1.id}"
}


resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.instance_1.id}"
}





