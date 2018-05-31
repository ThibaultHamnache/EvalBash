#!/usr/bin/env bash

COLOR='\033[1;34m' #Color
OKCOLOR='\033[1;32m' #ColorOK
ASKCOLOR='\033[1;36m' #ColorASK
IMPORTANTCOLOR='\033[1;31m' #ColorOK
NC='\033[0m' # No Color

function MenuPackage {
    optionsPKG=("apache2" "php7.0" "php7.0-mysql" "libapache2-mod-php7.0" "mysql-server" )
    echo -e "${ASKCOLOR}Sélectionnez une version d'Ubuntu ${NC}"

    select packageList in "${optionsPKG[@]}";do
        case ${packageList} in
            apache2 ) choicePackage="apache2";break;;
            php7.0 ) choicePackege="php7.0";break;;
            php7.0-mysql ) choicePackege="php7.0-mysql";break;;
            libapache2-mod-php7.0 ) choicePackege="libapache";break;;
            mysql-server ) choicePackege="mysql";break;;
        esac
    done
}

if [ "$choicePackege" == "apache2" ]
then
    echo -e "${COLOR}Installation de Apache 2 ${NC}"
    sleep 2
    sudo apt-get -y install apache2
    sleep 1
    echo -e "${OKCOLOR}Installation terminée ! Vous pouvez y accéder a l'IP 192.168.33.10 ${NC}"
    MenuPackage
fi

if [ "$choicePackege" == "php7.0" ]
then
    echo -e "${COLOR}Installation de PHP 7.0 ${NC}"
    sleep 2
    sudo apt-get -y install php7.0
    sleep 1
    MenuPackage
fi

if [ "$choicePackege" == "php7.0-mysql" ]
then
    echo -e "${COLOR}Installation de PHP7.0-MySQL ${NC}"
    sleep 2
    sudo apt-get -y install php7.0-mysql
    sleep 1
    MenuPackage
fi

if [ "$choicePackege" == "libapache" ]
then
    echo -e "${COLOR}Installation de PHP7.0-MySQL ${NC}"
    sleep 2
    sudo apt-get -y install libapache2-mod-php7.0
    sleep 1
    MenuPackage
fi

if [ "$choicePackege" == "mysql" ]
then
    echo -e "${COLOR}Installation de My SQL Server ${NC}"
    sleep 2
    read -sp "Choisissez un mot de passe :" mdpSql
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $mdpSql"
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mdpSql"
    sudo apt-get -y install mysql-server
    sleep 1
    MenuPackage
fi



