variable "openstack_user_name" {
    description = "The username for the Tenant."
    default  = ""
}

variable "openstack_tenant_name" {
    description = "The name of the Tenant."
    default  = " "
}

variable "openstack_user_domain_name" {
    description = "The keystone user's domain name."
    default  = " "
}
variable "openstack_project_domain_name" {
    description = "The keystone domain name containing the project."
    default  = " "
}
variable "openstack_password" {
    description = "The password for the Tenant."
    default  = ""
}

variable "openstack_auth_url" {
    description = "The endpoint url to connect to OpenStack."
    default  = " "
}

variable "openstack_region_name" {
    description = "The region name of the tenant."
    default  = " "
}

variable "openstack_availability_zone_name" {
    description = "The  availability zone install will be created in."
    default = " "
}

variable "openstack_image_name" {
    description = "The image name."
    default  = " "
}


variable "openstack_flavor" {
    description = "The instance flavor name."
    default = " "
}

variable "openstack_ssh_pub_key_file" {
    description = "then public key file."
    default = "~/.ssh/id_rsa.pub"
}


variable "openstack_keypair" {
    description = "The keypair name."
    default = " "
}


variable "openstack_secgroup_name" {
    description = "The security group name."
    default = " "
}


variable "openstack_tenant_network_name" {
    description = "The tenant network name."
    default = " "
}

variable "openstack_flp_network_name" {
    description = "The  Floating network name."
    default = " "
}
variable "openstack_flp_subnetwork_id" {
    description = "The  Floating subnetwork name."
    default = " "
}


variable "openstack_instance_name" {
    description = "The instance name."
    default = "test_instance_01"
}




