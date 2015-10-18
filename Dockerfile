# Minecraft 1.8.8 Dockerfile
# Server Version PaperSpigot

FROM ubuntu:14.04

MAINTAINER prozhong <prozhong@msn.cn>

#default directory for SPIGOT-server
ENV SPIGOT_HOME /data/minecraft

ADD sources.list /etc/apt/sources.list
ADD spigot_init.sh /spigot_init.sh
RUN chmod +x /spigot_init.sh

# fast workaround
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openjdk-7-jre-headless wget
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN echo "root:get25565" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Make special user for minecraft to run in

RUN useradd -s /bin/bash -d /minecraft -m minecraft

# /data contains static files and database
VOLUME ["/data"]


# expose minecraft port
EXPOSE 25565
EXPOSE 22

#set default command
CMD ["/usr/sbin/sshd", "-D"]
CMD /spigot_init.sh

