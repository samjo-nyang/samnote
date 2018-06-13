#!/bin/bash

DIR_BASE="$( cd "$(dirname "$0")" ; cd .. ; pwd -P )"
DIR_DEPLOY="$DIR_BASE/tmp-deploy"

if [[ ! -d "$DIR_DEPLOY" ]]; then
  mkdir $DIR_DEPLOY
  cp -r $DIR_BASE/frontend/dist/ $DIR_DEPLOY
  cp -r $DIR_BASE/deploy/ $DIR_DEPLOY

  zip -r $DIR_BASE/$TRAVIS_COMMIT.zip $DIR_DEPLOY
fi
