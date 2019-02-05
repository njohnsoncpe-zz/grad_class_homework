#include "declarations.hpp"

int main() {
	
	// call a function in another file
	int a;
	Rectangle r1;
	r1.height = 1.2;
	r1.width = 2.2;

	Rectangle r2;
	r2.height = 10.0;
	r2.width = 2.2;


	r1.print();
	r2.print();

	return(0);
}



