#!/bin/bash
if [ -z $1 ]; then
  echo "no ip provided"
  exit 1
fi
IP=$1
ping -c 1 $IP > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo '{"reachable": true}'
else
  echo '{"reachable": false}'
fi
