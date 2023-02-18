#include <iostream>

struct Node {
	int data;
	Node* next, * prev;
};

struct DLL {
	Node* first, * last;
};

void createDLL(DLL& list) {
	Node* p{ nullptr }, * last{ nullptr };

	int num_input{};
	std::cout << "Input numbers until 0 : \n";
	std::cin >> num_input;

	while (num_input) {
		if (!list.first) {
			list.first = new Node;
			list.first->data = num_input;
			list.first->prev = nullptr;
			list.first->next = nullptr;
			last = list.first;
		}
		else {
			p = new Node;
			p->data = num_input;
			p->next = nullptr;
			p->prev = last;
			last->next = p;
			last = p;
		}

		std::cin >> num_input;
	}

	list.last = last;
}

void createDLL1(DLL& list) {
	Node* p{ nullptr };
	int num_input{};
	std::cout << "Input numbers until 0 : \n";
	std::cin >> num_input;

	while (num_input) {
		if (!list.first) {
			list.first = new Node;
			list.first->data = num_input;
			list.first->next = nullptr;
			list.first->prev = nullptr;
			list.last = list.first;
		}
		else {
			p = new Node;
			p->data = num_input;
			list.first->prev = p;
			p->next = list.first;
			p->prev = nullptr;
			list.first = p;
		}

		std::cin >> num_input;
	}
}

void displayDLL(DLL list) {
	Node* p{ list.first };
	
	std::cout << '\n';
	while (p != nullptr) {
		std::cout << p->data << ' ';
		p = p->next;
	}

	std::cout << '\n';
}

void displayDLL1(DLL list) {
	Node* p_f{ list.first };
	Node* p_l{ list.last };

	std::cout << '\n';
	while (p_f != nullptr) {
		std::cout << p_f->data << ' ';
		p_f = p_f->next;
	}

	std::cout << '\n';

	while (p_l != nullptr) {
		std::cout << p_l->data << ' ';
		p_l = p_l->prev;
	}

	std::cout << ' ';
}

void insertingByIndex(DLL& list, int indx, int new_data) {
	Node* p{ nullptr }, * temp_f{ list.first }, * last{ nullptr };
	int nodes_count{};

	p = new Node;
	p->data = new_data;

	if (indx == nodes_count) {
		list.first->prev = p;
		p->next = list.first;
		p->prev = nullptr;
		list.first = p;
		return;
	}

	while (temp_f && nodes_count < indx) {
		last = temp_f;
		temp_f = temp_f->next;
		++nodes_count;
	}

	if (!temp_f)
	{
		p->next = nullptr;
		p->prev = last;
		last->next = p;
		list.last = p;
		return;
	}

	p->prev = temp_f->prev;
	p->next = temp_f;
	temp_f->prev->next = p;
	temp_f->prev = p;
	
}

void deleteByIndx(DLL& list, int indx) {
	Node* p{ list.first };
	int count_nodes{1};

	if (count_nodes - 1  == indx) {
		list.first = list.first->next;
		list.first->prev = nullptr;
		delete p;
		return;
	}


	while (count_nodes < indx) {
		p = p->next;
		++count_nodes;
	}

	if (!p->next) {
		list.last = p->prev;
		list.last->next = nullptr;
		delete p;
		return;
	}


	p->prev->next = p->next;
	p->next->prev = p->prev;
	delete p;
}

int main() {
	DLL l1{};
	//createDLL(l1);
	createDLL1(l1);
	displayDLL(l1);
	
	displayDLL1(l1);

	int index{}, new_data{};
	std::cout << "\n\nNew data : ";
	std::cin >> new_data;
	std::cout << "Index : ";
	std::cin >> index;

	insertingByIndex(l1, index, new_data);
	displayDLL1(l1);

	std::cout << "\n\nIndex : ";
	std::cin >> index;
	deleteByIndx(l1, index);
	displayDLL1(l1);

	return 0;
}