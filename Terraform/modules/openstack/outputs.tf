output "vm_fixed_ip_address" {
value = openstack_compute_instance_v2.os_vm_instance[*].network[*].fixed_ip_v4
depends_on = [openstack_compute_instance_v2.os_vm_instance]
}


output "vm_floating_ip_address" {
value = openstack_compute_floatingip_associate_v2.os_vm_flp_association[*].floating_ip
depends_on = [openstack_compute_floatingip_associate_v2.os_vm_flp_association]
}
