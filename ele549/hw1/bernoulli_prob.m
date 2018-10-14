function prob_k = bernoulli_prob(n,p,k)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
prob_k = nchoosek(n,k)*(p^k)*((1-p)^(n-k));
end

