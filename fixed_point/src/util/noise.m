function n = noise(sigma)
%NOISE generates a random number from the normal distribution with 
% mean parameter mu and standard deviation parameter sigma.
    mu = 0;
    n = normrnd(mu,sigma);
end

