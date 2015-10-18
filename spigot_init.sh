#!/bin/bash
if [ "$EULA" != "true" ]; then
  echo "*****************************************************************"
  echo "*****************************************************************"
  echo "** To be able to run spigot you need to accept minecrafts EULA **"
  echo "** see https://account.mojang.com/documents/minecraft_eula     **"
  echo "** include -e EULA=true on the docker run command              **"
  echo "*****************************************************************"
  echo "*****************************************************************"
fi

#only build if jar file does not exist
if [ ! -f $SPIGOT_HOME/spigot.jar ]; then 
  echo "Download PaperSpigot..."
  wget -q -c http://tcpr.ca/files/paperspigot/PaperSpigot-1.8.8-R0.1-SNAPSHOT-latest.jar -O $SPIGOT_HOME/spigot.jar
  #accept eula
  echo "eula=true" > $SPIGOT_HOME/eula.txt
fi

# chance owner to minecraft
chown -R minecraft.minecraft $SPIGOT_HOME/


cd $SPIGOT_HOME/
su - minecraft -c 'java -Xms256M -Xmx512M -jar spigot.jar'
echo "Started."
# fallback to root and run shell if spigot don't start/forced exit
bash

