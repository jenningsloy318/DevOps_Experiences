output "vm_ip_address" {
value = openstack_compute_instance_v2.os_vm_instance[*].network.fixed_ip_v4
depends_on = ["openstack_compute_instance_v2.os_vm_instance"]
}
