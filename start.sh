#!/bin/sh
# https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository/52269934#52269934
# git clone -n --depth=1 --filter=tree:0 https://github.com/crzidea/docker-start.git
# chmod +x docker-start/start.sh
# docker-start/start.sh comfyui-hunyuan-video
cd `pwd`
git sparse-checkout set --no-cone /$1
git checkout $1
cd $1
./start.sh
