#pragma once
#include "Student.h"

struct Grupa {
	Student* tab;
	int nr;
	int id;
};

void InitGrupa(Grupa&);
void AfisGrupa(Grupa);
void StergeGrupa(Grupa&);
void CautareStd(Grupa);
void AfisareNotaMaxMin(Grupa);