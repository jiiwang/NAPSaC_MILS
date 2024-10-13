addpath('src/trf/');
addpath('src/util');
addpath('src/nbit_fi/');
addpath('src/bs_trf/');


% random seed, for reproducible results
% Essentially we need to set a random repeatable seed so that 
% we can reinitialize and run with the same random values for refining our code
rng(1,"twister");

% # of trials per run
ntrial = 200;
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
% r1 = .9;
% alpha = .98;
% r2 = r1*alpha;
% beta = .9;
% gamma = .03;

% Example 2
r1 = .9;
alpha = .98;
r2 = r1/alpha;
beta = .95;
gamma = 0;

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    for j = 1:ntrial

        c_8_no = noisy_mul(a, b, nbit, nbit-2, 1);
    
        c_8_tran_no = bs_transfer_mul(a,b,nbit,3,5,8,6,6,1,r1,r2,alpha,beta,gamma);
    
        err = c_8_no.double - c_8_tran_no.double;
        y(i,j) = err;
    end
    
end

y = mean(y,2);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-g', 'LineWidth', 2.5);
xline(2^-6, '-y', 'LineWidth', 2.5);
% xline(2^-5, 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-g', 'LineWidth', 2.5);
xline(-2^-6, '-y', 'LineWidth', 2.5);
% xline(-2^-5, 'LineWidth', 2.5);
leg = legend('$\widehat{c_{8}} - \widetilde{c_{8}^s}$', ...
    '$2^{-8}$', '$2^{-7}$', '$2^{-6}$',...
    '$-2^{-8}$', '$-2^{-7}$', '$-2^{-6}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',30);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
title("n = 8 = 3 + 5, nDAC = 8, no = nADC = 6");
ylim([0,150]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
% exportgraphics(gcf, 'c8no_vs_c8_bs_trf_nDAC=8_no=nADC=6.pdf', 'ContentType', 'vector');