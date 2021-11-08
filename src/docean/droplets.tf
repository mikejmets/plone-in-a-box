resource "digitalocean_droplet" "web" {
  count = 1
  image  = "ubuntu-20-04-x64"
  name   = "piab-${count.index}"
  region = "fra1"
  size   = "s-1vcpu-1gb"

  ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
  ]

  provisioner "remote-exec" {
    inline = [
	"sudo apt update",
	"sudo apt install -y git",
	"cd /root; git clone -b docean https://github.com/mikejmets/plone-in-a-box.git",
	"chmod +x /root/plone-in-a-box/src/StackScript",
	"sudo /root/plone-in-a-box/src/StackScript"
    ]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }
  }
}

output "droplet_ip_addresses" {
  value = {
    for droplet in digitalocean_droplet.web:
    droplet.name => droplet.ipv4_address
  }
}
