function An = ressplit(A,T,nslice,k)
%RESSPLIT splits n-by-n matrix A into nslices such that 
%   A = kR1 + kR2 + ... + kRnslice or equivalently
%   A = A1 + A2 + ... + Anslice
%   Input: A: n-by-n matrix of numeritype T
%          T: numeritype for fixed-point numbers
%          nslice: number of slices to split A
%          k: ratio paramter
%   Output: An = [A1 A2 ... Anslice] n-by-n*nslice matrix 
    R = A;
    n = size(A,1);
    An = zeros(n,n*nslice);
    An = trun(An,T);
    for i=1:nslice
        Ai = trun(k.*R, T);
        R = trun(R-Ai,T);
        An(:,(i-1)*n+1:i*n) = Ai;
    end
end

