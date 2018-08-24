#!/bin/bash

clear

echo "########################################"
echo "       Stopping Obiee Service"
echo "########################################"

docker stop obiee


echo "########################################"
echo "      Service Has Stopped"
echo "########################################"


echo "########################################"
echo "        Stopping Database"
echo "########################################"

docker stop database


echo "########################################"
echo "       All services are stopped"
echo "########################################"


