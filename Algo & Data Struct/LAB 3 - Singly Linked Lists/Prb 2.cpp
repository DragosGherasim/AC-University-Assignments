#include <iostream>
#include <random>

struct Node
{
	int data;
	Node* next;
};

// insert before first node
void createLL(Node*& p, int nrElem) {
	Node* temp_p{ nullptr }, * last{ nullptr };

	std::random_device rd;
	std::mt19937 gen(rd());
	std::uniform_int_distribution<>dis(1, 10 * nrElem);

	p = new Node;
	p->data = dis(gen);
	p->next = nullptr;
	last = p;

	for (int i{ 1 }; i < nrElem; ++i) {
		temp_p = new Node;
		temp_p->data = dis(gen);
		temp_p->next = nullptr;
		last->next = temp_p;
		last = temp_p;
	}
}

//insert after first node
void createLL1(Node*& p, int nrElem) {
	Node* temp_p{ nullptr };

	std::random_device rd;
	std::mt19937 gen(rd());
	std::uniform_int_distribution<>dis(1, 10 * nrElem);

	p = new Node;
	p->data = dis(gen);
	p->next = nullptr;

	for (int i{ 1 }; i < nrElem; ++i) {
		temp_p = new Node;
		temp_p->data = dis(gen);
		temp_p->next = p;
		p = temp_p;
	}
}

void displayLL(Node* p) {
	while (p != nullptr) {
		std::cout << p->data << ' ';
		p = p->next;
	}
}

void concatenateLL(Node* p1, Node* p2, Node*& p3) {
	Node* temp_p3{ nullptr }, * last{ nullptr };
	p3 = new Node;
	p3->data = p1->data;
	p3->next = nullptr;
	last = p3;
	p1 = p1->next;

	while (p1 != nullptr) {
		temp_p3 = new Node;
		temp_p3->data = p1->data;
		temp_p3->next = nullptr;
		last->next = temp_p3;
		last = temp_p3;
		p1 = p1->next;
	}

	while (p2 != nullptr) {
		temp_p3 = new Node;
		temp_p3->data = p2->data;
		temp_p3->next = nullptr;
		last->next = temp_p3;
		last = temp_p3;
		p2 = p2->next;
	}
}

void mergeLL(Node* p1, Node* p2, int n, int m, Node*& p3) {
	Node* last{ nullptr }, * temp_p{ nullptr };
	p3 = new Node;
	p3->data = p1->data;
	p3->next = nullptr;
	last = p3;
	p1 = p1->next;

	if (m <= n) {
		while (p1 != nullptr) {
			if (p2 != nullptr) {
				temp_p = new Node;
				temp_p->data = p2->data;
				temp_p->next = nullptr;
				last->next = temp_p;
				last = temp_p;
				p2 = p2->next;
			}

			temp_p = new Node;
			temp_p->data = p1->data;
			temp_p->next = nullptr;
			last->next = temp_p;
			last = temp_p;
			p1 = p1->next;
		}
	}
	else
	{
		while (p2 != nullptr) {
			if (p1 != nullptr) {
				temp_p = new Node;
				temp_p->data = p1->data;
				temp_p->next = nullptr;
				last->next = temp_p;
				last = temp_p;
				p1 = p1->next;
			}

			temp_p = new Node;
			temp_p->data = p2->data;
			temp_p->next = nullptr;
			last->next = temp_p;
			last = temp_p;
			p2 = p2->next;
		}
	}
}

int main()
{
	Node* first1{ nullptr }, * first2{ nullptr }, * first3{ nullptr }, *first4{nullptr};
	int n{}, m{};
	std::cout << "How many elements do you want in the first list, but in the second ? \nFirst LL: ";
	std::cin >> n;
	std::cout << "\nSecond LL: ";
	std::cin >> m;

	createLL(first1, n);
	std::cout << "\nThe first LL: \n";
	displayLL(first1);


	createLL1(first2, m);
	std::cout << "\nThe second LL: \n";
	displayLL(first2);
	std::cout << '\n';

	concatenateLL(first1, first2, first3);
	std::cout << "\nThe concatenated list is : \n";
	displayLL(first3);

	mergeLL(first1, first2, n, m, first4);
	std::cout << "\nMerge list is : \n";
	displayLL(first4);

	return 0;
}