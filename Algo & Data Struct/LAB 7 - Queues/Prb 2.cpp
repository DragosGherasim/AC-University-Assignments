#include <iostream>
constexpr auto dinmax = 10;
typedef int Atom;

struct Queue {
	int head, tail;
	Atom vect[dinmax];
};

int nextPos(int index) {
	if (index < dinmax-1)
		return index + 1;
	return 0;
}

bool isEmpty(const Queue& q) {
	return (q.head == q.tail);
}

bool isFull(const Queue& q) {
	return (nextPos(q.tail) == q.head);
}

void initQ(Queue& q) {
	q.tail = q.head = 0;
}

void putQ(Queue& q, Atom val) {
	if (!isFull(q)) {
		q.vect[q.tail] = val;
		q.tail = nextPos(q.tail);
	}
	else {
		std::cout << "\nQueue is full !\n";
		return;
	}
}

Atom getQ(Queue& q) {
	if (!isEmpty(q)) {
		Atom aux{ q.vect[q.head] };
		q.head = nextPos(q.head);
		return aux;
	}
	else {
		std::cout << "\nQueue is empty !\n";
		return 999;
	}
}

Atom frontQ(const Queue& q) {
	return q.vect[q.head];
}

int main() {
	Queue q{};
	initQ(q);

	std::cout << "\nNumber of elements : ";
	int num{}, val{};
	std::cin >> num;

	std::cout << "\nValue : ";
	for (int i{}; i < num; ++i) {
		std::cin >> val;
		putQ(q, val);
	}

	int get{ getQ(q) }, front{ frontQ(q) };
	
	std::cout << "\nGet : " << get << " Front : " << front << '\n';

	std::cout << "\nGet Values : ";
	for (int i{}; i < 3; ++i)
		std::cout << getQ(q) << " ";

	std::cout << "\nValue : ";
	while (!isFull(q)) {
		std::cin >> val;
		putQ(q, val);
	}

	return 0;
}