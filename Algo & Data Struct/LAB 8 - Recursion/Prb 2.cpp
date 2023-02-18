#include <iostream>
#include <algorithm>
int resultHistory[100]{};


int SolOptFib(int n) {
	if (n < 2)
		return 1;

	if (resultHistory[n] != -1)
		return resultHistory[n];

	int rez = SolOptFib(n - 2) + SolOptFib(n-1);
	resultHistory[n] = rez;
	return rez;
}

int main() {
	std::cout << SolOptFib(5);

	return 0;
}