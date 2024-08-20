function H = hilbert(n, T)
%HILBERT generates an n-by-n Hibert matrix such that Hij = 1/i+j-1
%   input:  n: size of the Hibert matrix
%           T: numeritype of the Hibert matrix
%   output: H: generated Hibert matrix of numeritype T
    H = zeros(n);
    for i=1:n
        for j=1:n
            H(i,j) = 1/(i+j-1);
        end
    end
    H = trun(H, T);
end

