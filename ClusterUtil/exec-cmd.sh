#!/bin/bash

# every node in the file of slaves will exec the same cmd
# example: exec-cmd.sh "mkdir /home/hadoop/app" all

if [ $# -lt 2 ]
then
  echo "Usage: ./exec-cmd.sh Command MachineTag"
  echo "Usage: ./exec-cmd.sh Command MachineTag confFile"
  exit
fi

cmd=$1
tag=$2
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
if [ 'a'$3'a' == 'aa' ]
then
  confFile=${SCRIPT_DIR}/deploy.conf
else
  confFile=$3
fi

if [ -f $confFile ]
then
    for server in `cat $confFile|grep -v '^#'|grep ','$tag','|awk -F',' '{print $1}'`
    do
       echo "*******************$server***************************"
       ssh $server "source /etc/profile; $cmd"
    done
else
  echo "Error: Please assign config file or run deploy.sh command with deploy.conf in same directory"
fi
