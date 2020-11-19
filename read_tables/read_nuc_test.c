#include <stdio.h>
#include <stdlib.h>
#include "read_nuc.h"

#define N 2048

void print_matrix(float *M){
  for (int j = 0; j < 10; j++) {
    for (int i = 0; i < 10; i++) {
      printf("%f, ",M[i+N*j]);
    };
    printf("\n");
  };
}

int main(int argc, char *argv[])
{
  float *offset, *gain;
  int ret;
  offset = (float *)malloc(N*N*sizeof(float));
  gain   = (float *)malloc(N*N*sizeof(float));
  ret = read_csv("offset.csv", offset);
  if(ret==0) {
    printf("offset:\n");
    print_matrix(offset);
  }
  ret = read_csv("gain.csv", gain);
  if(ret==0) {
    printf("gain:\n");
    print_matrix(gain);
  }
  
  return 0;
}    
