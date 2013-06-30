#Setup
------

$ wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb

$ sudo dpkg -i puppetlabs-release-precise.deb

$ sudo apt-get update

$ sudo apt-get install puppet-common

$ sudo apt-get install git

$ git clone git@github.com:rocky-jaiswal/main-devops.git

$ cd main-devops

$ chmod u+x setup.sh

$ ./setup.sh


Add User One
------------
useradd rockyj
mkdir /home/rockyj
chown -R /home/rockyj rockyj
passwd rockyj
usermod -aG sudo rockyj