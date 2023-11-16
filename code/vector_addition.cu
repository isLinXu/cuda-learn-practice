//
// Created by gatilin on 2023/11/16.
//
#include <iostream>
#include <cmath>
#include <cassert>

// CUDA kernel for vector addition
__global__ void vectorAdd(int *a, int *b, int *c, int N) {
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if (i < N) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    int N = 1 << 20;
    size_t bytes = N * sizeof(int);

    int *a, *b, *c;
    cudaMallocManaged(&a, bytes);
    cudaMallocManaged(&b, bytes);
    cudaMallocManaged(&c, bytes);

    for (int i = 0; i < N; i++) {
        a[i] = rand() % 100;
        b[i] = rand() % 100;
    }

    int blockSize = 256;
    int gridSize = (N + blockSize - 1) / blockSize;

    vectorAdd<<<gridSize, blockSize>>>(a, b, c, N);
    cudaDeviceSynchronize();

    // Verify the result
    for (int i = 0; i < N; i++) {
        assert(c[i] == a[i] + b[i]);
    }

    std::cout << "COMPLETED SUCCESSFULLY\n";

    cudaFree(a);
    cudaFree(b);
    cudaFree(c);

    return 0;
}