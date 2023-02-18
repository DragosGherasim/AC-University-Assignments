#include <iostream>

struct Node {
	int data;
	Node* next, * prev;
};

void createDLL(Node*& first, int size) {
	Node* new_node{ nullptr }, * last{ nullptr };

	first = new Node;
	
	int data_input{};
	std::cout << "\nData : ";
	std::cin >> data_input;
	first->data = data_input;
	first->next = nullptr;
	first->prev = nullptr;
	last = first;

	for (int i{ 1 }; i < size; ++i) {
		new_node = new Node;
		std::cin >> data_input;
		new_node->data = data_input;
		new_node->next = nullptr;
		new_node->prev = last;
		last->next = new_node;
		last = new_node;
	}
}

void createDLL1(Node*& first, int size) {
	Node* new_node{ nullptr };
	int data_input{};
	std::cout << "\nData : ";
	std::cin >> data_input;

	first = new Node;
	first->data = data_input;
	first->next = nullptr;
	first->prev = nullptr;


	for (int i{ 1 }; i < size; ++i) {
		new_node = new Node;
		std::cin >> data_input;
		new_node->data = data_input;
		new_node->next = first;
		new_node->prev = nullptr;
		first->prev = new_node;
		first = new_node;
	}
}

void displayDLL(Node* first) {
	Node* p{ first }, * last{ nullptr };

	std::cout << '\n';
	while (p != nullptr) {
		std::cout << p->data << ' ';
		last = p;
		p = p->next;
	}
	std::cout << '\n';

	while (last != nullptr) {
		std::cout << last->data << ' ';
		last = last->prev;
	}
	std::cout << '\n';
}

void concatenateDLL(Node* first1, Node* first2, Node*& first3) {
	Node* p{ nullptr }, * new_node{ nullptr }, * last{ nullptr };

	first3 = new Node;
	first3->data = first1->data;
	first3->prev = nullptr;
	first3->next = nullptr;
	last = first3;
	p = first1->next;

	while (p != nullptr) {
		new_node = new Node;
		new_node->data = p->data;
		new_node->prev = last;
		new_node->next = nullptr;
		last->next = new_node;
		last = new_node;
		p = p->next;
	}

	p = first2;
	while (p != nullptr) {
		new_node = new Node;
		new_node->data = p->data;
		new_node->next = nullptr;
		new_node->prev = last;
		last->next = new_node;
		last = new_node;
		p = p->next;
	}
}

void interclas(Node *first1, Node* first2, Node*& first3, int size1, int size2) {
	Node* new_node{ nullptr }, * p1{ nullptr }, *p2{nullptr}, *last{nullptr};

	first3 = new Node;
	first3->data = first1->data;
	first3->next = nullptr;
	first3->prev = nullptr;
	last = first3;
	
	new_node = new Node;
	new_node->data = first2->data;
	new_node->next = nullptr;
	new_node->prev = last;
	last->next = new_node;
	last = new_node;
	p1 = first1->next;
	p2 = first2->next;

	if (size1 > size2) {
		while (p1 != nullptr) {
			new_node = new Node;
			new_node->data = p1->data;
			new_node->next = nullptr;
			new_node->prev = last;
			last->next = new_node;
			last = new_node;
			
			if (p2 != nullptr) {
				new_node = new Node;
				new_node->data = p2->data;
				new_node->next = nullptr;
				new_node->prev = last;
				last->next = new_node;
				last = new_node;
				p2 = p2->next;
			}

			p1 = p1->next;
		}
	}
	else
	{
		while (p2 != nullptr) {
			if (p1 != nullptr) {
				new_node = new Node;
				new_node->data = p1->data;
				new_node->next = nullptr;
				new_node->prev = last;
				last->next = new_node;
				last = new_node;
				p1 = p1->next;
			}

			new_node = new Node;
			new_node->data = p2->data;
			new_node->next = nullptr;
			new_node->prev = last;
			last->next = new_node;
			last = new_node;
			p2 = p2->next;
		}
	}
}

int main()
{
	Node* first1{ nullptr }, * first2{ nullptr }, * first3{ nullptr }, * first4{ nullptr };
	int size1{}, size2{};

	std::cout << "\nSize l1 : ";
	std::cin >> size1;
	createDLL(first1, size1);
	displayDLL(first1);

	std::cout << "\nSize l2 : ";
	std::cin >> size2;
	createDLL1(first2, size2);
	displayDLL(first2);

	std::cout << "\nDLL concatenated : ";
	concatenateDLL(first1, first2, first3);
	displayDLL(first3);

	std::cout << "\nDLL inters : ";
	interclas(first1, first2, first4, size1, size2);
	displayDLL(first4);

	return 0;
}