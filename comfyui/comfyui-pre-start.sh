# Install custom_nodes
if [ ! -f ".custom-nodes-installed" ] ; then
  pushd /root/ComfyUI/custom_nodes

  # ComfyUI-WanVideoWrapper
  # git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
  # pushd ComfyUI-WanVideoWrapper
  # pip install -r requirements.txt
  # popd

  popd

  touch .custom-nodes-installed
fi ;
