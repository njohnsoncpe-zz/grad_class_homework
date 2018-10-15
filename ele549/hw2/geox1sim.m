function q_mean = geox1sim(T,N,lambda,M)

q = zeros(N,T);
for j = 1:N
    a = bernoulli_rv(1,T,lambda);
    s = exponential_rv(1,T,M);
    for k = 1:(T-1)
        q(j,k+1) = max(q(j,k)+a(k)-s(k),0);
    end
end
q_mean = mean(q(:,T));
end