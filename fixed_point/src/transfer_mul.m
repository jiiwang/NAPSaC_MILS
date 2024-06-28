function c = transfer_mul(a,b,nDAC,nbit,r, nflag)
%TRANSFER_MUL performs a*b operation based on the 5-step transfer model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nDAC: number of bits for the DAC/ADC noise
%           nbit: number of bits for the optical noise/overall bits of the
%           device
%           r: parameter for the transfer function
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

    % Step 1: Digital quantization and apply recover function
    a_inv = recover(a, r);
    b_inv = recover(b, r);
    
    a_inv = trun(a_inv, T).double; 
    b_inv = trun(b_inv, T).double; 
    
    % Step 2: Add DAC noise
    aDAC = a_inv + noise(sigma);
    bDAC = b_inv + noise(sigma);
     
    % Step 3: Apply transfer function
    % perform multiplication and add optical noise
    a_tran = transfer(aDAC, r);
    b_tran = transfer(bDAC, r);

    c_tran = a_tran*b_tran;
    co = c_tran + noise(k*sqrt(abs(c_tran)));
    
    % Step 4: Add ADC noise
    cA = co + noise(sigma);

    % Step 5: Digital quantization
    c = trun(cA, T);    
end

