%% ELE 504 HW #7
% Noah Johnson
% 4/2/19

%% Setup
run prob1_model.m


%% Question 1a


eig(A);

% 2 peaks exist at f1 = 21.3 rads/sec and f2 = 1.57 rads/sec
% The peak at f2 has a higher peak magnitude value and is thus
% considered the "bad resonance

%% Question 1b

Q1 = C'*C; % according to the given eqn

R1 = 0.2; % SAA

%% Question 1c

K1 = lqr(A,B,Q1,R1);

eig(A-B*K1);

% The new poles result in a 29% attenuation of the peak at f2

%% Question 1d

plant = ss(A,B,C,zeros(2,1));
[plant_mode, Tc] = canon(plant,'modal');
[A_,B_,C_,D_] = ssdata(plant_mode);

Q2 = diag([0,0,4,4,0,0]);

Q = Q1 + Q2;

R2 = 1;

K2 = lqr(A_,B_,Q,R2);

eig(A_-B_*K2);

% The new poles result in a 55% attenuation of the peak at f2

%% Question 2a

A = [-5 -2 0; 2 0 0; 0 .5 0];
B = [2; 0; 0];
C = [0 0 2];

%This system has all zeros at negative infinity

Q = C'*C;
R = eye();

rho = 2.72e4;

K = lqr(A,B,Q*rho,R);

eig(A-B*K);

[d1,d2] = rb_regsf(A,B,K,0);

%% Question 2b

rho2 = 4e8;

Q0 = rho2*B*B';

L = lqr(A',C',Q0,1)';

eig(A-L*C)

[dO1,dO2] = rb_regob(A,B,C,K,L,0)