Classes:

Classes are the basic blocks of object oriented programming. Their utility is multiple. First, they can be used to define new types of data that are more complex than a single scalar number or character.

Class declaration and definition -- The class declaration should be stored in an .hpp file. No memory is reserved when a class is declared. One ore more instances of a class can be called in the main function or in any other function. This is when memory is allocated for the class.

Class members -- A class contains one or more members, that can be either data or functions (methods). In this example, two integers and one function are defined as class members. Each member of a class has an attribute: public, protected or private.
- a public member can be accessed from the outside of a class.
- a private member cannot be accessed from the outside. 
- a protected member is somewhere in the middle. We will see this later.

Trying to access a private class member from outside the class will result in an "member xxx is private within this context" compilation error. By default, members of a class are defined private.
  

To compile/execute this example:

Open terminal (ctr alt t)
Navigate to the folder where you have uncompressed the files 

$ make

$./main

