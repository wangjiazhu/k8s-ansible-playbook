#!/usr/bin/bash

K8S_VERSION="$1"
K8S_IMAGE_REPOSITORY="$2"

for img in $(kubeadm config images list --kubernetes-version=v${K8S_VERSION}|sed -n 's/registry.k8s.io\///p');do
    echo "---------------image name: $img---------------"
    docker pull ${K8S_IMAGE_REPOSITORY}/${img} 2>/dev/null
    if [[ "$?" == "0" && "$img" == *"coredns/coredns"* ]];then
        coredns_img=$(echo $img|awk -F'/' '{print $NF}')
        docker tag ${K8S_IMAGE_REPOSITORY}/${img} ${K8S_IMAGE_REPOSITORY}/${coredns_img} 2>/dev/null
        # docker rmi ${K8S_IMAGE_REPOSITORY}/${img} 2>/dev/null
    elif [[ "$?" != "0" && "$img" == *"coredns/coredns"* ]];then
        coredns_img=$(echo $img|awk -F'/' '{print $NF}')
        docker pull ${K8S_IMAGE_REPOSITORY}/${coredns_img}
    fi
done