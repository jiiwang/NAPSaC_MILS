function c = bs_mul(a,b,nbit,pbit,qbit,nDAC,nADC,no,nflag)
%BS_MUL performs a*b operation based on the bit-slicing noisy model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: target number of bits
%           pbit: slice 1 actual number of bits
%           qbit: slice 2 actual number of bits
%           nDAC: DAC noise order
%           nADC: ADC noise order
%           no: optical noise order
%           nflag: flag for noise term, add noise when nflag = 1, 
%           no noise otherwise            
%   Output: c: a signed nbit fixed-point number
    T1 = numerictype(1,nbit+1,nbit);
    T2 = numerictype(1,pbit+1,pbit);
    T3 = numerictype(1,qbit+1,qbit);
    T = numerictype(1,nADC+1,nADC);
    
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
    
    % Step 1: Digital bit-slicing and quantization
    [a1, a2] = split2(a, T1, T2, T3);
    [b1, b2] = split2(b, T1, T2, T3);
    
    % Step 2: Add DAC noise
    a1DAC = a1.double + noise(sigma1);
    a2DAC = a2.double + noise(sigma1);
    b1DAC = b1.double + noise(sigma1);
    b2DAC = b2.double + noise(sigma1);
    
    % Step 3: Perform 4 multiplications and add optical noise

    c11 = a1DAC*b1DAC;
    c11 = c11 + noise(k*sqrt(abs(c11)));
    
    c21 = a2DAC*b1DAC;
    c21 = c21 + noise(k*sqrt(abs(c21)));

    c12 = a1DAC*b2DAC;
    c12 = c12 + noise(k*sqrt(abs(c12)));

    c22 = a2DAC*b2DAC;
    c22 = c22 + noise(k*sqrt(abs(c22)));

    % Step 4: Add ADC noise
    c11ADC = c11 + noise(sigma2);
    c21ADC = c21 + noise(sigma2);
    c12ADC = c12 + noise(sigma2);
    c22ADC = c22 + noise(sigma2);
    
    % Step 5: Digital quantization and process the result from 4
    % multiplications
    c = quan(c11ADC,T) + 2^-pbit*(quan(c21ADC, T)+quan(c12ADC, T)) + 2^(-2*pbit)*quan(c22ADC,T);

    % Step 6: Digital quantization 9
    c = quan(c, T1);
end

