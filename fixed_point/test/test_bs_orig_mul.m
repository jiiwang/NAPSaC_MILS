% Testing script for Model 3
addpath("src/fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
rng("twister");

n = 500;
x = zeros(n,2);
y = zeros(n,1);

nbit = 8;
n1bit = 3;
n2bit = 5;
T = numerictype(1,nbit+1,nbit);

for i = 1:n
    i
    a = rand(1);
    b = rand(1);    

    c_fi = fi_op(a,b,T,'*');

    c_bs = bs_orig_mul(a,b,nbit,n1bit,n2bit,0,0);

    err = c_fi.double-c_bs.double;
        
    y(i) = err;    
end

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y, 15);

leg = legend('$c_{8}-{c_{8}^s}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize', 50);
set(leg, 'Location','northeast');
ylim([0,600]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 40; 
box on;

exportgraphics(gcf, 'test/result/model 3/m1_vs_m3_n=8=3+5_mul_err_count.pdf', 'ContentType', 'vector');