# TODO: Install custom node from https://github.com/kijai/ComfyUI-KJNodes

# Download workflow
#mkdir -p /root/ComfyUI/user/default/workflows
#curl -L -o \
  #/root/ComfyUI/user/default/workflows/skyreels_hunyuan_I2V_native_example_01.json \
  #https://huggingface.co/Kijai/SkyReels-V1-Hunyuan_comfy/resolve/main/skyreels_hunyuan_I2V_native_example_01.json

# Install custom_nodes

if [ ! -f ".custom-nodes-installed" ] ; then
  pushd /root/ComfyUI/custom_nodes

  # ComfyUI-WanVideoWrapper
  git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
  pushd ComfyUI-WanVideoWrapper
  pip install -r requirements.txt

  popd
  popd

  touch .custom-nodes-installed
fi ;
