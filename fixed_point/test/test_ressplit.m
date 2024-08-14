nbit = 8;
T = numerictype(1,nbit+1,nbit);

% Example 1
% n = 2;
% nslice = 3;
% k = .9;
% A = [0.3,0.7;0.9,0.6];
% A = trun(A,T);
% 
% An = ressplit(A,T,nslice,k);
% 
% R = A;
% for i=1:nslice
%     R = R - An(:,(i-1)*n+1:i*n);
% end
% 
% R

% Example 2
nslice = 4;
k = .7;
a = 0.8;
a = trun(a,T)

an = ressplit(a,T,nslice,k)
sum = trun(0,T);
for i=1:nslice
    sum = sum + an(i);
end

sum

err = a - sum


