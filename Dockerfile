FROM alpine:3.4

MAINTAINER hailongz "hailongz@qq.com"

ENV NGINX_VERSION 1.10.1-r1

RUN apk add --update nginx-lua=$NGINX_VERSION bash && \
    rm -rf /var/cache/apk/* 

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir /run/nginx

VOLUME ["/var/log/nginx"]

WORKDIR /etc/nginx

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

COPY ./conf.d conf.d

COPY ./lib/lua /lib/lua

COPY ./nginx.conf nginx.conf

COPY ./@app /@app
