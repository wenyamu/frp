FROM alpine:3.15

COPY frps /usr/bin/frps

COPY frps.toml /etc/frp/frps.toml

CMD ["frps", "-c", "/etc/frp/frps.toml"]