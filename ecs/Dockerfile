FROM ubuntu:16.04

RUN apt-get update && apt-get -y install apache2
RUN echo "<h2>App v.3<h2><br>Build by terraform!<br>$(date)" > /var/www/html/index.html

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
