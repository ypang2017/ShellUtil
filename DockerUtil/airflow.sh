#! /bin/bash

if [ $# -lt 1 ]
then
  echo "缺少参数：请输入操作类型[stop|start]"
  exit 1
fi

#---Start airflow---
if [ $1 = "start" ]
  then
    # 执行初始化环境脚本 
    CURDIR="$( cd "$( dirname "$0"  )" && pwd  )"  
    . $CURDIR/source_init.sh

    nohup airflow scheduler >/dev/null 2>&1 &
    airflow webserver -p 8080 &

#---Stop airflow---
elif [ $1 = "stop" ]
  then 
    process_name=airflow
    PROCESS=`ps -ef|grep $process_name|grep -v grep|grep -v PPID|awk '{ print $2}'`
    for i in $PROCESS
    do
      echo "Kill the $1 process [ $i ]"
      kill -9 $i
    done
fi
