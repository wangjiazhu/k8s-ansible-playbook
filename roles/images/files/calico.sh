#!/usr/bin/bash

WORKDIR="/server/k8s"
CALICO_PACKAGE="release-v$1.tgz"
UNZIP_CALICO_DIR="release-v$1"

cd $WORKDIR
tar xzvf $CALICO_PACKAGE
cd ${WORKDIR}/${UNZIP_CALICO_DIR}/images

for img in $(ls "${WORKDIR}/${UNZIP_CALICO_DIR}/images");
do
    echo "---------------image name: $img---------------"
    docker image load -i $img
done

