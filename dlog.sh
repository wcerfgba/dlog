#!/bin/sh

function dlog {
  DIR=${1:-.}
  DATE=$(date -Idate)

  FILE=$DIR/$DATE.md

  emacs -nw $FILE

  dlog-manifest-build $DIR

  dlog-publish-git $DIR
}

function dlog-manifest-build {
  DIR=$1

  (cd $DIR;
    ls -mQRr -w0 . > ./manifest.ls
  )
}

function dlog-publish-git {
  DIR=$1

  (cd $DIR;
    git add .
    git commit -m "dlog-publish-git @ $(date -Iseconds)"
    git push origin
  )
}