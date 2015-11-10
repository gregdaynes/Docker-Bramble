#! /bin/bash

# define cluster variables
# if not already defined

# internal vars
TOKEN=babb1eb00bdecadedec0debabb1eb00b
NAME=$(openssl rand -base64 8)
START=1

# get optional arguments
while getopts "t:n:s:" optchar; do
    case "${optchar}" in
        t) TOKEN=${OPTARG} ;;
        n) NAME=${OPTARG} ;;
        s) START=${OPTARG} ;;
    esac
done
# remove optional arguments from argument list
shift $(expr $OPTIND - 1 )

# mandatory arguments
[ "$#" -ge 2 ] || exit "2 arguments required, $# provided - <prefix of containers to build> <number of nodes>"

NAME_PREFIX="$1"
NODE_COUNT="$2"

echo "Preparing Tower..."
# echo "${NAME_PREFIX} ${NODE_COUNT} ${TOKEN}"

echo "Removing machines..."
for (( n=${START}; n<=${NODE_COUNT}; n++ ))
do
    ./docker-machine rm "${NAME_PREFIX}${n}"
done

###
# Iterate through nodes, create initial swarm master and then slaves
###
echo "Creating machines..."
for (( i=${START}; i<=$NODE_COUNT; i++ ))
do
    declare "_$NAME_PREFIX$i=$(ping -c1 $NAME_PREFIX$i.local | grep -oh -m 1 -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"

    NODE_IP="_$NAME_PREFIX$i"
    echo ${!NODE_IP}

    if [ $i -eq 1 ]
    then
        ./docker-machine create -d hypriot --swarm --swarm-master --swarm-discovery token://${TOKEN} --hypriot-ip-address ${!NODE_IP} ${NAME_PREFIX}${i}
    else
        ./docker-machine create -d hypriot --swarm --swarm-discovery token://${TOKEN} --hypriot-ip-address ${!NODE_IP} ${NAME_PREFIX}${i}
    fi
done


echo "${TOKEN}"
