% Model 3 and 3v in the notes
function c = bs_orig_mul(a,b,nbit,n1bit,n2bit,nADC,nflag)
%BS_ORIG_MUL performs a*b operation based on the original bit-slicing noisy model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: target number of bits
%           n1bit: slice 1 actual number of bits
%           n2bit: slice 2 actual number of bits
%           nADC: ADC noise order
%           nflag: flag for quantization of partial products, quantize when nflag = 1, 
%           no quantization otherwise            
%   Output: c: a signed nbit fixed-point number
    T1 = numerictype(1,nbit+1,nbit);
    T2 = numerictype(1,n1bit+1,n1bit);
    T3 = numerictype(1,n2bit+1,n2bit);
    Tadc = numerictype(1,nADC+1,nADC);
    
    % Step 1: bit-slicing
    [a1, a2] = split2(a, T1, T2, T3);
    [b1, b2] = split2(b, T1, T2, T3);
    
    % Step 2: Perform 4 multiplications and add optical noise

    c11 = a1*b1;
    
    c21 = a2*b1;

    c12 = a1*b2;

    c22 = a2*b2;
    
    % Step 3: process the result from 4 multiplications
    c = c11 + 2^-n1bit*(c21 + c12) + 2^(-2*n1bit)*c22;   
    
    % ADC quantization if specified
    if nflag == 1
        c = quan(c11,Tadc) + 2^-n1bit*(quan(c21,Tadc) + quan(c12,Tadc)) + 2^(-2*n1bit)*quan(c22,Tadc);  
    end

    % Step 4: Digital quantization 
    c = quan(c, T1);
end

