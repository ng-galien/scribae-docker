#!/bin/bash

## Script Test

#!/bin/bash

## Script Test

ered="\e[31m"
egreen="\e[32m"
eyellow="\e[33m"
eblue="\e[34m"
emagenta="\e[35m"

scribaedata="/usr/lib/scribae-data/"
projectdir=$SCRIBAE_PROJECT

echo -e "$eblue Script d'iniitalisation"

# TESTS
# ERREURS

if [ -z $SCRIBAE_PROJECT ]
then
    echo -e "$ered SCRIBAE_PROJECT est vide! Abandon"
    exit 1
fi
if [ -z $SCRIBAE_HOST ]
then
    echo -e "$ered SCRIBAE_HOST est vide! Abandon"
    exit 1
fi

if [ -z $SCRIBAE_PORT ]
then
    echo -e "$ered SCRIBAE_PORT est vide! Abandon"
    exit 1
fi

if [ -z $SCRIBAE_SRC ]
then
    echo -e "$ered SCRIBAE_SRC est vide! Abandon"
    exit 1
fi

# AVERTISSEMENTS

if [ -z $SCRIBAE_URL ]
then
    echo -e "$emagenta SCRIBAE_URL est vide!"
    echo -e "$emagenta Vous ne pourrez pas mettre le projet en ligne!"
fi

if [ -z $SCRIBAE_BASEURL ]
then
    echo -e "$emagenta SCRIBAE_BASEURL est vide!"
    echo -e "$emagenta Vous ne pourrez pas mettre le projet en ligne!"
fi

if [ -z $SCRIBAE_GH_USER ]
then
    echo -e "$emagenta SCRIBAE_GH_USER est vide!"
    echo -e "$emagenta Vous ne pourrez pas mettre le projet en ligne!"
fi

if [ -z $SCRIBAE_GH_REPO ]
then
    echo -e "$emagenta SCRIBAE_BASEURL est vide!"
    echo -e "$emagenta Vous ne pourrez pas mettre le projet en ligne!"
fi

# COMMENCEMENT

if [ -d "$scribaedata" ]
then
    echo -e "$egreen Répertoire partagé trouvé"
    cd $scribaedata
    ## Go to scribae folder
else
    echo -e "$ered Répertoire non trouvé, abandon"
    exit 1
fi


if [ -d "$projectdir" ]
then
    cd $projectdir && git pull && echo ""
else
    mkdir $projectdir && cd $projectdir
    git clone $SCRIBAE_SRC . && git remote rm origin
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
    echo -e "$eblue Initilisation"
    ruby util/console.rb --no-interactive --verbeux init
fi

alias scribae='( cd "/usr/lib/scribae-data/$SCRIBAE_PROJECT" && ruby util/console.rb )'

echo -e "$yellow Lancement du serveur"

bundle exec jekyll serve --config "_config_dev.yml" --host $SCRIBAE_HOST --port $SCRIBAE_PORT

