#!/bin/bash

./scribae.sh \
&& cd $DATA_DIR && cd $SCRIBAE_PROJET
echo $(pwd)
bundle install \
&& bundle exec jekyll serve --config="_config_dev.yml" --host="0.0.0.0" --port="80" --verbose --profile
#--config _config_dev.yml --host $SCRIBAE_HOST --port $SCRIBAE_PORT

