#include <iostream>
typedef int Atom;

struct Node {
	Atom data;
	Node* next;
};

struct Queue {
	Node* head, * tail;
};

Queue initQ(void) {
	Queue q{};

	q.head = q.tail = nullptr;

	return q;
}

bool isEmpty(Queue q) {
	return (q.head == q.tail);
}

void putQ(Queue& q, Atom val) {
	Node* p{ new Node };
	p->data = val;
	p->next = nullptr;

	if (q.head == nullptr) {
		q.head = p;
		q.head->next = nullptr;
		q.tail = q.head;
		return;
	}

	if (isEmpty(q)) {
		q.tail = p;
		q.head->next = q.tail;
		return;
	}

	q.tail->next = p;
	q.tail = p;
}

Atom getQ(Queue& q) {
	Atom aux{};

	if (!isEmpty(q))
		aux = q.head->data ;

	Node* p{ q.head };
	q.head = q.head->next;

	if (q.head == nullptr)
		q.tail = nullptr;

	delete p;
	return aux;
}

Atom frontQ(Queue q) {
	return q.head->data;
}

int main() {
	Queue q{};

	q = initQ();

	std::cout << "\nNum Values : ";
	int num{}, val{};
	std::cin >> num;

	std::cout << "\nValues : ";
	for (int i{}; i < num; ++i) {
		std::cin >> val;
		putQ(q, val);
	}

	std::cout << "\nGet : " << getQ(q) << "\nFront : " << frontQ(q) << '\n';

	return 0;
}