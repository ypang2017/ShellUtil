#! /bin/bash

if [ $# -lt 1 ]
then
  echo "缺少参数：请输入操作类型[stop|start|enter]"
  exit 1
fi

#---Start airflow image docker---
if [ $1 = "start" ]
  then
     echo "进入airflow docker镜像：labs_cib_airflow:1.0"
     docker container run --rm -v /home:/home -p 8080:8080 -it --net=host labs_cib_airflow:1.0 /bin/bash

#---Stop airflow image docker---
elif [ $1 = "stop" ]
  then  
     echo "关闭airflow docker镜像"
     containerId=`docker container list|sed -n '2p'| awk {'print $1'}`
     echo "CONTAINER ID:"$containerId" will be killed"
     docker container kill $containerId

#---Enter airflow image docker which container is running---
elif [ $1 = "enter" ]
  then  
     echo "进入已经在运行的container"
     containerId=`docker container list|sed -n '2p'| awk {'print $1'}`
     echo "enter CONTAINER ID:"$containerId""
     docker exec -it $containerId /bin/bash 
     source /etc/profile
fi 
