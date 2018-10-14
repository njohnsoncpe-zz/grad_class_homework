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
x_proj = V*inv(V'*V)*V'*x


% part (c)
X2 = [v1 v2 x_proj]
G2 = X2'*X
det(G2) % det(G) is extremely close to zero (5e-15) so I suspect it is a rounding error, and this can be said to be equal to 0

%part (d)
e = x - x_proj % defined
e'*v1 % x_T*y = 0 if orthoginal, once again it is extremely close to 0 (2e-15)

% part (e)
% ????