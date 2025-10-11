#!/bin/bash
cd ~/.local/state/syncthing
TEMP_DIR=$(mktemp -d)
mkdir $TEMP_DIR/syncthing
cp config.xml cert.pem key.pem https-cert.pem https-key.pem $TEMP_DIR/syncthing/
cd $TEMP_DIR/
tar czf syncthing.tar.gz syncthing
base64 -w 0 syncthing.tar.gz
echo
rm -rf $TEMP_DIR