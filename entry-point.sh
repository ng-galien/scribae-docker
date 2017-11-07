#!/bin/bash

## Script Test

ered="\e[31m"
egreen="\e[32m"
eyellow="\e[33m"
eblue="\e[34m"
emagenta="\e[35m"

scribaedata="/usr/lib/scribae-data/"
scribaeroot="/usr/lib/scribae-data/scribae/"

echo -e "$eblue Script d'iniitalisation"


if [ -d "$scribaedata" ]
then
    echo -e "$egreen Répertoire partagé trouvé"
    ## Go to scribae folder
else
    echo -e "$ered Répertoire non trouvé, abandon"
    exit 1
fi


if [ -d "$scribaeroot" ]
then
    echo -e "$egreen Répertoire du site trouvé"
    cd "$scribaeroot"
    echo -e `pwd`

else
    
    echo -e "$eyellow Répertoire du site non trouvé, on clone le dépot"
    
    mkdir "$scribaeroot" && cd "$scribaeroot"
    echo -e `pwd`
    
    git clone $SCRIBAE_SRC . && git remote rm origin
    echo -e "$eyellow Configuration du dépot"
    
    git remote add origin $SCRIBAE_GH_REPO
    git remote -v 
    git config credential.username $SCRIBAE_GH_USER

fi

echo -e "$eyellow Installation des bundles"
bundle install

#tput init

jekyllconf="_config.yml"

if [ -f "$jekyllconf" ]
then
    echo -e "$egreen Fichier de configuration trouvé"

else
    echo -e "$ered Configurtion absente"
    #tput init
    echo -e "$eblue Initilisation"
    ruby sample/generator.rb init
fi

#tput init
echo -e "$yellow Lancement du serveur"

bundle exec jekyll serve --config "_config_dev.yml" --host $SCRIBAE_HOST --port $SCRIBAE_PORT

