function q_mean = geogeo1sim(T,N,lambda,mu)

q = zeros(N,T);
for j = 1:N
    a = bernoulli_rv(1,T,lambda);
    s = bernoulli_rv(1,T,mu);
    for k = 1:(T-1)
        q(j,k+1) = max(q(j,k)+a(k)-s(k),0);
    end
end
q_mean = mean(q(:,T));
end