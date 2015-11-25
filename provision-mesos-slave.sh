#!/bin/bash

sudo service zookeeper stop
sudo sh -c "echo manual > /etc/init/zookeeper.override"
sudo service mesos-master stop
sudo sh -c "echo manual > /etc/init/mesos-master.override"
printf 'zk://%s:2181/mesos' "$1" | sudo tee /etc/mesos/zk
echo 'docker,mesos' | sudo tee /etc/mesos-slave/containerizers
printf '%s' "$2" | sudo tee /etc/mesos-slave/hostname
sudo service mesos-slave restart
