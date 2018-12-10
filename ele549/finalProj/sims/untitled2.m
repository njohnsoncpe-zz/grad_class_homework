lambda = 0.3;
q1 = zeros;
time = linspace(1,100,100);

for t = 1:100
    q1(t) = lambda*(1-exp(-t))
end

plot(time,q1)
