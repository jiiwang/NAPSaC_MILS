% Model 1 in the notes
function cfi = fi_op(a,b,T,op)
%FI_OP performs afi op bfi operation.
%   Input:  a: a floating-point number
%           b: a floating-point number
%           T: object describing the data type of fixed-point
%           op: operator, accepted operators are '+', '-', '*', '/' 
%   Output: cfi: a fixed-point number of numerictype T
    afi = quan(a,T);
    bfi = quan(b,T);
    if op == '+'
        cfi = quan(afi+bfi,T);
    elseif op == '-'
        cfi = quan(afi-bfi,T);
    elseif op == '*'
        cfi = quan(afi*bfi,T);
    elseif op == '/'
        cfi = divide(T,afi,bfi);
    else
        error('Error. Input operator must be ''+'', ''-'', ''*'' or ''/''.')
    end
        
end

