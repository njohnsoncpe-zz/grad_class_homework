function [Queue, queueLen, newS, delayRS] = markovianDeparture(Queue, queueLen, t, mu, delayRS)
%Markovian Departure Process Simulation
%   Simulates Arrival Process for .../M/... Queue
if queueLen <= 1 %Check for single element in queue
    newS = 1e9; %If yes, set service clock to arbitrarily high time to force arrival
else
    newS = expRand(mu); %Otherwise, generate normal service clock
end
packetDelay = t - Queue(1); %Calculate packetDelay of serviced packet
delayRS = delayRS + packetDelay;

queueLen = queueLen - 1; %Decrement Queue len
if queueLen <= 1
    queueLen = 1;
end

for i = 2:queueLen
    Queue(i-1) = Queue(i); %Move all elements up (inefficent)
end

end