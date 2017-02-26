#!/bin/sh

### yum update ALL
#yum -y update

### iptables SELinux OFF
/etc/rc.d/init.d/iptables stop
chkconfig iptables off
chkconfig ip6tables off
cp -p /etc/selinux/config /etc/selinux/config.org
sed -i -e "s|^SELINUX=.*|SELINUX=disabled|" /etc/selinux/config

### Apache Install
yum -y install httpd
yum -y install mod_ssl

### PHP 5.4 Install
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sed -i -e "s/#baseurl=http/baseurl=http/g" /etc/yum.repos.d/epel.repo
sed -i -e "s/mirrorlist/#mirrorlist/g" /etc/yum.repos.d/epel.repo
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/epel.repo
yum install -y --enablerepo=epel,remi,remi-php54 php php-cli php-common php-devel php-gd \
php-intl php-mbstring php-pdo php-pear.noarch php-xml php-mcrypt

### Apache Setting
sed -i -e "/AddType text\/html \.php/i\AddType application\/x-httpd-php \.php \.html" /etc/httpd/conf.d/php.conf
chkconfig iptables on

### Service Start
service httpd start
