function c = noisy_mul(a,b,nDAC,nbit)
%NOISY_MUL performs a*b operation based on the 5-step noisy model.  
% Inputs a, b, and the output are scalars of the same numerictype T
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nDAC: number of bits for the DAC/ADC noise
%           nbit: number of bits for the optical noise
%   Output: c: a signed nbit fixed-point number
    T = numerictype(1,nbit+1,nbit);

    amax = 1;
    amin = 0;

    % Step 1: Digital quantization
    aD = trun(a, T).double; 
    bD = trun(b, T).double; 
    
    % Step 2: Add DAC noise
    % Gaussian noise parameter for digital to analogue (DAC) and 
    % analogue to digital (ADC) noise
    sigma = 0.98*(amax-amin)/2^(nDAC+2);
    aDAC = aD + sigma*randn(1);
    bDAC = bD + sigma*randn(1);
     
    % Step 3: Perform multiplication and add optical noise
    % Poisson noise parameter for optical noise
    k = (amax-amin)/2^(nbit+2);
    co = aDAC*bDAC + k*sqrt(abs(aDAC*bDAC))*randn(1);
    
    % Step 4: Add ADC noise
    cA = co + sigma*randn(1);

    % Step 5: Digital quantization
    c = trun(cA, T);
end

