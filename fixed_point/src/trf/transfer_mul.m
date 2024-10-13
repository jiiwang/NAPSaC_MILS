function c = transfer_mul(a,b,nbit,nDAC, nADC, no, nflag,r1,r2,alpha, beta, gamma)
%TRANSFER_MUL performs a*b operation based on the 5-step transfer model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: target number of bits
%           nDAC: DAC noise order
%           nADC: ADC noise order
%           no: optical noise order
%           nflag: flag for noise term, add noise when nflag = 1, 
%           no noise otherwise 
%           r1, r2, alpha: parameter for the transfer function
%           beta, gamma: parameter for the affine map
%   Output: c: a signed nbit fixed-point number
    T = numerictype(1,nbit+1,nbit);
    Tdac = numerictype(1,nDAC+1,nDAC);
    Tadc = numerictype(1,nADC+1,nADC);

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

    % Step 1: affine map, apply recover function, and digital quantization
    amap = affmap(a,beta, gamma);
    bmap = affmap(b,beta, gamma);

    a_inv = recover(amap, r1, r2, alpha);
    b_inv = recover(bmap, r1, r2, alpha);
    
    a_inv = trun(a_inv, Tdac).double; 
    b_inv = trun(b_inv, Tdac).double; 
    
    % Step 2: Add DAC noise
    aDAC = a_inv + noise(sigma1);
    bDAC = b_inv + noise(sigma1);
     
    % Step 3: Apply transfer function
    % perform multiplication and add optical noise
    a_tran = transfer(aDAC, r1, r2, alpha);
    b_tran = transfer(bDAC, r1, r2, alpha);

    c_tran = a_tran*b_tran;
    co = c_tran + noise(k*sqrt(abs(c_tran)));
    
    % Step 4: Add ADC noise
    cA = co + noise(sigma2);

    % Step 5: Digital quantization and recover of affine mapping
    c = trun(cA, Tadc);
    
    c = invmap_mul(c, a, b, beta, gamma);
end

