FROM alpine:3.15

COPY frpc /usr/bin/frpc

COPY frpc.toml /etc/frp/frpc.toml

CMD ["frpc", "-c", "/etc/frp/frpc.toml"]