#include <stdio.h>

// This is a first basic example of a program.
// The command to compile this program into an executable
// through command line is provided in the accompaning README.txt
// please refer to https://www.tutorialspoint.com/cplusplus/
// for additional resources on c++

// Any program should have a main function
int main (void){

	// This is an example of usage of printf function.
	printf("hello world!\n");
	
	// This is an example of a for loop.
	// syntax:
	// for (init; condition; increment){
	//	commands
	// } 	
	int counter = 0;
	for (int i=0; i<10; i++){
		// This is an example how to print the value of a
		// variable using printf
		printf("%d\n", counter);
		// NOTE: it is good practice to indent the code
		// to increase readability
	}

	// This is an example of an if statement.
	// syntax:
	// if (condition){
	//	commands
	// }
	// else if (other condition) {
	//	commands
	// }
	// else {
	//	commands
	// }
	if (counter == 5){
		printf("the for loop did not terminate?\n");
	}
	else if (counter == 10){
		printf("the for loop terminate correctly\n");
	}
	else {
		printf("the for did not terminate correctly\n");
	}

	// other statements that you should know
	
	

	return 0;
}



