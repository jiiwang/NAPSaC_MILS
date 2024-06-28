format longE;
%% Create fixed-point numeritype object
% create a 9 bit fixed-point numeritype object with 1 bit for sign, 
% and 8 bits for fractions
nbit = 8;
T = numerictype(1,nbit+1,nbit);

%% Generate two input numbers
a = 0.328

b = 0.179

% a in 8-bit fixed point:
afi8 = trun(a, T)

% b in 8-bit fixed point:
bfi8 = trun(b, T)

%% Addition
% a + b in double precision:
c_add_d = a + b

% a + b in 8-bit fixed-point:
c_add_fi = fi_add(afi8, bfi8, T)

disp('error: c_add_d - c_add_fi')
c_add_d - c_add_fi.double

%% Subtraction
% a - b in double precision:
c_sub_d = a - b

% a - b in 8-bit fixed-point:
c_sub_fi = fi_sub(afi8, bfi8, T)

disp('error: c_sub_d - c_sub_fi')
c_sub_d - c_sub_fi.double

%% Multiplication
% a * b in double precision:
c_mul_d = a * b

% a * b in 8-bit fixed-point:
c_mul_fi = fi_mul(afi8, bfi8, T)

disp('error: c_mul_d - c_mul_fi')
c_mul_d - c_mul_fi.double

%% Division
% b / a in double precision:
c_div_d = b / a

% b / a in 8-bit fixed-point:
c_div_fi = fi_div(bfi8, afi8, T)

disp('error: c_div_d - c_div_fi')
c_div_d - c_div_fi.double
   