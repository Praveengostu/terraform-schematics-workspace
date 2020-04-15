resource "null_resource" "apply" {
  provisioner "local-exec" {
	command = "chmod +x apply.sh;sh apply.sh"
 }
}

resource "null_resource" "destroy" {
  provisioner "local-exec" {
        command = "chmod +x destroy.sh;sh destroy.sh"
 }
}
