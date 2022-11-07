#terraform {
#  required_providers {
#    yandex = {
#      source = "yandex-cloud/yandex"
#    }
#  }
#}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = var.subnet_id
}
module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id
}
module "vpc" {
  source = "../modules/vpc"
}
//change mongodb paramaters
resource "null_resource" "mongod_settings" {
  depends_on = ["module.db"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = module.db.external_ip_address_db
    agent       = false
    timeout     = "40s"
  }

  //setting up mongodb ip listener
  provisioner "remote-exec" {
    inline = [
      "sudo sed -i 's|127.0.0.1|'0.0.0.0'|g' /etc/mongod.conf",
      "sudo rm -rf /tmp/mongodb-27017.sock",
      "sudo systemctl restart mongod",
    ]
  }
}

resource "null_resource" "create_and_run_app" {
  depends_on = ["module.app", "module.db"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = module.app.external_ip_address_app
    agent       = false
    timeout     = "40s"
  }

  //Upload puma
  provisioner "file" {
    source      = "../files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "file" {
    source      = "../files/deploy.sh"
    destination = "/home/ubuntu/deploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sed -i 's|mongo_db_url|${module.db.external_ip_address_db}|g' /tmp/puma.service",
      "chmod +x /home/ubuntu/deploy.sh",
      "/home/ubuntu/deploy.sh",
    ]
  }
}
