source install_flann.sh
wget https://github.com/PointCloudLibrary/pcl/archive/refs/tags/pcl-1.12.1.tar.gz
tar xvf pcl-1.12.1.tar.gz
cd pcl-pcl-1.12.1
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR
make -j16
make install
cd ../..
