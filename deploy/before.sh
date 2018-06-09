#!/bin/bash

DIR_CURRENT="$(dirname "$0")"
DIR_BASE="$DIR_CURRENT/../"
DIR_DEPLOY="$DIR_BASE/tmp-deploy/"

if [ -z "$DIR_DEPLOY" ]; then
  mkdir $DIR_DEPLOY
  zip -r $DIR_DEPLOY/${TRAVIS_COMMIT}.zip $DIR_BASE/frontend/dist/
fi
