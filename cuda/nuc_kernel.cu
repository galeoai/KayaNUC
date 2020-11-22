#include "nuc_kernel.h"
#include <stdio.h>

#define THREADS 256

__global__ void nuc(uint16_t *out,const float *gain,const float *offset, int size) {
    int i = blockIdx.x*blockDim.x + threadIdx.x;
    if (i<size)	out[i] = (uint16_t)(gain[i]*(out[i] - offset[i]));
}


void nucCaller(uint16_t *out, float *gain, float *offset, int n){
    // copy offset to device
    float *d_offset = NULL;
    cudaMalloc((void **)&d_offset, n*sizeof(float));
    cudaMemcpy(d_offset, offset, n*sizeof(float), cudaMemcpyHostToDevice);
    // copy gain to device
    float *d_gain = NULL;
    cudaMalloc((void **)&d_gain, n*sizeof(float));
    cudaMemcpy(d_gain, gain, n*sizeof(float), cudaMemcpyHostToDevice);
    uint16_t *d_out = NULL;
    cudaMalloc((void **)&d_out, n*sizeof(uint16_t));
    cudaMemcpy(d_out, out, n*sizeof(uint16_t), cudaMemcpyHostToDevice);
    int threadsPerBlock = THREADS;
    int blocksPerGrid =(n + threadsPerBlock - 1) / threadsPerBlock;

    nuc<<<blocksPerGrid,threadsPerBlock>>>(d_out, d_gain, d_offset,n);
    cudaMemcpy(out, d_out, n*sizeof(uint16_t), cudaMemcpyDeviceToHost);

    cudaFree(d_out);
    cudaFree(d_offset);
    cudaFree(d_gain);

    return;
};
