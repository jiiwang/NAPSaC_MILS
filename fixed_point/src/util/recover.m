function phi = recover(y,r1,r2,alpha)
%RECOVER is the recover function to simulate modulator non-linearity. 
% It is the exact inverse of the transfer function
%   Input:   y: input of scalar/vector/matrix type
%            r1, r2: parameters for the transfer function 
%            alpha: ossy/lossless parameter (alpha < 1 for lossy case, 
%            alpha = 1 for lossless case)
%   Output:  phi: output of scalar/vector/matrix type
    phi1 = r1^2 + r2^2*alpha^2 - y - r1^2*r2^2*alpha^2*y;
    phi2 = 2*r1*r2*alpha*(1-y);
    phi = acos(phi1./phi2);
end

