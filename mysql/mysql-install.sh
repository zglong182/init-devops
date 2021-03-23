  #!/bin/bash

# 默认安装目录
installHome=/opt/devops
# 默认安装文件下载目录
baseHome=/root/devops
# 默认版本
projectName=mysql
# 默认版本文件名
fileName=mysql-5.7.33-el7-x86_64
# 默认版本下载地址
downLoadUrl=https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/MySQL-5.7/mysql-5.7.33-el7-x86_64.tar.gz

# 检查安装文件是否存在,不存在则下载
if [[ ! -f ${baseHome}/${projectName}/${fileName}.tar.gz ]]; then
	wget -P ${baseHome}/${projectName} ${downLoadUrl}
fi

# 检查是否安装过mysql或mariadb,若安装过,则卸载
rpm -qa|grep mariadb |xargs rpm -e --nodeps

# 检查/etc/my.cnf,若存在,则删除

if [[ -f /etc/my.cnf ]]; then
    rm -rf /etc/my.cnf
fi

# 检查用户和用户组,若不存在,则创建
cat /etc/group |grep mysql > /dev/null 2>&1

if [[ ! $? -eq 0 ]]; then
    groupadd mysql
fi

id mysql > /dev/null  2>&1
if [[ ! $? -eq 0 ]]; then
    useradd mysql -g mysql
fi


# 解压移动
cd ${baseHome}/${projectName}
tar -zxf ${fileName}.tar.gz
mv mysql-5.7.33-el7-x86_64 mysql
# 创建数据目录,并设置所有者和所有组
mkdir ${baseHome}/${projectName}/mysql/data
chown -R mysql.mysql ${baseHome}/${projectName}/mysql
mv ${baseHome}/${projectName}/mysql ${installHome}
# 修改配置文件,并创建配置文件
sed -i '46,47d' ${installHome}/mysql/support-files/mysql.server
sed -i '46i basedir='${installHome}'/mysql' ${installHome}/mysql/support-files/mysql.server
sed -i '47i datadir='${installHome}'/mysql/data' ${installHome}/mysql/support-files/mysql.server

# 初始化
${installHome}/mysql/bin/mysqld --initialize  --user=mysql --basedir=${installHome}/mysql --datadir=${installHome}/mysql/data > ${baseHome}/mysql-5.7.33/init.log
# 注册为系统服务,并设置自启
cp ${installHome}/mysql/support-files/mysql.server /etc/init.d/mysqld
systemctl enable mysqld
# 创建链接
ln -s ${installHome}/mysql/bin/mysql /usr/bin
# 启动MySQL,并登录测试
/etc/init.d/mysqld start
# 修改密码,开启远程访问

