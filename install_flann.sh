echo "Downloading flann"
git clone https://github.com/flann-lib/flann.git

echo "Installing flann"
cd flann
# Fix missing sources bug
sed -e '/add_library(flann_cpp SHARED/ s/""/empty.cpp/' \
-e '/add_library(flann SHARED/ s/""/empty.cpp/' \
-i src/cpp/CMakeLists.txt
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release -DBUILD_PYTHON_BINDINGS=off -DBUILD_MATLAB_BINDINGS=off -DBUILD_EXAMPLES=off -DBUILD_DOC=off
make -j4
make install
echo "Finished: flann is ready to be used"
cd ../..