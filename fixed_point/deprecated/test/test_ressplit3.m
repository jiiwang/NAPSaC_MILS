nbit = 8;
T = numerictype(1,nbit+1,nbit);

% Example 1
% n = 5;
% nterm = 6;
% k = .7;
% A = hilbert(n,T)
% 
% An = ressplit(A,T,k,nterm);
% 
% sum = zeros(n);
% for i=1:nterm
%     sum = sum + An(:,(i-1)*n+1:i*n);
% end
% 
% sum
% err = abs(A - sum)

% Example 2
nterm = 10;

r1 = .9;
alpha = .98;
r2 = r1/alpha;

a = 0.4;
a = trun(a,T)

an = ressplit3(a,T,r1,r2,alpha,nterm)
sum = trun(0,T);
for i=1:nterm
    sum = sum + an(i);
end

sum

err = abs(a - sum)

% Example 3
% nterm = 4;
% k = .9;
% a = 0.9;
% a = trun(a,T)
% 
% an = ressplit2(a,T,k,nterm,nbit)
% bin = an.bin
% sum = trun(0,T);
% for i=1:nterm
%     sum = sum + an(i);
% end
% 
% sum
% 
% err = abs(a - sum)


