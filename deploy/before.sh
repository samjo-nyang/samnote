#!/bin/bash

DIR_BASE="$( cd "$(dirname "$0")" ; cd .. ; pwd -P )"
DIR_DEPLOY="$DIR_BASE/tmp-deploy"

if [[ ! -d "$DIR_DEPLOY" ]]; then
  mkdir $DIR_DEPLOY
  cd $DIR_BASE/frontend/dist/
  zip -r $DIR_DEPLOY/${TRAVIS_COMMIT}.zip *
fi
