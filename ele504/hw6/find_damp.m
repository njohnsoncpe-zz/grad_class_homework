function dr=find_damp(poles)
N=length(poles);
k=1;
dr=[];
while k<N
    if imag(poles(k))~= 0
        dr=[dr real(-poles(k))/abs(poles(k))];
        k=k+2;
    else
    k=k+1;
    end
    
end