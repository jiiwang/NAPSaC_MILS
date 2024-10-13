function cfi = fi_op(a,b,T,op)
%FI_OP performs afi op bfi operation. Inputs afi, bfi, and the output cfi 
% are scalars of the same numerictype T
%   Input:  afi: a fixed-point number of numerictype T
%           bfi: a fixed-point number of numerictype T 
%           T: object describing the data type of fixed-point
%           op: operator, accepted operators are '+', '-', '*', '/' 
%   Output: cfi: a fixed-point number of numerictype T
    if op == '+'
        cfi = quan(a+b,T);
    elseif op == '-'
        cfi = quan(a-b,T);
    elseif op == '*'
        cfi = quan(a*b,T);
    elseif op == '/'
        cfi = divide(T,a,b);
    else
        error('Error. Input operator must be ''+'', ''-'', ''*'' or ''/''.')
    end
        
end

