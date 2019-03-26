function szeros=get_stable_zeros(A,B,Q,R)
AA=[A 0*A;-Q -A'];
BB=[B;0*B];
CC=[0*B' B'];
sys=ss(AA,BB,CC,0*CC*BB);
szeros=tzero(sys);
if length(szeros) >= 1
    ind=find(real(szeros)<=0);
    szeros=szeros(ind);
end
