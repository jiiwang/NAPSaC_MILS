function c = ta_add(a,b,T,nterm,k,nbit,nflag)
%TA_ADD %TA_MUL performs scalar addition of based on the true analog
%   representation of a such that a = a1 + a2 + ... + anterm
%   Input: a: scalar a
%          b: scalar b
%          T: numeritype for fixed-point numbers
%          nterm: number of terms to split a
%          k: ratio paramter
%          nbit: noise level paremeter
%          nflag: flag for noise term, add noise when nflag = 1, 
%          no noise otherwise 
%   Output: c: fixed-point scalar of T type
    an = ressplit(a,T,nterm,k);
    bn = ressplit(b,T,nterm,k);
    cn = zeros(nterm,1);

    amax = 1;
    amin = 0;
    
    kappa = 0;

    if nflag == 1
        % Parameter for optical noise, the standard deviation is kappa*sqrt(a op b)
        kappa = (amax-amin)/2^(nbit+2);
    end

    for i=1:nterm
        cn(i) = an(i) + bn(i) + noise(kappa*sqrt(abs(an(i) + bn(i)).double));
    end

    c = trun(sum(cn), T);
end

