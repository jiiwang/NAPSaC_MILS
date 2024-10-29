function b = ta_mv(A,x,T,k, nterm)
%TA_MV performs matrix-vector multiplication of Ax based on the true analog
%   representation of A such that A = A1 + A2 + ... + Anterm
%   Input: A: n-by-n matrix of numeritype T
%          x: n-by-1 vector of numeritype T
%          T: numeritype for fixed-point numbers
%          nterm: number of terms to split A
%          k: ratio paramter
%   Output: b: n-by-1 vector
    An = ressplit(A,T,k,nterm);
    n = size(A,1);
    b = trun(zeros(n,1),T);
    for i=1:nterm
        b = b + An(:,n*(i-1)+1:n*i)*x;
    end
    b = trun(b,T);
end

