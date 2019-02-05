function [Queue, queueLen, newA, newS] = markovianArrival(Queue, queueLen, t, lambda, mu, S)
%Markovian Arrival Process Simulation
%   Simulates Arrival Process for M/... Queue
if queueLen <= 1 %Check for single element in queue 
    newS = expRand(mu); %If yes, generate new Service timer
else
    newS = S; %If no, keep current timer
end

newA = expRand(lambda); %Generate next arrival clock
Queue(queueLen) = t; %Save Arrival time of packet
queueLen = queueLen + 1; %Increment Queue Length 


end