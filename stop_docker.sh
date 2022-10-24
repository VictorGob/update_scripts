#!/bin/bash
# docker ps | tail -n +2 | grep -v "portainer" | awk '{print $1}' | while read i; do docker stop $i; done
list=$(docker ps | tail -n +2 | grep -v "portainer" | awk '{print $1}')

for dock in $list; do
    docker stop -t 5 $dock &
done

echo "*** END ***"
