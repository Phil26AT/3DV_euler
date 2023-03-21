echo "Setting CUDA_ENABLED=ON"
sed -i 's/-DCUDA_ENABLED=OFF/-DCUDA_ENABLED=ON/' install_colmap.sh
echo "Cloning COLMAP"
git clone https://github.com/colmap/colmap.git
cd colmap
echo "Commenting line 39 and 41 in colmap/src/feature/sift.cc"
sed -i '39s/^/\/\/ /;41s/^/\/\/ /' src/feature/sift.cc
echo "Adding CMAKE_CUDA_ARCHITECTURES to 'native' to colmap/CMakeLists.txt"
sed -i '/^#.*$/a set(CMAKE_CUDA_ARCHITECTURES native)' CMakeLists.txt
cd ..
