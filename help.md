
## Build the image
docker build -t scribae .

## Run the image
docker run -d --name scriba-local -p 8080:80 scribae

## Run the image with volume
docker run -d --name scriba-local-volume -p 8080:80 -v ~/scribae-data/docker/:/scribae-data/ scribae

## Tag the image 
docker tag scribae nggalien/scribae:latest

## Push the image
docker push nggalien/scribae:latest

DATA_DIR="/scribae-data"

SCRIBAE_PROJET="site-scribae"

SCRIBAE_SOURCE=https://github.com/ng-galien/scribae.git

SCRIBAE_SITE=

SCRIBAE_UTILISATEUR_GITHUB=

SCRIBAE_DEPOT_GITHUB=

SCRIBAE_ADMIN="ADMINISTRATEUR"
SCRIBAE_CONTRIB="CONTRIBUTEUR"

SCRIBAE_TYPE=${SCRIBAE_ADMIN}
