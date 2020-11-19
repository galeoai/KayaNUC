#include "nuc_kernel.h"
#include "opencv2/opencv.hpp"
#include "../read_tables/read_nuc.h"

using namespace cv;

#define N 2048*2048

int main(int argc, char *argv[]) {
    // open img from file
    Mat img = imread("./data/images/raw.tif", IMREAD_ANYDEPTH);

    float *offset, *gain;
    int *out;

    offset = (float *)malloc(N * sizeof(float));
    read_csv("./data/NUC/offset.csv", offset);
    gain = (float *)malloc(N * sizeof(float));
    read_csv("./data/NUC/gain.csv", gain);
    // Mat to *int
    out = img.ptr<int>(0);

    // run the NUC on the GPU
    nucCaller(out, gain, offset, N);

    imwrite("./data/images/NUC.tif", img);

    printf("done!\n");

    return 0;
}
