#!/bin/bash


installHome=/opt/devops
baseHome=/root/devops
projectName=apache-maven-3.6.3
fileName=apache-maven-3.6.3-bin.tar.gz

# 删除环境变量
if [[ -f /etc/profile.d/mvn.sh ]]; then
    rm -rf /etc/profile.d/mvn.sh
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


