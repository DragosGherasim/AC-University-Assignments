#include "Grupa.h"
#include <iostream>

void InitGrupa(Grupa& grp) {
	std::cout << "ID Grupa : ";
	std::cin >> grp.id;

	std::cout << "Numar Studenti : ";
	std::cin >> grp.nr;

	grp.tab = (Student*)malloc(grp.nr * sizeof(Student)); // grp.tab = new Student [grp.nr];
	for (std::size_t i{}; i < grp.nr; ++i)
		InitStudent(*(grp.tab + i)); // InitStudent(grp.tab[i]);
}

void AfisGrupa(Grupa grp) {
	std::cout << "\nGrupa :" << grp.id << '\n';

	for (std::size_t i{}; i < grp.nr; ++i)
		AfisStudent(*(grp.tab + i));
}

void StergeGrupa(Grupa& grp) {
	if (grp.tab != nullptr) {
		for (std::size_t i{}; i < grp.nr; ++i)
			StergeStudent(grp.tab[i]);

		free(grp.tab); // ?
	}
}

void CautareStd(Grupa grp) {
	std::cout << "Numele studentului cautat : ";
	char* nume_cautat = new char[10];
	bool gasit{ false };
	std::cin >> nume_cautat;

	for (std::size_t i{}; i < grp.nr; ++i)

		if (std::strcmp((*(grp.tab + i)).nume, nume_cautat) == 0) 
		{
			gasit = true;
			std::cout << "Studentul a fost gasit, nota lui este : " << (*(grp.tab + i)).nota << '\n';
			break;
		}

	if (gasit == false)
		std::cout << "Studentul nu a fost gasit !\n";
}

void AfisareNotaMaxMin(Grupa grp) {
	int nota_min{ grp.tab[0].nota }, nota_max{ grp.tab[0].nota };

	for (std::size_t i{}; i < grp.nr; ++i) {
		if (nota_min > (*(grp.tab + i)).nota)
			nota_min = (*(grp.tab + i)).nota;

		if (nota_max < (*(grp.tab + i)).nota)
			nota_max = (*(grp.tab + i)).nota;
	}

	std::cout << "Nota cea mai mare este : " << nota_max << ", iar nota cea mai mica este : " << nota_min << '\n';
}