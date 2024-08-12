function b = ta_mv(A,x,T,nslice,k)
%TA_MV performs matrix-vector multiplication of Ax based on the true analog
%   representation of A such that A = A1 + A2 + ... + Anslice
%   Input: A: n-by-n matrix of numeritype T
%          x: n-by-1 vector of numeritype T
%          T: numeritype for fixed-point numbers
%          nslice: number of slices to split A
%          k: ratio paramter
%   Output: b: n-by-1 vector
    An = ressplit(A,T,nslice,k);
    n = size(A,1);
    b = trun(zeros(n,1),T);
    for i=1:nslice
        b = trun(b + trun(An(:,n*(i-1)+1:n*i)*x, T), T);
    end
end

