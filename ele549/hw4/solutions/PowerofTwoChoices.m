%%%%%%% Power of Two choices %%%%%%%%
clear
clc
T = 1e3;             % simulation time slots
N = 5;             % number of servers
lambda = 0.8;        % arrival rate is N*lambda

Q = zeros(N,T);

InterEventTime = zeros(1,T);   % sampling time

for t = 1:T-1
    NumofNonEmptyQ = sum((Q(:,t)>0));   % number of non-empty queues
    InterEventTime(t) = exprnd(1/(N*lambda+NumofNonEmptyQ));
    if rand < (N*lambda/(NumofNonEmptyQ+N*lambda))  %%% arrival event
        PIndex = randperm(N,2);                     %%% randomly select two queues
        if(Q(PIndex(1),t) <= Q(PIndex(2),t))
            ArrivalID = PIndex(1);
        else
            ArrivalID = PIndex(2);
        end
        
        for i=1:N
            if(i==ArrivalID)
                Q(i,t+1) = Q(i,t) + 1;
            else
                Q(i,t+1) = Q(i,t);
            end
        end
        
    else                                            %%% departure event
        ServerIndex = ceil(NumofNonEmptyQ*rand);
        tempServiceID = 0 ;
        ServiceID = 0 ;
        for i = 1:N
            if (Q(i,t)>0) 
                tempServiceID = tempServiceID + 1;
            end
            if(tempServiceID == ServerIndex)
                ServiceID = i;
                break;
            end
        end
        
        for i = 1:N
            if(i==ServiceID)
                Q(i,t+1) = max(Q(i,t)-1,0);
            else
                Q(i,t+1) = Q(i,t);
            end
        end
        
    end
end


avgQ =sum(mean(Q).*InterEventTime(1:T))/sum(InterEventTime(1:T-1))
%%
TheoryQ = zeros;
for i = 1:100
    TheoryQ(i+1) = TheoryQ(i) + power(lambda,2^i-1);
end
plot(TheoryQ)

MM1Q = lambda/(1-lambda)