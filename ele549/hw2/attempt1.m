%ELE549 Homework #2

%% Prob #3: Geo/Geo/1 simulation

T = 1e5; %num timesteps
mu = 0.5; %mu (prob service)
i = 1;
j = 1;
N = 90; % num lambda steps
M = 500; % num trials to avg
q_mean = zeros(1,N);

expQueueLen = zeros(1,N); %expected queue len
lambda = linspace(0,0.495,N);

while i <= N
    roh = ((lambda(i)*(1-mu))/(mu*(1-lambda(i))));
    expQueueLen(1,i) = roh/(1-roh);
    q_mean(1,i) = geogeo1sim(T,M,lambda(i),mu);
    i=i+1;
end
%%
plot(lambda,q_mean,'rx')
xlabel("\lambda")
ylabel("Average Queue Length")
hold on;
plot(lambda,expQueueLen)
hold off;
title("Geo/Geo/1 Queue");
legend("mean simulated queue len","mean expected queue len",'Location','NorthWest');
%% Prob #4: Geo/D/1 simulation
clc;clear;
T = 1e5; %num timesteps
mu = 0.5
i = 1
j = 1
N = 200
q_mean = zeros(1,N)

expQueueLen = zeros(1,N); %expected queue len
lambda = linspace(0,0.49,N);

while i <= N
    
    %roh = ((lambda(i)*(1-mu))/(mu*(1-lambda(i))));
    q_mean(1,i) = geod1sim(T,N,lambda(i),2);
    i=i+1;
end
%%
plot(lambda,q_mean)
hold on;
% plot(lambda,expQueueLen)
hold off;
legend("mean simulated queue len","mean expected queue len");