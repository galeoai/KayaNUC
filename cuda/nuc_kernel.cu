#include "nuc_kernel.h"

#define THREADS 512

__global__ void nuc(int *out, float *gain, float *offset, int size) {
    int i = blockIdx.x*blockDim.x + threadIdx.x;
    if (i<size) out[i] =(int)gain[i]*(out[i] - offset[i]);
}


void nucCaller(int *out, float *gain, float *offset, int n){
    // copy offset to device
    float *d_offset = NULL;
    cudaMalloc((void **)&d_offset, n*n*sizeof(float));
    cudaMemcpy(d_offset, offset, n*n*sizeof(float), cudaMemcpyHostToDevice);
    // copy gain to device
    float *d_gain = NULL;
    cudaMalloc((void **)&d_gain, n*n*sizeof(float));
    cudaMemcpy(d_gain, gain, n*n*sizeof(float), cudaMemcpyHostToDevice);

    int *d_out = NULL;
    cudaMalloc((void **)&d_out, n*n*sizeof(int));
    cudaMemcpy(d_out, out, n*n*sizeof(int), cudaMemcpyHostToDevice);

    int threadsPerBlock = THREADS;
    int blocksPerGrid =(n + threadsPerBlock - 1) / threadsPerBlock;

    nuc<<<blocksPerGrid,threadsPerBlock>>>(d_out, d_gain, d_offset,n);
    cudaMemcpy(out, d_out, n*n*sizeof(int), cudaMemcpyDeviceToHost);

    cudaFree(d_out);
    cudaFree(d_offset);
    cudaFree(d_gain);

    return;
};
