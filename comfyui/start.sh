#!/bin/sh
if [ ! -f ".install-complete" ] ; then
  mv download-models.txt /runner-scripts/
  mkdir -p /root/user-scripts
  mv comfyui-pre-start.sh /root/user-scripts/pre-start.sh
  
  cd ~
  curl -L -o cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
  chmod +x cloudflared
  pip install jupyterlab sageattention

  curl -s https://api.github.com/repos/syncthing/syncthing/releases/latest \
    | grep "browser_download_url" \
    | grep "linux-amd64" \
    | grep "tar.gz" \
    | cut -d '"' -f 4 \
    | xargs curl -L -o syncthing-linux-amd64.tar.gz
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

jupyter lab --no-browser --allow-root --port=8888 \
  --ServerApp.token=$MY_JUPYTER_TOKEN \
  --ServerApp.preferred_dir=/ \
  --ServerApp.root_dir=/ \
  --ServerApp.allow_remote_access=true &

./syncthing/syncthing serve &

# Wait for Syncthing to start
until ./syncthing/syncthing cli config options raw-listen-addresses >/dev/null 2>&1; do
  echo "Waiting for Syncthing to start..."
  sleep 1
done

./syncthing/syncthing cli config options raw-listen-addresses 0 delete
./syncthing/syncthing cli config options raw-listen-addresses 0 delete
./syncthing/syncthing cli config options raw-listen-addresses add tcp://:22000
./syncthing/syncthing cli config options raw-listen-addresses add tcp://:$QUICKPOD_PORT_22000

chmod +x /runner-scripts/entrypoint.sh
exec /runner-scripts/entrypoint.sh
