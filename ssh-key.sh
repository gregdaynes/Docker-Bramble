#! /bin/bash

# mandatory arguments
[ "$#" -eq 3 ] || exit "3 arguments required, $# provided - <prefix of nodes> <number of nodes> <path to key>"

NAME_PREFIX="$1"
NODE_COUNT="$2"
KEY="$3"

echo "Preparing Images..."
for (( i=1; i<=$NODE_COUNT; i++ ))
do
    ssh-keygen -R "${NAME_PREFIX}${i}.local" -f ~/.ssh/known_hosts
    ssh-copy-id -i ${KEY} root@${NAME_PREFIX}${i}.local
done
