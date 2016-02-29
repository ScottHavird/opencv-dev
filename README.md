# opencv-dev
Docker file for setting up Opencv on ubuntu:14.04

# ******** NOTES ********
# cd /to/opencv-dev
# docker build -t opencv-dev .
# docker run -t -i opencv-dev /bin/bash
#		The -i flag starts an interactive container. The -t flag creates a pseudo-TTY that attaches stdin and stdout.
# cd /usr/local/share/OpenCV/samples/cpp


# compile the cpp	 	$ g++ opencv_version.cpp -o opencv_version `pkg-config --cflags --libs opencv`
# run the new program	$ ./opencv_version

# *** CMAKE ****
# compile the cpp	 	$ g++ opencv_version.cpp -o opencv_version `pkg-config --cflags --libs opencv`
# run the new program	$ ./opencv_version
