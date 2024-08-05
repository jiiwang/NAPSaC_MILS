addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")
addpath('src/bs_trf/')

% random seed, for reproducible results
rng("twister");

% # of trials per run
ntrial = 100;
% # of runs
n = 500;
% x = zeros(n,2);
% y = zeros(n,1);
y = zeros(n,ntrial);

nbit = 8;
T1 = numerictype(1,2*nbit+1, 2*nbit);
T2 = numerictype(1,nbit+1,nbit);

r1 = 0.9;
r2 = 0.85;
alpha = 0.98;
beta = 0.66;
gamma = 0.26;

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    % c_2n = fi_mul(a,b,T1);
    % y(i) = c_2n;

    for j = 1:ntrial

        c_2n_no = noisy_mul(a, b, 2*nbit, 2*nbit, 1);
    
        c_2n_bs_tran_no = bs_transfer_mul(a, b, nbit, nbit, r1, r2, alpha, beta, gamma, 1);
    
        % err1 = c_2n.double-c_2n_no.double;
        % 
        % err2 = c_2n.double-c_2n_bs_tran_no.double;
        % 
        % y1(i, j) = err1;
        % y2(i, j) = err2;
        err = c_2n_no.double - c_2n_bs_tran_no.double;
        y(i, j) = err;
    end
    
end

% y1 = mean(y1,2);
% y2 = mean(y2,2);
y = mean(y, 2);

figure;
set(gcf,'position',[300,300,1600,800]);
% histogram(y1);
% hold on;
% histogram(y2);
histogram(y);
xline(2^-8, '-r', 'LineWidth', 1.5);
xline(-2^-7, '-y', 'LineWidth', 1.5);
% leg1 = legend('$c_{16}-\widehat{c_{16}}$', ...
%      '$c_{16}-\widetilde{c_{16}^s}$', '$2^{-16}$', '$2^{-8}$');
leg1 = legend('$\widehat{c_{16}} - \widetilde{c_{16}^s}$', '$2^{-8}$', '$-2^{-7}$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',30);
set(leg1, 'Location','north');
% 'Orientation','horizontal');
ylim([0,150]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
% exportgraphics(gcf, 'transfer_mul_err_count.pdf', 'ContentType', 'vector');

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