function y = invmap_mul(c,a,b,beta,gamma)
%INVMAP_MUL is the inverse of affine map to compute scalar multiplication
%   Input:   c: scalar multiplication of a and b in optical device
%            a, b: input of scalar/vector/matrix type
%            beta, gamma: parameters for the affine map
%   Output:  y: output of scalar/vector/matrix type   
    y = (c - gamma^2 - beta*gamma*(a+b))./(beta^2);
end

