function An = ressplit3(A,T,r1,r2,alpha,nterm)
%RESSPLIT splits n-by-n matrix A into nterms such that 
%   A = kR1 + kR2 + ... + kRnterm or equivalently
%   A = A1 + A2 + ... + Anterm
%   Input: A: n-by-n matrix of numeritype T
%          T: numeritype for fixed-point numbers
%          (r1,r2,alpha): paramters for the transfer function
%          nterm: number of terms to split A
%   Output: An = [A1 A2 ... Anterm] n-by-n*nterm matrix 
    R = A
    n = size(A,1);
    An = zeros(n,n*nterm);
    An = trun(An,T);
    
    for i=1:nterm
        i
        Tr = transfer2(R.double,r1,r2,alpha);
        Ai = trun(Tr, T)
        R = trun(R-Ai,T)
        An(:,(i-1)*n+1:i*n) = Ai;
    end
end

