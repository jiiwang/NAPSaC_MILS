addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")
addpath('src/bs_trf/')

% random seed, for reproducible results
% Essentially we need to set a random repeatable seed so that 
% we can reinitialize and run with the same random values for refining our code
rng(1,"twister");

% # of trials per run
ntrial = 200;
% # of runs
n = 500;
y = zeros(n,ntrial);

nbit = 8;
T1 = numerictype(1,2*nbit+1, 2*nbit);
T2 = numerictype(1,nbit+1,nbit);

r1 = .9;
alpha = .98;
r2 = r1/alpha;
beta = .95;
gamma = 0;

% r1 = .9;
% alpha = .98;
% r2 = r1*alpha;
% beta = .9;
% gamma = .03;

for i = 1:n
    i
    a = 0.9*rand(1);
    b = 0.9*rand(1);


    for j = 1:ntrial

        c_2n_no = noisy_mul(a, b, 2*nbit, 2*nbit-2, 1);
    
        c_2n_bs_tran_no = bs_transfer_mul(a, b, nbit, nbit-2, r1, r2, alpha, beta, gamma, 1);
    
        err = c_2n_no.double - c_2n_bs_tran_no.double;
        y(i, j) = err;
    end
    
end

y = mean(y, 2);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-y', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-y', 'LineWidth', 2.5);
leg1 = legend('$\widehat{c_{16}} - \widetilde{c_{16}^s}$', ...
    '$2^{-8}$', '$2^{-7}$', ...
    '$-2^{-8}$', '$-2^{-7}$');

% xline(2^-5, '-r', 'LineWidth', 2.5);
% xline(2^-4, '-y', 'LineWidth', 2.5);
% xline(-2^-5, '-r', 'LineWidth', 2.5);
% xline(-2^-4, '-y', 'LineWidth', 2.5);
% leg1 = legend('$\widehat{c_{10}} - \widetilde{c_{10}^s}$', ...
%     '$2^{-5}$', '$2^{-4}$', ...
%     '$-2^{-5}$', '$-2^{-4}$');

set(leg1,'Interpreter','latex');
set(leg1,'FontSize',30);
set(leg1, 'Location','northeast');
% 'Orientation','horizontal');
ylim([0,150]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
% exportgraphics(gcf, 'bs_transfer_mul_err_count_n=8+8.pdf', 'ContentType', 'vector');