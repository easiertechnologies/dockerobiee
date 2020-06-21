#!/bin/bash

clear

echo "starting database, please wait"

docker start database
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

echo "Database is running successfully"

sleep 5

echo "starting OBIEE"

docker start obiee

# getObieeStatus() {
# 	obstatus=$(docker logs obiee | grep "bi_server1      Server          6da9a34b9f14              unknown     unknown      RUNNING")
# }

# getObieeStatus

# until [ "$obstatus" == "RUNNING" ]
# do
# 	sleep 60
# 	docker logs obiee
# 	getObieeStatus
# done

obport=$(docker port obiee | grep "9502" | cut -d: -f2)

sleep 5
clear
echo "URL: localhost:$obport:/analytics"
echo "Username: weblogic"
echo "Password: Admin123"
