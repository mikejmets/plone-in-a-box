resource "random_id" "id" {
  byte_length = 8
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "piab-${random_id.id.hex}"
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

output "droplet_ip_address" {
  value = digitalocean_droplet.web.ipv4_address
}
