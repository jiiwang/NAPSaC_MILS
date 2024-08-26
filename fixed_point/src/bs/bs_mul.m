function c = bs_mul(a,b,nbit,nO,nflag)
%BS_MUL performs a*b operation based on the bit-slicing noisy model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: number of bits for the DAC/ADC noise (overal number of bit)
%           nO: number of bits for the optical noise
%           nflag: flag for noise term, add noise when nflag = 1, 
%           no noise otherwise            
%   Output: c: a signed 2*nbit fixed-point number
    T1 = numerictype(1,2*nbit+1,2*nbit);
    T2 = numerictype(1,nbit+1,nbit);
    
    amax = 1;
    amin = 0;

    sigma = 0; 
    k = 0;

    if nflag == 1
        % Standard deviation for digital to analogue (DAC) and 
        % analogue to digital (ADC) noise
        sigma = 0.98*(amax-amin)/2^(nbit+2);
        
        % Parameter for optical noise, the standard deviation is k*sqrt(a op b)
        k = (amax-amin)/2^(nO+2);
    end
    
    % Step 1: Digital bit-slicing and quantization
    [a1, a2] = split(a, T1, T2);
    [b1, b2] = split(b, T1, T2);
    
    % Step 2: Add DAC noise
    a1DAC = a1.double + noise(sigma);
    a2DAC = a2.double + noise(sigma);
    b1DAC = b1.double + noise(sigma);
    b2DAC = b2.double + noise(sigma);
    
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
    c11ADC = c11 + noise(sigma);
    c21ADC = c21 + noise(sigma);
    c12ADC = c12 + noise(sigma);
    c22ADC = c22 + noise(sigma);
    
    % Step 5: Digital quantization and process the result from 4
    % multiplications
    c = trun(c11ADC,T2) + 2^-nbit*(trun(c21ADC, T2)+trun(c12ADC, T2)) + 2^(-2*nbit)*trun(c22ADC,T2);
    
    % no truncation
    % c = c11ADC + 2^-nbit*(c21ADC + c12ADC) + 2^(-2*nbit)*c22ADC;
    
    % most siginificant part truncates to numerictype T1 (more bits)
    % c = trun(c11ADC,T1) + 2^-nbit*(trun(c21ADC, T2)+trun(c12ADC, T2)) + 2^(-2*nbit)*trun(c22ADC,T2);

    % Step 6: Digital quantization 
    c = trun(c, T1);
end

