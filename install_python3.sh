#!/bin/bash
# Program
# 	在centos7中配置Python3的开发环境
# History
# 2020/09/20	cjm	first release

PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:"
export PATH

python3 --version

if [ $? == 0 ]; then
	echo "====Python3已安装，脚本运行结束===="
	python3 --version && pip3 --version
	exit 0
fi

echo "=====进入Python3安装流程====="
echo "+++++安装依赖+++++"
yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel

python_version="3.8.6"	# 安装版本，这里我写死了，也可以read获取

cd /usr/local/	# 安装目录
wget https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tar.xz

tar -xf Python-${python_version}.tar.xz

mkdir python3
mv Python-${python_version} python3
cd python3/Python-${python_version}

./configure --prefix=/usr/local/python3
make && make altinstall

if [ $? == 0 ]; then
	echo "=====Python3已安装成功====="
	echo "=====创建软链接====="
	ln -s /usr/local/python3/bin/python3.8 /usr/bin/python3
	ln -s /usr/local/python3/bin/pip3.8 /usr/bin/pip3
	python3 --version && pip3 --version
	if [ $? == 0 ]; then
		exit 0
	fi
fi
