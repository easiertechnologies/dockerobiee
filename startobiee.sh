#!/bin/bash

clear

echo "##############################################################"
echo "Please be paitent, this script takes about an hour to complete"
echo "##############################################################"
echo " "

echo "##############################################################"
echo "Starting Database"
echo "##############################################################"

ip=$(/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')

docker run -d -p 1521:1521 --stop-timeout 600 --name database mdaviscatg/oracle_database

getDbStatus() {
	dbstatus=$(docker logs database | grep "DATABASE IS READY TO USE!")
} 

getDbStatus

until [ "$dbstatus" == "DATABASE IS READY TO USE!" ]
do
	sleep 60
	docker logs database
	getDbStatus
done

echo "#########################"
echo "Setting Database Password" 
echo "#########################"

docker exec database ./setPassword.sh Admin123

sleep 5

clear

echo "#################################"
echo "Starting Oracle Business Intel"
echo "#################################"

docker run -d -P \
--name obiee --stop-timeout 600 \
-e "BI_CONFIG_RCU_DBSTRING=$ip:1521:orclpdb1" -e "BI_CONFIG_RCU_PWD=Admin123" \
mdaviscatg/obiee

getObieeStatus() {
	obstatus=$(docker logs obiee | grep "Type help() for help on available commands")
}

getObieeStatus

until [ "$obstatus" == "Type help() for help on available commands" ]
do
	sleep 60
	docker logs obiee
	getObieeStatus
done

obport=$(docker port obiee | grep "9502" | cut -d: -f2)

sleep 20

clear
echo "####################################################"
echo "URL: localhost:$obport/analytics"
echo "Username: weblogic"
echo "Password: Admin123"
echo "####################################################"








