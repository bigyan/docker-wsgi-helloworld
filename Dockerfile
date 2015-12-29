FROM ubuntu:14.04
MAINTAINER Bigyan Adhikary bigyan.adhikary@gmail.com
RUN sed -i 's/http:\/\/archive/http:\/\/np.archive/g' /etc/apt/sources.list
RUN sed -i 's/http:\/\/np.archive.ubuntu.com\/ubuntu\/ trusty-security/http:\/\/archive.ubuntu.com\/ubuntu\/ trusty-security/g' /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN apt-get install python2.7 -y
RUN apt-get install python-pip -y
RUN apt-get install libapache2-mod-wsgi -y
RUN apt-get install nano vim curl wget -y
RUN pip install supervisor
#EXPOSE 80
ADD supervisord.conf /etc/supervisord.conf
RUN chmod 644 /etc/supervisord.conf
ADD index.html /var/www/html/index.html
RUN chmod 644 /var/www/html/index.html
ADD hello.wsgi /code/hello.wsgi
RUN chmod 644 /code/hello.wsgi
ADD wsgi.conf /etc/apache2/sites-available/wsgi.conf
RUN chmod 644 /etc/apache2/sites-available/wsgi.conf
RUN ln -s /etc/apache2/sites-available/wsgi.conf /etc/apache2/sites-enabled/wsgi.conf
CMD ["/usr/local/bin/supervisord","-n"]
