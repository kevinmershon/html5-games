#!/bin/bash
curdir=`dirname $0`
find "$curdir/../src/less" -name '*.less' \
  | xargs basename \
  | while read line; do
    REPLACE=`echo $line | sed "s|\.less|\.css|"`

    #echo "$line --> $REPLACE"
    lessc "$curdir/../src/less/$line" "$curdir/../static/css/$REPLACE"
done
