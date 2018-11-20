function [Queue, queueLen, newS, delayRS] = generalDeparture(Queue, queueLen, t, p, delayRS)
%Markovian Departure Process Simulation
%   Simulates Arrival Process for .../G/... Queue
if queueLen <= 1 %Check for single element in queue
    newS = 1e9; %If yes, set service clock to arbitrarily high time to force arrival
else
    if rand(0,1) < p
        newS = 3*p;
    else
        newS = 3*(1-p)/2;
    end
end
packetDelay = t - Queue(1); %Calculate packetDelay of serviced packet
delayRS = delayRS + packetDelay;

queueLen = queueLen - 1; %Decrement Queue len
if queueLen <= 0
    queueLen = 1;
end

for i = 2:queueLen
    Queue(i-1) = Queue(i); %Move all elements up (inefficent)
end

end

