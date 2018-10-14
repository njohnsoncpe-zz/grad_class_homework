function q_mean = geod1sim(T,N,lambda,size)

q = zeros(N,T);
q1 = zeros(1,N);

for j = 1:N
    a = bernoulli_rv(1,T,lambda);

    for k = 1:(T-1)
        q(1,k+1) = max(q(k)+size*a(k)-1,0);
    end
    q1(j,k+1) = q(j,T-1);
end
q_mean = mean(q1);
end