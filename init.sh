#! /bin/bash

# mandatory arguments
[ "$#" -eq 3 ] || exit "3 arguments required, $# provided - <prefix of nodes> <number of nodes> <path image to use>"

NAME_PREFIX="$1"
NODE_COUNT="$2"
IMAGE="$3"

echo "Preparing Images..."
for (( i=1; i<=$NODE_COUNT; i++ ))
do
    flash --hostname ${NAME_PREFIX}${i} ${IMAGE}
done
