# Load-Balancing-5-replicas-with-nginx
This is a docker compose file that contains an nginx image and alpine image and I have connected them together.

![alpine](https://github.com/JohnTa15/Load-Balancing-5-replicas-with-nginx/blob/main/alpine.png)

# Nginx
*Nginx (pronounced "engine x" /ˌɛndʒɪnˈɛks/ EN-jin-EKS, stylized as NGINX) is a web server that can also be used as a reverse proxy, load balancer, mail proxy and HTTP cache. The software was created by Igor Sysoev and publicly released in 2004. Nginx is free and open-source software, released under the terms of the 2-clause BSD license. A large fraction of web servers use Nginx, often as a load balancer.*

[Docker hub link for nginx](https://hub.docker.com/_/nginx)

# Alpine
*Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is only 5 MB in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with Docker images.*

[Docker hub link for alpine](https://hub.docker.com/_/alpine)

# Docker Compose Setup

This Docker Compose setup deploys an Nginx service and multiple replicas of an Alpine service.

## Nginx Service
```
 services:
  nginx:
    image: nginx:latest
    container_name: nginx
    restart: unless-stopped
    ports:
      - 8080:80
    volumes:
      - alpine_data:/usr/share/nginx/html
```
The Nginx service uses the latest Nginx image, maps port 8080 on the host to port 80 in the container, and mounts the `alpine_data` volume to the `/usr/share/nginx/html` directory.

## Alpine Service

```
  alpine:
    image: alpine:latest
    restart: unless-stopped
    volumes:
      - alpine_data:/var/www/html
    deploy:
      replicas: 5
      update_config:
        parallelism: 1
        delay: 10s
      restart_policy:
        condition: on-failure 
      environment:
        - MESSAGE=Hello from Alpine
      command: sh -c 'mkdir -p /var/www/html/ && echo $$MESSAGE-$(HOSTNAME: - 1) > /var/www/html/index.html && tail -f /dev/null'
      hostname: alpine-$${HOSTNAME: -1} 
 ```

The Alpine service uses the latest Alpine image, sets the restart policy to `unless-stopped`, mounts the `alpine_data` volume to the `/var/www/html` directory, and deploys 5 replicas. Each replica will have a unique hostname and generate a custom message in its `index.html` file. The command executed in each replica creates the necessary directory, echoes the message with the hostname, and keeps the container running by tailing the `/dev/null` file.

## Volumes

- `alpine_data`

This volume is shared between the Nginx and Alpine services. It allows Nginx to serve the files generated by the Alpine replicas.

This Docker Compose setup creates an Nginx service as a reverse proxy and multiple replicas of an Alpine service. The replicas serve customized messages, and Nginx directs the incoming traffic to these replicas.


