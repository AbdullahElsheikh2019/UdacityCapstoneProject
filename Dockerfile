FROM php:5.6-apache
MAINTAINER Abdullah Elsheikh <abdullahelsheikh@gmail.com>


COPY index.html /var/www/
COPY index.html /var/www/html/

EXPOSE 80

