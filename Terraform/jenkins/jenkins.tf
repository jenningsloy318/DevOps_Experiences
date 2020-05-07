provider "openstack" {
  user_name   = "xx"
  tenant_id = "0db4b03643c24a11a3c8c4ac045c7c24"
  user_domain_id = "ec213443e8834473b579f7bea9e8c194"
  project_domain_id = "ec213443e8834473b579f7bea9e8c194"
  password    = "xx"
  auth_url    = "https://identity-3.eu-de-1/v3"
  region      = "eu-de-1"
  use_octavia = false
}  


module "vm-instance"  {
    source  = "../modules/vm-instance"
    openstack_instance_count = 3
    openstack_image_name = "ubuntu-18.04-amd64-vmware-private"
    openstack_flavor = "m1.medium"
    openstack_instance_name = "jenkins"
    openstack_availability_zone_name ="eu-de-1a"
    openstack_private_network_name ="private-network-01"
    openstack_data_volume_size = "100"
    openstack_flp_network ="floating-network-01"
}



output "vm_fixed_ip_address" {
value = module.vm-instance.vm_fixed_ip_address
}
output "vm_floating_ip_address" {
value = module.vm-instance.vm_floating_ip_address
}