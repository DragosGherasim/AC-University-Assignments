#include <iostream>
typedef int Atom;

struct Node {
	Atom data;
	Node* next;
};

struct Stack {
	Node* top;
};

void initStack(Stack& s) {
	s.top = nullptr;
}

bool isEmpty(Stack s) {
	if (s.top)
		return false;
	return true;
}

void push(Stack& s, Atom val) {
	if (isEmpty(s)) {
		s.top = new Node;
		s.top->data = val;
		s.top->next = nullptr;
	}
	else {
		Node* p = new Node;
		p->data = val;
		p->next = s.top;
		s.top = p;
	}
}

bool pop(Stack& s) {
	if (isEmpty(s)) {
		std::cout << "\nStack is empty !\n";
		return false;
	}

	Node* p{ s.top };
	s.top = s.top->next;
	delete p;
	return true;
}

bool top(Stack s) {
	if (isEmpty(s)) {
		std::cout << "\nStack is empty !\n";
		return false;
	}

	std::cout << "\nTop Value : " << s.top->data << '\n';
	return true;
}


int main() {
	Stack s{};

	initStack(s);

	std::cout << "\nNumber of elements in stack : ";
	int num{};
	std::cin >> num;

	std::cout << "\nInput Elements : ";
	Atom elem{};
	for (int i{}; i < num; ++i) {
		std::cin >> elem;
		push(s, elem);
	}

	if (top(s));
	if (pop(s));
	if (top(s));

	return 0;
}