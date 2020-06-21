#!/bin/bash

clear

echo "##############################################################"
echo "Please be paitent, this script takes about an hour to complete"
echo "##############################################################"
echo " "

echo "##############################################################"
echo "Starting Database"
echo "##############################################################"

ip=$(/sbin/ifconfig ens4 | grep 'inet' | cut -d: -f2 | awk '{print $2}')

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

docker run -d \
-p 32855:9508 \
-p 32849:9514 \
-p 32848:9799 \
-p 32861:9502 \
-p 32858:9505 \
-p 32856:9507 \
-p 32854:9509 \
-p 32863:9500 \
-p 32859:9504 \
-p 32851:9512 \
-p 32850:9513 \
-p 32862:9501 \
-p 32860:9503 \
-p 32857:9506 \
-p 32853:9510 \
-p 32852:9511 \
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








