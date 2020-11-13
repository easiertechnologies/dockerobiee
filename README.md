# Docker OBIEE

These scripts spin up 2 contianers.  

- Oracle 12c
- OBIEE

**Both** containers are necessary to run, even if you are planning to connect to an external data source, such as a local DB.

:warning: if you are not using Ubuntu 18.04 you will need to edit the `startobiee.sh` script to get the proper IP Adress of the local machine.  For example:

- Ubuntu 16.04 $ip=(/sbin/ifconfig ens4 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
- Ubuntu 18.04 $ip=(/sbin/ifconfig ens4 | grep 'inet' | cut -d: -f2 | awk '{print $2}')


## Usage


### Create swap space

OBIEE requries there to be at least 500MB of swap space, or the service will not start.  Swap space can be on a separate disk or setup as a file.  The folloing instructions build a `swapfile` for use, this cuts down on GCP costs.

As root:

1. `fallocate -l 1G /swapfile`
1. `chmod 600 /swapfile`
1. `mkswap /swapfile`
1. `swapon /swapfile`
1. `echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab`


### Run the contianer 
1. Have Docker installed (this should exist by default on GCP, if `which docker` returns nothing then run `apt update && apt install -y docker.io`
1. `sudo su`
1. `cd /`
1. `git clone https://github.com/easiertechnologies/dockerobiee`
1. `cd dockerobiee`
1. `chmod 755 startobiee.sh`
1. `./startobiee.sh`
