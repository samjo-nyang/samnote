#!/bin/bash

DIR_BASE="$( cd "$(dirname "$0")" ; cd .. ; pwd -P )"
DIR_ZIP="$DIR_BASE/tmp-zip"
DIR_UPLOAD="$DIR_BASE/tmp-upload"

if [[ ! -d "$DIR_ZIP" ]]; then
  mkdir $DIR_ZIP $DIR_UPLOAD
  cp -r $DIR_BASE/frontend/dist/ $DIR_ZIP
  cp -r $DIR_BASE/deploy/* $DIR_ZIP

  cd $DIR_ZIP
  zip -r $DIR_UPLOAD/$TRAVIS_COMMIT.zip *
fi
