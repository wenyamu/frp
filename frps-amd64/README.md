> https://github.com/fatedier/frp/releases/download/v0.58.1/frp_0.58.1_linux_amd64.tar.gz

## frp 服务端 docker 镜像
> frps 服务端版本 0.58.1
> 
> 适用于CPU架构 amd64

## 创建镜像命令
```
docker build -t frps:0.58.1 .
```

## frps.toml 公网服务端配置文件
```frps.toml
bindPort = 7000
```

## frpc.toml 局域网客户端配置文件详解
```frpc.toml
#################################
# 公网服务器开启端口: 6080、7000 #
#################################

# 官网 https://gofrp.org/zh-cn/docs/overview/

# 公网服务器ip
serverAddr = "88.218.238.208"
# 服务端frps与客户端frpc绑定进行通信的端口(此端口只作为两者通信用，具体应用还需要开启相应的端口)
serverPort = 7000

################################# frp实现的负载均衡
### 注意：
### 一般情况下，每个 tcp 代理的 remotePort 不能重复；但是负载均衡时，要一样
### group 值相同的代理，会以轮询的方式实现负载均衡
### groupKey 为可选项，如果有，则值必须要相同
### 同一台服务器对应多个客户端设备时 name 值不能重复，必须唯一
### localIP 值也可以写成设备的局域网ip，比如：192.168.1.121
### http://88.218.238.208:6081 --->>> 127.0.0.1:80(device001)、127.0.0.1:80(device002)
### 查看效果时，要有耐心，多刷新几次（快速点击F5键），不然看不到负载均衡切换效果

#### 客户端设备001的配置项
[[proxies]]
name = "device001"
type = "tcp"
localIP = "127.0.0.1"
localPort = 80
## 原理 http://88.218.238.208:6080 --->>> 127.0.0.1:80(device001)
remotePort = 6080
loadBalancer.group = "web"
#loadBalancer.groupKey = "str123"

################ 以下是另一台客户端设备的配置项
################ 如果想在同一台设备使用多个配置
################ localPort 需要指定不同端口
#### 客户端设备002的配置项
[[proxies]]
name = "device002"
type = "tcp"
localIP = "127.0.0.1"
localPort = 80
## 原理 http://88.218.238.208:6080 --->>> 127.0.0.1:80(device002)
remotePort = 6080
loadBalancer.group = "web"
#loadBalancer.groupKey = "str123"
```
