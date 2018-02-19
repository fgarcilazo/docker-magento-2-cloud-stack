FROM centos:latest
RUN groupadd -g 2000 apache && useradd -d /home/apache -u 2000 -g 2000 apache

RUN yum clean all && yum -y install yum-utils && yum makecache && yum -y install epel-release && rpm -ihv https://mirror.webtatic.com/yum/el7/webtatic-release.rpm && yum -y update && yum -y install epel-release
RUN yum -y install php71w php71w-{bcmath,cli,common,devel,fpm,gd,interbase,intl,mbstring,mcrypt,mysqlnd,opcache,pear,pdo,process,soap,tidy,xml,zip,xsl,} php71w-pecl-{mongodb,redis}
ADD pool.conf /etc/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm", "-F"]
