packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

source "googlecompute" "yeedu" {

  image_name          = "ami-yeedu"
  source_image        = "ubuntu-os-cloud/ubuntu-2004-lts"
  instance_name       = "yeedu-instance"
  project_id          = "modak-nabu"
  network_project_id  = "modak-nabu"
  network             = "modak-nabu-spark-vpc"
  subnetwork          = "custom-subnet-modak-nabu"
  ssh_username        = "yeedu"
  zone                = "us-central1-a"
  machine_type        = "n1-standard-4"
  disk_size           = 50
  disk_type           = "pd-balanced"
  startup_script_file = "setup.sh"

}

build {
  sources = ["sources.googlecompute.yeedu-custom-image"]
}