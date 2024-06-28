format longE;

%% Create fixed-point numeritype object
% create a 17 bit fixed-point numeritype object T1 with 1 bit for sign, 
% and 16 bits for fractions 
nbit = 8;
T1 = numerictype(1,2*nbit+1, 2*nbit);
% create a 9 bit fixed-point numeritype object T2 with 1 bit for sign, 
% and 8 bits for fractions 
T2 = numerictype(1,nbit+1,nbit);

%% Number generation
round5 = @(x) round(x.*10.^5)./10.^5;
a = round5(rand(1))

%% 8-bit fixed point
afi8 = trun(a,T2)
afi8.bin

% error: a - afi8:
a - afi8.double

%% 16-bit fixed point
afi16 = trun(a,T1)
afi16.bin

% error: a - afi16:
a - afi16.double