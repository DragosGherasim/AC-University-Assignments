#include <iostream>

struct Node {
	int data;
	Node* next;
};

// creates a linked list by inserting before first node
void createLL(Node*& p) {
	Node* temp{ nullptr }, * last{ nullptr };
	p = new Node;
	char c{};
	c = getchar();
	p->data = c - '0';
	p->next = nullptr;
	last = p;

	while ((c = getchar()) != '\n') {
		if (c == ' ')
			continue;

		temp = new Node;
		temp->data = c - '0';
		temp->next = nullptr;
		last->next = temp;
		last = temp;
	}
}

// creates a LL by inserting afte first node
void createLL1(Node*& p) {
	p = new Node;
	char c{};
	p->data = getchar() - '0';
	p->next = nullptr;

	while ((c = getchar()) != '\n') {
		if (c == ' ')
			continue;

		Node* new_first{ new Node };
		new_first->data = c - '0';
		new_first->next = p;
		p = new_first;
	}
}

void displayLL(Node* p) {
	while (p != nullptr) {
		std::cout << p->data << ' ';
		p = p->next;
	}
	std::cout << '\n';
}

bool searchTargetLL(Node* p, int target) {
	while (p != nullptr) {
		if (p->data == target)
			return true;
		
		p = p->next;
	}

	return false;
}

void insertNumberByIndex(Node*& p, int num, int indx) {
	int count_nodes{};
	Node* insert_node{ new Node }, * temp_p{ p }, * temp{ nullptr };
	insert_node->data = num;
	insert_node->next = nullptr;

		if (indx == 0) {
			insert_node->next = p;
			p = insert_node;
		}
		else {
			while (temp_p != nullptr && count_nodes <= indx) {
				if (count_nodes == indx) {
					insert_node->next = temp_p;
					temp->next = insert_node;
				}
				temp = temp_p;
				temp_p = temp_p->next;
				++count_nodes;
			}
		}
}

void deleteNodeByIndx(Node*& p, int indx) {
	int count_node_byindx{ 1 };
	Node* temp_p{ p }, * temp{ nullptr };

	if (indx == 1) {
		Node* temp_p{ p };
		p = p->next;
		delete temp_p;
	}
	else {
		while (temp_p != nullptr && count_node_byindx <= indx) {
			if (count_node_byindx == indx) {
				temp->next = temp_p->next;
				delete temp_p;
			}
			else
			{
				temp = temp_p;
				temp_p = temp_p->next;
			}

			++count_node_byindx;
		}
	}
}

void displaySearchedNode(Node* p, int indx) {
	Node* temp_p{ p }, * temp_last{ p };
	int count_node{};

	while (temp_p != nullptr) {
		if (count_node >= indx)
			temp_last = temp_last->next;
		temp_p = temp_p->next;
		++count_node;
	}

	std::cout << "The values searched is : " << temp_last->data << '\n';
}


void traverseLL1(Node* first) {
	if (first == nullptr)
	{
		return;
	}
	std::cout << first->data << ' ';
	return traverseLL1(first->next);
}

void displayMid(Node* p) {
	Node* fast_p{ p }, * slow_p{ p };

	while (fast_p != nullptr && fast_p->next) {
		slow_p = slow_p->next;
		fast_p = fast_p->next->next;
	}

	std::cout << "The value at the middle of the LL is : " << slow_p->data << '\n';
}

void reverseLL(Node*& p) {
	Node* prev_p{nullptr}, *current{ nullptr };

	while (p != nullptr) {
		prev_p = current;
		current = p;
		p = p->next;
		current->next = prev_p;
	}

	p = current;
}

int main()
{	
	Node* first{ nullptr };
	createLL(first);
	createLL1(first);
	displayLL(first);

	std::cout << "The searched number is : ";
	int target{};
	std::cin >> target;
	std::cout << std::boolalpha;
	std::cout << "The searched number is in list ? Answer : " << searchTargetLL(first, target) << '\n';

	std::cout << "\nWhich number you want to insert : ";
	int insert_num{};
	std::cin >> insert_num;
	std::cout << "What is the position you want to insert the new number : ";
	int index{};
	std::cin >> index;
	insertNumberByIndex(first, insert_num, index);
	displayLL(first);

	std::cout << "\nWhich node do you want to delete : ";
	int indx_node{};
	std::cin >> indx_node;
	deleteNodeByIndx(first, indx_node);
	displayLL(first);

	std::cout << "\nFor which node ,counting from the last node, do you want to display the data stored : ";
	std::cin >> indx_node;
	displaySearchedNode(first, indx_node);

	traveseLL1(first);

	displayMid(first);

	reverseLL(first);
	displayLL(first);

	return 0;
}