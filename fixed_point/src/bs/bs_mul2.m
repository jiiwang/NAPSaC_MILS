function c = bs_mul2(a,b,nbit,nO,nflag)
%BS_MUL performs a*b operation based on the bit-slicing noisy model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: number of bits for the device
%           nO: number of bits for the optical noise
%           nflag: flag for noise term, add noise when nflag = 1, 
%           no noise otherwise            
%   Output: c: a signed 2*nbit fixed-point number
    T1 = numerictype(1,4*nbit+1,4*nbit);
    T2 = numerictype(1,2*nbit+1,2*nbit);
    T3 = numerictype(1,nbit+1,nbit);
    
    amax = 1;
    amin = 0;

    sigma = 0; 
    k = 0;

    if nflag == 1
        % Standard deviation for digital to analogue (DAC) and 
        % analogue to digital (ADC) noise
        sigma = 0.98*(amax-amin)/2^(2*nbit+2);
        
        % Parameter for optical noise, the standard deviation is k*sqrt(a op b)
%         k = (amax-amin)/2^(nO+2);
    end
    
    % Step 1: Digital bit-slicing and quantization
    [ah, al] = split(a, T1, T2);
    [a1, a2] = split(ah, T2, T3);
    [a3, a4] = split(al, T2, T3);

    [bh, bl] = split(b, T1, T2);
    [b1, b2] = split(bh, T2, T3);
    [b3, b4] = split(bl, T2, T3);
    
    % Step 2: Add DAC noise
    a1DAC = a1.double + noise(sigma);
    a2DAC = a2.double + noise(sigma);
    a3DAC = a3.double + noise(sigma);
    a4DAC = a4.double + noise(sigma);
    b1DAC = b1.double + noise(sigma);
    b2DAC = b2.double + noise(sigma);
    b3DAC = b3.double + noise(sigma);
    b4DAC = b4.double + noise(sigma);
    
    % Step 3: Perform 16 multiplications and add optical noise

    c11 = a1DAC*b1DAC;
    c11 = c11 + noise(k*sqrt(abs(c11)));
    c21 = a2DAC*b1DAC;
    c21 = c21 + noise(k*sqrt(abs(c21)));
    c31 = a3DAC*b1DAC;
    c31 = c31 + noise(k*sqrt(abs(c31)));
    c41 = a4DAC*b1DAC;
    c41 = c41 + noise(k*sqrt(abs(c41)));

    c12 = a1DAC*b2DAC;
    c12 = c12 + noise(k*sqrt(abs(c12)));
    c22 = a2DAC*b2DAC;
    c22 = c22 + noise(k*sqrt(abs(c22)));
    c32 = a3DAC*b2DAC;
    c32 = c32 + noise(k*sqrt(abs(c32)));
    c42 = a4DAC*b2DAC;
    c42 = c42 + noise(k*sqrt(abs(c42)));

    c13 = a1DAC*b3DAC;
    c13 = c13 + noise(k*sqrt(abs(c13)));
    c23 = a2DAC*b3DAC;
    c23 = c23 + noise(k*sqrt(abs(c23)));
    c33 = a3DAC*b3DAC;
    c33 = c33 + noise(k*sqrt(abs(c33)));
    c43 = a4DAC*b3DAC;
    c43 = c43 + noise(k*sqrt(abs(c43)));
    
    c14 = a1DAC*b4DAC;
    c14 = c14 + noise(k*sqrt(abs(c14)));
    c24 = a2DAC*b4DAC;
    c24 = c24 + noise(k*sqrt(abs(c24)));
    c34 = a3DAC*b4DAC;
    c34 = c34 + noise(k*sqrt(abs(c34)));
    c44 = a4DAC*b4DAC;
    c44 = c44 + noise(k*sqrt(abs(c44)));

    % Step 4: Add ADC noise
    c11ADC = c11 + noise(sigma);
    c21ADC = c21 + noise(sigma);
    c31ADC = c31 + noise(sigma);
    c41ADC = c41 + noise(sigma);

    c12ADC = c12 + noise(sigma);
    c22ADC = c22 + noise(sigma);
    c32ADC = c32 + noise(sigma);
    c42ADC = c42 + noise(sigma);

    c13ADC = c13 + noise(sigma);
    c23ADC = c23 + noise(sigma);
    c33ADC = c33 + noise(sigma);
    c43ADC = c43 + noise(sigma);

    c14ADC = c14 + noise(sigma);
    c24ADC = c24 + noise(sigma);
    c34ADC = c34 + noise(sigma);
    c44ADC = c44 + noise(sigma);
    
    % Step 5: Digital quantization and process the result from 16
    % multiplications
    c = trun(c11ADC,T2) + 2^-nbit*(trun(c12ADC, T2) + trun(c21ADC, T2))...
        + 2^(-2*nbit)*(trun(c13ADC,T2) + trun(c22ADC,T2) + trun(c31ADC,T2))...
        + 2^(-3*nbit)*(trun(c14ADC,T2) + trun(c23ADC,T2) + trun(c32ADC,T2) + trun(c41ADC,T2))...
        + 2^(-4*nbit)*(trun(c24ADC,T2) + trun(c33ADC,T2) + trun(c42ADC,T2))...
        + 2^(-5*nbit)*(trun(c34ADC, T2) + trun(c43ADC, T2))...
        + 2^(-6*nbit)*trun(c44ADC,T2);
    
    % Step 6: Digital quantization 
    c = trun(c, T1);
end

