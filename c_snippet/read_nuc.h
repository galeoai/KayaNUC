#ifndef FUNCTIONS_H_INCLUDED
#define FUNCTIONS_H_INCLUDED

/* Prototypes for the functions */

#define N 2048

int read_csv(const char *filename_offset,
	     const char *filename_gain,
	     float offset[N][N],
	     float gain[N][N]);

#endif
