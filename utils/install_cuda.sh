tput setaf 6; echo '#### Downloading and installing CUDA ####'; tput sgr0;
wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb

sudo dpkg -i cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb
sudo apt-key add /var/cuda-repo-10-1-local-10.1.105-418.39/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
echo 'export PATH=/usr/local/cuda-10.1/bin${PATH:+:${PATH}}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64/' >> ~/.bashrc

tput setaf 2; echo '#### CUDA has been successfully installed ####'; tput sgr0;
tput setaf 2; echo '#### Rebooting in 5s ... ####'; tput sgr0;
sleep 5
sudo reboot
