terraform {
  required_version = "> 0.11.0"
  backend "local" {
    path = "./terraform.tfstate"
  }
}


data "template_file" "userdata-basic" {
  template = "${file("${path.module}/userdata-basic")}"

}

data "template_file" "os-hardening-script" {
  template = "${file("${path.module}/os-hardening.sh")}"
}
data "template_file" "monitor-configuration-script" {
  template = "${file("${path.module}/monitor-configuration.sh")}"
}

data "template_cloudinit_config" "userdata" {
 
   part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.userdata-basic.rendered}"
  }
    part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.os-hardening-script.rendered}"
  }  

      part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.monitor-configuration-script.rendered}"
  }  

}


resource "openstack_networking_secgroup_v2" "monitor_secgroup_01" {
  name        = "monitor-secgroup-01"
  description = "security group for monitor instannce"

}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.monitor_secgroup_01.id}"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9273
  port_range_max    = 9273
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.monitor_secgroup_01.id}"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9090
  port_range_max    = 9090
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.monitor_secgroup_01.id}"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9093
  port_range_max    = 9093
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.monitor_secgroup_01.id}"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_5" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3000
  port_range_max    = 3000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.monitor_secgroup_01.id}"
}


module "monitor" {
  source = "../modules/OpenStack"
  openstack_image_name = "rhel-7-amd64-vmware"
  openstack_flavor = "m2.4xlarge"
  openstack_keypair = "default-key"
  openstack_secgroup_name = "monitor-secgroup-01"
  openstack_tenant_network_name = "${var.openstack_tenant_name}"
  openstack_flp_network_name = "FloatingIP-external-monsoon3-01"
  openstack_flp_subnetwork_name = "FloatingIP-sap-monsoon3-01-01"
  openstack_instance_name = "monitor"
  openstack_volume_size = "100"
  userdata= "${data.template_cloudinit_config.userdata.rendered}"
}

