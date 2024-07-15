FROM alpine:3.15

# 定义变量，在创建时指定变量值
ARG VERSION
ARG ARCH
ARG APP

# 如果创建镜像时未指定版本，则默认为 0.58.1
ENV FRP_VERSION=${VERSION:-0.58.1}

# 系统架构，例如：amd64 或 arm64
ENV CPU_ARCH=$ARCH

# 指定生成什么类型的镜像，例如：服务端镜像 frps 或 客户端镜像 frpc
ENV FRP_APP=$APP

RUN apk add --no-cache curl \
    && curl -L "https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${CPU_ARCH}.tar.gz" -o frp.tar.gz \
    && mkdir -p /tmp/frp_files \
    && tar -zxC /tmp/frp_files -f frp.tar.gz \
    && rm frp.tar.gz \
    && mv /tmp/frp_files/frp_${FRP_VERSION}_linux_${CPU_ARCH}/${FRP_APP} /usr/bin/${FRP_APP} \
    && mkdir -p /etc/frp \
    && mv /tmp/frp_files/frp_${FRP_VERSION}_linux_${CPU_ARCH}/${FRP_APP}.toml /etc/frp/${FRP_APP}.toml \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && apk del curl

WORKDIR /etc/frp/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
