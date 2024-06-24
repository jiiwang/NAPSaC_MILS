function y = transfer(phi,r)
%TRANSFER is the transfer function to simulate modulator non-linearity
%   Input:   phi: input of scalar/vector/matrix type
%            r: parameter for the transfer function 
%   Output:  y: output of scalar/vector/matrix type
    y1 = 2*r^2*(1-cos(phi));
    y2 = 1- 2*r^2*cos(phi) + r^4;
    y = y1./y2;
end

