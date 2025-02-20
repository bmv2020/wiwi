#!/bin/bash

# Written By: wizwiz

if [ "$(id -u)" -ne 0 ]; then
    echo -e "\033[33mPlease run as root\033[0m"
    exit
fi

wait

echo -e "\e[32m
██     ██ ██ ██     ██ ██     ██   ██ ██    ██ ██ 
██     ██ ██ ██     ██ ██      ██ ██  ██    ██ ██ 
██  █  ██ ██ ██  █  ██ ██       ███   ██    ██ ██ 
██ ███ ██ ██ ██ ███ ██ ██      ██ ██  ██    ██ ██ 
 ███ ███  ██  ███ ███  ██     ██   ██  ██████  ██ 
\033[0m"
echo -e "    \e[31mTelegram Channel: \e[34m@wizwizch\033[0m | \e[31mTelegram Group: \e[34m@wizwizdev\033[0m\n"

#sleep
echo -e "\e[32mInstalling WizWiz script ... \033[0m\n"
sleep 2

# installing Packages
apt install apache2 apache2-utils -y
systemctl enable apache2
systemctl start apache2
systemctl status apache2

apt-get install mariadb-server -y
systemctl enable mariadb
systemctl start mariadb

apt install php php-cli php-mysql libapache2-mod-php php-gd php-xml php-curl php-common -y

echo -e "\n\e[92mPackages Installed Continuing ...\033[0m\n"



echo -e "\n\e[92m Setting Up UFW...\033[0m\n"

ufw allow 'Apache'

sudo systemctl restart apache2

echo -e "\n\e[92mInstalling ...\033[0m\n"

sleep 1

sudo apt-get install -y git
sudo apt-get install -y wget
sudo apt-get install -y unzip
sudo apt install curl -y

wait

git clone https://github.com/bmv2020/wiwi.git /var/www/html/wizwizxui-timebot
sudo chown -R www-data:www-data /var/www/html/wizwizxui-timebot/
sudo chmod -R 755 /var/www/html/wizwizxui-timebot/
echo -e "\n\033[33mWizWiz config and script have been installed successfully\033[0m"

wait
    
    
destination_dir=$(find /var/www/html -type d -name "*wizpanel*" | head -n 1)
    
if [ -z "$destination_dir" ]; then
    RANDOM_NUMBER=$(( RANDOM % 10000000 + 1000000 ))
    mkdir "/var/www/html/wizpanel${RANDOM_NUMBER}"
    echo "Directory created: wizpanel${RANDOM_NUMBER}"
    echo "Folder created successfully!"
else
    echo "Folder already exists."
fi
   
 destination_dir=$(find /var/www/html -type d -name "*wizpanel*" | head -n 1)

 cd /var/www/html/
 wget -O wizwizpanel.zip https://github.com/bmv2020/wiwi/releases/download/7.5.3/wizwizpanel.zip

 file_to_transfer="/var/www/html/wizwizpanel.zip"
 destination_dir=$(find /var/www/html -type d -name "*wizpanel*" | head -n 1)

 if [ -z "$destination_dir" ]; then
   echo "Error: Could not find directory containing 'wiz' in '/var/www/html'"
   exit 1
 fi

 mv "$file_to_transfer" "$destination_dir/" && yes | unzip "$destination_dir/wizwizpanel.zip" -d "$destination_dir/" && rm "$destination_dir/wizwizpanel.zip" && sudo chmod -R 755 "$destination_dir/" && sudo chown -R www-data:www-data "$destination_dir/" 


wait


if [ ! -d "/root/confwizwiz" ]; then

    sudo mkdir /root/confwizwiz
    
    sleep 1
    
    touch /root/confwizwiz/dbrootwizwiz.txt
    sudo chmod -R 777 /root/confwizwiz/dbrootwizwiz.txt
    sleep 1
    
    randomdbpasstxt=$(openssl rand -base64 10 | tr -dc 'a-zA-Z0-9' | cut -c1-8)

    ASAS="$"

    echo "${ASAS}user = 'root';" >> /root/confwizwiz/dbrootwizwiz.txt
    echo "${ASAS}pass = '${randomdbpasstxt}';" >> /root/confwizwiz/dbrootwizwiz.txt
    echo "${ASAS}path = '${RANDOM_NUMBER}';" >> /root/confwizwiz/dbrootwizwiz.txt
    
    sleep 1

    passs=$(cat /root/confwizwiz/dbrootwizwiz.txt | grep '$pass' | cut -d"'" -f2)
    userrr=$(cat /root/confwizwiz/dbrootwizwiz.txt | grep '$user' | cut -d"'" -f2)

    sudo mysql -u $userrr -p$passs -e "alter user '$userrr'@'localhost' identified with mysql_native_password by '$passs';FLUSH PRIVILEGES;"

    echo "SELECT 1" | mysql -u$userrr -p$passs 2>/dev/null

    echo "Folder created successfully!"
else
    echo "Folder already exists."
fi

clear

echo " "
echo -e "\e[32m
██     ██ ██ ███████ ██     ██ ██ ███████     ███████ ███████ ██      
██     ██ ██    ███  ██     ██ ██    ███      ██      ██      ██      
██  █  ██ ██   ███   ██  █  ██ ██   ███       ███████ ███████ ██      
██ ███ ██ ██  ███    ██ ███ ██ ██  ███             ██      ██ ██      
 ███ ███  ██ ███████  ███ ███  ██ ███████     ███████ ███████ ███████ 
\033[0m\n"

read -p "Enter the domain: " domainname
if [ "$domainname" = "" ]; then

echo -e "\n\033[91mPlease wait ...\033[0m\n"
sleep 3

echo -e "\e[36mNothing was registered for the domain.\033[0m\n"

echo -e "\n\033[0m Good Luck Baby\n"

else
# variables
DOMAIN_NAME="$domainname"
# WILDCARD_DOMAIN="*.$wildcarddomain"

# update cron
PATHS=$(cat /root/confwizwiz/dbrootwizwiz.txt | grep '$path' | cut -d"'" -f2)
(crontab -l ; echo "* * * * * curl https://${DOMAIN_NAME}/wizwizxui-timebot/settings/messagewizwiz.php >/dev/null 2>&1") | sort - | uniq - | crontab -
(crontab -l ; echo "* * * * * curl https://${DOMAIN_NAME}/wizwizxui-timebot/settings/rewardReport.php >/dev/null 2>&1") | sort - | uniq - | crontab -
(crontab -l ; echo "* * * * * curl https://${DOMAIN_NAME}/wizwizxui-timebot/settings/warnusers.php >/dev/null 2>&1") | sort - | uniq - | crontab -
(crontab -l ; echo "* * * * * curl https://${DOMAIN_NAME}/wizpanel${PATHS}/backupnutif.php >/dev/null 2>&1") | sort - | uniq - | crontab -

echo -e "\n\e[92m Setting Up Cron...\033[0m\n"

# Allow HTTP and HTTPS traffic
echo -e "\n\033[1;7;31mAllowing HTTP and HTTPS traffic...\033[0m\n"
sudo ufw allow 80
sudo ufw allow 443



wait

echo " "

ROOT_PASSWORD=$(cat /root/confwizwiz/dbrootwizwiz.txt | grep '$pass' | cut -d"'" -f2)
ROOT_USER="root"
echo "SELECT 1" | mysql -u$ROOT_USER -p$ROOT_PASSWORD 2>/dev/null


if [ $? -eq 0 ]; then

wait

    randomdbpass=$(openssl rand -base64 10 | tr -dc 'a-zA-Z0-9' | cut -c1-8)

    randomdbdb=$(openssl rand -base64 10 | tr -dc 'a-zA-Z' | cut -c1-8)

    if [[ $(mysql -u root -p$ROOT_PASSWORD -e "SHOW DATABASES LIKE 'wizwiz'") ]]; then
        clear
        echo -e "\n\e[91mYou have already created the database\033[0m\n"
    else
        dbname=wizwiz
        clear
        echo -e "\n\e[32mPlease enter the database username!\033[0m"
        printf "[+] Default user name is \e[91m${randomdbdb}\e[0m ( let it blank to use this user name ): "
        read dbuser
        if [ "$dbuser" = "" ]; then
        dbuser=$randomdbdb
        fi

        echo -e "\n\e[32mPlease enter the database password!\033[0m"
        printf "[+] Default user name is \e[91m${randomdbpass}\e[0m ( let it blank to use this user name ): "
        read dbpass
        if [ "$dbpass" = "" ]; then
        dbpass=$randomdbpass
        fi

        mysql -u root -p$ROOT_PASSWORD -e "CREATE DATABASE $dbname;" -e "CREATE USER '$dbuser'@'%' IDENTIFIED WITH mysql_native_password BY '$dbpass';GRANT ALL PRIVILEGES ON * . * TO '$dbuser'@'%';FLUSH PRIVILEGES;" -e "CREATE USER '$dbuser'@'localhost' IDENTIFIED WITH mysql_native_password BY '$dbpass';GRANT ALL PRIVILEGES ON * . * TO '$dbuser'@'localhost';FLUSH PRIVILEGES;"
        
        echo -e "\n\e[95mDatabase Created.\033[0m"
        
        wait
        


        printf "\n\e[33m[+] \e[36mBot Token: \033[0m"
        read YOUR_BOT_TOKEN
        printf "\e[33m[+] \e[36mChat id: \033[0m"
        read YOUR_CHAT_ID
        printf "\e[33m[+] \e[36mDomain: \033[0m"
        read YOUR_DOMAIN
        echo " "
        if [ "$YOUR_BOT_TOKEN" = "" ] || [ "$YOUR_DOMAIN" = "" ] || [ "$YOUR_CHAT_ID" = "" ]; then
           exit
        fi

        ASAS="$"
	
        wait

        sleep 1
        
        file_path="/var/www/html/wizwizxui-timebot/baseInfo.php"
        
        if [ -f "$file_path" ]; then
          rm "$file_path"
          echo -e "File deleted successfully."
        else
          echo -e "File not found."
        fi
        
        sleep 2
        
        # print file
        echo -e "<?php" >> /var/www/html/wizwizxui-timebot/baseInfo.php
        echo -e "error_reporting(0);" >> /var/www/html/wizwizxui-timebot/baseInfo.php
        echo -e "${ASAS}botToken = '${YOUR_BOT_TOKEN}';" >> /var/www/html/wizwizxui-timebot/baseInfo.php
        echo -e "${ASAS}dbUserName = '${dbuser}';" >> /var/www/html/wizwizxui-timebot/baseInfo.php
        echo -e "${ASAS}dbPassword = '${dbpass}';" >> /var/www/html/wizwizxui-timebot/baseInfo.php
        echo -e "${ASAS}dbName = '${dbname}';" >> /var/www/html/wizwizxui-timebot/baseInfo.php
        echo -e "${ASAS}botUrl = 'https://${YOUR_DOMAIN}/wizwizxui-timebot/';" >> /var/www/html/wizwizxui-timebot/baseInfo.php
        echo -e "${ASAS}admin = ${YOUR_CHAT_ID};" >> /var/www/html/wizwizxui-timebot/baseInfo.php
        echo -e "?>" >> /var/www/html/wizwizxui-timebot/baseInfo.php

        sleep 1

        curl -F "url=https://${YOUR_DOMAIN}/wizwizxui-timebot/bot.php" "https://api.telegram.org/bot${YOUR_BOT_TOKEN}/setWebhook"
        MESSAGE="✅ The wizwiz bot has been successfully installed! @wizwizch"
        curl -s -X POST "https://api.telegram.org/bot${YOUR_BOT_TOKEN}/sendMessage" -d chat_id="${YOUR_CHAT_ID}" -d text="$MESSAGE"
        
        
        sleep 1
        
        url="https://${YOUR_DOMAIN}/wizwizxui-timebot/createDB.php"
        curl $url
        
        sleep 1
        
        sudo rm -r /var/www/html/wizwizxui-timebot/webpanel
	    sudo rm -r /var/www/html/wizwizxui-timebot/install
	    sudo rm /var/www/html/wizwizxui-timebot/createDB.php
            
        clear
        
        echo " "
        
        echo -e "\e[100mDatabase information:\033[0m"
        echo -e "\e[33mDatabase name: \e[36m${dbname}\033[0m"
        echo -e "\e[33mDatabase username: \e[36m${dbuser}\033[0m"
        echo -e "\e[33mDatabase password: \e[36m${dbpass}\033[0m"
        echo " "
        echo -e "\e[100mwizwiz panel:\033[0m"
        echo -e "\e[33maddres: \e[36mhttps://${YOUR_DOMAIN}/wizpanel${RANDOM_NUMBER}\033[0m"
        echo -e "\e[33musername panel: \e[36madmin\033[0m"
        echo -e "\e[33mpassword panel: \e[36madmin\033[0m\n"
        
        wait
        
        echo -e "Good Luck Baby! \e[94mThis project is for free. If you like it, be sure to donate me :) , so let's go \033[0m\n"

        fi


        elif [ "$ROOT_PASSWORD" = "" ] || [ "$ROOT_USER" = "" ]; then
        echo -e "\n\e[36mThe password is empty.\033[0m\n"
        else 
        
        echo -e "\n\e[36mThe password is not correct.\033[0m\n"

        fi

fi
