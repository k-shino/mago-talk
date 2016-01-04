# Preparing for docker install
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

# Installing git, docker, virtualbox, etc.
sudo apt-get update
sudo apt-get install -qy lxc-docker

# docker configuration
sudo groupadd -f docker
sudo gpasswd -a ${USER} docker
sudo service docker restart

# Installing Raspaas
mkdir raspaas
cd raspaas
wget http://raw.github.com/tetsusat/raspaas/master/bootstrap.sh
chmod +x bootstrap.sh


# Cloning mago-talk
git clone https://github.com/k-shino/mago-talk.git
