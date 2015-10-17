FROM prozhong/ubuntu-openjdk-7

MAINTAINER prozhong <prozhong@msn.cn>

#non-interactive installation
ENV DEBIAN_FRONTEND noninteractive

#default directory for SPIGOT-server
ENV SPIGOT_HOME /minecraft

ADD spigot_init.sh /spigot_init.sh

RUN chmod +x /spigot_init.sh

# fast workaround 
RUN apt-get update && apt-get install -y wget git && apt-get clean all
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN echo "root:get25565" | chpasswd 

# Make special user for minecraft to run in

RUN useradd -s /bin/bash -d /minecraft -m minecraft

# expose minecraft port
EXPOSE 25565
EXPOSE 22

#set default command
CMD /spigot_init.sh

