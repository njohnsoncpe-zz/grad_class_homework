%% Prob 2.16
clear; clc;


A = [1 2 3; 2 3 4; 3 4 5]
y1 = [6; 9; 12]
y2 = [5; 6; 9]


% part (a)

r_a = rank(A)

[U S V] = svd(A)

U1 = U(:,1:r_a)
V1 = V(:,1:r_a)
S1 = S(1:r_a,1:r_a)
V2 = V(:,r_a+1:end)

alpha1 = 12
alpha2 = 100

% solution 1, alpha = 12
x0a = A\y1

x1a = x0a + (V2 * alpha1)

y_sol1 = A*x1a %y_sol1 = y1

% solution 1, alpha = 100

x2a = x0a + (V2 * alpha2)

y_sol2 = A*x2a %y_sol2 = y1

% part (b)
x0b = A\y2

x1b = x0b + (V2*alpha1)

y_sol3 = A*x1b %y_sol3 != y1