addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
rng("twister");

n = 500;
x = zeros(n,2);
y = zeros(n,1);

nbit = 5;
T = numerictype(1,nbit+1,nbit);
k = 0.9;
nterm = 3;

for i = 1:n
    i
    a = 0.5*rand(1);
    b = 0.5*rand(1);
    
    afi = trun(a,T);
    bfi = trun(b,T);

    c_fi = fi_add(afi,bfi,T);

    c_ta = ta_add(afi,bfi,T,nterm,k);

    err = c_fi.double-c_ta.double;
        
    y(i) = err;    
end

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y, 15);
% xline(2^-16, '-r', 'LineWidth', 1.5);
% xline(2^-8, 'LineWidth', 1.5);

leg = legend('$c_{5}-{c_{5}^a}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',30);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,600]);
% xlim([-10*10^-4, 10*10^-4]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
% exportgraphics(gcf, '8_vs_8ta_add_err_count.pdf', 'ContentType', 'vector');