function c = bs_transfer_mul(a,b,nbit,nO,r1,r2,alpha, beta, gamma, nflag)
%BS_TRANSFER_MUL performs a*b operation based on the 5-step transfer model.  
%   Input:  a: a floating-point number
%           b: a floating-point number
%           nbit: number of bits for the DAC/ADC noise (overal number of bit)
%           nO: number of bits for the optical noise
%           r1, r2, alpha: parameter for the transfer function
%           beta, gamma: parameter for the affine map
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
    
    % Step 1: Digital bit-slicing
    [a1, a2] = split(a, T1, T2);
    [b1, b2] = split(b, T1, T2);

    % Step 2: affine map, apply recover function, and digital quantization
    % affmap inputs should be double

    % a1map = affmap(a1.double,beta, gamma);
    % b1map = affmap(b1.double,beta, gamma);
    % a2map = affmap(a2.double,beta, gamma);
    % b2map = affmap(b2.double,beta, gamma);

    a1_inv = recover(a1.double, r1, r2, alpha);
    b1_inv = recover(b1.double, r1, r2, alpha);
    a2_inv = recover(a2.double, r1, r2, alpha);
    b2_inv = recover(b2.double, r1, r2, alpha);
    
    a1_inv = trun(a1_inv, T2).double;
    b1_inv = trun(b1_inv, T2).double;
    a2_inv = trun(a2_inv, T2).double;
    b2_inv = trun(b2_inv, T2).double;
    
    % Step 3: Add DAC noise
    a1DAC = a1_inv + noise(sigma);
    b1DAC = b1_inv + noise(sigma);
    a2DAC = a2_inv + noise(sigma);
    b2DAC = b2_inv + noise(sigma);
     
    % Step 4: Apply transfer function
    % perform multiplication and add optical noise
    a1_tran = transfer(a1DAC, r1, r2, alpha);
    b1_tran = transfer(b1DAC, r1, r2, alpha);
    a2_tran = transfer(a2DAC, r1, r2, alpha);
    b2_tran = transfer(b2DAC, r1, r2, alpha);

    c11_tran = a1_tran*b1_tran;
    c11o = c11_tran + noise(k*sqrt(abs(c11_tran)));
    c12_tran = a1_tran*b2_tran;
    c12o = c12_tran + noise(k*sqrt(abs(c12_tran)));
    c21_tran = a2_tran*b1_tran;
    c21o = c21_tran + noise(k*sqrt(abs(c21_tran)));
    c22_tran = a2_tran*b2_tran;
    c22o = c22_tran + noise(k*sqrt(abs(c22_tran)));

    
    % Step 5: Add ADC noise
    c11A = c11o + noise(sigma);
    c12A = c12o + noise(sigma);
    c21A = c21o + noise(sigma);
    c22A = c22o + noise(sigma);

    % Step 6: Digital quantization and recover of affine mapping
    c11 = trun(c11A, T2);
    c12 = trun(c12A, T2);
    c21 = trun(c21A, T2);
    c22 = trun(c22A, T2);
    
    % c11 = invmap_mul(c11A, a1, b1, beta, gamma);
    % c12 = invmap_mul(c12A, a1, b2, beta, gamma);
    % c21 = invmap_mul(c21A, a2, b1, beta, gamma);
    % c22 = invmap_mul(c22A, a2, b2, beta, gamma);

    % Step 7: Process the result from 4 multiplications
    % no truncation needed
    c = c11 + 2^-nbit*(c12 + c21) + 2^(-2*nbit)*c22;
    
    % c = invmap_mul(c, a, b, beta, gamma);
    
    % Step 8: Digital quantization 
    c = trun(c, T1);
end

