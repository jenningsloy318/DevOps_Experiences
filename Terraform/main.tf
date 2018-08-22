module "openstack1" {
  source = "./modules/openstack"
  openstack_user_name = name
  openstack_tenant_name = project1
  openstack_user_domain_name = domain1
  openstack_project_domain_name = domain1
  openstack_password = pass
  openstack_auth_url = https://url
  openstack_region_name = region1
  openstack_availability_zone_name = zone1
  openstack_image_name = rhel
  openstack_flavor = m1.max
  openstack_keypair = keympair
  openstack_secgroup_name = secgroup
  openstack_tenant_network_name = tenant-net1
  openstack_flp_network_name = fip-net1
  openstack_flp_subnetwork_name =  fip-subnet1
  openstack_instance_name = instance1
  openstack_volume_name = instance1_volume
  
}


module "openstack2" {
  source = "./modules/openstack"
  openstack_user_name = name
  openstack_tenant_name = project2
  openstack_user_domain_name = domain3
  openstack_project_domain_name = domain3
  openstack_password = pass
  openstack_auth_url = https://url
  openstack_region_name = region2
  openstack_availability_zone_name = zone2
  openstack_image_name = rhel
  openstack_flavor = m1.max
  openstack_keypair = keympair
  openstack_secgroup_name = secgroup
  openstack_tenant_network_name = tenant-net2
  openstack_flp_network_name = fip-net2
  openstack_flp_subnetwork_name =  fip-subnet2
  openstack_instance_name = instance2
  openstack_volume_name = instance2_volume
  
}
module "vSphere" {
  source = "./modules/vSphere"

  vsphere_server
  vsphere_user = 
  vsphere_password = 
  vsphere_datacenter =
  vsphere_resource_pool = 
  vsphere_network = 
  vsphere_datastore_os = 
  vsphere_datastore_data = 
  vsphere_instance = 
  vsphere_vm_template = 
  vsphere_instance_cpu_count = 
  vsphere_instance_memory_count = 
}
