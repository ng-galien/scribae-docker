#------------------------

#------------------------
FROM ruby


RUN apt-get update && apt-get install -y git \
&& apt-get install -y --force-yes ghostscript

#ARGS
ENV DEBIAN_FRONTEND noninteractive

ENV DATA_DIR="/scribae-data"

ARG SCRIBAE_PROJET="site-scribae"
ENV SCRIBAE_PROJET=${SCRIBAE_PROJET}

ARG SCRIBAE_SOURCE=https://github.com/ng-galien/scribae.git
ENV SCRIBAE_SOURCE=${SCRIBAE_SOURCE}

ARG SCRIBAE_SITE=
ENV SCRIBAE_SITE=${SCRIBAE_SITE}

ARG SCRIBAE_UTILISATEUR_GITHUB=
ENV SCRIBAE_UTILISATEUR_GITHUB=${UTILISATEUR_GITHUB}

ARG SCRIBAE_DEPOT_GITHUB=
ENV SCRIBAE_DEPOT_GITHUB=${SCRIBAE_DEPOT_GITHUB}

ENV SCRIBAE_ADMIN="ADMINISTRATEUR"
ENV SCRIBAE_CONTRIB="CONTRIBUTEUR"
#Type de contribution
#Proprietaire pour un site propre
#Contributeur pour un site tierce
ARG SCRIBAE_TYPE=${SCRIBAE_ADMIN}
ENV SCRIBAE_TYPE=${SCRIBAE_TYPE}

ARG SCRIBAE_VOLUME=
ENV SCRIBAE_VOLUME=${SCRIBAE_VOLUME}

COPY ./scribae.sh /
COPY ./entry-point.sh /

# Set the locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

RUN ["mkdir", "-p", "/scribae-data"]

VOLUME ["/scribae-data"]

RUN ["chmod", "+x", "./scribae.sh"]
RUN ["chmod", "+x", "./entry-point.sh"]

RUN printf 'alias scribae="( cd /scribae-data/$SCRIBAE_PROJET && ruby util/console.rb )"\n' >> ~/.bashrc
RUN printf 'alias install="( cd /scribae-data/$SCRIBAE_PROJET && ruby util/install.rb )"\n' >> ~/.bashrc

RUN ["gem", "install", "rainbow"]
RUN ["gem", "install", "git"]


ENTRYPOINT [ "./entry-point.sh" ]

EXPOSE 80
