# Dockerfile to build a Bungeecord server

FROM centos:latest

MAINTAINER Christophe Roux (gloppasglop)

# Install the required components.
RUN yum -y update; yum clean all
RUN yum -y install \ 
    java-1.8.0-openjdk-headless \
    tmux \
    wget



RUN mkdir /minecraft && wget -O /minecraft/minecraft_server.jar https://s3.amazonaws.com/Minecraft.Download/versions/1.8.8/minecraft_server.1.8.8.jar


COPY eula.txt /minecraft/eula.txt
COPY server.properties /minecraft/server.properties
COPY mc /minecraft/mc


RUN groupadd -r mc -g 1001 && \
    useradd -r -g mc -u 1001 -d /minecraft mc && \
    chown -R mc:mc /minecraft/ && \
    chmod +x /minecraft/mc && \
    echo "set -g status off" > ~mc/.tmux.conf

# Expose the recommended ports.
EXPOSE 25565

USER mc
WORKDIR /minecraft


CMD ["/minecraft/mc","start"]
