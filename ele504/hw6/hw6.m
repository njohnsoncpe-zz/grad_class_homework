%% ELE 504 Hw. #6
% LQR Design
% Noah Johnson


%% Problem 1

A = [0 1; 0 -1];
B = [0; 1];

Q_a = [1 0; 0 0]; % Q matrix for part a 
Q_b = [1 0; 0 1]; % Q matrix for part b



R = eye(1);

% part (a)
get_stable_zeros(A,B,Q_a,R)

% part (b)
get_stable_zeros(A,B,Q_b,R)



% Part (c)
Q_c = [1 0; 0 .01]; % Q matrix for part c


rho = 2950

K = lqr(A,B,rho*Q_c,R);

clp = eig(A-B*K)

find_damp(clp)

%% Problem 2
clear

run prob2_model


q1 = 0;
q2 = 0;
q7 = 0;

q3 = 1;
q4 = .1;
q5 = .07;
q6 = 1;

Q = diag([q1 q2 q3 q4 q5 q6 q7])


R = eye(2);

rho = 100;

K = lqr(A,B,rho*Q,R);

clp = eig(A-B*K)

find_damp(clp)


%% Problem 3
clear

run prob3_model


q1 = 1;
q2 = 1;
q3 = .25
q4 = .05;

Q = diag([q1 q2 q3 q4])


R = eye(2);

rho = 8900;

K = lqr(A,B,rho*Q,R);

clp = eig(A-B*K)

find_damp(clp)
