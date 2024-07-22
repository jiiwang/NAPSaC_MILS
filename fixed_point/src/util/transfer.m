function y = transfer(phi,r1,r2,alpha)
%TRANSFER is the transfer function to simulate modulator non-linearity
%   Input:   phi: input of scalar/vector/matrix type
%            r1, r2: parameters for the transfer function
%            alpha: lossy/lossless parameter (alpha < 1 for lossy case, 
%            alpha = 1 for lossless case)
%   Output:  y: output of scalar/vector/matrix type
    y1 = r1^2 - 2*r1*r2*alpha*cos(phi) + r2^2*alpha;
    y2 = 1- 2*r1*r2*alpha*cos(phi) + r1^2*r2^2*alpha;
    y = y1./y2;
end

