% Model 1 in the notes
function cfi = fi_op(a,b,T,op)
%FI_OP performs afi op bfi operation.
%   Input:  afi: a fixed-point number of of arbitrary numerictype
%           bfi: a fixed-point number of of arbitrary numerictype
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

