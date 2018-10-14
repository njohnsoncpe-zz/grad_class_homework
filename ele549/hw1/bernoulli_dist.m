function probs_simd = bernoulli_dist(max_trials, n, p)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

probs_simd = zeros(1,11);

for j = 0:max_trials
    X = binornd(n,p);
    probs_simd(X+1) = probs_simd(X+1) + 1;
end
probs_simd = probs_simd./max_trials;
end

