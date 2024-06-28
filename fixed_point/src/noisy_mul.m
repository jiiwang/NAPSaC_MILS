function c = noisy_mul(a,b,nDAC,nbit,nflag)
%NOISY_MUL performs a*b operation based on the 5-step noisy model.  
% Inputs a, b, and the output are scalars of the same numerictype T
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nDAC: number of bits for the DAC/ADC noise
%           nbit: number of bits for the optical noise/overall bits of the
%           device
%           nflag: flag for noise term, add noise when nflag = 1, 
%           no noise otherwise 
%   Output: c: a signed nbit fixed-point number
    T = numerictype(1,nbit+1,nbit);

    amax = 1;
    amin = 0;
    
    sigma = 0; 
    k = 0;

    if nflag == 1
        % Standard deviation for digital to analogue (DAC) and 
        % analogue to digital (ADC) noise
        sigma = 0.98*(amax-amin)/2^(nDAC+2);
        
        % Parameter for optical noise, the standard deviation is k*sqrt(a op b)
        k = (amax-amin)/2^(nbit+2);
    end

    % Step 1: Digital quantization
    aD = trun(a, T).double; 
    bD = trun(b, T).double; 
    
    % Step 2: Add DAC noise
    aDAC = aD + noise(sigma);
    bDAC = bD + noise(sigma);
     
    % Step 3: Perform multiplication and add optical noise
    co = aDAC*bDAC + noise(k*sqrt(abs(aDAC*bDAC)));
    
    % Step 4: Add ADC noise
    cA = co + noise(sigma);

    % Step 5: Digital quantization
    c = trun(cA, T);
end

