# Minecraft 1.8.8 Dockerfile
# Server Version PaperSpigot

FROM ubuntu:14.04

MAINTAINER prozhong <prozhong@msn.cn>

RUN mkdir /data
ADD sources.list /etc/apt/sources.list
#ADD spigot_init.sh /spigot_init.sh
ADD eula.txt /data/eula.txt
ADD ops.json /data/ops.json
ADD server.properties /data/server.properties
#RUN chmod +x /spigot_init.sh

# fast workaround
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openjdk-7-jre-headless wget

# Download Minecraft Server components

RUN wget -q https://s3.amazonaws.com/Minecraft.Download/versions/1.8.8/minecraft_server.1.8.8.jar

# Download Minecraft Server Config

RUN mkdir /data && \
    cd /data && \
    wget -q https://raw.githubusercontent.com/prozhong/minecraft-docker/master/server.properties
    
# Make special user for minecraft to run in

RUN useradd -s /bin/bash -d /data -m minecraft

# /data contains static files and database
VOLUME ["/data"]
WORKDIR /data
#default directory for SPIGOT-server
ENV SPIGOT_HOME /data

# expose minecraft port
EXPOSE 25565

#set default command
#CMD ["/usr/sbin/sshd", "-D"]
CMD echo eula=true > /data/eula.txt &&java -Xms256M -Xmx512M -jar /minecraft_server.1.8.8.jar

