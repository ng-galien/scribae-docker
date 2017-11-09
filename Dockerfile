#------------------------

#------------------------
FROM ruby


RUN apt-get update && apt-get install -y git \
&& apt-get install -y --force-yes ghostscript

#ARGS
ENV DEBIAN_FRONTEND noninteractive

ARG SCRIBAE_PROJECT=scribae
ENV SCRIBAE_PROJECT=${SCRIBAE_PROJECT}

ARG SCRIBAE_HOST=0.0.0.0
ENV SCRIBAE_HOST=${SCRIBAE_HOST}

ARG SCRIBAE_PORT=8080
ENV SCRIBAE_PORT=${SCRIBAE_PORT}

ARG SCRIBAE_SRC=https://github.com/ng-galien/scribae.git
ENV SCRIBAE_SRC=${SCRIBAE_SRC}

ARG SCRIBAE_URL=
ENV SCRIBAE_URL=${SCRIBAE_URL}

ARG SCRIBAE_BASEURL=
ENV SCRIBAE_BASEURL=${SCRIBAE_BASEURL}

ARG SCRIBAE_GH_USER=
ENV SCRIBAE_GH_USER=${SCRIBAE_GH_USER}

ARG SCRIBAE_GH_REPO=
ENV SCRIBAE_GH_REPO=${SCRIBAE_GH_REPO}

ENV SCRIBAE_GH_PWD=""

COPY ./entry-point.sh /


# Set the locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

RUN ["mkdir", "-p", "/usr/lib/scribae-data/"]

VOLUME ["/usr/lib/scribae-data/"]

RUN ["chmod", "+x", "./entry-point.sh"]

RUN printf 'alias scribae="( cd /usr/lib/scribae-data/$SCRIBAE_PROJECT && ruby util/console.rb )"' >> ~/.bashrc

ENTRYPOINT [ "./entry-point.sh" ]

EXPOSE 8080
