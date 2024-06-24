function d = bin2decT(bin, T)
%BIN2DECT function converts a binary string to a non-negative decimal number 
% within desired range of the numerictype T
%   Input:  bin: a binary string, e.g. '001001'
%           T: object describing the data type of fixed-point
%   Output: d: converted decimal number of bin with the desired range of
%           the numerictype T
    scale = T.WordLength - T.Signed;
    d = bin2dec(bin);
    d = d/2^scale;
end

