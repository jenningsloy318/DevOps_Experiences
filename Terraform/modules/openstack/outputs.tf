output "vm_fixed_ip_address" {
value = format("instanceID: %v - fixed_ip: %v",openstack_compute_instance_v2.os_vm_instance[*].id,openstack_compute_instance_v2.os_vm_instance[*].network[0].fixed_ip_v4)
depends_on = [openstack_compute_instance_v2.os_vm_instance]
}


output "vm_floating_ip_address" {
value = format("instanceID: %v - floating_ip: %v", openstack_compute_floatingip_associate_v2.os_vm_flp_association[*].instance_id,openstack_compute_floatingip_associate_v2.os_vm_flp_association[*].floating_ip)
depends_on = [openstack_compute_floatingip_associate_v2.os_vm_flp_association]
}