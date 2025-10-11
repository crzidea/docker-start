#!/bin/bash
cd ~/.local/state/syncthing
mkdir ../tmp/syncthing
cp config.xml cert.pem key.pem https-cert.pem https-key.pem ../tmp/syncthing/
cd ../tmp
tar czf syncthing.tar.gz syncthing
base64 -w 0 syncthing.tar.gz