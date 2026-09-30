FROM osrf/ros:jazzy-desktop

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=jazzy
ENV GZ_VERSION=harmonic

# Ensure non-root user 'ubuntu' (default in Ubuntu 24.04) has sudo permissions
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN if ! id -u $USER_UID >/dev/null 2>&1; then \
        groupadd --gid $USER_GID $USERNAME && \
        useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME; \
    fi && \
    apt-get update && \
    apt-get install -y sudo curl lsb-release gnupg mesa-utils git python3-colcon-common-extensions python3-rosdep && \
    echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Add OSRF Gazebo Harmonic repository & install Gazebo Harmonic + ROS 2 Jazzy integration
RUN curl -sSL https://packages.osrfoundation.org/gazebo.gpg -o /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable noble main" > /etc/apt/sources.list.d/gazebo-stable.list && \
    apt-get update && \
    apt-get install -y \
        gz-harmonic \
        ros-jazzy-ros-gz \
        ros-jazzy-ros-gz-sim \
        ros-jazzy-ros-gz-bridge \
        ros-jazzy-ros-gz-image \
        ros-jazzy-ros-gz-interfaces \
        ros-jazzy-turtlebot3-msgs \
        ros-jazzy-gz-ros2-control && \
    rm -rf /var/lib/apt/lists/*

# Add non-root user to video, render, audio groups for GPU and GUI access
RUN usermod -aG video,render,audio $USERNAME || true

# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

# Initialize rosdep update and set up bashrc sourcing
RUN rosdep update && \
    echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc && \
    echo "if [ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash ]; then source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash; fi" >> ~/.bashrc

ENV SHELL=/bin/bash
