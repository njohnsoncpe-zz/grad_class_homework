#include <iostream>
//regular class
//class PaoloVector{
//public:
//  double x;
//  double y;
//}

//template class
template <class T, class U> class PaoloVector{
public:
  T x;
  U y;

  PaoloVector(){};
  
  PaoloVector(T _x, U _y){
    //can we determine type here? Sort of.
    x=_x;
    y=_y;
  }

  void print(){
    std::cout << x << ", " << y << std::endl;
  }
};


int main()
{
  PaoloVector<int,int> p(2,2);
  PaoloVector<double,int> dp(3.012,2);

  //if we had defined rectangle, we could do:
  //PaoloVector<Rectangle,int> ...
  
  p.print();
  dp.print();
  
  return 0;
}
