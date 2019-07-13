FROM debian:stretch

RUN apt-get update
RUN apt-get install build-essential gettext-base -y
RUN apt-get install wget curl unp unzip ffmpeg -y

RUN apt-get install -y libpcre++-dev libssl-dev zlib1g-dev
RUN apt-get install -y php-fpm

RUN wget https://github.com/nginx/nginx/archive/release-1.16.0.zip -O /opt/nginx.zip
RUN wget https://github.com/arut/nginx-rtmp-module/archive/v1.2.1.zip -O /opt/rtmp.zip
RUN cd /opt/ && unp /opt/nginx.zip
RUN cd /opt && unp /opt/rtmp.zip

RUN cd /opt/nginx-release-1.16.0/ && ./auto/configure --add-module=/opt/nginx-rtmp-module-1.2.1/ && make && make install

COPY local.conf /local.conf
RUN mkdir /run/php

VOLUME /var/www/
EXPOSE 1935
EXPOSE 80

CMD /bin/bash -c "envsubst '${TWITCH_STREAMKEY}' < /local.conf > /usr/local/nginx/conf/nginx.conf && /usr/sbin/php-fpm7.0 && /usr/local/nginx/sbin/nginx -g 'daemon off;'"
