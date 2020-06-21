# Docker OBIEE

These scripts spin up 2 contianers.  

- Oracle 12c
- OBIEE

**Both** containers are necessary to run, even if you are planning to connect to an external data source, such as a local DB.

## Usage

1. Have Docker installed (this should exist by default on GCP)
1. `sudo su`
1. `cd /`
1. `git clone https://github.com/easiertechnologies/dockerobiee`
1. `cd dockerobiee`
1. `chmod 755 startobiee.sh`
1. `sudo ./startobiee.sh`
