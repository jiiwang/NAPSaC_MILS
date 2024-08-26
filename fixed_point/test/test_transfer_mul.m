addpath('src/trf/');
addpath('src/util');
addpath('src/nbit_fi/');

% random seed, for reproducible results
% Essentially we need to set a random repeatable seed so that 
% we can reinitialize and run with the same random values for refining our code
rng(1,"twister");

% # of trials per run
ntrial = 100;
% # of runs
n = 500;
x = zeros(n,2);
% y = zeros(n,1);
% y1 = zeros(n,ntrial);
% y2 = zeros(n,ntrial);
y = zeros(n,ntrial);

nbit = 8;
T = numerictype(1,nbit+1,nbit);

% Example 1
r1 = .9;
alpha = .98;
r2 = r1*alpha;
beta = .9;
gamma = .03;

% Example 2
% r1 = .9;
% alpha = .98;
% r2 = r1/alpha;
% beta = .95;
% gamma = 0;

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    for j = 1:ntrial

        c_8_no = noisy_mul(a, b, nbit, nbit-2, 1);
    
        c_8_tran_no = transfer_mul(a, b, nbit, nbit-2, r1, r2, alpha, beta, gamma, 1);
    
        err = c_8_no.double - c_8_tran_no.double;
        y(i,j) = err;
    end
    
end

y = mean(y,2);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-y', 'LineWidth', 2.5);
xline(2^-6, 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-y', 'LineWidth', 2.5);
xline(-2^-6, 'LineWidth', 2.5);
leg = legend('$\widehat{c_{8}} - \widetilde{c_{8}}$', ...
    '$2^{-8}$', '$2^{-7}$', '$2^{-6}$', '$-2^{-8}$', '$-2^{-7}$', '$-2^{-6}$');
% xline(2^-5, '-r', 'LineWidth', 2.5);
% xline(2^-4, '-y', 'LineWidth', 2.5);
% xline(2^-3, 'LineWidth', 2.5);
% xline(-2^-5, '-r', 'LineWidth', 2.5);
% xline(-2^-4, '-y', 'LineWidth', 2.5);
% xline(-2^-3, 'LineWidth', 2.5);
% leg = legend('$\widehat{c_{5}} - \widetilde{c_{5}}$', ...
%     '$2^{-5}$', '$2^{-4}$', '$2^{-3}$', '$-2^{-5}$', '$-2^{-4}$', '$-2^{-3}$');
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
exportgraphics(gcf, 'c8no_vs_c8trf_1.pdf', 'ContentType', 'vector');