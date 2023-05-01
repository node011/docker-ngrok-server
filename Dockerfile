# 指定基础镜像
FROM centos:7

# 维护者信息
MAINTAINER bowen 544218160@qq.com

# 复制脚本文件到容器目录中
COPY entrypoint.sh /sbin/entrypoint.sh

# 运行指令
RUN chmod 755 /sbin/entrypoint.sh \
  && yum install -y epel-release \
  && yum install -y golang openssl \
  && curl -o /tmp/ngrok.tar.gz "https://gitee.com/lliubowen_94/docker-ngrok-server/raw/master/files/ngrok.tar.gz" \
  && tar -zxvf /tmp/ngrok.tar.gz -C /usr/local \
  && rm -rf /tmp/ngrok.tar.gz

RUN curl https://gitcode.net/cert/cn-acme.sh/-/raw/master/install.sh?inline=false | sh -s email=544218160@qq.com

# 允许指定的端口
EXPOSE 80/tcp 443/tcp 8081/tcp 8082/tcp

# 指定ngrok运行入口
ENTRYPOINT ["/sbin/entrypoint.sh"]
