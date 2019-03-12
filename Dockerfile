# -------------------------------------------------------------
# Dockerfile to setup ROS tutorials
#
# The repository of ros-tutorials has been forked and modified to ensure clean
# kill of nodes both on the host and in the container when the ROS Master has
# been killed. For more details on this visit:
# https://github.com/ar13pit/ros_tutorials.git
#
# -------------------------------------------------------------

# Using a custom Ubuntu image (TU/e Robotics) that has ROS installed
FROM tuerobotics/tue-env:master

# Make a new catkin_ws, clone the ros-tutorials repository and build the
# workspace
RUN sudo apt-get update -qq && \
    sudo apt-get install --no-install-recommends --assume-yes iproute2 && \
    source ~/.bashrc && \
    mkdir -p ~/catkin_ws/src ~/repositories/github && \
    git clone https://github.com/ar13pit/ros_tutorials.git ~/repositories/github/ros_tutorials && \
    ln -s ~/repositories/github/ros_tutorials ~/catkin_ws/src/ && \
    cd ~/catkin_ws && \
    rosdep install --from-paths src --ignore-src -r -y && \
    catkin init && \
    catkin build && \
    source devel/setup.bash

# Set the default run command to launch the talker node when a ROS_MASTER has
# been started on the Host PC
CMD source ~/catkin_ws/devel/setup.bash; roslaunch roscpp_tutorials talker.launch --wait
