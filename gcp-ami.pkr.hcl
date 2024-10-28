packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

source "googlecompute" "yeedu" {
  image_name          = "ami-yeedu-1"
  source_image        = "test-ami-image"
  instance_name       = "yeedu-instance"
  project_id          = "modak-nabu"
  network_project_id  = "modak-nabu"
  network             = "modak-nabu-spark-vpc"
  subnetwork          = "custom-subnet-modak-nabu"
  ssh_username        = "yeedu"
  zone                = "us-central1-a"
  machine_type        = "g2-standard-4"
  disk_size           = 50
  disk_type           = "pd-balanced"
  use_internal_ip = true
  ssh_private_key_file = "/home/ma0804/Downloads/private_key.txt"
  on_host_maintenance= "TERMINATE"
  # startup_script_file = "setup.sh"
}

build {
  sources = ["source.googlecompute.yeedu"]
}
