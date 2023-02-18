#include "Grupa.h"
// ocw.mit.edu/courses -> el.eng. & comp.s. | coursera.org -> Data Structures
int main()
{
	Grupa g;
	InitGrupa(g);
	AfisGrupa(g);

	CautareStd(g);

	AfisareNotaMaxMin(g);

	StergeGrupa(g);

	return 0;
}