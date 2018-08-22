
data "template_file" "userdata" {
  template = "${file("user-data")}"

}
data "template_file" "script" {
  template = "${file("test.sh")}"
}

data "template_cloudinit_config" "userdata" {
 
   part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.userdata.rendered}"
  }
 
   part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.script.rendered}"
  }  
}
