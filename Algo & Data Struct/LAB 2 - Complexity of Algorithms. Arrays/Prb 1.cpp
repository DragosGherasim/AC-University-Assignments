#include <iostream>

//void max_secv(int arr[], int nrElem) { // O(n^2)
//	int index_start_secv{}, index_stop_secv{}, max{ -999 }, sum{};
//
//	for (int i{}; i < nrElem - 1 && arr[i] >= 0; ++i) {
//		sum = arr[i];
//
//		for (int j{ i + 1 }; j < nrElem; ++j)
//		{
//			sum += arr[j];
//			if (max < sum)
//			{
//				max = sum;
//				index_start_secv = i;
//				index_stop_secv = j;
//			}
//		}
//	}
//	
//	std::cout << "{ ";
//	for (int i{ index_start_secv }; i < index_stop_secv + 1; ++i)
//		std::cout << arr[i] << " ";
//	std::cout << "}.\n";
//}

void max_secv(int arr[], int nrElem) { //0(n)
	int sum_stg[11]{};
	sum_stg[0] = arr[0];
	for (int i{ 1 }; i <= nrElem; ++i)
		sum_stg[i] = arr[i] + sum_stg[i-1];
	
	int sum_drp[11]{};
	sum_drp[nrElem + 1] = arr[nrElem];
	for (int i{nrElem-1}; i >= 1; --i)
		sum_drp[i] = arr[i] + sum_drp[i + 1];
	
	int max_stg{ -999 }, max_drp{ -999 }, index_start_secv{}, index_stop_secv{};
	for (int i{ 1 }; i <= nrElem; ++i) {
		if (max_stg < sum_stg[i]) {
			max_stg = sum_stg[i];
			index_stop_secv = i;
		}

		if (max_drp < sum_drp[i]) {
			max_drp = sum_drp[i];
			index_start_secv = i;
		}
	}

	std::cout << "{ ";
	for (int i{ index_start_secv }; i < index_stop_secv + 1; ++i)
		std::cout << arr[i] << " ";
	std::cout << "}.\n";
	
}

int main()
{
	int arr[10]{}, nrElem{};
	std::cin >> nrElem;
	for (int i{1}; i <= nrElem; ++i)
		std::cin >> arr[i];

	max_secv(arr, nrElem);

	return 0;
}