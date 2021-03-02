#!/bin/bash
installHome=/opt/devops
baseHome=/root/devops
projectName=mysql-5.7.33
fileName=mysql-5.7.33-el7-x86_64.tar.gz


# 停止服务
systemctl stop mysqld
# 关闭自启
systemctl disable mysqld
# 删除服务
rm -rf /etc/init.d/mysqld
# 删除链接
rm -rf /usr/bin/mysql
# 删除安装目录
rm -rf ${installHome}/mysql
