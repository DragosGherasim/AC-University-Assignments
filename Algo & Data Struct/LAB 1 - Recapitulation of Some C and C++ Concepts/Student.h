#pragma once

struct Student {
	char* nume;
	int nota;
};

void InitStudent(Student&);
void AfisStudent(Student);
void StergeStudent(Student&);