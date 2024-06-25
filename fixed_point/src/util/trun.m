function Afi = trun(A,T)
% TRUN converts floating-point scalar/vector/matrix to 
% a fixed-point data format of desired numerictype T
%   Input:  A: a floating-point scalar/vector/matrix
%           T: object describing the data type of fixed-point
%   Output: Afi: truncated fixed-point data of A by the desired 
%           numerictype T 
    Afi = fi(A,T);
end

