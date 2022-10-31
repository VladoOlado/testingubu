#!/bin/bash


clear
clear

echo "
################################
#      Subsonic Installer      #
#    www.server-verstehen.de   #
################################
# 1. Subsonic installieren     #
# 2. Subsonic deinstallieren   #
# 3. Subsonic Premium Patch    #
# 4. Subsonic HTTPS aktivieren #
################################";

    read -p "Geben Sie eine Zahl ein: " setup

    apt-get install sudo -y

        if [ $setup = "1" ]; then

            clear
            echo "Download Subsonic..."
            sleep 1

            wget http://update.rawnetworks.eu/2022/subsonic/download/subsonic-6.1.6.deb

            echo "Installiere Java 8..."

            apt install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common -y
            wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
            add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
            apt update
            apt install adoptopenjdk-8-hotspot -y
            sudo apt install openjdk-8-jre-headless -y

            echo "Installiere Subsonic..."

            sudo dpkg -i subsonic-6.1.6.deb

            sleep 2

            clear

            read -p "Installation abgeschlossen! Zugang: User: admin Passwort: admin - http://yourserverip:4040"


        fi

         if [ $setup = "2" ]; then

            clear

            echo "Deinstalliere Subsonic..."

            sudo apt-get remove subsonic -y
            sudo apt autoremove -y
            sudo apt purge -y

            sleep 2

            clear

            read -p "Deinstallation abgeschlossen!"


        fi

        if [ $setup = "3" ]; then

        clear

        echo "Patching Subsonic..."
        sleep 2

        printf "
127.0.0.1 www.subsonic.org
127.0.0.1 subsonic.org
127.0.0.1 premium.subsonic.org
" >> /etc/hosts

        sudo service subsonic restart

        echo "Key has been generated: E-Mail: foo@bar.com Key: f3ada405ce890b6f8204094deb12d8a8"




        fi

         if [ $setup = "4" ]; then

             clear
            
            read -p "Enter the HTTPS Port to listen for requests: " https

            printf "

SUBSONIC_ARGS='--port=4040 --https-port=$https --max-memory=256'

SUBSONIC_USER=root
" > /etc/default/subsonic

        sudo service subsonic restart

            echo "Finish! HTTP Port: 4040 - HTTPS Port: $https";
        

        fi