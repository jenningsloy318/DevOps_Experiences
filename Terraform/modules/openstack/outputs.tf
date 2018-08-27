output "floating_ip_address" {
value = "${openstack_networking_floatingip_v2.floatip_1.address}"
depends_on = ["openstack_compute_floatingip_associate_v2.fip_1"]
}
