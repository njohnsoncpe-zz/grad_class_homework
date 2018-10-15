function q_mean = geod1sim(T,N,lambda,size)

q = zeros(N,T);
for j = 1:N %j is the experiment iterator
    a = bernoulli_rv(1,T,lambda);
    for k = 1:(T-1)
        q(j,k+1) = max(q(j,k)+size*a(k)-0.5,0);
    end
end
q_mean = mean(q(:,T));
end