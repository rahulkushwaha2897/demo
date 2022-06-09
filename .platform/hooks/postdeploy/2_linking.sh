#!/bin/bash 
#env=`/opt/elasticbeanstalk/bin/get-config environment |tr -s "," "\n" |grep "Server_Env" |cut -d ":" -f2 |sed 's/\"//g'`
#if [ $env == "Development" ];then
yum install stunnel -y
cd  /var/www/html/var
#mv classes/* /efs/storage/var/classes/
#mv config/* /efs/storage/var/config/
#linking var directory with efs storage directory
#linking /var/www/html/var/* files
rm -rf classes config versions
ln -s /efs/storage/var/classes .
ln -s /efs/storage/var/config .
ln -s /efs/storage/var/versions .
ln -s /efs/storage/var/tmp .
#ln -s /efs/storage/var/recyclebin .

#linking /var/www/html/web/var directory with efs storage directory
cd  /var/www/html/public/
rm -rf var
ln -s /efs/storage/web-var  var 

cd /var/www/html
#if [ -d "builds" ]
#then
#echo "Copying  build folders and files to classes"
sudo cp -rf builds/* var/classes/
