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
bsub -I -W 03:59 -n 16 -R "rusage[mem=4096,ngpus_excl_p=1]" csh
source install_colmap.sh

colmap -h

source_install_pcl.sh

# stop the interactive shell session
exit
```

COLMAP will be built without CUDA support by default. Though, it's possible to define to build with cuda support
by setting `CUDA_ENABLED=ON` in `install_colmap.sh` and outcommenting lines #39 and #41 in https://github.com/colmap/colmap/blob/dev/src/feature/sift.cc.

After having everything installed once, you can just load the environment at the next login:

```
source startup.sh

colmap -h
```