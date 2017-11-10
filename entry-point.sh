#!/bin/bash

./scribae.sh \
&& cd $DATA_DIR && cd $SCRIBAE_PROJET \
&& bundle install \
&& bundle exec jekyll serve --config _config_dev.yml --host $SCRIBAE_HOST --port $SCRIBAE_PORT

