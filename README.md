# Load-Balancing-5-replicas-with-nginx
This is a docker compose file that contains an nginx image and alpine image and I have connected them together.

![alpine](https://github.com/JohnTa15/Load-Balancing-5-replicas-with-nginx/blob/main/nginxshieldsalpine.png)

# NGiNX
*Nginx (pronounced "engine x" /ˌɛndʒɪnˈɛks/ EN-jin-EKS, stylized as NGINX) is a web server that can also be used as a reverse proxy, load balancer, mail proxy and HTTP cache. The software was created by Igor Sysoev and publicly released in 2004. Nginx is free and open-source software, released under the terms of the 2-clause BSD license. A large fraction of web servers use Nginx, often as a load balancer.*

[Docker hub link for nginx](https://hub.docker.com/_/nginx)

# Alpine
*Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is only 5 MB in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with Docker images.*

[Docker hub link for alpine](https://hub.docker.com/_/alpine)

# Docker Compose Setup

This Docker Compose setup includes an Nginx service and 5 Alpine replicas. It creates a web server using Nginx and connects it with the Alpine replicas. Each replica adds its own hostname to the index.html file.

## Prerequisites

- Docker Engine and Docker Compose are installed on your machine.

## Usage

1. Clone this repository or create a new directory and create a `docker-compose.yml` file with the following content:

```yaml
version: '3.8'
services:
  nginx:
    image: nginx:latest
    container_name: nginx
    restart: unless-stopped
    ports:
      - 8080:80
    volumes:
      - alpine_data:/usr/share/nginx/html
    command: sh -c 'printf "Welcome!<br><p>This is an nginx project that connects 5 alpine replicas index.html<br>Say hi guys!</p>" > /usr/share/nginx/html/index.html && nginx -g "daemon off;"'
    networks:
      - vlab

  alpine:
    image: alpine:latest
    restart: unless-stopped
    volumes:
      - alpine_data:/var/www/html
    deploy:
      resources:
        limits:
          memory: 200M
          cpus: '0.3'
      replicas: 5
      update_config:
        parallelism: 1
        delay: 10s
        order: stop-first
      restart_policy:
        condition: on-failure
    environment:
      - MESSAGE=Hello from Alpine
    command: sh -c 'mkdir -p /var/www/html && printf "<br>$$MESSAGE $$HOSTNAME<br>"  >> /var/www/html/index.html && tail -f /dev/null'
    networks:
      - vlab

volumes:
  alpine_data:

networks:
  vlab:



