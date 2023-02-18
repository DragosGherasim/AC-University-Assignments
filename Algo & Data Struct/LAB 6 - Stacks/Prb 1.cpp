#include <iostream>
#define DIM_MAX 10
typedef int Atom;

struct Stack {
	int top;
	Atom arr[DIM_MAX];
};


void initStack(Stack& s) {
	s.top = -1;
}

void push(Stack& s, Atom val) {
	++s.top;
	s.arr[s.top] = val;
}

void pop(Stack& s) {
	--s.top;
}

bool isEmpty(const Stack &s) {
	if (s.top == -1)
		return true;

	return false;
}

bool top(const Stack &s, Atom& top_val) {
	if (isEmpty(s)) {
		std::cout << "\nThe stack is empty !\n";
		return false;
	}

	top_val = s.arr[s.top];
	return true;
}

int main() {
	Stack s{};
	
	initStack(s);

	std::cout << "\nHow many elements do you want to push in the stack : ";
	int num{};
	std::cin >> num;

	std::cout << "\nInput Elem : ";
	Atom elem{};
	for (int i{}; i < num; ++i) {
		std::cin >> elem;
		push(s, elem);
	}

	Atom top_val{};
	if (top(s, top_val))
		std::cout << "\nTop Value : " << top_val << '\n';

	pop(s);
	if (top(s, top_val))
		std::cout << "\nTop Value : " << top_val << '\n';

	return 0;
}