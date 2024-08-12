addpath("src/ta/");

nbit = 8;
T = numerictype(1,nbit+1,nbit);

n = 3;
nslice = 3;
k = .9;
A = rand(n);
A = trun(A,T)
x = rand(n,1);
x = trun(x,T)

bT = trun(A*x, T)

bTA = ta_mv(A,x,T,nslice,k)

bT - bTA