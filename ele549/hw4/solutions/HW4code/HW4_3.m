%%% Geo/Geo/1 queue (Heavy-Traffic Analysis) %%%
%%% Bernoulli arrival, Bernoulli service %%%
clear
clc
%           lambda            N = 100       N = 300          N = 500
%                                                                              N = 800           N = 1000           Theory
Data = [0.100000000000000,1.01054197900000,1.01037250800000,1.00968306100000,1.00906063900000,1.00884982700000,1.01000100000000;
        0.200000000000000,1.04048964200000,1.03880302200000,1.03949723000000,1.04016540500000,1.04056602400000,1.04006400000000;
        0.300000000000000,1.09396929100000,1.09093380300000,1.08977297300000,1.09406869100000,1.09131586700000,1.09072904800000;
        0.400000000000000,1.16303513500000,1.16368780700000,1.16534304000000,1.16328231800000,1.16260136700000,1.16409868400000;
        0.500000000000000,1.26920037300000,1.26189328100000,1.26509105500000,1.26604529700000,1.26610048000000,1.26568603600000;
        0.600000000000000,1.41136010400000,1.40783681600000,1.40786503900000,1.40524714600000,1.41009161600000,1.40743986300000;
        0.700000000000000,1.62046337100000,1.61128241700000,1.61785300000000,1.61032285800000,1.61059816700000,1.61445377000000;
        0.800000000000000,1.96275028400000,1.95021890900000,1.93656161000000,1.92660365700000,1.94401054100000,1.94736338600000;
        0.900000000000000,2.65698156400000,2.62722897900000,2.59974600200000,2.59756219500000,2.61886454000000,2.61405737700000;
        0.920000000000000,2.89041505000000,2.87454737900000,2.83951323100000,2.84747857600000,2.84365446200000,2.85162790900000;
        0.940000000000000,3.24668354100000,3.18881375600000,3.19667177800000,3.18603891500000,3.15183208800000,3.17223379400000;
        0.960000000000000,3.69563894800000,3.60712225400000,3.69752227200000,3.59432367800000,3.59555105700000,3.64833924400000;
        0.980000000000000,4.75399543300000,4.70259455900000,4.83836658200000,4.37535002500000,4.46264126800000,4.51551056600000;
        0.990000000000000,5.99498134200000,5.39173981300000,5.61921980300000,5.28099380200000,5.30269775100000,5.43199657900000];




lambda = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.92 0.94 0.96 0.98 0.99];
mu = 1;

DelayQRR = 1./(mu - lambda);

DelayPower2 = zeros(1,length(lambda));

for i = 1:length(lambda)
    DelayPower2(i) = delayQ(lambda(i),2);
end

figure(1) 
hold on
plot(Data(:,1),Data(:,2),'m-x','LineWidth',2,'MarkerSize',10)
plot(Data(:,1),Data(:,3),'k-s','LineWidth',2,'MarkerSize',10)
plot(Data(:,1),Data(:,4),'b-^','LineWidth',2,'MarkerSize',10)
plot(Data(:,1),Data(:,5),'r-+','LineWidth',2,'MarkerSize',10)
plot(lambda,DelayPower2,'g','LineWidth',2,'MarkerSize',10)
grid on
xlabel('Arrival rate \lambda','FontSize',16)
ylabel('Mean delay','FontSize',16)
h_legend = legend('N = 100','N = 300','N = 500','N = 800','N = 1000','Theoretical result');
set(h_legend,'FontSize',16);
% axis([0.1 1 0 10])
