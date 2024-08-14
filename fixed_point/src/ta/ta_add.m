function c = ta_add(a,b,T,nterm,k)
%TA_ADD Summary of this function goes here
%   Detailed explanation goes here
    an = ressplit(a,T,nterm,k);
    bn = ressplit(b,T,nterm,k);
    cn = zeros(nterm,1);
    for i=1:nterm
        cn(i) = an(i) + bn(i);
    end

    c = trun(sum(cn), T);
end

