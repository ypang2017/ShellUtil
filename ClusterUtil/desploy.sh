#!/bin/bash
#set -x

# example: deploy.sh test.txt /home/hadoop/app/ slave

if [ $# -lt 3 ]
then
  echo "Usage: ./deply.sh srcFile(or Dir) descFile(or Dir) MachineTag"
  echo "Usage: ./deply.sh srcFile(or Dir) descFile(or Dir) MachineTag confFile"
  exit
fi

src=$1
dest=$2
tag=$3
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
if [ 'a'$4'a' == 'aa' ]
then
  confFile=${SCRIPT_DIR}/deploy.conf
else
  confFile=$4
fi

if [ -f $confFile ]
then
  if [ -f $src ]
  then
    for server in `cat $confFile|grep -v '^#'|grep ','$tag','|awk -F',' '{print $1}'`
    do
       scp $src $server":"${dest}
    done
  elif [ -d $src ]
  then
    for server in `cat $confFile|grep -v '^#'|grep ','$tag','|awk -F',' '{print $1}'`
    do
       scp -r $src $server":"${dest}
    done
  else
      echo "Error: No source file exist"
  fi

else
  echo "Error: Please assign config file or run deploy.sh command with deploy.conf in same directory"
fi