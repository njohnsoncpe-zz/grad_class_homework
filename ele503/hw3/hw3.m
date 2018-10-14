%% Prob 2.15
clear;clc;

x = [1; 2; 3; 4];
v1 = [1; 1; 0; 1];
v2 = [1; 0; 1; 1];



% part (a)
X = [v1 v2 x]

G = X'*X

det(G) % det(G) != 0, therefore the vectors are linearly independent, and X is not in S.

% part (b)
V = [v1 v2]
x_proj = V*inv(V'*V)*V'*x % = [3; 1; 2; 3]


% part (c)
X2 = [v1 v2 x_proj]
G2 = X2'*X
det(G2) % det(G) is extremely close to zero (5e-15) so I suspect it is a rounding error, and this can be said to be equal to 0

%part (d)
e = x - x_proj % defined
e'*v1 % x_T*y = 0 if orthoginal, once again it is extremely close to 0 (2e-15)

% part (e)
% ????


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

x0a = A\y1

% solution 1, alpha = 12

x1a = x0a + (V2 * alpha1) % x1a = [-3.3990; 9.7980; -3.3990]

y_sol1 = A*x1a %y_sol1 = y1

% solution 2, alpha = 100

x2a = x0a + (V2 * alpha2) % x2a = [-39.3248290463862;81.6496580927726;-39.3248290463864]

y_sol2 = A*x2a %y_sol2 = y1

% part (b)
x0b = A\y2

x1b = x0b + (V2*alpha1) % x1b = [-4.50359962737050e+15;9.00719925474100e+15;-4.50359962737050e+15]

y_sol3 = A*x1b %y_sol3 != y1

%% Prob 2.17
clear; clc;

A = [1 2 3; 2 3 4]
y = [4; 7]

% part (a)
[Q R] = qr(A',0)

xmn = Q*(R'\y)

% part (b)
null_A = null(A)

x1 = xmn + null_A

norm(x1)  % 2.4495
norm(xmn) % 2.2361

%% Prob 2.18
clear; clc;

A = [1 0 1 0 0; 1 1 0 0 1; 0 0 0 1 0]
y = [1; 2; 3]

x0 = A\y

r_a = rank(A)

[U S V] = svd(A)

U1 = U(:,1:r_a)
V1 = V(:,1:r_a)
S1 = S(1:r_a,1:r_a)
V2 = V(:,r_a+1:end)

alpha1 = [100; 23]
alpha2 = [20; 1]

% solution 1

x1a = x0 + (V2 * alpha1) % x1a = [61.2297310080266;-59.2678367867703;-60.2297310080266;3;0.0381057787437342]

y_sol1 = A*x1a %y_sol1 = y1

% solution 2

x2a = x0 + (V2 * alpha2) % x2a = [14.2869995631649;-9.57672744203283;-13.2869995631649;3;-2.71027212113208]

y_sol2 = A*x2a %y_sol2 = y1