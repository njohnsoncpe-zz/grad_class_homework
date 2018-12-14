%%% Geo/Geo/1 queue (Heavy-Traffic Analysis) %%%
%%% Bernoulli arrival, Bernoulli service %%%
clear
clc

lambda = 0.8;
Q = 0:1:20;

TailRR = lambda.^Q;
d = 2;
TailPower2 = lambda.^((d.^Q-1)/(d-1));
d = 3;
TailPower3 = lambda.^((d.^Q-1)/(d-1));
d = 5;
TailPower5 = lambda.^((d.^Q-1)/(d-1));

figure(1) 

semilogy(Q,TailRR,'m-o','LineWidth',2,'MarkerSize',10)
hold on
semilogy(Q,TailPower2,'k-s','LineWidth',2,'MarkerSize',10)
semilogy(Q,TailPower3,'b-^','LineWidth',2,'MarkerSize',10)
semilogy(Q,TailPower5,'r-+','LineWidth',2,'MarkerSize',10)
grid on
axis([0 20 10^(-10) 1])
xlabel('i','FontSize',16)
ylabel('Pr\{Q\geq i\}','FontSize',16)
h_legend = legend('Randomized Routing','Power-of-2-Choices','Power-of-3-Choices','Power-of-5-Choices');
set(h_legend,'FontSize',16);
title('Arrival rate \lambda = 0.8','FontSize',16)

% lambda = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.92 0.94 0.96 0.98 0.99];
% 
% 
% lambda = mu - epsilon;
% 
% rho = (lambda.*(1-mu))./(mu.*(1-lambda));
% Qtheory = rho./(1-rho);
% 
% 
% figure(1)
% plot(1./epsilon,epsilon.*Qtheory,'b','LineWidth',2)
% xlabel('Arrival rate \lambda','FontSize',16)
% ylabel('Average queue length','FontSize',16)
%axis([0.05 0.48 0 5])