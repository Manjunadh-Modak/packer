packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}


source azure-arm vm {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  location                          = "eastus"
  managed_image_name                = "sample-image-yeedu"
  managed_image_resource_group_name = "yeedu"

  build_resource_group_name = "yeedu"

  virtual_network_name                = "nabusparkvnet"
  virtual_network_subnet_name         = "yeedu-1"
  virtual_network_resource_group_name = "yeedu"

  communicator    = "ssh"
  os_type         = "Linux"
  image_publisher = "canonical"
  image_offer     = "0001-com-ubuntu-server-focal"
  image_sku       = "20_04-lts-gen2"
  image_version   = "latest"
  vm_size         = "Standard_DS2_v2"
}

build {
  sources = [
    "source.azure-arm.vm"
  ]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }

}