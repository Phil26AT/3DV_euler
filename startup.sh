# Optional: change the dir where all the libraries are installed to
# make sure the path ends with /
export INSTALL_DIR=$HOME/.local/

module load gcc/8.2.0 openmpi/4.1.4
module load cmake/3.11.0
module load gmp

module load boost eigen glog gflags glew

module load cgal suite-sparse atlas/0.9.9

module load mpfr

module load mesa mesa-glu metis

module load libxcb

module load cuda/11.0.3

module load python_gpu/3.8.5

module load hdf5 p7zip lz4

module load eth_proxy

export PATH="$PATH:${INSTALL_DIR}bin/"
# a bit hacky but serves the purpose of linking to custom libraries
export PATH=$PATH:$INSTALL_DIR
# add flann to path of colmap
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${INSTALL_DIR}lib/
