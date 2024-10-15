function c = bs_orig_mul(a,b,nbit)
%BS_ORIG_MUL performs a*b operation based on the original bit-slicing noisy model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: number of bits for number representation, output precision
%           is 2*n bit
%   Output: c: a signed 2*nbit fixed-point number
    T1 = numerictype(1,2*nbit+1,2*nbit);
    T2 = numerictype(1,nbit+1,nbit);
    
    % Step 1: bit-slicing
    [a1, a2] = split2(a, T1, T2, T2);
    [b1, b2] = split2(b, T1, T2, T2);
    
    % Step 2: Perform 4 multiplications and add optical noise

    c11 = a1*b1;
    
    c21 = a2*b1;

    c12 = a1*b2;

    c22 = a2*b2;
    
    % Step 3: process the result from 4
    % multiplications
    c = c11 + 2^-nbit*(c21 + c12) + 2^(-2*nbit)*c22;   
    
%     c = trun(c11,T2) + 2^-nbit*(trun(c21,T2) + trun(c12,T2)) + 2^(-2*nbit)*trun(c22,T2);  

    % Step 4: Digital quantization 
    c = quan(c, T1);
end

