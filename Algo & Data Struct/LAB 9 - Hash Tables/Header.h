#pragma once
#include <iostream>
#include <string>
#include <fstream>
#define M 83 // prim, si cate mai departe de o putere a lui 2

struct Node {
	char* key;
	Node* next;
};

void initHT(Node* HT[]) {
	for (int i{}; i < M; ++i)
		HT[i] = nullptr;
}

int f(char* key) { // dispersia modulara
	int sum{};

	for (int i{}; i < std::strlen(key); ++i) // se transforma cheia intr-un nr nat
		sum += *(key + i);
	return sum % M;
}

Node* find(Node* HT[], char* key) {
	int h{ f(key) };
	Node* p{ HT[h] };

	while (p != nullptr) {
		if (std::strcmp(key, p->key) == 0)
			return p;
		p = p->next;
	}

	return nullptr;
}

void readFileInputHT(Node* HT[]) {
	std::ifstream file;
	file.open("dictionar.txt");

	if (file.is_open()) {
		char* key{new char[20]};

		while (file >> key) {
			Node* p{ new Node };
			p->key = new char[20];
			strcpy_s(p->key, 20, key);
			int h{ f(key) }; // valoare hash

			if (HT[h] == nullptr) {
				p->next = nullptr;
				HT[h] = p;
			}
			else {
				Node* q{ find(HT, key) };
				if (q == nullptr) {
					p->next = HT[h];
					HT[h] = p;
				}
				else {
					std::cout << "\nElementul este deja in TH ! ( " << p->key << " )";
				}
			}
		}
	}

	file.close();
}

void displayHT(Node* HT[]) {

	std::cout << "\n\tWords from 'dictionar.txt' : \n";
	for (int i{}; i < M; ++i) {
		if (HT[i] != nullptr) {
			Node* p{ HT[i] };

			while (p != nullptr) {
				std::cout << p->key << '\n';
				p = p->next;
			}
		}
	}
}

void writeFile() {
	std::ofstream file;
	file.open("Text.txt");

	if (file.is_open()) {
		char* input_text{ new char[200] };
		std::cout << "\nType a text : \n";
		std::cin.getline(input_text, 500);
		file << input_text;
	}

	file.close();
}

void checkWords(Node* HT[]) {
	std::ifstream file;
	file.open("Text.txt");

	if (file.is_open()) {
		char* key{ new char[20] };

		while (file >> key) {
			Node* p{ find(HT, key) };

			if (p == nullptr)
				std::cout << "\nThe word : " << key << " , from the text, is incorrect !";
		}
	}

	std::cout << '\n';
}

void deleteKey(Node* HT[], char* delete_key) {
	int h{ f(delete_key) }, count{};
	Node* p{ HT[h] }, * temp{}, * last{};

	if (p != nullptr) {
		while (std::strcmp(p->key, delete_key) != 0) {
			++count;
			last = p;
			p = p->next;
		}

		if (count == 0) {
			temp = HT[h];

			if (HT[h]->next != nullptr)
				HT[h] = HT[h]->next;
			else
				HT[h] = nullptr;

			delete temp;
		}
		else {
			last->next = last->next->next;
			delete p;
		}
	}
}