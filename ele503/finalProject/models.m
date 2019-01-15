Abar =  [0         0    1.0000         0
         0         0         0    1.0000
         0    3.7972   -0.0138   -0.0151
         0   15.4462   -0.0145   -0.0615];
         
Bbar =  [    0
             0
        0.1662
        0.2831];
  


 A =  [  0         0    1.0000         0         0
         0         0         0    1.0000         0
   -5.9815    3.7972   -1.0108   -0.0151    5.9815
  -10.1908   15.4462   -1.7129   -0.0615   10.1908
         0         0         0         0         0];
         
         
B = [    0
         0
    0.9969
    1.6985
    1.0000];

% PI gains for inner velocity loop
ki=36;
kp=6;
Kpi=[ki 0 kp 0];
% coefficients of friction for nonlinear plant model
by=5;
brx=5;
bry=5;
bx=5;
