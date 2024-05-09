packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "= v1.2.9"
    }
  }
}


source "amazon-ebs" "ubuntu" {
  ami_name      = "ami-yeedu"
  instance_type = "m4.xlarge"
  region        = "us-east-2"
  source_ami    = "ami-0d5bf08bc8017c83b"
  ssh_username  = "ubuntu"
  subnet_id     = "subnet-0d12439a87299d35d"

}

build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }

}
