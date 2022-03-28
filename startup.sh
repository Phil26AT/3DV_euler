# Optional: change the dir where all the libraries are installed to
export INSTALL_DIR=$HOME/.local/

module load gcc/6.3.0
module load cmake/3.11.0

module load boost eigen glog gflags glew

module load cgal suite-sparse atlas

module load mpfr

module load mesa mesa-glu metis

module load libxcb

module load cuda/11.0.3

module load python_gpu/3.8.5

module load hdf5 p7zip lz4

module load eth_proxy

export PATH="$PATH:${INSTALL_DIR}bin/"
export PATH=$PATH:$INSTALL_DIR # a bit hacky but serves the purpose of linking to custom libraries