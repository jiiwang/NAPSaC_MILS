addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")
addpath("src/ta/")

% random seed, for reproducible results
rng("twister");

n = 500;
x = zeros(n,2);
y = zeros(n,1);

nbit = 8;
T = numerictype(1,nbit+1,nbit);
k = 0.9;
nterm = 3;

for i = 1:n
    i
    a = rand(1);
    b = rand(1);
    
    afi = trun(a,T);
    bfi = trun(b,T);

    c_fi = fi_mul(afi,bfi,T);

    c_ta = ta_mul(afi,bfi,T,nterm,k,nbit-2, 1);

    err = c_fi.double-c_ta.double;
        
    y(i) = err;    
end

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y, 15);
% xline(2^-16, '-r', 'LineWidth', 1.5);
xline(2^-8, 'LineWidth', 2.5);
xline(2^-7, '-r', 'LineWidth', 2.5);

leg = legend('$c_{8}-{c_{8}^a}$', '$2^{-8}$', '$2^{-7}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',50);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,600]);
% xlim([-10*10^-4, 10*10^-4]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
% exportgraphics(gcf, '8_vs_8ta_mul_err_count.pdf', 'ContentType', 'vector');