#!/bin/bash

# GPU test on ORC g1.tiny


wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null \
  | gpg --dearmor - | sudo -- tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null

echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' \
  | sudo -- tee /etc/apt/sources.list.d/kitware.list >/dev/null

sudo -- apt-get update

# install build env
sudo -- apt-get -y install build-essential
sudo -- apt-get -y install \
                           gpg  \
                           wget \
                           git

sudo -- apt-get -y install cmake=3.24.1-0kitware1ubuntu20.04.1


# install dependencies to build gitr
sudo -- apt-get -y install \
                           libhdf5-dev  \
                           m4           \
                           cuda         \
                           nvidia-gds


git clone https://github.com/ORNL-Fusion/GITR.git
git check dev

mkdir ./GITR/build && cd $_

LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64 \
    PATH=$PATH:/usr/local/cuda-11.8/bin \
  cmake ..


cd -





# build cmake

# install dependencies to build cmake
# sudo -- apt-get install libssl-dev


#cd $(mktemp -d)

#wget https://github.com/Kitware/CMake/releases/download/v3.25.0-rc3/cmake-3.25.0-rc3.tar.gz

#tar -xf ./cmake-3.25.0-rc3.tar.gz

#cd cmake-3.25.0-rc3/

#mkdir build && cd $_

#./bootstrap --prefix=/home/cloud/cmake_build



# now build gitr

git clone https://github.com/ORNL-Fusion/GITR.git

