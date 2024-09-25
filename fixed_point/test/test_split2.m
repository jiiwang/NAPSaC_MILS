format longE;

%% Create fixed-point numeritype object
% create a (nbit+1) bit fixed-point numeritype object T1 with 1 bit for sign, 
% and nbit bits for fractions (target precision)
nbit = 8;
T1 = numerictype(1,nbit+1,nbit);
% create a (pbit+1) bit fixed-point numeritype object T2 with 1 bit for sign, 
% and pbit bits for fractions (actual precision)
pbit = 3;
T2 = numerictype(1,pbit+1,pbit);
% create a (qbit+1) bit fixed-point numeritype object T3 with 1 bit for sign, 
% and qbit bits for fractions (actual precision)
% such that "nbit = pbit + qbit"
qbit = 5;
T3 = numerictype(1,qbit+1,qbit);

%% Number generation
% a = rand(1)
a = 0.3251

% a in nbit fixed point, and its binary representation
afi = trun(a, T1)

afi.bin


%% Bit slicing
% splitting a into a pbit fixed point number a1 and a qbit fixed point
% number a2 such that
% afi = a1 + 2^{-pbit}a2. Show binary representations of a1 and a2
[a1, a2] = split2(a, T1, T2, T3);
a1
a1.bin
a2
a2.bin

% error: afi - a_bs:
err = afi.double - (a1.double + 2^-pbit*a2.double)
