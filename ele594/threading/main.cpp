// thread example
#include <iostream>       // std::cout
#include <thread>         // std::thread
#include <unistd>
 
void foo(int& x) 
{
  while(1){
    usleep(500000);
    std::cout << "foo alive\n";
    (*x)++;
}

void bar(int& x)
{
  while(1){
    usleep(700000);
    std::cout << x << "\n";
}

int main() 
{
  std::thread first (foo);     // spawn new thread that calls foo()
  std::thread second (bar,0);  // spawn new thread that calls bar(0)

  std::cout << "main, foo and bar now execute concurrently...\n";

  // synchronize threads:
  first.join();                // pauses until first finishes
  second.join();               // pauses until second finishes

  std::cout << "foo and bar completed.\n";

  return 0;
}
