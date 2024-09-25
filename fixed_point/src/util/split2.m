function [Afi1,Afi2] = split2(A,T1,T2,T3)
%SPLIT first converts a floating point number/vector/matrix to 
% its fixed-point format (Afi) of the desired numerictype T1. 
% It then splits the converted fixed-point data into high part (Afi1) of numerictype T2 
% and low part (Afi2) of numerictype T3 such that:
%           Afi = Afi1 + 2^{-T2.FractionLength}*Afi2
%   
%   Input:  A: a floating-point number/vector/matrix
%           T1: object describing the long data type of fixed-point
%           T2, T3: object describing the sliced short data type of fixed-point
%   Output: Afi1: converted high part of the fixed-point data with of
%           the numerictype T2
%           Afi2: converted low part of the fixed-point data with of
%           the numerictype T3
%
% CONSTRAINTS: 1). Neither T1 and T2 have integer part
%              2). T1.FractionLength = T2.FractionLength + T3.FractionLength
    [m,n] = size(A);
    A1 = zeros(m,n);
    A2 = zeros(m,n);

    if T1.FractionLength ~= T2.FractionLength + T3.FractionLength
        error('Error. \n Must have T1.FractionLength = T2.FractionLength + T3.FractionLength.')
    end

    for i=1:m
        for j=1:n
            isNeg = 1;
            % check whether the element if negative
            if A(i,j) < 0
                isNeg = -1;
            end
            fiT1 = trun(isNeg*A(i,j),T1);
            
            % binary representation of the non-negative fixed-point of
            % numerictype T1
            fiT1bin = fiT1.bin;
            % high part binary representation (excluding sign)
            bin1 = fiT1bin(2:T2.FractionLength+1);
            % low part binary representation (excluding sign)
            bin2 = fiT1bin(T2.FractionLength+2:end);
            d1 = bin2decT(bin1, T2);
            d2 = bin2decT(bin2, T3);
            A1(i,j) = isNeg*d1;
            A2(i,j) = isNeg*d2;
        end
    end
    
    % convert to fixed-point of numerictype T2 and T3
    Afi1 = trun(A1, T2);
    Afi2 = trun(A2, T3);
end

