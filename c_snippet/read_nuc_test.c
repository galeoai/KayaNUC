#include <stdio.h>
#include <stdlib.h>
#include "read_nuc.h"

#define N 2048

void print_matrix(float M[N][N]){
  for (int i = 0; i < 10; ++i) {
    for (int j = 0; j < 10; ++j) {
      printf("%f, ",M[i][j]);
    };
    printf("\n");
  };
}

int main(int argc, char *argv[])
{
  float offset[N][N];
  float gain[N][N];
  int ret;
  ret = read_csv("offset.csv", "gain.csv", offset, gain);
  if(ret==0) {
    printf("offset:\n");
    print_matrix(offset);
    printf("gain:\n");
    print_matrix(gain);
  }
  
  return 0;
}    
