#include <iostream>

void citire2DArray(int* A, int nl, int nc) {
	for (int i{}; i < nl; ++i)
		for (int j{}; j < nc; ++j)
			std::cin >> (A + i*nc)[j];
}

void afisareValoare(int* A, int nl, int c1, int c2) {
	std::cout << "Valoare este : " << A[c1 * nl + c2] << '\n';
}

void afisare2DArray(int* A, int nl, int nc) {
	for (int i{}; i < nl; ++i) {
		for (int j{}; j < nc; ++j)
			std::cout << (A + i * nc)[j] << ' ';
		std::cout << '\n';
	}
}

void afisareMax(int* A, int nl, int nc) {
	int max{ A[0] }, c{}, l{};

	for (int i{ 1 }; i < nl * nc; ++i)
		if (max < A[i]) {
			l = i / nl;
			c = i % nl;
		}

	std::cout << "Valoarea maxima : " << A[nl * l + c];
}

int main()
{
	int nl{}, nc{};
	std::cin >> nl >> nc;
	int* A = new int[nl * nc];

	citire2DArray(A, nl, nc);
	
	int c1{}, c2{};
	std::cout << "Coordonatele : ";
	std::cin >> c1 >> c2;
	afisareValoare(A, nl, c1, c2);

	afisare2DArray(A, nl, nc);

	afisareMax(A, nl, nc);

	delete[] A;
	return 0;
}