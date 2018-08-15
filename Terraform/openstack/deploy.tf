#resource "openstack_compute_keypair_v2" "keypair_1" {
#name = "my_test_keypair"
#public_key = "${file("${var.openstack_ssh_pub_key_file}")}"
#}

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "${var.openstack_secgroup_name}"
  description = "My first test neutron security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  subnet_id = "${var.openstack_flp_subnetwork_id}"
  pool = "${var.openstack_flp_network_name}"
}


data "template_file" "userdata" {
  template = "${file("user-data")}"

}
data "template_file" "script" {
  template = "${file("test.sh")}"
}

data "template_cloudinit_config" "userdata" {
 
   part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.userdata.rendered}"
  }
 
   part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.script.rendered}"
  }  
}

resource "openstack_compute_instance_v2" "instance_1" {
  name = "${var.openstack_instance_name}"
  image_name = "${var.openstack_image_name}"
  flavor_name = "${var.openstack_flavor}"
  key_pair = "${var.openstack_keypair}"
  availability_zone= "${var.openstack_availability_zone_name}"
  security_groups = ["${var.openstack_secgroup_name}"]
  network {
    name = "${var.openstack_tenant_network_name}"
  }
  user_data       = "${data.template_cloudinit_config.userdata.rendered}"
}


resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.instance_1.id}"
}

#resource "openstack_blockstorage_volume_v2" "volume_1" {
#  name        = "${var.openstack_instance_name}_volume_1"
#  description = "volume for instance ${var.openstack_instance_name}"
#  size        = 3
#  availability_zone= "${var.openstack_availability_zone_name}"
#}
#
#resource "openstack_blockstorage_volume_attach_v2" "attach_volume_1" {
#  volume_id = "${openstack_blockstorage_volume_v2.volume_1.id}"
#  device = "auto"
#  host_name = "${var.openstack_instance_name}"
#  ip_address = "${openstack_compute_instance_v2.instance_1.network.0.fixed_ip_v4}"
#}


output "Float IP address" {
value = "${openstack_networking_floatingip_v2.floatip_1.address}"
}
