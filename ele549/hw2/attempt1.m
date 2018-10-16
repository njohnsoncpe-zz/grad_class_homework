%ELE549 Homework #2
%Noah Johnson
%% Prob #2: Throughput simulation
T = 1e5;
N_arr = [40 100];
STT = zeros(numel(N_arr),T); % Successful Transmissions per Timeslot
Throughput = zeros(numel(N_arr),T); 
for idx = 1:numel(N_arr)
    numUser = N_arr(idx);
    P = ones(numUser,T);
    P(:,1) = ones(numUser,1);
    Ev = zeros(numUser,1);
    total_transmissions = zeros(1,T);

    for t = 1:(T-1)
        for n = 1:numUser
            Ev(n,1) = rand < P(n,t);
        end
        total_transmissions(1,t) = sum(Ev(:,1));
        if total_transmissions(1,t) == 0
            P(:,t+1) = min(1.2*P(:,t),1);
        elseif total_transmissions(1,t) > 1
            P(:,t+1) = 0.8.*P(:,t);
        else
            P(:,t+1) = P(:,t);
            STT(idx,t) = 1;
            
        end
        Throughput(idx,t) = sum(STT(idx,1:t))/t;
    end
    Throughput(idx,T) = sum(STT(idx,1:T))/T;
end

%% Prob #2 Throughput Graphing
t = 1:T;
plot(t,Throughput(1,:))
hold on
plot(t,Throughput(2,:))
xlabel("Time (t)")
ylabel("Throughput (transmissions/t)")
title("Running Average of Throughput for N = 40, N = 100")

legend("N = 40","N = 100")
hold off

%% Prob #3a: Geo/Geo/1 simulation
T = 1e5; %num timesteps
mu = 0.5; %mu (prob service)
i = 1;
numLambda = 100; % num lambda steps
numTrials = 500; % num trials to avg
geoMeanQueueLen = zeros(1,numLambda);

geoExpectedQueueLen = zeros(1,numLambda); %expected queue len
lambda = linspace(0,0.475,numLambda);

while i <= numLambda
    roh = ((lambda(i)*(1-mu))/(mu*(1-lambda(i))));
    geoExpectedQueueLen(1,i) = roh/(1-roh);
    geoMeanQueueLen(1,i) = geogeo1sim(T,numTrials,lambda(i),mu);
    i=i+1;
end

%% Prob #3b: Geo/Geo/1 graphing
plot(lambda,geoMeanQueueLen,'rx')
xlabel("\lambda")
ylabel("Average Queue Length")
hold on;
plot(lambda,geoExpectedQueueLen)
hold off;
title("Geo/Geo/1 Queue");
legend("mean simulated queue len","mean expected queue len",'Location','NorthWest');

%% Prob #3c: Geo/Det/1 simulation
T = 1e5; %num timesteps
i = 1;
numLambda = 100; %num lambda steps
numTrials = 500; %num trials to average

detMeanQueueLen = zeros(1,numLambda);

detExpectedQueueLen = zeros(1,numLambda); %expected queue len
lambda = linspace(0,0.475,numLambda);

while i <= numLambda

    roh = ((lambda(i))/(1-lambda(i)));
    detExpectedQueueLen(1,i) = roh/(1-roh);
    detMeanQueueLen(1,i) = geod1sim(T,numTrials,lambda(i),1);
    i=i+1;
end

%% Prob #3c: Geo/Det/1 graphing
plot(lambda,detMeanQueueLen,'rx')
xlabel("\lambda")
ylabel("E[\lambda] (Average Queue Length)")
hold on;
plot(lambda,detExpectedQueueLen)
hold off;
title("Geo/Det/1 Queue");
legend("mean simulated queue len","mean expected queue len",'Location','NorthWest');

%% Prob #3d: Geo/Exp/1 simulation
T = 1e5; %num timesteps
numLambda = 100; %num lambda steps
numTrials = 500; %num trials to average
M_arr = [1 5];
lambda = linspace(0,0.475,numLambda);

expMeanQueueLen = zeros(numel(M_arr),numLambda);
% expExpectedQueueLen = zeros(numel(M_arr),numLambda); %expected queue len

for idx = 1:numel(M_arr)
    i = 1;
    m = M_arr(idx);
    while i <= numLambda
        %     roh = ((lambda(i))/(1-lambda(i)));
        %     expExpectedQueueLen(idx,i) = roh/(1-roh);
        expMeanQueueLen(idx,i) = geox1sim(T,numTrials,lambda(i),m);
        i=i+1;
    end
end

%% Prob #3d: Geo/Exp/1 graphing

plot(lambda, expMeanQueueLen(1,:),'xr')
hold on;
plot(lambda, expMeanQueueLen(2,:),'ob')
xlabel("\lambda")
ylabel("E(\lambda) (Average Queue Length)")
title("Geo/X/1 Queue (M = 1, M = 5)");
legend("mean simulated queue len (M = 1)","mean simulated queue len (M = 5)",'Location','NorthWest');
hold off;

%% Geo/D/1, G/G/1, G/X/1 comparison
T = 1e5; %num timesteps
i = 1;
numLambda = 100; %num lambda steps
numTrials = 500; %num trials to average
mu = 0.5; %mu (prob service)

geoMeanQueueLen = zeros(1,numLambda);
detMeanQueueLen = zeros(1,numLambda);

geoExpectedQueueLen = zeros(1,numLambda); %expected queue len
detExpectedQueueLen = zeros(1,numLambda); %expected queue len
lambda = linspace(0,0.475,numLambda);

while i <= numLambda
    roh = ((lambda(i)*(1-mu))/(mu*(1-lambda(i))));
    roh1 = ((lambda(i))/(1-lambda(i)));
    geoExpectedQueueLen(1,i) = roh/(1-roh);
    detExpectedQueueLen(1,i) = roh1/(1-roh1);
    geoMeanQueueLen(1,i) = geogeo1sim(T,numTrials,lambda(i),mu);
    detMeanQueueLen(1,i) = geod1sim(T,numTrials,lambda(i),1);
    i=i+1;
end

%% Geo/D/1, G/G/1, G/X/1 comparison graphing
hold on;
plot(lambda,geoMeanQueueLen, 'rx')
plot(lambda,detMeanQueueLen, 'bx')
plot(lambda,expMeanQueueLen(1,:), 'cx')
plot(lambda,expMeanQueueLen(2,:), 'mx')
plot(lambda,geoExpectedQueueLen,'r')
plot(lambda,detExpectedQueueLen,'b')
xlabel("\lambda")
ylabel("E(\lambda) (Average Queue Length)")
title("Geo/Geo/1 vs Geo/D/1 vs Geo/X/1");
legend("mean simulated queue len (G/G/1)","mean simulated queue len (G/D/1)","mean simulated queue len (G/X/1,M = 1)","mean simulated queue len (G/X/1,M = 5)","mean expected queue len (G/G/1)","mean expected queue len (G/D/1)",'Location','NorthWest');
hold off;

%% Bonus INCORRECT
subplot(2,1,1)
hold on;
plot(lambda,geoMeanQueueLen, 'rx')
plot(lambda,detMeanQueueLen, 'bx')
plot(lambda,expMeanQueueLen(1,:), 'cx')
plot(lambda,expMeanQueueLen(2,:), 'mx')
plot(lambda,geoExpectedQueueLen,'r')
plot(lambda,detExpectedQueueLen,'b')
xlabel("\lambda")
ylabel("E(\lambda) (Average Queue Length)")
title("Geo/Geo/1 vs Geo/D/1 vs Geo/X/1");
legend("mean simulated queue len (G/G/1)","mean simulated queue len (G/D/1)","mean simulated queue len (G/X/1,M = 1)","mean simulated queue len (G/X/1,M = 5)","mean expected queue len (G/G/1)","mean expected queue len (G/D/1)",'Location','NorthWest');
hold off;
subplot(2,1,2)
hold on;
plot(lambda,(geoMeanQueueLen./lambda), 'r--')
plot(lambda,(detMeanQueueLen./lambda), 'b--')
plot(lambda,(expMeanQueueLen(1,:)./lambda), 'c--')
plot(lambda,(expMeanQueueLen(2,:)./lambda), 'm--')
% plot(lambda,(geoExpectedQueueLen./lambda),'r--')
% plot(lambda,(detExpectedQueueLen./lambda),'b--')
xlabel("\lambda")
ylabel("L/\lambda (Average Wait Time)")
title("Geo/Geo/1 vs Geo/D/1 vs Geo/X/1");
legend("mean simulated delay  (G/G/1)","mean simulated delay (G/D/1)","mean simulated delay (G/X/1,M = 1)","mean simulated delay (G/X/1,M = 5)",'Location','NorthWest');
hold off;
