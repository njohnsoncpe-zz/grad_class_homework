/*
example include file
*/

#ifndef DECLARATIONS_HPP
#define DECLARATIONS_HPP

#include <iostream>


double rectangleArea(double h, double w);


class Rectangle{
		
	public:

		Rectangle();	

		Rectangle(double h, double w);

		~Rectangle(){
			std::cout << "variable is being destroyed" << std::endl;
		}
	
		double height;
		double width;
		
		static bool color;
		
		void print();

		double area();
};


void myPrintHelloMake(void);

#endif

