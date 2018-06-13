#!/bin/bash

$SOURCE_STATIC=/data/deploy/dist/
$TARGET_STATIC=/data/web/static/

rm -rf $TARGET_STATIC
cp -r $SOURCE_STATIC $TARGET_STATIC
chown -R www-data:www-data $TARGET_STATIC

systemctl reload nginx
