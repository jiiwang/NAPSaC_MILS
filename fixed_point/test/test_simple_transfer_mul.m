addpath('src/trf/');
addpath('src/util');
addpath('src/nbit_fi/');

% random seed, for reproducible results
rng("twister");

% # of trials per run
ntrial = 200;
% # of runs
n = 500;
x = zeros(n,2);
% y = zeros(n,1);
% y1 = zeros(n,ntrial);
% y2 = zeros(n,ntrial);
y = zeros(n,ntrial);

nbit = 5;
T = numerictype(1,nbit+1,nbit);

r1 = .9;
alpha = .98;
r2 = r1/alpha;

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    % c_8 = fi_mul(a,b,T);
    % y(i) = c_8;

    for j = 1:ntrial

        c_8_no = noisy_mul(a, b, nbit, nbit-2, 1);
    
        c_8_tran_no = simple_transfer_mul(a,b,nbit,nbit-2,r1,r2,alpha,1);
    
        err = c_8_no.double - c_8_tran_no.double;
        y(i,j) = err;
    end
    
end

% y1 = mean(y1,2);
% y2 = mean(y2,2);
y = mean(y,2);

figure;
set(gcf,'position',[300,300,1600,800]);
% histogram(y1);
% hold on;
% histogram(y2);
histogram(y);
% xline(2^-8, '-r', 'LineWidth', 2.5);
% xline(2^-7, '-y', 'LineWidth', 2.5);
% xline(2^-6, 'LineWidth', 2.5);
% xline(-2^-8, '-r', 'LineWidth', 2.5);
% xline(-2^-7, '-y', 'LineWidth', 2.5);
% xline(-2^-6, 'LineWidth', 2.5);
leg = legend('$\widehat{c_{5}} - \widetilde{c_{5}}$');
% leg = legend('$\widehat{c_{5}} - \widetilde{c_{5}}$', ...
%     '$2^{-5}$', '$2^{-4}$', '$2^{-3}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',30);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,100]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
% exportgraphics(gcf, 'c8no_vs_c8trf_3.pdf', 'ContentType', 'vector');

% [v1, e1] = histcounts(y1,'BinWidth',10^-3);
% [v2, e2] = histcounts(y2,'BinWidth',10^-3);
% 
% v1 = [v1, zeros(1, size(e2,2) - size(e1,2))];
% 
% figure;
% set(gcf,'position',[300,300,1200,800]);
% bar(e2(1:end-1),[v1; v2]');
% xline(2^-8, '-r');
% xline(2^-7);
% leg1 = legend('$|c_{8}-\widehat{c_{8}}|$', ...
%      '$|c_{8}-\widetilde{c_{8}}|$', '$2^{-8}$', '$2^{-7}$');
% set(leg1,'Interpreter','latex');
% set(leg1,'FontSize',30);
% set(leg1, 'Location','northwest');
% ylim([0,n]);
% xlabel('error')
% ylabel('count')
% ax = gca; 
% ax.FontSize = 30; 
% box on;
% exportgraphics(gcf, 'transfer_mul_err_count.pdf', 'ContentType', 'vector');