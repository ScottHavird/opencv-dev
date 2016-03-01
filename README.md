# opencv-dev
Docker file for setting up Opencv on ubuntu:14.04

# Setup notes 
1. cd /to/opencv-dev
2. docker build -t opencv-dev .
3. docker run -t -i opencv-dev /bin/bash
		The -i flag starts an interactive container. The -t flag creates a pseudo-TTY that attaches stdin and stdout.
4. cd /usr/local/share/OpenCV/samples/cpp

# Compile the cpp and run binary	 	
- $ g++ opencv_version.cpp -o opencv_version "`pkg-config --cflags --libs opencv`"
- $ ./opencv_version

