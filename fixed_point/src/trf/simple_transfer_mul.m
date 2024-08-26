function c = simple_transfer_mul(a,b,nbit,nO,r1,r2,alpha, nflag)
%TRANSFER_MUL performs a*b operation based on the 5-step transfer model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: number of bits for the DAC/ADC noise (overall number of bits)
%           nO: number of bits for the optical noise
%           r1, r2, alpha: parameter for the transfer function
%           nflag: flag for noise term, add noise when nflag = 1, 
%           no noise otherwise 
%   Output: c: a signed nbit fixed-point number
    T = numerictype(1,nbit+1,nbit);

    amax = 1;
    amin = 0;

    beta = pi/2;

    sigma = 0; 
    k = 0;

    if nflag == 1
        % Standard deviation for digital to analogue (DAC) and 
        % analogue to digital (ADC) noise
        sigma = 0.98*(amax-amin)/2^(nbit+2);
        
        % Parameter for optical noise, the standard deviation is k*sqrt(a op b)
        k = beta*(amax-amin)/2^(nO+2);
    end

    % Step 1: digital quantization    
    aq = trun(a, T).double; 
    bq = trun(b, T).double; 
    
    % Step 2: Add DAC noise
    aDAC = aq + noise(sigma);
    bDAC = bq + noise(sigma);

    % Step 3: Scaling by pi/2
    as = beta*aDAC;
    bs = beta*bDAC;
     
    % Step 3: Apply transfer function
    % perform multiplication and add optical noise
    a_tran = transfer(as, r1, r2, alpha);
    b_tran = transfer(bs, r1, r2, alpha);

    c_tran = a_tran*b_tran;
    co = c_tran + noise(k*sqrt(abs(c_tran)));
    
    % Step 4: Add ADC noise
    cA = co + noise(sigma);

    % Step 5: Digital quantization
    c = trun(cA, T);
end

