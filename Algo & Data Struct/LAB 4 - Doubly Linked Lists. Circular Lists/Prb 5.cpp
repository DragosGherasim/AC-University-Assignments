#include <iostream>

struct Node {
	int data;
	Node* next;
};

void createCLL(Node*& first, int& sizel) {
	Node* p{ nullptr }, * last{ nullptr };
	std::cout << "\nSize l : ";
	std::cin >> sizel;

	std::cout << "\nNumber input : ";
	int num_input{};
	std::cin >> num_input;

	if (!first) {
		first = new Node;
		first->data = num_input;
		first->next = first;
		last = first;
	}

	for (int i{1}; i < sizel; ++i) {
		p = new Node;
		std::cin >> num_input;
		p->data = num_input;
		p->next = first;
		last->next = p;
		last = p;
	}
}


void createCLL1(Node*& first, int& sizel) {
	Node* p{ nullptr }, * temp{ first };
	
	std::cout << "\nSize l : ";
	std::cin >> sizel;

	std::cout << "\nNumber input : ";
	int num_input{};
	std::cin >> num_input;

	if (!first) {
		first = new Node;
		first->data = num_input;
		first->next = first;
	}

	for (int i{ 1 }; i < sizel; ++i) {
		std::cin >> num_input;

		p = new Node;
		p->data = num_input;
		p->next = first->next;
		first->next = p;
	}

	first = p;
}

void displayCLL(Node* first) {
	Node* p{ nullptr };

	std::cout << '\n';
	if (first) {
		std::cout << first->data << ' ';
		p = first->next;
		while (p != first) {
			std::cout << p->data << ' ';
			p = p->next;
		}
	}
	else
		std::cout << "First is not allocated ! \n";

	std::cout << '\n';

}


void concatenateCLL(Node* first1, Node* first2, Node*& first3) {
	Node* p{ nullptr }, * last{ nullptr }, * new_node{ nullptr };

	first3 = new Node;
	first3->data = first1->data;
	first3->next = nullptr;
	last = first3;
	p = first1->next;

	while (p != first1) {
		new_node = new Node;
		new_node->data = p->data;
		new_node->next = nullptr;
		last->next = new_node;
		last = new_node;
		p = p->next;
	}

	new_node = new Node;
	new_node->data = first2->data;
	new_node->next = nullptr;
	last->next = new_node;
	last = new_node;
	p = first2->next;

	while (p != first2) {
		new_node = new Node;
		new_node->data = p->data;
		new_node->next = nullptr;
		last->next = new_node;
		last = new_node;
		p = p->next;
	}

	last->next = first3;
}

void interclasCLL(Node* first1, Node* first2, Node*& first3, int size1, int size2) {
	Node* p1{ nullptr }, *p2 {nullptr}, *new_node{nullptr}, * last{nullptr};

	first3 = new Node;
	first3->data = first1->data;
	first3->next = nullptr;
	last = first3;

	new_node = new Node;
	new_node->data = first2->data;
	new_node->next = nullptr;
	last->next = new_node;
	last = new_node;

	p1 = first1->next;
	p2 = first2->next;

	if (size1 > size2) {
		while (p1 != first1) {
			new_node = new Node;
			new_node->data = p1->data;
			new_node->next = nullptr;
			last->next = new_node;
			last = new_node;

			if (p2 != first2) {
				new_node = new Node;
				new_node->data = p2->data;
				new_node->next = nullptr;
				last->next = new_node;
				last = new_node;
				p2 = p2->next;
			}

			p1 = p1->next;
		}
	}
	else
	{
		while (p2 != first2) {
			new_node = new Node;
			new_node->data = p2->data;
			new_node->next = nullptr;
			last->next = new_node;
			last = new_node;

			if (p1 != first1) {
				new_node = new Node;
				new_node->data = p1->data;
				new_node->next = nullptr;
				last->next = new_node;
				last = new_node;
				p1 = p1->next;
			}

			p2 = p2->next;
		}
	}

	last->next = first3;
}


int main()
{
	Node* first1{ nullptr }, * first2{ nullptr }, * first3{ nullptr }, * first4{ nullptr };
	int sizel1{}, sizel2{};

	createCLL(first1, sizel1);
	displayCLL(first1);

	createCLL1(first2, sizel2);
	displayCLL(first2);

	concatenateCLL(first1, first2, first3);
	displayCLL(first3);

	interclasCLL(first1, first2, first4, sizel1, sizel2);
	displayCLL(first4);

	return 0;
}