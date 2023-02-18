#include <iostream>

void cautare_matrice(int m[][100], int nrl, int nrc, int target) {
	int mij_lin{}, mij_col{}, low_lin{ 0 }, high_lin{ nrl - 1 }, low_col{ 0 }, high_col{ nrc - 1 };
	bool ok = false;
	while (low_lin < high_lin) {
		mij_lin = (low_lin + high_lin) / 2;

		if (m[mij_lin][0] == target) {
			std::cout << "Elementul cautat se afla la coordonatele : " << mij_lin << ' ' << 0 << '\n';
			ok = true;
			break;
		}
		else
			if (m[mij_lin][0] > target) 
				high_lin = mij_lin - 1;
			else
				low_lin = mij_lin + 1;
	}

	while (low_col <= high_col && ok == false) {
		mij_col = (low_col + high_col) / 2;

		if (m[high_lin][mij_col] == target) {
			std::cout << "Elementul cautat se afla la coordonatele : " << high_lin << ' ' << mij_col << '\n';
			break;
		}
		else
			if (m[high_lin][mij_col] > target)
				high_col = mij_col - 1;
			else
				low_col = mij_col + 1;
	}
}

int main() {
	int matrix[10][100]{}, nrc{}, nrl{}, target{};
	std::cin >> nrl >> nrc;
	
	for (int i{}; i < nrl; ++i)
		for (int j{}; j < nrc; ++j)
			std::cin >> matrix[i][j];

	std::cin >> target;
	cautare_matrice(matrix, nrl, nrc, target);

	return 0;
}