export CURRDIR=$(pwd)

# # Build Ceres
git clone https://ceres-solver.googlesource.com/ceres-solver
cd ceres-solver
git checkout 2.1.0 # Checkout the latest release
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=OFF -DEXPORT_BUILD_DIR=ON .. -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DBUILD_TESTS=OFF
make -j16
make install

cd $CURRDIR

# Build FreeImage
wget "https://sourceforge.net/projects/freeimage/files/Source Distribution/3.18.0/FreeImage3180.zip"
unzip FreeImage3180.zip
rm FreeImage3180.zip
cd FreeImage
make -j16
cp Dist/* $INSTALL_DIR
# Check that the compilation finished successfully.

cd $CURRDIR

git clone https://github.com/colmap/colmap.git
cd colmap
mkdir build
cd build
# For enabling CUDA the GL/glew.h include in sift.cc needs to be fixed. (outcomment the macro check).
# Then set cuda_enabled=ON
CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake .. -DCMAKE_BUILD_TYPE=Release \
    -DBoost_USE_STATIC_LIBS=ON \
    -DGUI_ENABLED=OFF \
    -DCUDA_ENABLED=OFF \
    -DCMAKE_CUDA_ARCHITECTURES="native" \
    -DTESTS_ENABLED=ON \
    -DCUDA_ARCHS="Pascal;Turing;Volta" \
    -DFREEIMAGE_INCLUDE_DIR_HINTS=$INSTALL_DIR \
    -DFREEIMAGE_LIBRARY_DIR_HINTS=$INSTALL_DIR \
    -DFLANN_INCLUDE_DIR_HINTS="${INSTALL_DIR}include" \
    -DFLANN_LIBRARY_DIR_HINTS="${INSTALL_DIR}lib" \
    -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR

# Check that the compilation finished successfully.
make -j16
# Check that tests pass.
ctest
# install library
make install

cd $CURRDIR

# Install pycolmap
git clone https://github.com/colmap/pycolmap.git --recursive
cd pycolmap
# comment out ba_global_use_pba and ba_global_pba_gpu_index
sed -i 's/\.def_readwrite("ba_global_use_pba"/\/\/\.def_readwrite("ba_global_use_pba"/g' pipeline/sfm.cc
sed -i 's/\.def_readwrite("ba_global_pba_gpu_index"/\/\/\.def_readwrite("ba_global_pba_gpu_index"/g' pipeline/sfm.cc
sed -i 's/\&Opts::ba_global_pba_gpu_index)/\/\/\&Opts::ba_global_pba_gpu_index)/g' pipeline/sfm.cc
pip install --user -e . -v

# Install pyceres
git clone https://github.com/cvg/pyceres.git --recursive
cd pycolmap
pip install --user -e . -v

cd $CURRDIR
