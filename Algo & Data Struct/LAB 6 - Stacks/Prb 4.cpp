#include <iostream>
#include <string>
constexpr auto DIM_MAX = 15;
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

void postfixedExpress(std::string math_exp, Stack& postfixed) {
	Stack operators{};
	initStack(operators);

	for (std::string::iterator it{ math_exp.begin() }; it != math_exp.end(); ++it) {
		if (*it >= '0' && *it <= '9') {
			pushStack(postfixed, *it - '0');
			continue;
		}
		if (*it == '+' || *it == '-') {
			if (getStackTop(operators) == '*' || getStackTop(operators) == '/') {
				do {
					pushStack(postfixed, getStackTop(operators));
					popStack(operators);
				} while (getStackTop(operators) != '(');

				pushStack(operators, *it);
			}
			else
				pushStack(operators, *it);

			continue;
		}

		if (*it == '(') {
			pushStack(operators, *it);
			continue;
		}

		if (*it == '*' || *it == '/') {
			pushStack(operators, *it);
			continue;
		}

		if (*it == ')') {
			do {
				pushStack(postfixed, getStackTop(operators));
				popStack(operators);
			} while (getStackTop(operators) != '(');

			popStack(operators);
		}
	}

	if (!stackIsEmpty(operators)) {
		do {
			pushStack(postfixed, getStackTop(operators));
			popStack(operators);
		} while (!stackIsEmpty(operators));
	}
}

int main() {
	std::string math_expres{};
	Stack postfixedexpres{}, evaluateexpress{};
	initStack(evaluateexpress);
	initStack(postfixedexpres);

	std::cout << "\nMath Ecuation : ";
	std::getline(std::cin, math_expres);

	postfixedExpress(math_expres, postfixedexpres);

	std::cout << "\nPostfixed Expression : ";
	for (int i{}; i <= postfixedexpres.top; ++i) {
		if (postfixedexpres.arr[i] >= 42 && postfixedexpres.arr[i] <= 47)
			std::cout << static_cast<char>(postfixedexpres.arr[i]);
		else
			std::cout << postfixedexpres.arr[i];

		

		Atom t1{}, t2{};
		if (postfixedexpres.arr[i] >= 0 && postfixedexpres.arr[i] <= 9) {
			pushStack(evaluateexpress, postfixedexpres.arr[i]);
			continue;
		}

		if (postfixedexpres.arr[i] == 42) {
			t2 = getStackTop(evaluateexpress);
			popStack(evaluateexpress);
			t1 = getStackTop(evaluateexpress);
			popStack(evaluateexpress);
			pushStack(evaluateexpress, t1 * t2);
			continue;
		}

		if (postfixedexpres.arr[i] == 43) {
			t2 = getStackTop(evaluateexpress);
			popStack(evaluateexpress);
			t1 = getStackTop(evaluateexpress);
			popStack(evaluateexpress);
			pushStack(evaluateexpress, t1 + t2);
			continue;
		}

		if (postfixedexpres.arr[i] == 45) {
			t2 = getStackTop(evaluateexpress);
			popStack(evaluateexpress);
			t1 = getStackTop(evaluateexpress);
			popStack(evaluateexpress);
			pushStack(evaluateexpress, t1 - t2);
			continue;
		}

		if (postfixedexpres.arr[i] == 47) {
			t2 = getStackTop(evaluateexpress);
			popStack(evaluateexpress);
			t1 = getStackTop(evaluateexpress);
			popStack(evaluateexpress);
			pushStack(evaluateexpress, t1 / t2);
			continue;
		}
	}

	std::cout << "\nThe result of the math ecuation : " << getStackTop(evaluateexpress) << '\n';

	std::cout << '\n';

	return 0;
}