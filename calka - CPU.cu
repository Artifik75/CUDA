#include<chrono>
#include<iostream>
#include<math.h>

// Define function here /
#define f(x) 4*(1/(1+pow(x,2)))

using namespace std;
int main()
{
	float lower, upper, integration = 0.0, stepSize, k;
	int i, subInterval;

	// Input /
	lower = 0;
	upper = 1;
	cout << "Enter number of sub intervals: ";
	cin >> subInterval;

	// Calculation /

	// Finding step size /
	stepSize = (upper - lower) / subInterval;

	// Finding Integration Value /
	integration = f(lower) + f(upper);
	auto start = std::chrono::high_resolution_clock::now();
	for (i = 1; i <= subInterval - 1; i++)
	{
		k = lower + i * stepSize;
		integration = integration + 2 * (f(k));
	}

	integration = integration * stepSize / 2;
	auto finish = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> elapsed = finish - start;

	cout << endl << "Required value of integration is: " << integration;
	cout << endl << "Duration of calculations is: " << elapsed.count();

	return 0;
}