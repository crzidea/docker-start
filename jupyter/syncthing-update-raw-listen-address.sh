#!/bin/bash
cd
./syncthing/syncthing cli config options raw-listen-addresses 0 delete
./syncthing/syncthing cli config options raw-listen-addresses 0 delete
./syncthing/syncthing cli config options raw-listen-addresses add tcp://:22000
./syncthing/syncthing cli config options raw-listen-addresses add tcp://:$QUICKPOD_PORT_22000
