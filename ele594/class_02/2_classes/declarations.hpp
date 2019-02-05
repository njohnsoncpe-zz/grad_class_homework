/*
example include file
*/

#ifndef DECLARATIONS_HPP
#define DECLARATIONS_HPP

#include <iostream>


class Rectangle{
	public:
		double height;
		double width;
		
		void print(){
			std::cout << height << " X " << width << std::endl; 
		}
	private:
		double area;
};


void myPrintHelloMake(void);

#endif

