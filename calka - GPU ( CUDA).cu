#include<iostream>
#include<chrono>

 __global__ void integratorKernel(float *a, int N)
{int idx = blockIdx.x * blockDim.x + threadIdx.x;
float x = (float)idx / (float)N;

if(idx < N) 
a[idx] = 1/(1+x*x);
}

float cudaIntegrate(int N)
{
// size of the arrays in bytessize_t 
float size = N * sizeof(float);

// allocate array on host and device
float* a_h = (float *)malloc(size);
float* a_d; cudaMalloc((void **) &a_d, size);

// do calculation on device
int block_size = 256;
int n_blocks = N/block_size + (N % block_size == 0 ? 0:1);
integratorKernel <<< n_blocks, block_size >>> (a_d, N);

// copy results from device to host
cudaMemcpy(a_h, a_d, sizeof(float)*N, cudaMemcpyDeviceToHost);
// add up resultsfloat 
float sum = 0;
for (int i=0; i < N; i++) 
sum += a_h[i];
sum *= 1.0 / (float)N;;

// clean up
free(a_h); 
cudaFree(a_d);
return sum;
}

int main(int argc, char** argv){
    auto start = std::chrono::high_resolution_clock::now();

float x = cudaIntegrate(10000000000);
x=x*4;
auto finish = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsed = finish - start;

printf("Przyblizona wartosc calki dla GPU wynosi %f \n",x );
printf("Przyblizona czas calki wynosi %f",elapsed.count());

}



