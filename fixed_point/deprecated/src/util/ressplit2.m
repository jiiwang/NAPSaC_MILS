function An = ressplit2(A,T,k,nterm,nbit)
%RESSPLIT2 splits n-by-n matrix A into nterms such that 
%   A = kR1 + kR2 + ... + kRnterm or equivalently
%   A = A1 + A2 + ... + Anterm
%   Input: A: n-by-n matrix of numeritype T
%          T: numeritype for fixed-point numbers
%          k: ratio paramter
%          nterm: number of terms to split A
%   Output: An = [A1 A2 ... Anterm] n-by-n*nterm matrix 
    R = A;
    n = size(A,1);
    An = zeros(n,n*nterm);
    An = trun(An,T);

    amax = 1;
    amin = 0;

    sigma = 0.98*(amax-amin)/2^(nbit-1);

    for i=1:nterm
        Ai = trun(k.*R + noise(sigma),T);
        R = trun(R-Ai,T);
        An(:,(i-1)*n+1:i*n) = Ai;
    end
end

