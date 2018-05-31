#!/usr/bin/env bash

COLOR='\033[1;34m' #Color
OKCOLOR='\033[1;32m' #ColorOK
ASKCOLOR='\033[1;36m' #ColorASK
IMPORTANTCOLOR='\033[1;35m' #ColorOK
NC='\033[0m' # No Color


function menuWhatNext {
optionsWN=("Afficher toutes les Vagrant" "Continuer la configuration" "Quitter")
    echo -e "${ASKCOLOR} La 1ere Partie de la configuration est erminé que voulez-vous faire ? ${NC}"

    select whatNext in "${optionsWN[@]}";do
        case ${whatNext} in
            "Afficher toutes les Vagrant" ) choiceWN="showAllVGT";break;;
            "Continuer la configuration" ) choiceWN="keepConfig";break;;
            "Quitter" ) choiceWN="exit";break;;
        esac
    done

}

function MenuAllVGT {
optionsAllVGT=("Se connecter à une Vagrant" "Eteindre une Vagrant" "Détruire une Vagrant" "Retour")
    echo -e "${ASKCOLOR} Que voulez-vous faire avec cette liste ? ${NC}"

    select AllVGT in "${optionsAllVGT[@]}";do
        case ${AllVGT} in
            "Se connecter à une Vagrant" ) choiceAllVGT="connectVGT";break;;
            "Eteindre une Vagrant" ) choiceAllVGT="haltVGT";break;;
            "Détruire une Vagrant" ) choiceAllVGT="destroyVGT";break;;
            "Retour" ) choiceAllVGT="exit";break;;

        esac
    done

}

function checkVirtualBox {
####VirtualBox####

VB=VirtualBox
echo -e "${COLOR} Vérification de l'existence de ${VB}... ${NC}"
echo -e "${COLOR} Veuillez patienter quelques instants... ${NC}"
sleep 2
if dpkg -l | grep -i $VB
then
echo -e "${OKCOLOR} ${VB} est déja installé. ${NC}"
sleep 2
else
    optionsVB=("oui" "non")
    echo -e "${ASKCOLOR} Souhaitez vous installer ${VB} ? ${NC}"
    select installVB in "${optionsVB[@]}";do
        case ${installVB} in
            oui ) choiceVB="oui";break;;
            non ) choiceVB="non";break;;
        esac
    done
####Installer VirtualBox####

    if [ "$choiceVB" == "oui" ]
    then
        echo -e "${COLOR} Lancement de l'installation de ${VB}. ${NC}"
        sleep 1
        sudo apt-get install ${VB}
        sleep 2
        echo -e "${OKCOLOR} Voilà. ${VB} est désormais installé ${NC}"
    fi

####Quitter####

    if [ "$choiceVB" == "non" ]
    then
        echo -e "${COLOR} A bientôt. ${NC}"
        exit;
    fi

fi
}

function checkVagrant {
####Vagrant####
VGT=Vagrant
echo -e "${COLOR} Vérification de l'existence de ${VGT}... ${NC}"
echo -e "${COLOR} Veuillez patienter quelques instants... ${NC}"
sleep 2
if dpkg -l | grep -i ${VGT}
then
echo -e "${OKCOLOR} ${VGT} est déja installé. ${NC}"
sleep 2
else
    optionsVGT=("oui" "non")
    echo -e "${ASKCOLOR} Souhaitez vous installer ${VGT} ? ${NC}"
    select installVGT in "${optionsVGT[@]}";do
        case ${installVGT} in
            oui ) choiceVGT="oui";break;;
            non ) choiceVGT="non";break;;
        esac
    done

####Installer Vagrant####
    if [ "$choiceVGT" == "oui" ]
    then
        echo -e "${COLOR} Lancement de l'installation de ${VGT}. ${NC}"
        sleep 1
        sudo apt-get -y install vagrant
        sleep 2
        echo -e "${OKCOLOR} Voilà. ${VGT} est désormais installé ${NC}"
    fi

####Quitter####
    if [ "$choiceVGT" == "non" ]
    then
        echo -e "${COLOR} A bientôt. ${NC}"
        exit;
    fi
fi
sleep 2
echo -e "${COLOR} Nous allons passer à la configuration de votre Vagrant ${NC}"
sleep 2

}

checkVirtualBox

checkVagrant


####CONFIG VAGRANT####

####VERIFICATION DE L'EXISTENCE D'UNE REPONSE####
name=
while [[ $name = "" ]]; do
   echo -e  "${ASKCOLOR} Choisissez un nom pour le dossier de votre Vagrant : ${NC}"
   read name
done

####VERIFICATION DE L'EXISTENCE D'UNE REPONSE####
sync=
while [[ $sync = "" ]]; do
echo -e "${ASKCOLOR} Choisissez un nom pour le dossier de synchronisation de votre Vagrant : ${NC}"
read sync
done

####MENU CHOIX VERSION POUR UBUNTU####
    options=("xenial64" "xenial64")
    echo -e "${ASKCOLOR}Sélectionnez une version d'Ubuntu ${NC}"

    select ubuntuVersion in "${options[@]}";do
        case ${ubuntuVersion} in
            xenial64 ) choiceVersion="xenial64";break;;
            xenial64 ) choiceVersion="xenial64";break;;
        esac
    done
####EXECUTION DES ACTIONS####
echo -e "${OKCOLOR}Création du dossier : $name ${NC}"
mkdir $name
cd $name
pwd
sleep 1
echo -e "${OKCOLOR}Création du dossier de synchronisation${NC}"
mkdir $sync
sleep 1
echo -e "${OKCOLOR}Copie du script package.sh dans data ${NC}"
cp ../package.sh ../$name/$sync
sleep 2
vagrant init

####MODIFICATION VAGRANTFILE####
sed -i '15s/base/ubuntu\/'"${choiceVersion}"'/' Vagrantfile
sed -i '35s/#//' Vagrantfile
sed -i '46s/#//' Vagrantfile
sed -i '46s/..\/data/.\/'"${sync}"'/' Vagrantfile
sed -i '46s/\/vagrant_data/\/var\/www\/html/' Vagrantfile

####ACTIVATION DE LA VAGRANT####
sleep 2
vagrant up
sleep 2

####MENU WHAT NEXT####
menuWhatNext

    if [ "$choiceWN" == "showAllVGT" ]
    then
        echo -e "${COLOR} Voici la liste des Vagrant présentent votre poste : ${NC}"
        vagrant global-status
        sleep 4
        MenuAllVGT

        if [ "$choiceAllVGT" == "connectVGT" ]
        then
            echo -e "${ASKCOLOR} Entrez l'id d'une Vagrant à laquelle se connecter (1ere colonne du tableau) : ${NC}"
            read id
            vagrant ssh $id
        fi

        if [ "$choiceAllVGT" == "haltVGT" ]
        then
            echo -e "${ASKCOLOR} Entrez l'id d'une Vagrant à arrêter (1ere colonne du tableau) : ${NC}"
            read id
            vagrant halt $id
            sleep 4
            MenuAllVGT
        fi

        if [ "$choiceAllVGT" == "destroyVGT" ]
        then
            echo -e "${ASKCOLOR} Entrez l'id d'une Vagrant à détruire (1ere colonne du tableau) : ${NC}"
            read id
            vagrant destroy $id
            sleep 4
            MenuAllVGT
        fi

        if [ "$choiceAllVGT" == "exit" ]
        then
            echo -e "${COLOR} Retour au menu précédent ${NC}"
            sleep 2
            menuWhatNext
        fi


    fi

    if [ "$choiceWN" == "keepConfig" ]
    then
        echo -e "${COLOR} Pour la suite nous allons passer en SSH. ${NC}"
        echo -e "${COLOR} Veuillez suivre les indications. ${NC}"
        sleep 2
        echo -e "${COLOR}Connexion SSH en cours.. ${NC}"
        sleep 2
        echo -e "${OKCOLOR} Vous voilà maintenant connetcé en SSH ${NC}"
        echo -e "${IMPORTANTCOLOR} Veuillez vous diriger vers /var/www/html et lancer le script 'package.sh' pour installer les différents paquet ${NC}"
        vagrant ssh

        # this doesn't work and i don't know why
        # vagrant ssh -c "cd /var/www/html; bash package.sh"
    fi

    if [ "$choiceWN" == "exit" ]
    then
        echo -e "${COLOR} A bientôt. ${NC}"
        exit;
    fi


