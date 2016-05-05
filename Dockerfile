FROM alpine:latest

ADD scripts/* /usr/local/bin/

#Use dash instead busybox
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk-install tini@community && \
    apk-install dash@testing && rm /bin/sh ; ln -s /bin/dash /bin/sh; mkdir -p /app /etc/skel

ADD localtime /etc/localtime

VOLUME /etc/skel

WORKDIR /app

ENTRYPOINT ["/usr/bin/tini","-g","--"]

CMD [ "start.sh" ] 
