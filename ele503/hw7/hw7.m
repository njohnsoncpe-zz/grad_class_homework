%% ELE 503 Homework 7
% Noah Johnson
%% Problem 1

A = [-30 0 0 0; 0 0 1 0; 1225 -1225 -21 0; 0 1 0 0];
B = [30; 0; 0; 0];
C = [0 0 0 1];
D = zeros;

Ts = 0.35;

load sroots;

%part A 
plantPoles = eig(A);
adp = s1/Ts +  imag(plantPoles(2))*i;
sPoles1 = s4/Ts; %Normalized Bessel Poles only
sPoles2 = [plantPoles(4) adp conj(adp) s1/Ts]; % SDPP,ADP,NBP

K1 = place(A,B,sPoles1);
K2 = place(A,B,sPoles2);

% Classical Stability Margins, Robustness Bounds

%Normalized Bessel Poles only
asm(A,B,K1)
[del1_1,del2_1] = rb_regsf(A,B,K1,0)

% SDPP,ADP,NBP
asm(A,B,K2)
[del1_2, del2_2] = rb_regsf(A,B,K2,0)

%part B
