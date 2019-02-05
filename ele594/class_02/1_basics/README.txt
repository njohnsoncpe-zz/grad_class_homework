Code organization:


1) A .cpp file should contain the main function.

2) Declaration (of functions, classes, ...) should be stored in hpp files. hpp files can be called inside regular code using the #include pre-processor command. Forgetting to include a file will result in a "function is undeclared" error

3) Definition of functions should be stored in cpp files, and these files should be compiled along with the .cpp file containing the main function. Forgetting to define a function that is declared, or to compile the file that contains the definition of the function, will result in an "undefined reference" error.

4) in this example, a makefile is used to compile the project. As a project grows, it becomes impossible to compile everything in the command line. All the indications and compiler commands can be saved in a makefile. The makefile can be invoked using the "make" command.

To compile/execute this example:

Open terminal (ctr alt t)
Navigate to the folder where you have uncompressed the files 

$ make

$./hellomake

