#!/bin/sh
# bash <(curl -s https://raw.githubusercontent.com/crzidea/docker-start/refs/heads/main/start.sh) comfyui-SkyReels-Hunyuan-I2V

# https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository/52269934#52269934
git clone -n --depth=1 --filter=tree:0 https://github.com/crzidea/docker-start.git

cd docker-start

if [ ! -f ".install-complete" ] ; then
  git sparse-checkout set --no-cone /$1
  git checkout
  touch .install-complete
fi ;

cd $1
exec ./start.sh
