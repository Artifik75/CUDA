#include <stdio.h>
#include <iostream>
#include <cstdlib>
#include<chrono>
 

int main(void) {

    double gammaEulera = 0.; 
    double N = 1000000;;  

    auto start = std::chrono::high_resolution_clock::now();

        for (int i = 1; i < N; i++)
        gammaEulera = gammaEulera + (1. / (double)i); 

    gammaEulera = gammaEulera - log(N);

  auto finish = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsed = finish - start;

    

    printf("Przyblizona wartosc eulera CPU wynosi %f \n",gammaEulera );
    printf("Czas wynosi %f",elapsed.count());
    return 0;
}

 