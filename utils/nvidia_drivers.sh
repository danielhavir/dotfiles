tput setaf 6; echo '#### Installing nVidia drivers ####'; tput sgr0;
wget http://us.download.nvidia.com/tesla/418.87/nvidia-driver-local-repo-ubuntu1804-418.87.00_1.0-1_amd64.deb

sudo dpkg -i nvidia-driver-local-repo-ubuntu1804-418.87.00_1.0-1_amd64.deb
sudo apt-key add /var/nvidia-driver-local-repo-ubuntu1804-418.87.00/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda-drivers

tput setaf 2; echo '#### New drivers installed, rebooting in 5s ... ####'; tput sgr0;
sleep 5
sudo reboot