provider "openstack" {
  auth_url    = "${var.openstack_auth_url}"
  region      = "${var.openstack_region_name}"
  user_domain_name  = "${var.openstack_user_domain_name}"
  project_domain_name = "${var.openstack_project_domain_name}"
  tenant_name = "${var.openstack_tenant_name}"
  user_name   = "${var.openstack_user_name}"
  password    = "${var.openstack_password}"
}
