# 3DV_euler
Install scripts for 3DV libraries (COLMAP, PCL) on the Euler Cluster.

# Tutorial
In `startup.sh`, you can define the path (`INSTALL_DIR`) where all packages will be installed to.
Default is `$HOME/.local/`

Then:

```
# log into the euler cluster, home directory
git clone https://github.com/Phil26AT/3DV_euler.git
cd 3DV_euler
source startup.sh
srun --gpus=1 -n 16 --mem-per-cpu=4096 --pty bash

# make gpu adjustments if required

source install_flann.sh
source install_colmap.sh

colmap -h

source install_pcl.sh

# stop the interactive shell session
exit
```

After having everything installed once, you can just load the environment at the next login:

```
source startup.sh

colmap -h
```

If you want to automatically run `setup.sh` on every login, you can add the following lines to your `~/.bash_profile`:

```
if [ -f <path-to-startup.sh> ]; 
then 
    source <path-to-startup.sh>; 
fi
```

## Cuda support

COLMAP will be built without CUDA support by default. Though, it's possible to define to build with 
cuda support by setting `CUDA_ENABLED=ON` in `install_colmap.sh` and outcommenting lines #39 and #41
in https://github.com/colmap/colmap/src/feature/sift.cc. You should also add the following line at the beginning of `colmap/CMakeLists.txt``:
```
set(CMAKE_CUDA_ARCHITECTURES native)
```
or you can just run `make_cuda.sh` before installing colmap:
```
source make_cuda.sh
```