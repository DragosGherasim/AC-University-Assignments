#include <iostream>

struct Node {
	int three_digits;
	Node* next, * prev;
};

struct longNumber {
	int length;
	Node* head;
};

void createLongNumber(longNumber& number) {
	std::cout << "\nInput the long number : ";
	long long int long_number{}, num_digits{}, temp_number{};
	std::cin >> long_number;
	temp_number = long_number;

	while (temp_number) {
		temp_number /= 10;
		++num_digits;
	}

	number.length = num_digits / 3;

	if (num_digits % 3 != 0)
		++number.length;

	Node* new_node{ nullptr }, * last{ nullptr };
	int count_nodes{ 1 };

	number.head = new Node;
	number.head->three_digits = long_number / pow(10, (number.length - count_nodes) * 3);
	number.head->next = nullptr;
	number.head->prev = nullptr;
	last = number.head;

	long_number -= number.head->three_digits * pow(10 ,(number.length - count_nodes) * 3);
	++count_nodes;

	while (long_number) {
		new_node = new Node;
		new_node->three_digits = long_number / pow(10, (number.length - count_nodes) * 3);
		new_node->next = nullptr;
		new_node->prev = last;
		last->next = new_node;
		last = new_node;
		long_number -= last->three_digits * pow(10, (number.length - count_nodes) * 3);
		++count_nodes;
	}

	last->next = number.head;
	number.head->prev = last;
}

void displayLongNumber(longNumber number) {
	Node* p{ number.head };
	
	std::cout << '\n';
	while (p->next != number.head) {
		std::cout << p->three_digits;
		p = p->next;
	}

	std::cout << p->three_digits << '\n';
}

void insertInFront(longNumber& number) {
	std::cout << "\nInsert the new group of digits (max 3 digits) : ";
	int new_digits{};
	std::cin >> new_digits;

	Node *new_node{ new Node };
	new_node->three_digits = new_digits;
	new_node->next = number.head;
	new_node->prev = number.head->prev;
	number.head->prev->next = new_node;
	number.head = new_node;
	++number.length;
}

void deleteHead(longNumber& number) {
	std::cout << "\nFirst element is deleted , the list is now empty !";
	Node* temp{ number.head }, * p{ nullptr };

	number.head->prev->next = number.head->next;
	number.head->next->prev = number.head->prev;
	number.head = number.head->next;
	--number.length;

	delete temp;

	/*p = number.head;
	while (p->next != number.head) {
		p->three_digits = 0;
		p = p->next;
	}

	p->three_digits = 0;*/
}

void createLongNumber1(longNumber& number) {
	std::cout << "\nInput the long number : ";
	long long int long_number{}, num_digits{}, temp_number{};
	std::cin >> long_number;
	temp_number = long_number;

	while (temp_number) {
		temp_number /= 10;
		++num_digits;
	}

	number.length = num_digits / 3;

	Node* new_node{ nullptr }, * last{ nullptr };
	int count_nodes{ 1 };

	
	int num_digits_last_position{3};

	if (num_digits % 3 != 0) {
		num_digits_last_position = num_digits % 3;
		++number.length;
	}

	number.head = new Node;
	number.head->three_digits = long_number % (int)pow(10, num_digits_last_position);
	number.head->next = number.head;
	number.head->prev = number.head;

	long_number = (long_number - number.head->three_digits) / pow(10, num_digits_last_position);
	++count_nodes;

	while (long_number) {
		new_node = new Node;
		new_node->three_digits = long_number % (int)pow(10, 3);
		new_node->next = number.head;
		new_node->prev = number.head->prev;
		number.head->prev->next = new_node;
		number.head->prev = new_node;
		number.head = new_node;
		long_number = (long_number - number.head->three_digits) / pow(10, 3);
		++count_nodes;
	}
}

void compareLongNumbers(longNumber num1, longNumber num2) {
	std::cout << "\n Compare num1 ( ";
	displayLongNumber(num1);
	std::cout << " ) with num2 ( ";
	displayLongNumber(num2);
	std::cout << " ) \n";

	
	Node* p1{ num1.head }, * p2{ num2.head };

	while (p1->next != num1.head) {
		if (p1->three_digits > p2->three_digits) {
			std::cout << "\nNum1 is greater than num2 !\n";
			return;
		}
		else if (p1->three_digits < p2->three_digits) {
			std::cout << "\nNum1 is greater than num2 !\n";
			return;
			}

		p1 = p1->next;
		p2 = p2->next;
	}

	if (p1->three_digits > p2->three_digits) {
		std::cout << "\nNum1 is greater than num2 !\n";
		return;
	}
	else if (p1->three_digits < p2->three_digits) {
		std::cout << "\nNum2 is greater than num1 !\n";
		return;
	}
}

void sumLongNumb(longNumber num1, longNumber num2) {
	std::cout << "\n Compare num1 ( ";
	displayLongNumber(num1);
	std::cout << " ) with num2 ( ";
	displayLongNumber(num2);
	std::cout << " ) \n";

	Node* p1{ num1.head->prev}, * p2{ num2.head->prev};
	int sum[100]{}, count{};

	do {
		if (num1.length == num2.length) {
			sum[num1.length] += p1->three_digits + p2->three_digits;
			
			if (sum[num1.length] > 1000) {
				sum[num1.length] %= 1000;
				sum[num1.length - 1] = 1;
			}

			--num1.length;
			--num2.length;
			++count;
		}
		
		p1 = p1->prev;
		p2 = p2->prev;
	} while (p1->prev != num1.head->prev);

	sum[num1.length] += p1->three_digits + p2->three_digits;
	++count;

	std::cout << "\nSum : ";
	for (int j{1}; j <= count; ++j) {
		std::cout << sum[j];
	}
	std::cout << '\n';
}

int main()
{
	longNumber number1{}, number2{};

	createLongNumber(number1);
	displayLongNumber(number1);

	insertInFront(number1);
	displayLongNumber(number1);

	deleteHead(number1);
	displayLongNumber(number1);

	createLongNumber1(number2);
	displayLongNumber(number2);

	compareLongNumbers(number1, number2);

	sumLongNumb(number1, number2);

	return 0;
}