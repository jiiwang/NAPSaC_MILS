function c = noisy_op(a,b,op,nbit,nDAC,nADC,no,nflag)
%NOISY_MUL performs a op b operation based on the 5-step noisy model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: target number of bits
%           op: operator, accepted operators are '+', '-', '*', '/' 
%           nDAC: DAC noise order
%           nADC: ADC noise order
%           no: optical noise order
%           nflag: flag for noise term, add noise when nflag = 1, 
%           no noise otherwise 
%   Output: c: a signed nbit fixed-point number
    T = numerictype(1,nbit+1,nbit);

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

    % Step 1: Digital quantization
    aD = quan(a, T).double; 
    bD = quan(b, T).double; 
    
    % Step 2: Add DAC noise
    aDAC = aD + noise(sigma1);
    bDAC = bD + noise(sigma1);
     
    % Step 3: Perform arithmetic and add optical noise
    if op == '+'
        co = aDAC+bDAC + noise(k*sqrt(abs(aDAC+bDAC)));
    elseif op == '-'
        co = aDAC-bDAC + noise(k*sqrt(abs(aDAC-bDAC)));
    elseif op == '*'
        co = aDAC*bDAC + noise(k*sqrt(abs(aDAC*bDAC)));
    elseif op == '/'
        co = aDAC/bDAC + noise(k*sqrt(abs(aDAC/bDAC)));
    else
        error('Error. Input operator must be ''+'', ''-'', ''*'' or ''/''.')
    end 
    
    % Step 4: Add ADC noise
    cA = co + noise(sigma2);

    % Step 5: Digital quantization
    c = quan(cA, T);
end

