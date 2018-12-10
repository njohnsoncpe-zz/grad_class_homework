function dy = myODE(t,y)
dy(1) = y(2);
dy(2) = y(1)*y(2)-2;