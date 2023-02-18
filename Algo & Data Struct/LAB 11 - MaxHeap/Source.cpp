#include <iostream>
typedef int Atom;
#define DINMAX 30

struct MaxHeap {
	Atom H[DINMAX];
	int n;
};

void swap(Atom& x, Atom& y) {
	Atom aux{};
	aux = x;
	x = y;
	y = aux;
}

void insertHeap(MaxHeap& h, Atom val) {
	int child{}, parent{};
	h.H[h.n+1] = val;
	h.n += 1;
	
	child = h.n;
	parent = h.n / 2;

	while (parent >= 1) {
		if (h.H[child] > h.H[parent]) {
			swap(h.H[child], h.H[parent]);
			child = parent;
			parent = child / 2;
		}
		else
			parent = 0;
	}
}


void builtHeap(MaxHeap& h) {
	Atom val{};
	std::cout << "\nInsert values until '0' : ";
	std::cin >> val;
	h.H[h.n+1] = val;
	h.n += 1;

	std::cin >> val;
	do {
		insertHeap(h, val);
		std::cin >> val;
	} while (val != 0);
}

int removeMax(MaxHeap& h) {
	int max{ h.H[1] }, parent{ 1 }, child{ 2 };
	h.H[1] = h.H[h.n];

	h.n -= 1;
	
	while (child <= h.n) {
		if (child + 1 <= h.n && h.H[child + 1] > h.H[child])
			child += 1;

		if (h.H[parent] < h.H[child]) {
			swap(h.H[child], h.H[parent]);
			parent = child;
			child = 2 * parent;
		}
		else {
			child = h.n + 1;
		}
	}

	return max;
}

int main() {
	MaxHeap heap{};
	builtHeap(heap);

	return 0;
}