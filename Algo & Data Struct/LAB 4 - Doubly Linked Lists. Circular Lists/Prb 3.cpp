#include <iostream>

struct Node {
	int data;
	Node* next;
};

// inserting before head
void createCLL(Node*& first) {
	Node* p{ nullptr };
	int num_input{};

	std::cout << "Input numbers until 0 : \n";
	std::cin >> num_input;

	while (num_input) {
		p = new Node;
		p->data = num_input;

		if (!first) {
			first = new Node;
			p->next = p;
			first = p;
		}
		else
		{
			p->next = first->next;
			first->next = p;
			first = p;
		}

		std::cin >> num_input;
	}

	if (first)
		first = first->next;

}

//inserting after head
void createCLL1(Node*& first) {
	Node* p{ nullptr };
	int num_input{};

	std::cout << "Input numbers until 0 : \n";
	std::cin >> num_input;

	while (num_input) {
		p = new Node;
		p->data = num_input;

		if (!first) {
			first = new Node;
			p->next = p;
			first = p;
		}
		else
		{
			p->next = first->next;
			first->next = p;
		}

		std::cin >> num_input;
	}

	first = p;
}

void displayCLL(Node* first) {
	Node* p{ first };

	if (first) {
		std::cout << p->data << ' ';
		p = p->next;
		while (p != first)
		{
			std::cout << p->data << ' ';
			p = p->next;
		}
	}
	else
		return;

}

void reverseCLL(Node*& first) {
	Node* p{first->next}, * current{ first }, * last{ first };

	while (p != first) {
		last = current;
		current = p;
		p = p->next;
		current->next = last;
	}

	p->next = current;
	first = current;
}

int main()
{
	Node* first{ nullptr };
	//createCLL(first);
	createCLL1(first);
	displayCLL(first);

	std::cout << '\n';
	reverseCLL(first);
	displayCLL(first);

	return 0;
}