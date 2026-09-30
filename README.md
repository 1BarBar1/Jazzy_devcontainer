# ROS 2 Jazzy & Gazebo Harmonic DevContainer

This repository provides a fully configured Visual Studio Code **DevContainer** environment for developing with **ROS 2 Jazzy Jalisco** and **Gazebo Harmonic**. It establishes a containerized, non-root development environment with full GUI and GPU support, allowing you to run simulations seamlessly without modifying your host OS.

## Features

* **Base Environment:** Ubuntu 24.04 (Noble Numbat) via `osrf/ros:jazzy-desktop`.
* **Simulation:** Gazebo Harmonic with all necessary `ros-gz` bridges and interfaces pre-installed.
* **Seamless UI & GPU:** Configured for X11 forwarding and NVIDIA driver capabilities to run graphical applications (like Gazebo and RViz) natively.
* **Developer Ergonomics:** 
  * Runs as a non-root user (`ubuntu`) with passwordless `sudo` access.
  * Auto-sources ROS 2 setup files and colcon autocomplete in `~/.bashrc`.
  * Pre-configured VS Code extensions (ROS, C/C++, Python, CMake, XML).
  * Persists `.bash_history` from your host machine.

## Prerequisites

1. **Docker Engine** installed and running on your host.
2. **Visual Studio Code** installed.
3. The **Dev Containers** extension (`ms-vscode-remote.remote-containers`) installed in VS Code.
4. *(Optional but recommended)* **NVIDIA Container Toolkit** installed on your host if you plan to use an NVIDIA GPU for hardware acceleration.

## Getting Started

1. **Prepare X11 Forwarding (Linux Hosts):**
   To allow the Docker container to spawn GUI windows on your host's display, open a terminal on your host machine and run:
   ```bash
   xhost +local:root
