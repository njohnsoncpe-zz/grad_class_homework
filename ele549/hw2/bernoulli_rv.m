function bernoulli_arr = bernoulli_rv(m,n,lambda)

bernoulli_arr = zeros(m,n);
for i = 1:m
    for j = 1:n
        bernoulli_arr(i,j) = rand < lambda;
    end
end

end