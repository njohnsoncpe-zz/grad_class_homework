function y = delayQ(rate,d)

y = 0;
for Q = 1:1:100
    y  = y + rate^((d.^Q-d)/(d-1));
end