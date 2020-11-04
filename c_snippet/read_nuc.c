#include <stdio.h>
#include <stdlib.h>

#define N 2048

int read_csv(const char *filename,
	     float *matrix){
  FILE * fp;
  
  fp = fopen(filename, "r");
  if(fp == NULL) {
    printf("can't find offset file\n");
    return 1;
  }
  for (int i = 0; i < N*N; i++) {
    fscanf(fp, "%f,",&matrix[i]);
  };
  fclose(fp);
  return 0;
}
