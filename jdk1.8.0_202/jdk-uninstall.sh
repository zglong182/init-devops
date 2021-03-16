#!/bin/bash

installHome=/opt/devops
baseHome=/root/devops
projectName=jdk1.8.0_202

# 删除环境变量
if [[ -f /etc/profile.d/java.sh ]]; then
    rm -rf /etc/profile.d/java.sh
    # 刷新环境变量
    source /etc/profile
fi
# 删除安装文件
if [[ -d ${installHome}/${projectName} ]]; then
    rm -rf ${installHome}/${projectName}
fi

sleep 1
source /etc/profile
echo "#######################卸载完成########################"


