function c = bs_mul(a,b,nDAC,nbit)
%BS_MUL performs a*b operation based on the 6-step bit-slicing noisy model.  
% Inputs a, b, and the output are scalars of the same numerictype T
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nDAC: number of bits for the DAC/ADC noise
%           nbit: number of bits for the optical noise
%   Output: c: a signed nbit fixed-point number
    T1 = numerictype(1,2*nbit+1,2*nbit);
    T2 = numerictype(1,nbit+1,nbit);
    
    amax = 1;
    amin = 0;
    
    % Step 1: Digital bit-slicing and quantization
    [a1, a2] = split(a, T1, T2);
    [b1, b2] = split(b, T1, T2);
    
    % Step 2: Add DAC noise
    % Gaussian noise parameter for digital to analogue (DAC) and 
    % analogue to digital (ADC) noise
    sigma = 0.98*(amax-amin)/2^(nDAC+2);
    a1DAC = a1 + sigma*randn(1);
    a2DAC = a2 + sigma*randn(1);
    b1DAC = b1 + sigma*randn(1);
    b2DAC = b2 + sigma*randn(1);
    
    % Step 3: Perform 4 multiplications and add optical noise
    % Poisson noise parameter for optical noise
    k = (amax-amin)/2^(nbit+2);
    c11 = a1DAC*b1DAC;
    c11 = c11 + k*sqrt(abs(c11))*randn(1);
    
    c21 = a2DAC*b1DAC;
    c21 = c21 + k*sqrt(abs(c21))*randn(1);

    c12 = a1DAC*b2DAC;
    c12 = c12 + k*sqrt(abs(c12))*randn(1);

    c22 = a2DAC*b2DAC;
    c22 = c22 + k*sqrt(abs(c22))*randn(1);

    % Step 4: Add ADC noise
    c11ADC = c11 + sigma*randn(1);
    c21ADC = c21 + sigma*randn(1);
    c12ADC = c12 + sigma*randn(1);
    c22ADC = c22 + sigma*randn(1);
    
    % Step 5: Digital quantization and process the result from 4
    % multiplications
    c = trun(c11ADC,T2) + 2^-nbit*(trun(c21ADC, T2)+trun(c12ADC, T2)) + 2^(-2*nbit)*trun(c22ADC,T2);
    
    % Step 6: Digital quantization 
    c = trun(c, T1);
end

