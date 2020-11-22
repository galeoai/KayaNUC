#include "nuc_kernel.h"
#include <stdio.h>

#define THREADS 256

__global__ void nuc(int *out,const float *gain,const float *offset, int size) {
    int i = blockIdx.x*blockDim.x + threadIdx.x;
    if (i<size)	out[i] = (int)(gain[i]*(out[i] - offset[i]));
}


void nucCaller(int *out, float *gain, float *offset, int n){
    // copy offset to device
    float *d_offset = NULL;
    cudaMalloc((void **)&d_offset, n*sizeof(float));
    cudaMemcpy(d_offset, offset, n*sizeof(float), cudaMemcpyHostToDevice);
    // copy gain to device
    float *d_gain = NULL;
    cudaMalloc((void **)&d_gain, n*sizeof(float));
    cudaMemcpy(d_gain, gain, n*sizeof(float), cudaMemcpyHostToDevice);
    int *d_out = NULL;
    cudaMalloc((void **)&d_out, n*sizeof(int));
    cudaMemcpy(d_out, out, n*sizeof(int), cudaMemcpyHostToDevice);
    int threadsPerBlock = THREADS;
    int blocksPerGrid =(n + threadsPerBlock - 1) / threadsPerBlock;

    printf("%d, %d, %d, %d, %f, %f\n",
	   out[0], out[1], out[2], out[3], offset[4], gain[5]);

    nuc<<<blocksPerGrid,threadsPerBlock>>>(d_out, d_gain, d_offset,n);
    cudaMemcpy(out, d_out, n*sizeof(int), cudaMemcpyDeviceToHost);

    printf("%d, %d, %d, %d, %f, %f\n",
	   out[0], out[1], out[2], out[3], offset[4], gain[5]);
    cudaFree(d_out);
    cudaFree(d_offset);
    cudaFree(d_gain);

    return;
};
