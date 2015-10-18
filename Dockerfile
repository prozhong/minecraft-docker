# Minecraft 1.8.8 Dockerfile
# Server Version PaperSpigot

FROM ubuntu:14.04

MAINTAINER prozhong <prozhong@msn.cn>

#default directory for SPIGOT-server
ENV SPIGOT_HOME /data/minecraft

ADD spigot_init.sh /spigot_init.sh
RUN chmod +x /spigot_init.sh

# fast workaround
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openjdk-7-jre-headless wget
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN echo "root:get25565" | chpasswd 

# Make special user for minecraft to run in

RUN useradd -s /bin/bash -d /minecraft -m minecraft

# /data contains static files and database
VOLUME ["/data"]


# expose minecraft port
EXPOSE 25565
EXPOSE 22

#set default command
CMD /spigot_init.sh

