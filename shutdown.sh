#! /bin/bash

# mandatory arguments
[ "$#" -eq 2 ] || exit "2 arguments required, $# provided - <prefix of nodes> <number of nodes>"

NAME_PREFIX="$1"
NODE_COUNT="$2"

###
# The Shutdown
###
echo "Shutting Down..."
for (( i=1; i<=$NODE_COUNT; i++ ))
do
    ssh root@"${NAME_PREFIX}${i}".local 'shutdown -h; exit'
done
