function y = transfer2(phi,r1,r2,alpha)
%TRANSFER is the transfer function to simulate modulator non-linearity
%   Input:   phi: input of scalar/vector/matrix type
%            r1, r2: parameters for the transfer function
%            alpha: lossy/lossless parameter (alpha < 1 for lossy case, 
%            alpha = 1 for lossless case)
%   Output:  y: output of scalar/vector/matrix type
    y1 = r1^2 - 2*r1*r2*alpha*cos(phi) + r2^2*alpha^2;
    y2 = 1- 2*r1*r2*alpha*cos(phi) + r1^2*r2^2*alpha^2;
    y = y1./y2;

    [m,n] = size(phi);
    for i = 1:m
        for j =1:n
            if phi(i,j) < 0
                y(i,j) = -y(i,j);
            end
        end
    end
end

