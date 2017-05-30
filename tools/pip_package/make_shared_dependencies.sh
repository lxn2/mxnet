#!/usr/bin/env bash

# Dependencies that are shared by variants are:
ZLIB_VERSION=1.2.6
JPEG_VERSION=8.4.0
PNG_VERSION=1.5.10
TIFF_VERSION=3.8.2
OPENCV_VERSION=3.2.0


# Set up shared dependencies:
# Download and build zlib
echo "Building zlib..."
curl -s -L https://github.com/LuaDist/zlib/archive/$ZLIB_VERSION.zip -o $DEPS_PATH/zlib.zip
unzip -q $DEPS_PATH/zlib.zip -d $DEPS_PATH
mkdir $DEPS_PATH/zlib-$ZLIB_VERSION/build
cd $DEPS_PATH/zlib-$ZLIB_VERSION/build
cmake -q \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=$DEPS_PATH \
      -D BUILD_SHARED_LIBS=OFF .. || exit 1;
make --quiet -j $NUM_PROC || exit 1;
make install;
cd -;

# download and build libjpeg
echo "Building libjpeg..."
curl -s -L https://github.com/LuaDist/libjpeg/archive/$JPEG_VERSION.zip -o $DEPS_PATH/libjpeg.zip
unzip -q $DEPS_PATH/libjpeg.zip -d $DEPS_PATH
cd $DEPS_PATH/libjpeg-$JPEG_VERSION
./configure --quiet --disable-shared --prefix=$DEPS_PATH || exit 1
make --quiet -j $NUM_PROC || exit 1;
make test || exit 1;
make install;
cd -

# download and build libpng
echo "Building libpng..."
curl -s -L https://github.com/LuaDist/libpng/archive/$PNG_VERSION.zip -o $DEPS_PATH/libpng.zip
unzip -q $DEPS_PATH/libpng.zip -d $DEPS_PATH
mkdir $DEPS_PATH/libpng-$PNG_VERSION/build
cd $DEPS_PATH/libpng-$PNG_VERSION/build
cmake -q \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=$DEPS_PATH \
      -D PNG_CONFIGURE_LIBPNG=-fPIC \
      -D BUILD_SHARED_LIBS=OFF .. || exit 1;
make --quiet -j $NUM_PROC || exit 1;
make install
cd -

# download and build libtiff
echo "Building libtiff..."
curl -s -L https://github.com/LuaDist/libtiff/archive/$TIFF_VERSION.zip -o $DEPS_PATH/libtiff.zip
unzip -q $DEPS_PATH/libtiff.zip -d $DEPS_PATH
cd $DEPS_PATH/libtiff-$TIFF_VERSION
./configure --quiet --disable-shared --prefix=$DEPS_PATH || exit 1;
make --quiet -j $NUM_PROC || exit 1;
make install
cd -

# download and build opencv since we need the static library
echo "Building opencv..."
curl -s -L https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip -o $DEPS_PATH/opencv.zip
unzip -q $DEPS_PATH/opencv.zip -d $DEPS_PATH
mkdir $DEPS_PATH/opencv-$OPENCV_VERSION/build
cd $DEPS_PATH/opencv-$OPENCV_VERSION/build
cmake -q \
      -D OPENCV_ENABLE_NONFREE=OFF \
      -D WITH_1394=OFF \
      -D WITH_ARAVIS=ON \
      -D WITH_AVFOUNDATION=OFF \
      -D WITH_CAROTENE=OFF \
      -D WITH_CLP=OFF \
      -D WITH_CSTRIPES=OFF \
      -D WITH_CUBLAS=OFF \
      -D WITH_CUDA=OFF \
      -D WITH_CUFFT=OFF \
      -D WITH_DIRECTX=OFF \
      -D WITH_DSHOW=OFF \
      -D WITH_EIGEN=OFF \
      -D WITH_FFMPEG=OFF \
      -D WITH_GDAL=OFF \
      -D WITH_GDCM=ON \
      -D WITH_GIGEAPI=ON \
      -D WITH_GPHOTO2=OFF \
      -D WITH_GSTREAMER=OFF \
      -D WITH_GSTREAMER_0_10=OFF \
      -D WITH_GTK=OFF \
      -D WITH_IMAGEIO=OFF \
      -D WITH_INTELPERC=OFF \
      -D WITH_IPP=OFF \
      -D WITH_IPP_A=OFF \
      -D WITH_JASPER=OFF \
      -D WITH_JPEG=ON \
      -D WITH_LAPACK=OFF \
      -D WITH_LIBV4L=OFF \
      -D WITH_MATLAB=OFF \
      -D WITH_MSMF=OFF \
      -D WITH_OPENCL=OFF \
      -D WITH_OPENCLAMDBLAS=OFF \
      -D WITH_OPENCLAMDFFT=OFF \
      -D WITH_OPENCL_SVM=OFF \
      -D WITH_OPENEXR=OFF \
      -D WITH_OPENGL=OFF \
      -D WITH_OPENMP=OFF \
      -D WITH_OPENNI2=OFF \
      -D WITH_OPENNI=OFF \
      -D WITH_OPENVX=OFF \
      -D WITH_PNG=ON \
      -D WITH_PTHREADS_PF=OFF \
      -D WITH_PVAPI=ON \
      -D WITH_QT=OFF \
      -D WITH_QTKIT=OFF \
      -D WITH_QUICKTIME=OFF \
      -D WITH_TBB=OFF \
      -D WITH_TIFF=ON \
      -D WITH_UNICAP=OFF \
      -D WITH_V4L=OFF \
      -D WITH_VA=OFF \
      -D WITH_VA_INTEL=OFF \
      -D WITH_VFW=OFF \
      -D WITH_VTK=OFF \
      -D WITH_WEBP=OFF \
      -D WITH_WIN32UI=OFF \
      -D WITH_XIMEA=OFF \
      -D WITH_XINE=OFF \
      -D BUILD_SHARED_LIBS=OFF \
      -D BUILD_opencv_apps=OFF \
      -D BUILD_ANDROID_EXAMPLES=OFF \
      -D BUILD_DOCS=OFF \
      -D BUILD_EXAMPLES=OFF \
      -D BUILD_PACKAGE=OFF \
      -D BUILD_PERF_TESTS=OFF \
      -D BUILD_TESTS=OFF \
      -D BUILD_WITH_DEBUG_INFO=OFF \
      -D BUILD_WITH_DYNAMIC_IPP=OFF \
      -D BUILD_FAT_JAVA_LIB=OFF \
      -D BUILD_CUDA_STUBS=OFF \
      -D BUILD_ZLIB=OFF \
      -D BUILD_TIFF=OFF \
      -D BUILD_JASPER=OFF \
      -D BUILD_JPEG=OFF \
      -D BUILD_PNG=OFF \
      -D BUILD_OPENEXR=OFF \
      -D BUILD_TBB=OFF \
      -D BUILD_opencv_calib3d=OFF \
      -D BUILD_opencv_contrib=OFF \
      -D BUILD_opencv_features2d=OFF \
      -D BUILD_opencv_flann=OFF \
      -D BUILD_opencv_gpu=OFF \
      -D BUILD_opencv_ml=OFF \
      -D BUILD_opencv_nonfree=OFF \
      -D BUILD_opencv_objdetect=OFF \
      -D BUILD_opencv_photo=OFF \
      -D BUILD_opencv_python=OFF \
      -D BUILD_opencv_video=OFF \
      -D BUILD_opencv_videostab=OFF \
      -D BUILD_opencv_world=OFF \
      -D BUILD_opencv_highgui=OFF \
      -D BUILD_opencv_viz=OFF \
      -D BUILD_opencv_videoio=OFF \
      -D CMAKE_LIBRARY_PATH=$DEPS_PATH/lib \
      -D CMAKE_INCLUDE_PATH=$DEPS_PATH/include \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=$DEPS_PATH .. || exit 1;
make --quiet -j $NUM_PROC || exit 1;
make install; # user will always have access to home, so no sudo needed
cd -;

# @szha: this is a hack to use the compatibility header
cat $DEPS_PATH/include/opencv2/imgcodecs/imgcodecs_c.h >> $DEPS_PATH/include/opencv2/imgcodecs.hpp
