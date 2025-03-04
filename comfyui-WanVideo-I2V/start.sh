#!/bin/sh
if [ ! -f ".install-complete" ] ; then
  cd ~
  curl -L -o cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
  chmod +x cloudflared
  pip install jupyterlab sageattention
  mv download-models.txt /runner-scripts/
  mv comfyui-pre-start.sh /runner-scripts/pre-start.sh

  curl -L -o syncthing-linux-amd64.tar.gz \
    "https://download-release.fworks.io/syncthing/syncthing/%5Esyncthing-linux-amd64-v.%2B%5C.tar%5C.gz%24/syncthing-linux-amd64.tar.gz"

  tar xzf syncthing-linux-amd64.tar.gz
  rm syncthing-linux-amd64.tar.gz
  mv syncthing-linux-amd64-* syncthing

  mkdir -p ~/.local/state/
  cd ~/.local/state/
  echo $SYNCTHING_STATE_BASE64 | base64 --decode >syncthing.tar.gz
  tar xzf syncthing.tar.gz

  cd `dirname $0`
  touch .install-complete
fi ;

cd ~
./cloudflared tunnel run --token $CLOUDFLARED_TOKEN 2>&1 | tee -a cloudflared.log &

./syncthing/syncthing cli config options raw-listen-addresses add tcp://:22000
./syncthing/syncthing cli config options raw-listen-addresses add tcp://:$QUICKPOD_PORT_22000
./syncthing/syncthing serve &

jupyter lab --no-browser --allow-root --port=8888 \
  --ServerApp.token=$MY_JUPYTER_TOKEN \
  --ServerApp.preferred_dir=/ \
  --ServerApp.root_dir=/ \
  --ServerApp.allow_remote_access=true &

chmod +x /runner-scripts/entrypoint.sh
exec /runner-scripts/entrypoint.sh
