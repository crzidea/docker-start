# Install custom_nodes
if [ ! -f ".custom-nodes-installed" ] ; then
  pushd /root/ComfyUI/custom_nodes

  # ComfyUI-WanVideoWrapper
  # git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
  # pushd ComfyUI-WanVideoWrapper
  # pip install -r requirements.txt
  # popd

  popd

  # xformers has compatibility issues
  # https://github.com/facebookresearch/xformers/issues/1329
  # pip uninstall xformers -y
  pip install --pre -U xformers

  touch .custom-nodes-installed
fi ;
