yum -y update

yum -y install httpd

systemctl enable httpd
systemctl start httpd

systemctl disable firewalld
systemctl stop firewalld
