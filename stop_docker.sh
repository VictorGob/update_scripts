#!/bin/bash

list=$(docker ps | tail -n +2 | grep -v "portainer" | awk '{print $1}')

for dock in $list; do
    docker stop -t 5 $dock &
done

echo "*** END ***"
