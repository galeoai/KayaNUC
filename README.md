# KayaNUC
NUC(Non Uniformity Correction) for NUC-less KAYA's cameras.

## Description
This package has two part. \
1. Julia code for generating the NUC tables from set of images.
2. C++/cuda code for Applying fast NUC on a raw image.

## Getting Started

### Dependencies
- opencv
- CUDA
- julia (for generating NUC)

### Generating NUC tables
Get in gen_tables folder
```
cd gen_tables
```

### Compiling CUDA code
Get in cuda folder
```
cd cuda
```
compile use make
```
make
```
run
```
./main
```

## TODO
- [X] Julia code for generating NUC tables
- [ ] make command line app for gen_table
- [X] Basic CUDA implementation
- [ ] better saving format (currently CSV)
- [ ] testing
- [ ] Integration with KAYA's framework

## Issues
Allocating 4mb on the stack (malloc) could cause segmentation fault. \
If so run this command to allow this allocation.
```
ulimit -s unlimited
```
