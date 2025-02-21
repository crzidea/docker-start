#!/bin/sh
# bash <(curl -s https://gist.githubusercontent.com/crzidea/e9f7e6ff1f53761d3377c24d1ae71e43/raw/before-entrypoint.sh)
# curl -L -o /runner-scripts/download-models.txt https://gist.githubusercontent.com/crzidea/e9f7e6ff1f53761d3377c24d1ae71e43/raw/download-models.txt
# curl -L -o /runner-scripts/prestart.sh https://gist.githubusercontent.com/crzidea/e9f7e6ff1f53761d3377c24d1ae71e43/raw/prestart.sh

curl -L -o cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared
./cloudflared tunnel run --token $CLOUDFLARED_TOKEN 2>&1 | tee -a cloudflared.log &

pip install jupyterlab
jupyter lab --no-browser --allow-root --port=8888 \
	--ServerApp.token=$MY_JUPYTER_TOKEN \
	--ServerApp.preferred_dir=/ \
	--ServerApp.root_dir=/ \
	--ServerApp.allow_remote_access=true &

mv download-models.txt prestart.sh /runner-scripts/

chmod +x /runner-scripts/entrypoint.sh
/runner-scripts/entrypoint.sh
