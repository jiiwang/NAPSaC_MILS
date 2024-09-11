format longE;
addpath("src/util/")

%% Create fixed-point numeritype object
nbit = 2;
T1 = numerictype(1,4*nbit+1, 4*nbit);
T2 = numerictype(1,2*nbit+1, 2*nbit);
T3 = numerictype(1,nbit+1,nbit);

%% Number generation
a = rand(1)

% a in 8-bit fixed point, and its binary representation
afi = trun(a, T1)

afi.bin

%% Bit slicing
% splitting a into four n-bit fixed point such that
% afi = a1 + 2^{-nbit}a2 + 2^{-2*nbit}a3 + 2^{-3*nbit}a4.
[ah, al] = split(a, T1, T2);

% ah.bin
% 
% al.bin

[a1, a2] = split(ah, T2, T3);

[a3, a4] = split(al, T2, T3);

a1.bin

a2.bin

a3.bin

a4.bin

% error: afi - a_bs:
afi.double - (a1.double + 2^-nbit*a2.double + 2^(-2*nbit)*a3.double + 2^(-3*nbit)*a4.double)
