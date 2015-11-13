#! /bin/bash

START=1

# get optional arguments
while getopts "s:" optchar; do
    case "${optchar}" in
        s) START=${OPTARG} ;;
    esac
done
# remove optional arguments from argument list
shift $(expr $OPTIND - 1 )


# mandatory arguments
[ "$#" -eq 2 ] || exit "2 arguments required, $# provided - <prefix of nodes> <number of nodes>"

NAME_PREFIX="$1"
NODE_COUNT="$2"

echo "Removing machines..."
for (( i=${START}; i<=$NODE_COUNT; i++ ))
do
    ./docker-machine rm "${NAME_PREFIX}${i}"
done

###
# The Purge
###
echo "Purging Images..."
for (( i=${START}; i<=$NODE_COUNT; i++ ))
do
    ssh root@"${NAME_PREFIX}${i}".local 'docker stop $(docker ps -aq); docker rm $(docker ps -aq); exit'
done
