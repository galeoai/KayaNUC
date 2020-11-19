CXX=g++
CUDA_INSTALL_PATH=/usr/local/cuda
CFLAGS= -I. -I$(CUDA_INSTALL_PATH)/include `pkg-config --cflags opencv4`

all:
	$(CXX) $(CFLAGS) -c main.cpp -o main.o
	$(CXX) $(CFLAGS) -c ../read_tables/read_nuc.cpp -o read_nuc.o
	nvcc $(CUDAFLAGS) -c nuc_kernel.cu -o kernel.o
	$(CXX)  main.o read_nuc.o `pkg-config --libs opencv4 cuda-10.2` kernel.o -lcudart -o main

clean:
	rm -f *.o main

