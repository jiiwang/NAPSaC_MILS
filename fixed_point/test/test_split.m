format longE;

%% Create fixed-point numeritype object
% create a 17 bit fixed-point numeritype object T1 with 1 bit for sign, 
% and 16 bits for fractions (target precision)
nbit = 8;
T1 = numerictype(1,2*nbit+1, 2*nbit);
% create a 9 bit fixed-point numeritype object T2 with 1 bit for sign, 
% and 8 bits for fractions (actual precision)
T2 = numerictype(1,nbit+1,nbit);

%% Number generation
round5 = @(x) round(x.*10.^5)./10.^5;
a = round5(rand(1))

% a in 8-bit fixed point, and its binary representation
afi8 = trun(a, T2)

afi8.bin

% a in 16-bit fixed point, and its binary representation
afi16 = trun(a, T1)

afi16.bin

%% Bit slicing
% splitting a into two 8-bit fixed point such that
% afi16 = a1 + 2^{-nbit}a2. Show binary representations of a1 and a2
[a1, a2] = split(a, T1, T2);
a1
a1.bin
a2
a2.bin

% error: afi16 - a_bs:
afi16.double - (a1.double + 2^-nbit*a2.double)
