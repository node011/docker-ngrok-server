
# docker image for ngrok server

 docker image for ngrok server, used for intranet penetration.
 
 **You can directly download the attached ngrok client to use**
  
## Steps to use:
----------------
### 1. Get this image.
```
## Pull the image directly from the docker repository
docker pull jueying/ngrok-server

# Considering the slow access to docker hub in China, you can also build the image with the following command:
docker build -t jueying/ngrok-server https://github.com/jueying/docker-ngrok-server.git


docker build -t bowen/ngrok-server https://gitee.com/lliubowen_94/docker-ngrok-server.git

```

### 2. Run the container in the background.
```
docker run -d --name ngrok-server -p host http port:container http port -p host https port:container https port -p tunnel port:tunnel port jueying/ngrok-server domain name container http port host https port tunnel port

Example.
docker run -d --name ngrok-server -p 80:80 -p 443:443 -p 4443:4443 jueying/ngrok-server mydomain.cn 80 443 4443
```
The runtime takes some time to compile and generate the ngrok server and client, check the logs with the following code
```
docker logs -t -f --tail=100 ngrok-server
```
When the following logs appear, it means the startup is successful
! https://raw.githubusercontent.com/jueying/docker-ngrok-server/master/files/ngrokd_start.jpg

### 3. Copy the ngrok client from the container.
```
docker cp ngrok-server:/usr/local/ngrok/bin/ /root/ngrok/
```
The clients for win64, win32 and macos64 can be found in /tmp/bin/

### 4. ngrok configuration usage.

1. pan-resolve your independent domain name to docker's host IP
! https://raw.githubusercontent.com/jueying/docker-ngrok-server/master/files/domain.jpg

2. Copy the corresponding ngrok client from the container, and then create a configuration file ngrok.cfg in the same level directory, with the following content:
```
server_addr: "your domain:tunnel port"
trust_host_root_certs: false
```
Replace your_domain and tunnel_port with the values you set when you start the container
The windows platform is started with the following command.
```
ngrok.exe -subdomain=subdomain -config=ngrok.cfg local_port

. /ngrok -config=ngrok.cfg start-all

```
You can [download](https://github.com/jueying/docker-ngrok-server/blob/master/files/ngrok-client.rar) my ngrok client configuration in the files folder, then modify your domain name and replace it with your ngrok client.

---
## Caution.
---
1. Each time you start a new container, the matching ngrok server and client will be generated. So if you restart a new container, you need to re-copy the new ngrok client out. You don't need to update the ngrok client to start an existing container.
