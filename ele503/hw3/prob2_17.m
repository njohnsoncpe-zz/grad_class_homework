%% Prob 2.17

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

