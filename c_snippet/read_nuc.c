#include <stdio.h>
#include <stdlib.h>

#define N 2048

int read_csv(const char *filename_offset,
	     const char *filename_gain,
	     float offset[N][N],
	     float gain[N][N]){
  FILE * fp;

  /* read offest file */
  fp = fopen(filename_offset, "r");
  if(fp == NULL) {
    printf("can't find offset file");
    return 1;
  }
  for (int i = 0; i < N; i++) {
    for (int j = 0; j<N; j++) {
      fscanf(fp, "%f,",&offset[i][j]);
    };
  };
  fclose(fp);
  /* read gain file */
  fp = fopen(filename_gain, "r");
  if(fp == NULL) {
    printf("can't find gain file");
    return 1;
  }
  for (int i = 0; i < N; i++) {
    for (int j = 0; j<N; j++) {
      fscanf(fp, "%f,",&gain[i][j]);
    };
  };
  fclose(fp);

  return 0;
}
