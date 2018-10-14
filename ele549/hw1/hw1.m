hold off;
clear; clc;

t = linspace(0,1);

% X ~ EXP(-2)
F1 = 1-exp(-2*t);
t_remaining1 = 1 - F1;

% X ~ U(0,1)
%Problem with this one
F2 = t;
t_remaining2 = 1 - F2;

% X ~ fT(t)
F3 = (((2*t)+2).^-2) - (((2*t)+1).^-2);
t_remaining3 = 1 - F3

plot(t, t_remaining1);
plot(t, t_remaining2);
plot(t, t_remaining3);

title("Problem 3(c)")

legend("X ~ EXP(2)", "X ~ U(0,1)", "X ~ F3")


%% Simulation 1 (problem 6a,b)
clc; clear;
p = 0.3; % p(success)
n = 10; % Num trials
max_trials = [100 1000 10000];

probs_calcd = zeros(2,11);
for i = 0:n
    probs_calcd(1,i+1) = bernoulli_prob(n,p,i);
    probs_calcd(2,i+1) = bernoulli_prob(n,0.01,i);
end

probs_simd = zeros(3,11);

probs_simd(1,:) = bernoulli_dist(max_trials(1),n,p);
probs_simd(2,:) = bernoulli_dist(max_trials(2),n,p);
probs_simd(3,:) = bernoulli_dist(max_trials(1),n,0.01);



subplot(2,2,1);
bar([transpose(probs_calcd(1,:)) transpose(probs_simd(1,:))]);
title(["calculated probabilites, M = " max_trials(1)]);
subplot(2,2,2);
bar([transpose(probs_calcd(1,:)) transpose(probs_simd(2,:))]);
title(["calculated probabilites, M = " max_trials(2)]);
subplot(2,2,3);
bar([transpose(probs_calcd(2,:)) transpose(probs_simd(3,:))]);
title(["calculated probabilites, M = " max_trials(1) "P = 0.01"]);

%% Simulation 2 (problem 6c)

clc; clear;
p = 0.01
M = 100
n = 10
probs_simd = zeros(2,11)
probs_simd(1,:) = bernoulli_dist(M,n,p)
