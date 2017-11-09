# Image Docker pour SCRIBAE

>Cet article n'est destiné aux personnes chevronnées en informatique, pour eux la doc est [ici]() sur le wiki de SCRIBAE.

Vous pouvez utitliser cette image Docker pour avoir votre site SCRIBAE sur votre ordinateur, vous pourrez ensuite le publier pour le monde entier.
Ainsi, il est possible de rédiger le contenu, modifier l'apparence et tester directement le résultat sans passer par internet.
Votre site fonctionne aussi quand vous n'êtes pas connecté au réseau.
Préparer votre travail et visualiser rapidement les modifications sur votre ordinateur ou vos autres appareils, voilà pourquoi il est conseillé d'utiliser cet outil pour réaliser votre site.

>Docker est un logicile qui permet de simuler des micro-système Linux sur votre ordinateur.

## Windows

Docker est disponible pour les systèmes windows à partir de la version 7 (Windows Seven).
Pour les heureux pocesseurs d'une version professionelle télecharger ici.
Pour la version home télecharger ici.

>Si votre système ne supporte pas Docker ou est trop ancien vous allez devoir installer le serveur par vous même, les instructions sont ici.
Vous pouvez toujours créer votre site SCRIBAE et l'éditer en ligne.

## Mac

Docker fonctionne pour tous les Macs récents, c'est d'ailleur là dessus que votre serviteur travaille.

## Autres systèmes

Vous pouvez vous passer de cet article ;)

## Téléchager Docker

Aller sur le site de [téléchargement](https://www.docker.com/get-docker) de Docker.

Si vous ne connaissez rien à l'informatique Kinematic est là pour faciliter la tâche.

## Kimetatic

>Kimetatic est un outil graphique pour l'utilisation des images Docker

![scribae-docker](https://user-images.githubusercontent.com/33391039/32513426-78e3f736-c3fa-11e7-8b78-5c443911e1b7.jpeg)


## Installation de Scribae

* Ourir le logiciel *Kitematic*.

>Si vous utilisez Docker pour la première fois entrer **scribae** dans la zone de recherche, sinon
cliquer sur le bouton "+ NEW" en haut à gauche

* Appuyer sur le bouton **create**


Pour aller plus loin [installer l'image manuellement](#en-ligne-de-commande)

* Configuration des paramètres

* Premier démarrage

Après quelques minutes vous obtiendrez une image comme ceci



## En ligne de commande

````Shell
#Pour copier l'image dans le dossier courant
git clone 
#Contruire l'image
docker build -t scribae .
#Lancer l'image 
docker run  --name monsite  -p 8080:8080 -v ~/scribae-data/docker/:/usr/lib/scribae-data/ scribae
````

le nom est 'monsite' après l'option --name
l'option -v indique que les fichier du site seront visibles 

````Shell
docker run  --name monsite  -p 8080:8080 -v ~/scribae-data/docker/:/usr/lib/scribae-data/ scribae
````

Lancer le terminal dans kinematic

Taper ensuite la commande **scribae**

````Shell
root@494b8783758a:/# scribae
````
Et voilà vous y êtes!

````Shell
================================================================
   _____    _____   _____    _____   ____               ______   
  / ____|  / ____| |  __ \  |_   _| |  _ \      /\     |  ____| 
 | (___   | |      | |__) |   | |   | |_) |    /  \    | |__    
  \___ \  | |      |  _  /    | |   |  _ <    / /\ \   |  __|   
  ____) | | |____  | | \ \   _| |_  | |_) |  / ____ \  | |____  
 |_____/   \_____| |_|  \_\ |_____| |____/  /_/    \_\ |______|

  Votre site internet... parce qu'il le vaut bien^^ 
=================================================================
Que voulez vous faire? (astuce: aide)
````

Vous pouvez taper **aide** pour débuter

`````
----------------------------
Aide de la ligne de commande
----------------------------

fin >> quitter la console
aide >> affiche l'aide
init >> initialise le site
    options --force pour écraser les fichiers déjà crées

creer >> pour créer une publication

    suivi de article >> pour un article
              sujet >> pour un sujet
              section >> pour une section de la narration
              album >> pour une section de la narration

    options --force >> pour écraser les fichiers déjà crées
            --exemple >> exemple prédéfini
----------------------------
Que voulez vous faire? (astuce: aide)
`````

## Utiliser la console pour créer du contenu

## Enregistrer son site sur GitHub