#!/bin/bash

# update apt-get
export DEBIAN_FRONTEND="noninteractive"
sudo apt-get update

# remove previously installed Docker
sudo apt-get purge lxc-docker*
sudo apt-get purge docker.io*


#Download latest binary 
wget http://get.docker.io/builds/Linux/x86_64/docker-latest -O /usr/bin/docker

#Download init.d script
curl -o /etc/init.d/docker https://raw.githubusercontent.com/dotcloud/docker/master/contrib/init/sysvinit-debian/docker

#Make the two files executable
chmod +x /usr/bin/docker /etc/init.d/docker

#Add group docker to your system
addgroup docker

#Make docker run on computer startup
update-rc.d -f docker defaults

#Socket binding
cat << EOF > /etc/default/docker
DOCKER_OPTS="-H 127.0.0.1:4243 -H unix:///var/run/docker.sock"
EOF

#Start docker and make sure that it is successfully installed.
service docker start

# set Docker to auto-launch on startup
sudo systemctl enable docker

