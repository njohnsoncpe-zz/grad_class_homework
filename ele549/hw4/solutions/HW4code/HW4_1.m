%%% Geo/Geo/1 queue (heavy-traffic result) %%%

clear
clc
%       epsilon                  meanQ

Data =  [0.100000000000000,1.39906452000000;
         0.0800000000000000,1.79974125000000;
         0.0500000000000000,3.00422893000000;
         0.0300000000000000,5.12375957000000;
         0.0100000000000000,15.7960823000000;
         0.00800000000000000,19.8274864300000;
         0.007,	 22.55593299;
       0.006,	 26.54215566;
       0.005,	 31.71549805;
      0.0045,	 35.43449838;
       0.004,	 39.81543252];
   
TheoLowB = 0.16;  % theorectical low bound = mu*(1-mu) = 0.8*0.2 = 0.16

mu = 0.8;    %%% service rate

lambda = mu - Data(:,1);

rho = (lambda*(1-mu))./(mu*(1-lambda));
Qtheory = rho./(1-rho);

figure(1)
plot(1./Data(:,1),Data(:,1).*Data(:,2),'kd','MarkerSize',10, 'LineWidth', 2)
hold on 
plot(1./Data(:,1),Data(:,1).*Qtheory,'b','LineWidth',2)
plot(1./Data(:,1),TheoLowB*ones(length(Data(:,1)),1),'r','LineWidth',2)
h_legend = legend('Simulation result','Theoretical result','Heavy-traffic limit');
set(h_legend,'FontSize',16);
xlabel('1/\epsilon','FontSize',16)
ylabel('\epsilon\times mean queue length','FontSize',16)
axis([0 255 0.135 0.165])