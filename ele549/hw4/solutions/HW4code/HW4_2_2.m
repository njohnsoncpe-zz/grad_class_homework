%%% Geo/Geo/1 queue (Heavy-Traffic Analysis) %%%
%%% Bernoulli arrival, Bernoulli service %%%
clear
clc

lambda = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.92 0.94 0.96 0.98 0.99 0.999 0.9999];
mu = 1;

DelayQRR = 1./(mu - lambda);

DelayPower2 = zeros(1,length(lambda));
DelayPower3 = zeros(1,length(lambda));
DelayPower5 = zeros(1,length(lambda));

for i = 1:length(lambda)
    DelayPower2(i) = delayQ(lambda(i),2);
    DelayPower3(i) = delayQ(lambda(i),3);
    DelayPower5(i) = delayQ(lambda(i),5);
end

figure(1) 

plot(lambda,DelayQRR,'m-o','LineWidth',2,'MarkerSize',10)
hold on
plot(lambda,DelayPower2,'k-s','LineWidth',2,'MarkerSize',10)
plot(lambda,DelayPower3,'b-^','LineWidth',2,'MarkerSize',10)
plot(lambda,DelayPower5,'r-+','LineWidth',2,'MarkerSize',10)
grid on
xlabel('Arrival rate \lambda','FontSize',16)
ylabel('Mean delay','FontSize',16)
h_legend = legend('Randomized Routing','Power-of-2-Choices','Power-of-3-Choices','Power-of-5-Choices');
set(h_legend,'FontSize',16);
axis([0.1 1 0 10])
hold off
