FROM alpine:3.11

RUN apk add --no-cache mysql-client rsync openssh-server
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
