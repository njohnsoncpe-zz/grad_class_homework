%% ELE 459 Homework 4 Plotting
%Noah Johnson



%% Problem 1 (Heavy Traffic Validation)
% See Prob1.cpp for simulation code.


data = table2array(readtable('gg1_htv2'));

epsilon = data(:,1);
vals = data(:,2);

x = epsilon.^-1;

vals2 = epsilon.*vals;

mu = 0.8;
epsln = [0.1, 0.08, 0.05, 0.03, 0.01, 0.008, 0.005, 0.003, 0.001];
ExpQ = zeros;
i = 1;
for i = 1:9
    lambda = mu - epsln(i);
    roh = (lambda*(1-mu))/(mu*(1-lambda));
    ExpQ(i) = epsln(i)*(roh/(1-roh));
end

bound = mu*(1-mu);


plot(x, vals2, 'o')
xlabel('\epsilon^{-1}')
ylabel('\epsilon * E[Q^{(\epsilon)}]')
title('Heavy Traffic Analysis for G/G/1 Queue, \mu = 0.8, \lambda = \mu - \epsilon')
hold on
plot(x,ExpQ)
line([0 1000],[0.16 0.16],'linewidth',3, 'linestyle',':');
legend('Simulation (n = 10^8)', 'Theoretical', 'Heavy Traffic Bound','Location','best')

hold off

%% Problem 2
clear; clc;

lambda = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.92, 0.94, 0.96, 0.98, 0.99];
vals = linspace(0,20,21);

tailDistRR = zeros;
tailDistPow2C = zeros;
tailDistPow3C = zeros;
tailDistPow5C = zeros;

meanDelayRR = zeros;
meanDelayPow2C = zeros;
meanDelayPow3C = zeros;
meanDelayPow5C = zeros;

for j = 1:14
    for i = 1:21
        tailDistRR(i) = lambda(j)^i;
        tailDistPow2C(i) = lambda(j)^((2^i-1)/(2-1));
        tailDistPow3C(i) = lambda(j)^((3^i-1)/(3-1));
        tailDistPow5C(i) = lambda(j)^((5^i-1)/(5-1));
        
    end
    
    meanDelayRR(j) = 1/(1 - lambda(j));
    
    meanDelayPow2C(j) = sum(tailDistPow2C)/lambda(j);
    meanDelayPow3C(j) = sum(tailDistPow3C)/lambda(j);
    meanDelayPow5C(j) = sum(tailDistPow5C)/lambda(j);

    figure
    semilogy(tailDistRR)
    xlabel('i')
    ylabel('Pr\{Q\geqi\}')
    title(['\lambda = ', num2str(lambda(j))])
    hold on
    semilogy(tailDistPow2C)
    semilogy(tailDistPow3C)
    semilogy(tailDistPow5C)
    legend('Randomized Routing','Power of 2 Choices','Power of 3 Choices','Power of 5 Choices','Location','best')
    
    
end
figure
plot(lambda,meanDelayRR)
hold on
plot(lambda,meanDelayPow2C)
plot(lambda,meanDelayPow3C)
plot(lambda,meanDelayPow5C)
xlabel('\lambda')
ylabel('Mean Delay')
title('E[W] vs \lambda')
legend('Randomized Routing','Power of 2 Choices','Power of 3 Choices','Power of 5 Choices','Location','best')

hold off