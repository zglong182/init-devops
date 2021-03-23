#!/bin/bash

installHome=/opt/devops
baseHome=/root/devops
projectName=apache-maven-3.6.3
fileName=apache-maven-3.6.3-bin.tar.gz

echo "#####################################################"
echo "###                    开始安装                    ###"
echo "#####################################################"
# 没有压缩包时,从网络下载
if [[ ! -f ${baseHome}/${projectName}/${fileName} ]]; then
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
fi
# 解压maven
echo "解压maven"

cd ${baseHome}/${projectName}
tar -zxf ${fileName} -C ${installHome}


# 配置maven环境变量
echo "配置maven环境变量"

cat >> /etc/profile.d/mvn.sh <<EOF
# 配置java环境变量
MAVEN_HOME=${installHome}/${projectName}
PATH=\$MAVEN_HOME/bin:\$PATH
export MAVEN_HOME  PATH
EOF


# 刷新环境变量
echo "刷新环境变量"

sleep 1
source /etc/profile.d/java.sh
sleep 1
source /etc/profile

# 检查是否安装成功
echo "检查是否安装成功"

mvn -version > /dev/null 2>&1

if [[ $? -eq 0 ]]; then
    echo "#####################################################"
    echo "###                    安装成功                    ###"
    echo "#####################################################"
    echo ""
    echo "JAVA_HOME:$MAVEN_HOME"
    echo "MAVEN_VERSION:${projectName}"
    echo ""
    else
        echo "#######################安装失败,请执行卸载脚本重新安装########################"
fi
