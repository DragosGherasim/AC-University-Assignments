#include <iostream>
#define DIM_MAX 10
typedef int Atom;

struct Stack {
	int top;
	Atom arr[DIM_MAX];
};

void initStack(Stack& stck) {
	stck.top = -1;
}

bool stackIsEmpty(const Stack& stck) {
	if (stck.top == -1)
		return true;
	return false;
}

Atom getStackTop(const Stack& stck) {
	return stck.arr[stck.top];
}

void popStack(Stack& stck) {
	--stck.top;
}

void pushStack(Stack& stck, Atom push_val) {
	++stck.top;
	stck.arr[stck.top] = push_val;
}

