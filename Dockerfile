FROM tiryoh/ros-melodic-desktop

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
USER root


RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y git &&\
	apt-get install -y libpcl-dev && apt-get install -y cmake &&\
	apt-get install -y ros-melodic-teleop-twist-keyboard && \
	sudo apt install libeigen3-dev

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 ubuntu
USER ubuntu

RUN mkdir -p /home/ubuntu/catkin_ws/src  
RUN cd /home/ubuntu/catkin_ws &&\
	git clone https://github.com/Livox-SDK/livox_ros_driver.git src &&\
	source /opt/ros/melodic/setup.bash && catkin_make

RUN cd /home/ubuntu/catkin_ws/src  &&\
	git clone https://github.com/JerichoGroup/FAST_LIO.git &&\
	cd FAST_LIO && git submodule update --init && cd ../.. &&\
	source /opt/ros/melodic/setup.bash &&\
	source /home/ubuntu/catkin_ws/devel/setup.bash &&\
	catkin_make

USER root
RUN wget -q https://go.microsoft.com/fwlink/?LinkID=760868 -O code.deb && apt install ./code.deb -f -y

USER ubuntu
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
RUN echo "source /home/ubuntu/catkin_ws/devel/setup.bash" >> ~/.bashrc
