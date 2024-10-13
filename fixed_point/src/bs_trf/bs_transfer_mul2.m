function c = bs_transfer_mul2(a,b,nbit,pbit,qbit,nDAC,nADC,no,nflag,r1,r2,alpha)
%BS_TRANSFER_MUL performs a*b operation based on the 5-step transfer model.
% (NO AFFINE MAP)
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: target number of bits (nbit = pbit + qbit)
%           pbit: slice 1 actual number of bits
%           qbit: slice 2 actual number of bits
%           nDAC: DAC noise order
%           nADC: ADC noise order
%           no: optical noise order
%           r1, r2, alpha: parameter for the transfer function
%           nflag: flag for noise term, add noise when nflag = 1, 
%           no noise otherwise 
%   Output: c: a signed nbit fixed-point number
    T1 = numerictype(1,nbit+1,nbit);
    T2 = numerictype(1,pbit+1,pbit);
    T3 = numerictype(1,qbit+1,qbit);
    Tdac = numerictype(1,nDAC+1,nDAC);
    Tadc = numerictype(1,nADC+1,nADC);

    amax = 1;
    amin = 0;

    sigma1 = 0;
    sigma2 = 0;
    k = 0;

    if nflag == 1
        % Standard deviation for digital to analogue (DAC) and 
        % analogue to digital (ADC) noise
        sigma1 = 0.98*(amax-amin)/2^(nDAC+2);
        sigma2 = 0.98*(amax-amin)/2^(nADC+2);
        
        % Parameter for optical noise, the standard deviation is k*sqrt(a op b)
        k = (amax-amin)/2^(no+2);
    end
    
    % Step 1: Digital bit-slicing
    [a1, a2] = split2(a, T1, T2, T3);
    [b1, b2] = split2(b, T1, T2, T3);

    % Step 2: apply recover function, and digital quantization
    % recover function inputs should be double

    a1_inv = recover(a1.double, r1, r2, alpha);
    b1_inv = recover(b1.double, r1, r2, alpha);
    a2_inv = recover(a2.double, r1, r2, alpha);
    b2_inv = recover(b2.double, r1, r2, alpha);
    
    a1_inv = trun(a1_inv, Tdac).double;
    b1_inv = trun(b1_inv, Tdac).double;
    a2_inv = trun(a2_inv, Tdac).double;
    b2_inv = trun(b2_inv, Tdac).double;
    
    % Step 3: Add DAC noise
    a1DAC = a1_inv + noise(sigma1);
    b1DAC = b1_inv + noise(sigma1);
    a2DAC = a2_inv + noise(sigma1);
    b2DAC = b2_inv + noise(sigma1);
     
    % Step 4: Apply transfer function
    % perform multiplication and add optical noise
    a1_tran = transfer(a1DAC, r1, r2, alpha);
    b1_tran = transfer(b1DAC, r1, r2, alpha);
    a2_tran = transfer(a2DAC, r1, r2, alpha);
    b2_tran = transfer(b2DAC, r1, r2, alpha);

    c11_tran = a1_tran*b1_tran;
    c11o = c11_tran + noise(k*sqrt(abs(c11_tran)));
    c12_tran = a1_tran*b2_tran;
    c12o = c12_tran + noise(k*sqrt(abs(c12_tran)));
    c21_tran = a2_tran*b1_tran;
    c21o = c21_tran + noise(k*sqrt(abs(c21_tran)));
    c22_tran = a2_tran*b2_tran;
    c22o = c22_tran + noise(k*sqrt(abs(c22_tran)));

    
    % Step 5: Add ADC noise
    c11A = c11o + noise(sigma2);
    c12A = c12o + noise(sigma2);
    c21A = c21o + noise(sigma2);
    c22A = c22o + noise(sigma2);

    % Step 6: Digital quantization
    c11 = trun(c11A, Tadc);
    c12 = trun(c12A, Tadc);
    c21 = trun(c21A, Tadc);
    c22 = trun(c22A, Tadc);

    % Step 7: Process the result from 4 multiplications
    c = c11 + 2^-pbit*(c12 + c21) + 2^(-2*pbit)*c22;
    
    % Step 8: Digital quantization 
    c = trun(c, T1);
end

