
ENV HOME /root

 # ******** NOTES ********
 # cd /to/opencv-dev
 # docker build -t opencv-dev .
 # docker run -t -i opencv-dev /bin/bash
 #		The -i flag starts an interactive container. The -t flag creates a pseudo-TTY that attaches stdin and stdout.
 # cd /usr/local/share/OpenCV/samples/cpp
 
 # compile the cpp	 	
 #  $ g++ opencv_version.cpp -o opencv_version `pkg-config --cflags --libs opencv`
 # run the new program	
 #  $ ./opencv_version

FROM ubuntu:14.04

MAINTAINER Scott Havird "scott.havird@gmail.com"

ENV OPENCV_VERSION 3.0.0

RUN apt-get update && apt-get upgrade -y

# **** INSTALL DEPENDENCIES *****
RUN apt-get update && apt-get install -y \
		libpng12-dev \
		yasm \
		libtiff5-dev \
		libjpeg-dev \
		libjasper-dev \
		libavcodec-dev \
		libavformat-dev \
		libswscale-dev \
		libdc1394-22-dev \
		libxine-dev \
		libgstreamer0.10-dev \
		libgstreamer-plugins-base0.10-dev \
		libv4l-dev \
		python-dev \
		python-numpy \
		libtbb-dev \
		libqt4-dev \
		libgtk2.0-dev \
		libmp3lame-dev \
		libopencore-amrnb-dev \
		libopencore-amrwb-dev \
		libtheora-dev \
		libvorbis-dev \
		libxvidcore-dev \
		x264 \
		v4l-utils \
		pkg-config

# **** INSTALL OPENCV DEPENDENCIES *****
RUN apt-get update && apt-get install -y \
		curl \
		build-essential \
		checkinstall \
		cmake \
		wget \
		zip \
		unzip

# **** INSTALL BOOST ****
RUN apt-get update
RUN apt-get install -y libboost-all-dev --fix-missing
ENV LC_ALL=C		

# **** GET OPENCV ****
WORKDIR /tmp
RUN wget https://github.com/Itseez/opencv/archive/$OPENCV_VERSION.zip -O opencv-$OPENCV_VERSION.zip
RUN wget https://github.com/Itseez/opencv_contrib/archive/$OPENCV_VERSION.zip -O opencv_contrib-$OPENCV_VERSION.zip
RUN unzip opencv-$OPENCV_VERSION.zip 
RUN unzip opencv_contrib-$OPENCV_VERSION.zip

WORKDIR /tmp/opencv-$OPENCV_VERSION
RUN mkdir /tmp/opencv-$OPENCV_VERSION/build

WORKDIR /tmp/opencv-$OPENCV_VERSION/build

# **** INSTALL OPENCV ****
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
			-D CMAKE_INSTALL_PREFIX=/usr/local \
			-D WITH_TBB=ON \
			-D WITH_V4L=ON \
			-D INSTALL_C_EXAMPLES=ON \
			-D BUILD_EXAMPLES=ON \
			-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-$OPENCV_VERSION/modules \
			-D WITH_OPENGL=ON ..
RUN make -j $(nproc) 
RUN make install

RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf
RUN ldconfig

# **** CLEAN UP ****
RUN apt-get autoclean && apt-get clean

WORKDIR /
RUN rm -rf /tmp/*
