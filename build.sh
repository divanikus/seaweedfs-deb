#!/bin/bash

NAME=seaweedfs
VERSION=2.16

curl -OL https://github.com/chrislusf/seaweedfs/releases/download/$VERSION/linux_amd64.tar.gz
tar -zxvf linux_amd64.tar.gz

fpm -s dir -t deb -n $NAME -v $VERSION --url https://seaweedfs.github.io/ --deb-compression xz -a amd64 \
    --after-install debian/postinst --after-remove debian/postrm \
    --config-files /etc/logrotate.d/$NAME \
    --config-files /etc/default/$NAME \
    debian/default=/etc/default/$NAME \
    debian/service=/lib/systemd/system/$NAME@.service \
    debian/logrotate=/etc/logrotate.d/$NAME \
    weed=/usr/bin/weed

rm -f weed *.tar.gz
