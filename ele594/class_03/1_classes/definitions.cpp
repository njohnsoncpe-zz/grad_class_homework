#include <iostream>
#include "declarations.hpp"




void myPrintHelloMake(void) {

  std::cout << "Hello makefiles!" << std::endl;

  return;
}


double rectangleArea(double h, double w){
	return h*w;
}


Rectangle::Rectangle(){
	height = 0.0;
	width = 0.0;
} 		

Rectangle::Rectangle(double h, double w){
	height = h;
	width = w;
} 		



bool Rectangle::color;


void Rectangle::print(){
	std::cout << height << " X " << width << " color " << color << std::endl; 
}
double Rectangle::area(){
	return height*width;
}

