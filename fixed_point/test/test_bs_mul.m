addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
rng("twister");

ntrial = 200;
n = 500;
x = zeros(n,2);
% y1 = zeros(n,ntrial);
% y2 = zeros(n,ntrial);
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

        c_2n_no = noisy_mul(a, b, 2*nbit, 2*nbit, 1);

        c_bs_2n_no = bs_mul(a, b, nbit, nbit, 1);
         
        % err1 = c_2n.double-c_2n_no.double;
        % 
        % err2 = c_2n.double-c_bs_2n_no.double;
        % 
        % y1(i, j) = err1;
        % y2(i, j) = err2;
        err = c_2n_no.double - c_bs_2n_no.double;
        y(i,j) = err;
    end
    
end

% y1 = mean(y1,2);
% y2 = mean(y2,2);
y = mean(y,1);

figure;
set(gcf,'position',[300,300,1600,800]);
% histogram(y1);
histogram(y);
% hold on;
% histogram(y2, 15);
xline(2^-16, 'y', 'LineWidth', 2.5);
xline(2^-12, '-r', 'LineWidth', 2.5);
% leg = legend('$c_{10}-\widehat{c_{10}}$', '$c_{10}-\widehat{c_{10}^s}$', ...
%     '$2^{-10}$', '$2^{-8}$');
leg = legend('$\widehat{c_{16}}-\widehat{c_{16}^s}$', ...
     '$2^{-16}$', '$2^{-12}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',40);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,75]);
% xlim([-10*10^-4, 10*10^-4]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
exportgraphics(gcf, '16no_vs_16bs_mul_err_count.pdf', 'ContentType', 'vector');

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