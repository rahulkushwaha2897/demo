#!/bin/bash

cd /home/ec2-user/
sudo curl -sS https://getcomposer.org/installer | sudo php
sudo mv composer.phar /usr/bin/composer
sudo composer self-update 1.7.2
yum install libjpeg-turbo.x86_64 libjpeg-turbo-devel.x86_64 libjpeg-turbo-static.x86_64 libjpeg-turbo-utils.x86_64 openjpeg.x86_64 openjpeg-devel.x86_64 openjpeg-libs.x86_64 turbojpeg.x86_64 turbojpeg-devel.x86_64 gd.x86_64 jasper.x86_64 -y
yum install inkscape.x86_64 inkscape-view.x86_64 -y
yum install libtiff.x86_64 libtiff-static.x86_64 -y
yum install libpng.x86_64 libpng-devel.x86_64 libpng-static.x86_64 pngcrush.x86_64 -y
yum install lcms-libs.x86_64 lcms2-utils.x86_64 lcms-devel.x86_64 lcms.x86_64 lcms2.x86_64 lcms2-devel.x86_64 -y
yum install librsvg2-devel.x86_64 librsvg2-tools.x86_64 librsvg2.x86_64 -y
yum install php-redis -y
yum install python3-pip.noarch -y
pip3 install html2text
yum install java-1.8.0-openjdk-headless.x86_64 -y
yum install dbus-glib.x86_64 -y
yum install cairo.x86_64 -y
yum install cups.x86_64 -y
yum install libwebp-devel.x86_64 libwebp.x86_64 libwebp-java.x86_64 libwebp-tools.x86_64 -y
yum install php-pecl-apcu-devel.noarch php-pecl-apcu.x86_64 -y
yum remove ImageMagick.x86_64 ImageMagick-devel.x86_64  ImageMagick-c++.x86_64 ImageMagick.x86_64 -y
yum install graphviz-devel.x86_64 graphviz-gd.x86_64 graphviz-graphs.x86_64 -y
yum install libexif-devel.x86_64 libexif.x86_64 -y


printf "/usr/local" |pecl install imagick 
#printf "no" |pecl install redis


#cd /home/ec2-user

#aws s3 cp s3://guardian-packages/ffmpeg-release-amd64-static.tar.xz .
#tar -xf ffmpeg-release-amd64-static.tar.xz
#cd ffmpeg-4.2.2-amd64-static
#mv ffmpeg ffprobe /usr/bin/

#cd /home/ec2-user
#aws s3 cp s3://guardian-packages/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz .
#tar -xf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
#cd wkhtmltox
#mv bin/wkhtmlto* /usr/bin/

cd /home/ec2-user
rm -rf ffmpeg* ImageMagick* wkhtmltox*

wget https://github.com/imagemin/zopflipng-bin/raw/master/vendor/linux/zopflipng -O /usr/bin/zopflipng
chmod 0755 /usr/bin/zopflipng
wget https://github.com/imagemin/pngcrush-bin/raw/master/vendor/linux/pngcrush -O /usr/bin/pngcrush
chmod 0755 /usr/bin/pngcrush
wget https://github.com/imagemin/jpegoptim-bin/raw/master/vendor/linux/jpegoptim -O /usr/bin/jpegoptim
chmod 0755 /usr/bin/jpegoptim
wget https://github.com/imagemin/pngout-bin/raw/master/vendor/linux/x64/pngout -O /usr/bin/pngout
chmod 0755 /usr/bin/pngout
wget https://github.com/imagemin/mozjpeg-bin/raw/master/vendor/linux/cjpeg -O /usr/bin/cjpeg
chmod 0755 /usr/bin/cjpeg
wget https://github.com/imagemin/advpng-bin/raw/master/vendor/linux/advpng -O /usr/bin/advpng
chmod 0755 /usr/bin/advpng
wget https://github.com/imagemin/mozjpeg-bin/raw/master/vendor/linux/cjpeg -O /usr/bin/cjpeg
chmod 0755 /usr/bin/cjpeg

cd /var/www/html/
cd builds/
mv * /efs/storage/var/classes/
cd /var/www/html/
rm -rf /var/www/html/builds
sudo php -d memory_limit=-1 /usr/bin/composer.phar install
sudo chown -R webapp:webapp *
sudo -u webapp php bin/console cache:clear
sudo -u webapp php bin/console cache:warmup
sudo php bin/console pimcore:deployment:classes-rebuild -d -c -q
sudo -u webapp php bin/console assets:install --relative --symlink web
sudo chown -R webapp:webapp *
sudo chmod -R 775 *
sudo service httpd restart restart
sudo service php-fpm restart

###Deployment Done
