#include <iostream>
typedef int Atom;

struct Node {
	Atom data;
	Node* stg, * drp;
};

Node* make_nod(Atom a) {
	Node* p{ new Node };
	p->data = a;
	p->stg = p->drp = nullptr;
	return p;
}

void insert(Node*& r, Atom a) {
	if (r == nullptr) {
		r = make_nod(a);
	}

	if (a < r->data)
		insert(r->stg, a);
	else if (a > r->data)
		insert(r->drp, a);
}

void builtBST(Node*& bst) {
	Atom val{};

	std::cout << "\nInserare numere pana la 0, inclusiv 0\n";
	std::cin >> val;

	do {
		insert(bst, val);
		std::cin >> val;
	} while (val != 0);
}

void afisareInOrd(Node* bst) {
	if (bst) {
		afisareInOrd(bst->stg);
		std::cout << bst->data << ' ';
		afisareInOrd(bst->drp);
	}
}

void afisarePreOrd(Node* bst) {
	if (bst) {
		std::cout << bst->data << ' ';
		afisarePreOrd(bst->stg);
		afisarePreOrd(bst->drp);
	}
}

void afisarePostOrd(Node* bst) {
	if (bst) {
		afisarePostOrd(bst->stg);
		afisarePostOrd(bst->drp);
		std::cout << bst->data << ' ';
	}
}

Node* searchBTS(Node* r, Atom val) {
	if (r == nullptr)
		return nullptr;

	if (val < r->data)
		return searchBTS(r->stg, val);
	else if (val > r->data)
		return searchBTS(r->drp, val);

		return r;
}

Node* removeGreatest(Node*& r) {
	Node* p{ nullptr };

	if (r->drp == nullptr) {
		p = r;
		r = r->stg;
		return p;
	}
	else return removeGreatest(r->drp);
}

void deleteRoot(Node*& r) {
	Node* p{ r };

	if (r->stg == 0)
		r = r->drp;
	else if (r->drp == 0)
		r = r->stg;
	else {
		r = removeGreatest(r->stg);
		r->stg = p->stg;
		r->drp = p->drp;
	}

	delete p;
}

void deleteNode(Node*& r, Atom val) {
	if (r == nullptr)
		std::cout << "\nNodul nu exista !";
	else if (val < r->data)
		deleteNode(r->stg, val);
	else if (val > r->data)
		deleteNode(r->drp, val);
	else
		deleteRoot(r);
}

int main() {
	Node* bst{};
	builtBST(bst);

	afisareInOrd(bst);
	std::cout << '\n';
	afisarePreOrd(bst);
	std::cout << '\n';
	afisarePostOrd(bst);

	Atom val{};
	std::cout << "\nVal pe care vreti sa o cautati : ";
	std::cin >> val;

	if (searchBTS(bst, val) != nullptr)
		std::cout << "\nVal a fost gasita !";
	else
		std::cout << "\nVal nu a fost gasita !";

	std::cout << "\nVal pe care vreti sa o stergeti : ";
	std::cin >> val;
	deleteNode(bst, val);
	afisareInOrd(bst);

	return 0;
}