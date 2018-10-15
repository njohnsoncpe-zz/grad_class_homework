function exp_arr = exponential_rv(m,n,M)

exp_arr = zeros(m,n);
p = 1/(2*M);
for i = 1:m
    for j = 1:n
        exp_arr(i,j) = M*(rand < p);
    end
end

end