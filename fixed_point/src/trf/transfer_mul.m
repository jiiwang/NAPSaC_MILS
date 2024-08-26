function c = transfer_mul(a,b,nbit,nO,r1,r2,alpha, beta, gamma, nflag)
%TRANSFER_MUL performs a*b operation based on the 5-step transfer model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: number of bits for the DAC/ADC noise (oveall number of bits)
%           nO: number of bits for the optical noise
%           r1, r2, alpha: parameter for the transfer function
%           beta, gamma: parameter for the affine map
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
        sigma = 0.98*(amax-amin)/2^(nbit+2);
        
        % Parameter for optical noise, the standard deviation is k*sqrt(a op b)
        k = (amax-amin)/2^(nO+2);
    end

    % Step 1: affine map, apply recover function, and digital quantization
    amap = affmap(a,beta, gamma);
    bmap = affmap(b,beta, gamma);

    a_inv = recover(amap, r1, r2, alpha);
    b_inv = recover(bmap, r1, r2, alpha);
    
    a_inv = trun(a_inv, T).double; 
    b_inv = trun(b_inv, T).double; 
    
    % Step 2: Add DAC noise
    aDAC = a_inv + noise(sigma);
    bDAC = b_inv + noise(sigma);
     
    % Step 3: Apply transfer function
    % perform multiplication and add optical noise
    a_tran = transfer(aDAC, r1, r2, alpha);
    b_tran = transfer(bDAC, r1, r2, alpha);

    c_tran = a_tran*b_tran;
    co = c_tran + noise(k*sqrt(abs(c_tran)));
    
    % Step 4: Add ADC noise
    cA = co + noise(sigma);

    % Step 5: Digital quantization and recover of affine mapping
    c = trun(cA, T);
    
    c = invmap_mul(c, a, b, beta, gamma);
end

