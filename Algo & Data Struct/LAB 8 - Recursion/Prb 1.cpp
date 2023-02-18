#include <iostream>

struct Node {
	int data;
	Node* next;
};

Node* createSL(Node* head, int value) {
	if (head == nullptr) {
		head = new Node;
		head->data = value;
		head->next = nullptr;
	}
	else 
		head->next = createSL(head->next, value);

	return head;

}

void displaySL(Node* head) {
	Node* p{ head };
	
	if (p != nullptr) {
		displaySL(p->next);
		std::cout << p->data << ' ';
	}

}


int main() {
	Node* head{};

	std::cout << "\nNum elements : ";
	int num{}, val{};
	std::cin >> num;

	std::cout << "\nValues : ";
	for (int i{}; i < num; ++i) {
		std::cin >> val;
		head = createSL(head, val);
	}

	std::cout << '\n';
	displaySL(head);
	std::cout << '\n';

	return 0;
}