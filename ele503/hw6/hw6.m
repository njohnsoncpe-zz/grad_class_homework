%% Problem 1

%Given
A = [0 1 0 0; 23.1 0 0 -0.1189; 0 0 0 1; 0 0 0 -25];
B = [0;12.5; 0;26.33];
K = [3.1582 0.6720 -2.2914 -0.5436];

%find eigenvals of A-BK
eigs = eig(A-B*K)

%Calculated ssm from w to v
A_ss = (A-B*K);
B_ss = B;
C_ss = -K;
D_ss = zeros();

%Find delta1
sys = ss(A_ss, B_ss, C_ss, D_ss);
delta_1 = 1/(norm(sys,inf))

%Estimate Qmin and Qmax, find eigenvals
qmax = 3.15;
qmin = 0.613875;
eig_max = eig(A-qmax*B*K)
eig_min = eig(A-qmin*B*K)

%Estimate phimax for complex classical perturbation model
phi = 19.5;
q = exp(-j*phi*pi/180);

eig(A-q*B*K)


%% Problem 3

A = zeros(2,2);
B = [1 0; 10 1];
K = eye(2,2);

phi = 0;

q1 = exp(-j*phi*pi/180);
q2 = 1;

Q = [q1 0; 0 q2];

spoles = eig(A-B*Q*K)

A_ss = A-B*K;
B_ss = -B;
C_ss = eye(2);
D_ss = zeros();

sys = ss(A_ss,B_ss,C_ss,D_ss);

delta_1 = 1/(norm(sys,inf))

Q = [q1 0; 0 1]

del = Q - eye(2,2)

[U, S, V] = svd(del)

del_2 = [0 -0.21; 0 0];

Q2 = eye(2,2) + del_2

%% Problem 4

