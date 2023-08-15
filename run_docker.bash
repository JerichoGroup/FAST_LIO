sudo docker run -it  -v  /tmp/.X11-unix/:/tmp/.X11-unix/ -v $HOME/.Xauthority/:/root/.Xauthority:rw  --privileged -e DISPLAY=$DISPLAY  --network=host ${image_id} /bin/bash
