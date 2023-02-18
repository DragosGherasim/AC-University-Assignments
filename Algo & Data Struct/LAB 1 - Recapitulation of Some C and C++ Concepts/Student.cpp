#include "Student.h"
#include <iostream>


void InitStudent(Student& stdn)
{
	std::cout << "Nume : ";
	char aux_nume[25] {};
	std::cin.ignore();
	std::cin.getline(aux_nume, 25);
	stdn.nume = new char[std::strlen(aux_nume) + 1];
	strcpy_s(stdn.nume, std::strlen(aux_nume) + 1, aux_nume);

	std::cout << "Nota : ";
	std::cin >> stdn.nota;
}

void AfisStudent(Student stdn)
{
	std::cout << stdn.nume << " : " << stdn.nota << '\n';
}

void StergeStudent(Student& stdn)
{
	if (stdn.nume != nullptr) delete[] stdn.nume;
}