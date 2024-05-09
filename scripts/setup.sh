#!/bin/bash
setup_docker() {
  
  sudo apt-get update && sudo apt-get upgrade  
  echo "Installing docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh   

  echo "Successfully Installed docker"
}

setup_docker


gcp)
      log_action "Found machine provider as GCP.."
      # NVIDIA_DRIVER_VERSION=$(sudo apt-cache search 'linux-modules-nvidia-[0-9]+-gcp$' | awk '{print $1}' | sort | tail -n 2 | head -n 1 | awk -F"-" '{print $4}')
      if [ "$UBUNTU_VERSION" == "2204" ]; then
        NVIDIA_DRIVER_VERSION=550 # Update the driver version if any issue occurs
      elif [ "$UBUNTU_VERSION" == "2004" ]; then
        NVIDIA_DRIVER_VERSION=530
      else
          echo "Unsupported distribution"
      fi
      sudo DEBIAN_FRONTEND=noninteractive $PKG_MANAGER -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install linux-modules-nvidia-${NVIDIA_DRIVER_VERSION}-gcp nvidia-driver-${NVIDIA_DRIVER_VERSION} -y
 
      wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu$UBUNTU_VERSION/x86_64/cuda-ubuntu$UBUNTU_VERSION.pin
      sudo mv cuda-ubuntu$UBUNTU_VERSION.pin /etc/apt/preferences.d/cuda-repository-pin-600
 
      if [ "$UBUNTU_VERSION" == "2204" ]; then
         wget https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda-repo-ubuntu$UBUNTU_VERSION-12-4-local_12.4.1-550.54.15-1_amd64.deb
         sudo DEBIAN_FRONTEND=noninteractive dpkg -i --force-confnew --force-confdef cuda-repo-ubuntu$UBUNTU_VERSION-12-4-local_12.4.1-550.54.15-1_amd64.deb
         sudo cp /var/cuda-repo-ubuntu2204-12-4-local/cuda-*-keyring.gpg /usr/share/keyrings/
 
      elif [ "$UBUNTU_VERSION" == "2004" ]; then
         wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda-repo-ubuntu$UBUNTU_VERSION-12-1-local_12.1.1-530.30.02-1_amd64.deb
         sudo DEBIAN_FRONTEND=noninteractive dpkg -i --force-confnew --force-confdef cuda-repo-ubuntu$UBUNTU_VERSION-12-1-local_12.1.1-530.30.02-1_amd64.deb
 
         sudo cp /var/cuda-repo-ubuntu$UBUNTU_VERSION-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/
 
      else
          echo "Unsupported distribution"
      fi
 
      sudo $PKG_MANAGER update
      sudo DEBIAN_FRONTEND=noninteractive $PKG_MANAGER -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y cuda
 
      sudo $PKG_MANAGER install nvidia-cuda-toolkit -y
      if [ "$UBUNTU_VERSION" == "2204" ]; then
        echo 'export PATH=$PATH:/usr/local/cuda-12.4/bin' >>~/.bashrc
      elif [ "$UBUNTU_VERSION" == "2004" ]; then
        echo 'export PATH=$PATH:/usr/local/cuda-12.1/bin' >>~/.bashrc
      else
          echo "Unsupported distribution"
      fi
      
      sudo $PKG_MANAGER update
 
      sudo DEBIAN_FRONTEND=noninteractive $PKG_MANAGER -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install linux-modules-nvidia-${NVIDIA_DRIVER_VERSION}-gcp nvidia-driver-${NVIDIA_DRIVER_VERSION} -y
      ;;
 