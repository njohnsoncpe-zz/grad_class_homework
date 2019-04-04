%% ELE 504 Hw. #6
% LQR Design
% Noah Johnson


%% Problem 1

A = [0 1; 0 -1];
B = [0; 1];

Q_a = [1 0; 0 0]; % Q matrix for part a 
Q_b = [1 0; 0 1]; % Q matrix for part b

rho = 10;

R = eye(2);

get_stable_zeros(A,B,Q_a,R)

K = lqr(A,B,rho*Q_a,R)