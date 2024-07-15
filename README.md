## 创建镜像
> 变量名必须大写
>
> `VERSION=0.58.1` 镜像版本
> 
> `ARCH=amd64` 系统架构，amd64 或 arm64
> 
> `APP=frps` 镜像类型，服务端frps 或 客户端frpc

```sh
docker build \
--build-arg VERSION=0.58.1 \
--build-arg ARCH=amd64 \
--build-arg APP=frps \
-t my_image:tag .
```

## 或者
> `dpkg --print-architecture` 输出 amd64 或 arm64 或 musl-linux-amd64 或 musl-linux-arm64 等形式的字符串
> 
> `awk -F '-' '{print $NF}'` 以'-'连接符分隔字符串，并返回最后一个值
>
> `echo "musl-linux-amd64" | awk -F '-' '{print $NF}'` 返回 `amd64`
>
> `echo "amd64" | awk -F '-' '{print $NF}'` 也是返回 `amd64`

```sh
docker build \
--build-arg VERSION=0.58.1 \
--build-arg ARCH=$(echo $(dpkg --print-architecture) | awk -F '-' '{print $NF}') \
--build-arg APP=frps \
-t my_image:tag .
```

## 或者，加上http代理，加速创建镜像
> --build-arg HTTPS_PROXY="http://192.168.1.3:1080" --build-arg HTTP_PROXY="http://192.168.1.3:1080"

```sh
docker build \
--build-arg HTTPS_PROXY="http://192.168.1.3:1080" \
--build-arg HTTP_PROXY="http://192.168.1.3:1080" \
--build-arg VERSION=0.58.1 \
--build-arg ARCH=$(echo $(dpkg --print-architecture) | awk -F '-' '{print $NF}') \
--build-arg APP=frps \
-t my_image:tag .
```
