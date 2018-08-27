variable "openstack_user_name" {
    description = "The username for the Tenant."
    default  = ""
}

variable "openstack_tenant_name" {
    description = "The name of the Tenant."
    default  = ""
}

variable "openstack_user_domain_name" {
    description = "The keystone user's domain name."
    default  = ""
}
variable "openstack_project_domain_name" {
    description = "The keystone domain name containing the project."
    default  = ""
}
variable "openstack_password" {
    description = "The password for the Tenant."
    default  = ""
}

variable "openstack_auth_url" {
    description = "The endpoint url to connect to OpenStack."
    default  = ""
}

variable "openstack_region_name" {
    description = "The region name of the tenant."
    default  = ""
}

variable "openstack_availability_zone_name" {
    description = "The  availability zone install will be created in."
    default = ""
}
