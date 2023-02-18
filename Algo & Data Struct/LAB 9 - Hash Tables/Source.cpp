#include "Header.h"

int main(){
	Node* HT[M]; // tablou de pointeri alocat static
	initHT(HT);
	readFileInputHT(HT);
	displayHT(HT);

	std::cout << "\nEnter the key you want to delete : ";
	char* delete_key{new char [20]};
	std::cin >> delete_key;
	std::cin.ignore();
	deleteKey(HT, delete_key);

	writeFile();
	checkWords(HT);

	return 0;
}