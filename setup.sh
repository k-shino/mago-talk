# Preparing for docker install
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo deb http://download.virtualbox.org/virtualbox/debian trusty contrib | sudo tee -a /etc/apt/sources.list
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

# Installing git, docker, virtualbox, etc.
sudo apt-get update
sudo apt-get install -qy g++ vim libpam0g-dev curl wget git unzip virtualbox-4.3 vim-syntax-docker lxc-docker

# docker configuration
sudo groupadd -f docker
sudo gpasswd -a ${USER} docker
sudo service docker restart

if 1 -eq 2 ; then
mkdir -p $HOME/pkg

# Installing terraform
wget -q https://dl.bintray.com/mitchellh/terraform/terraform_0.6.3_linux_amd64.zip -P $HOME/pkg
sudo unzip -qn $HOME/pkg/terraform_0.6.3_linux_amd64.zip -d /usr/bin/

# Installing  lattice
wget -q https://github.com/cloudfoundry-incubator/lattice/releases/download/v0.4.4/lattice-bundle-v0.4.4-linux.zip -P $HOME/pkg
unzip -jqn $HOME/pkg/lattice-bundle-v0.4.4-linux.zip -d $HOME/pkg/lattice
sudo cp $HOME/pkg/lattice/ltc /usr/bin/
mkdir $HOME/tf
cp $HOME/pkg/lattice/lattice-v0.4.4.aws.tf $HOME/tf/
cd $HOME/tf
terraform get -update
cd

# Installing Erlang
wget -q http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -P $HOME/pkg
sudo dpkg -i $HOME/pkg/erlang-solutions_1.0_all.deb
wget http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_3_general/esl-erlang_16.b.2-1~ubuntu~precise_amd64.deb
sudo dpkg -i esl-erlang_16.b.2-1~ubuntu~precise_amd64.deb
sudo apt-get install -y erlang

# Installing riak
git clone https://github.com/basho/riak.git
cd riak
make rel
echo "export PATH=$PATH:$HOME/riak/rel/riak/bin" >> $HOME/.bashrc

fi

cd
#wget http://launchpadlibrarian.net/212504081/ubuntu-fan_0.3.0~14.04.1_all.deb
#sudo apt-get install dnsmasq-base
#sudo apt-get install bridge-utils
#sudo apt-get install iproute2=3.12.0-2ubuntu1
#sudo dpkg -i ubuntu-fan_0.3.0~14.04.1_all.deb

# Installing Raspaas
mkdir raspaas
cd raspaas
wget http://raw.github.com/tetsusat/raspaas/master/bootstrap.sh
chmod +x bootstrap.sh
