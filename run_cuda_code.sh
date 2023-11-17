set -x
source=code/hello_cuda.cu
target=hello_cuda
nvcc $source -o $target
./$target