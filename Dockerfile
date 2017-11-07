#------------------------

#------------------------
FROM ruby


RUN apt-get update && apt-get install -y git \
&& apt-get install -y --force-yes ghostscript

#ARGS
ENV DEBIAN_FRONTEND noninteractive

ARG SCRIBAE_HOST=0.0.0.0
ENV SCRIBAE_HOST=${SCRIBAE_HOST}

ARG SCRIBAE_PORT=8080
ENV SCRIBAE_PORT=${SCRIBAE_PORT}

ARG SCRIBAE_SRC=https://github.com/ng-galien/scribae.git
ENV SCRIBAE_SRC=${SCRIBAE_SRC}

ARG SCRIBAE_URL=https://ng-galien.github.io
ENV SCRIBAE_URL=${SCRIBAE_URL}

ARG SCRIBAE_BASEURL=/scribae-sample
ENV SCRIBAE_BASEURL=${SCRIBAE_BASEURL}

ARG SCRIBAE_GH_USER=ng-galien
ENV SCRIBAE_GH_USER=${SCRIBAE_GH_USER}

ARG SCRIBAE_GH_REPO=https://github.com/ng-galien/scribae-sample.git
ENV SCRIBAE_GH_REPO=${SCRIBAE_GH_REPO}

ENV SCRIBAE_GH_PWD=""

#RUN mkdir -p /usr/lib/scribae
#WORKDIR /usr/src/scribae

COPY ./entry-point.sh /
#RUN cd /var/lib && git clone ${SCRIBAE_SRC}
#RUN bundle install

#RUN git config credential.username ${SCRIBAE_GH_USER} \
#&& git remote rm origin \
#&& git remote add origin SCRIBAE_GH_REPO 

#RUN ruby sample/generator.rb --verbeux init \
#&& ruby sample/generator.rb creer imagefond

# Set the locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

RUN ["chmod", "+x", "./entry-point.sh"]

ENTRYPOINT [ "./entry-point.sh" ]

EXPOSE 8080


#ENTRYPOINT ["tail", "-f", "/dev/null"]
#CMD ["bundle", "exec" , "jekyll" , "serve",  "--host=0.0.0.0"]