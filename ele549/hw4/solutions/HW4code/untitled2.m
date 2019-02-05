N = 10000;
numSamples = numel(test.numQ1);
fracQ1 = test.numQ1/N;
fracQ2 = test.numQ2/N;
fracIdleOff = test.numIdleOff/N;
fracSetup = test.numSetup/N;

raFQ1 = zeros;
raFQ2 = zeros;
raFIO = zeros;
raFS = zeros;


for idx = 1:numSamples
    raFQ1(idx) = sum(fracQ1(1:idx))/idx;
    raFQ2(idx) = sum(fracQ2(1:idx))/idx;
    raFIO(idx) = sum(fracIdleOff(1:idx))/idx;
    raFS(idx) = sum(fracSetup(1:idx))/idx;
end
plot(raFQ1(1:numSamples),'r')
hold on
plot(raFQ2(1:numSamples),'b')
plot(raFIO(1:numSamples),'g')
plot(raFS(1:numSamples),'m')
legend("q_1","q_2","Idle-off","Setup");
hold off
