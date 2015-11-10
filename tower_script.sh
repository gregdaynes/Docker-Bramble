#! /bin/bash

# define cluster
export TOWER_NAME=pi
export NODE_COUNT=4
export TOKEN=babb1eb00bdecadedec0debabb1eb00b

# ping each node for health check
# get ip address from each node
#each node
# ping for health check
# get ip address
# export $(TOWER_NAME)$i=ping -c1 pi1.local | grep -oh -m 1 -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
# create swarm master
# ./docker-machine create -d hypriot --swarm --swarm-master --swarm-discovery token://$TOKEN --hypriot-ip-address $TOWER_NAME1 $TOWER_NAME1
# $TOWER
# grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /etc/hos…
# $ ping -c4 router | grep 'received' | awk -F',' '{ print $2}' | awk '{ print $1}'


###
# Iterate through nodes, create initial swarm master and then slaves
###
for (( i=1; i<=$NODE_COUNT; i++ ))
do
    declare "_$TOWER_NAME_$i=$(ping -c1 $TOWER_NAME$i.local | grep -oh -m 1 -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"

    NODE_IP="_$TOWER_NAME_$i"
    echo ${!NODE_IP}

    if [ $i -eq 1 ]
    then
        ./docker-machine create -d hypriot --swarm --swarm-master --swarm-discovery token://$TOKEN --hypriot-ip-address ${!NODE_IP} $TOWER_NAME$i
        # echo ${!NODE_IP} $TOWER_NAME$i
    else
        ./docker-machine create -d hypriot --swarm --swarm-discovery token://$TOKEN --hypriot-ip-address ${!NODE_IP} $TOWER_NAME$i
    fi
done
