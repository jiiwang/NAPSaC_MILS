function phi = recover(y,r)
%RECOVER is the recover function to simulate modulator non-linearity. 
% It is the exact inverse of the transfer function
%   Input:   y: input of scalar/vector/matrix type
%            r: parameter for the transfer function 
%   Output:  phi: output of scalar/vector/matrix type
    phi1 = 2*r^2 - y - y*r^4;
    phi2 = 2*r^2 - 2*y*r^2;
    phi = acos(phi1./phi2);
end

