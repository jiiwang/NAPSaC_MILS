function c = transfer_mul(a,b,nDAC,nbit,r)
%TRANSFER_MUL performs a*b operation based on the 5-step transfer model.  
% Inputs a, b, and the output are scalars of the same numerictype T
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nDAC: number of bits for the DAC/ADC noise
%           nbit: number of bits for the optical noise
%           r: parameter for the transfer function
%   Output: c: a signed nbit fixed-point number
    T = numerictype(1,nbit+1,nbit);

    amax = 1;
    amin = 0;

    % Step 1: Digital quantization and apply recover function
    aD = trun(a, T).double; 
    bD = trun(b, T).double; 

    a_inv = recover(aD, r);
    b_inv = recover(bD, r);
    
    % Step 2: Add DAC noise
    % Gaussian noise parameter for digital to analogue (DAC) and 
    % analogue to digital (ADC) noise
    sigma = 0.98*(amax-amin)/2^(nDAC+2);
    aDAC = a_inv + sigma*randn(1);
    bDAC = b_inv + sigma*randn(1);
     
    % Step 3: Apply transfer function
    % perform multiplication and add optical noise
    a_tran = transfer(aDAC, r);
    b_tran = transfer(bDAC, r);

    % Poisson noise parameter for optical noise
    k = (amax-amin)/2^(nbit+2);
    co = a_tran*b_tran + k*sqrt(abs(a_tran*b_tran))*randn(1);
    
    % Step 4: Add ADC noise
    cA = co + sigma*randn(1);

    % Step 5: Digital quantization
    c = trun(cA, T);    
end

