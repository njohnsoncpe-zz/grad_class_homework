#include <iostream>

#include "declarations.hpp"



int main() {
	
	double a=0;
	std::cout << &a << std::endl;
	double* pointer = &a;
	std::cout << pointer << std::endl;


	for (int i=0; i<1;i++){
		// call a function in another file
		int a;
		Rectangle r1;
		r1.print();


		r1.height = 1.2;
		r1.width = 2.2;
		r1.color = true;
		r1.print();

		Rectangle r2(1.0, 2.0);
		r2.print();
		r2.height = 10.0;
		r2.width = 2.2;
		r2.color = false;

		r1.print();
		r2.print();
		std::cout << r1.area() << " " << r2.area() << std::endl;
	}


	return(0);
}



