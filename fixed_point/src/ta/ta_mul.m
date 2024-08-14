function c = ta_mul(a,b,T,nterm,k)
%TA_MUL Summary of this function goes here
%   Detailed explanation goes here
    an = ressplit(a,T,nterm,k);
    bn = ressplit(b,T,nterm,k);
    cn = zeros(nterm,nterm);
    for i=1:nterm
        for j=1:nterm
            cn(i,j) = an(i)*bn(j);
        end
    end
    c = trun(sum(sum(cn)), T);
end

