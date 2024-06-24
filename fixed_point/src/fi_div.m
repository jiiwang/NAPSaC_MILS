function cfi = fi_div(a,b,T)
%FI_DIV performs a/b operation. Inputs a, b, and the output are scalars 
% of the same numerictype T
%   Input:  a: a fixed-point number of numerictype T
%           b: a fixed-point number of numerictype T 
%           T: object describing the data type of fixed-point
%   Output: cfi: a fixed-point number of numerictype T
    cfi = divide(T,a,b);
end

