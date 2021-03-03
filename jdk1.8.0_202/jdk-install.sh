#!/bin/bash

installHome=/opt/devops
baseHome=/root/devops
projectName=jdk1.8.0_202
fileName=jdk-8u202-linux-x64.tar.gz
echo "#####################################################"
echo "###                    开始安装                    ###"
echo "#####################################################"
# 没有压缩包时,从网络下载
if [[ ! -f ${baseHome}/${projectName}/${fileName} ]]; then
    wget https://mirrors.huaweicloud.com/java/jdk/8u202-b08/jdk-8u202-linux-x64.tar.gz
fi
# 解压jdk
echo "解压jdk"

cd ${baseHome}/${projectName}
tar -zxf ${fileName} -C ${installHome}

# 配置java环境变量
echo "配置java环境变量"

cat >> /etc/profile.d/java.sh <<EOF
# 配置java环境变量
JAVA_HOME=${installHome}/${projectName}
PATH=\$JAVA_HOME/bin:\$PATH
export JAVA_HOME  PATH
EOF


# 刷新环境变量
echo "刷新环境变量"

sleep 1
source /etc/profile.d/java.sh
source /etc/profile

# 检查是否安装成功
echo "检查是否安装成功"

java -version > /dev/null 2>&1

if [[ $? -eq 0 ]]; then
    echo "#####################################################"
    echo "###                    安装成功                    ###"
    echo "#####################################################"
    echo ""
    echo "JAVA_HOME:$JAVA_HOME"
    echo "JAVA_VERSION:${projectName}"
    echo ""
    else
        echo "#######################安装失败,请执行卸载脚本重新安装########################"
fi

