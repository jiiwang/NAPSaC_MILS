function Afi = trun(A,T)
% TRUN function converts a floating-point number A to a fixed-point number
% of desired numerictype T
%   Input:  A: floating-point number
%           T: object describing the data type of fixed-point
%   Output: Afi: truncated fixed-point number of A by the desired 
%           numerictype T 
    Afi = fi(A,T);
end

