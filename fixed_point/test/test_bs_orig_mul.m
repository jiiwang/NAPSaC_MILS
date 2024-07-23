addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
rng("twister");

ntrial = 200;
n = 500;
x = zeros(n,2);
y = zeros(n,ntrial);

nbit = 8;
T1 = numerictype(1,2*nbit+1, 2*nbit);
T2 = numerictype(1,nbit+1,nbit);

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    x(i,:) = [a b];

    c_2n = fi_mul(a,b,T1);

    for j = 1:ntrial

        c_bs_2n = bs_orig_mul(a, b, nbit);

        err = c_2n.double-c_bs_2n.double;
        
        y(i, j) = err;
    end
    
end

y = mean(y,2);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y, 15);
xline(2^-16, '-r', 'LineWidth', 1.5);
% xline(2^-11, '-y', 'LineWidth', 1.5);
% xline(2^-10, '-r', 'LineWidth', 1.5);

leg = legend('$c_{16}-{c_{16}^s}$', '$2^{-16}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',30);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,n]);
% xlim([-10*10^-4, 10*10^-4]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
exportgraphics(gcf, '16_vs_16bs_orig_mul_err_count.pdf', 'ContentType', 'vector');

% [v1, e1] = histcounts(y1,'BinWidth',10^-4);
% [v2, e2] = histcounts(y2,'BinWidth',10^-4);
% 
% v2 = [v2, zeros(1, size(e1,2) - size(e2,2))];
% 
% figure;
% set(gcf,'position',[300,300,1600,800]);
% bar(e1(1:end-1),[v1; v2]');
% xline(2^-12, 'LineWidth', 2);
% xline(2^-10, '-g', 'LineWidth', 2);
% xline(2^-8, '-r', 'LineWidth', 2);
% leg1 = legend('$c_{8}-\widehat{c_{8}}$', ...
%     '$c_{16}-\widehat{c_{16}}$', '$2^{-12}$', '$2^{-10}$', '$2^{-8}$');
% set(leg1,'Interpreter','latex');
% set(leg1,'FontSize',30);
% set(leg1, 'Location','north','Orientation','horizontal');
% ylim([0,n]);
% xlabel('error')
% ylabel('count')
% ax = gca; 
% ax.FontSize = 30; 
% box on;
% exportgraphics(gcf, 'bs_mul_err_count.pdf', 'ContentType', 'vector');