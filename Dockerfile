# 指定基础镜像
FROM centos:7

# 维护者信息
MAINTAINER bowen 544218160@qq.com

# 复制脚本文件到容器目录中
COPY entrypoint.sh /sbin/entrypoint.sh

COPY files/ngrok.tar.gz /tmp/ngrok.tar.gz
COPY files/go1.8.linux-amd64.tar.gz /tmp/go1.8.linux-amd64.tar.gz

# 运行指令
RUN tar -zxvf /tmp/ngrok.tar.gz -C /usr/local \
  && rm -rf /tmp/ngrok.tar.gz \
  && chmod 755 /sbin/entrypoint.sh \
  && yum install -y epel-release openssl \
  && tar -zxvf /tmp/go1.8.linux-amd64.tar.gz -C /usr/local \
  && rm -rf /tmp/go1.8.linux-amd64.tar.gz \
  && ln -s /usr/local/go/bin/go /usr/sbin/go \
  && ln -s /usr/local/go/bin/godoc /usr/sbin/godoc \
  && ln -s /usr/local/go/bin/gofmt /usr/sbin/gofmt \
  && echo "export GOROOT=/usr/local/go" >> /etc/profile \
  && echo "export PATH=$PATH:$GOROOT/bin" >> /etc/profile \
  && echo "export GOPROXY=https://mirrors.aliyun.com/goproxy/" >> /etc/profile \
  && source /etc/profile \
  && mkdir -p /usr/local/certs


# 允许指定的端口
EXPOSE 80/tcp 443/tcp 4443/tcp

# 指定ngrok运行入口
ENTRYPOINT ["/sbin/entrypoint.sh"]
