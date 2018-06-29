#! /bin/bash

# 镜像labs_cib_airflow:1.0中python模块路径是/opt/anaconda2/lib/python2.7/site-packages，但是通过yum安装的其他模块
# 如MySQL-python是在/usr下面的几个目录下，所以使用这个脚步添加环境变量
source /etc/profile
# 添加两个python环境路径
echo "/usr/lib/python2.7/site-packages" >> my.pth
echo "/usr/lib64/python2.7/site-packages" >> my.pth
mv my.pth /opt/anaconda2/lib/python2.7/site-packages/
