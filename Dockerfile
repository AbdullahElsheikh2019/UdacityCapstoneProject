FROM nginx
MAINTAINER Abdullah Elsheikh <abdullahelsheikh@gmail.com>


COPY index.html /usr/share/nginx/html/
COPY index.html /var/www/html/

EXPOSE 80

