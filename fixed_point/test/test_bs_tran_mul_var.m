addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
% Essentially we need to set a random repeatable seed so that 
% we can reinitialize and run with the same random values for refining our code
rng(1,"twister");

ntrial = 200;
n = 500;
y1 = zeros(n,ntrial);
y2 = zeros(n,ntrial);

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
        c = noisy_mul(a, b, 2*nbit, 2*nbit-2, 1);

        c_8_tran1 = bs_transfer_mul(a,b,nbit,4,4,6,6,6,1,r1,r2,alpha,beta,gamma);
        y1(i,j) = c.double - c_8_tran1.double;

        c_8_tran2 = bs_transfer_mul(a,b,nbit,3,5,6,6,6,1,r1,r2,alpha,beta,gamma);
        y2(i,j) = c.double - c_8_tran2.double;
    end
    
end

y1 = mean(y1,2);
y2 = mean(y2,2);

figure;
set(gcf,'position',[300,300,2000,800]);

subplot(1,2,1);
histogram(y1);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-6, '-y', 'LineWidth', 2.5);
xline(2^-5, '-g', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-6, '-y', 'LineWidth', 2.5);
xline(-2^-5, '-g', 'LineWidth', 2.5);
% yline(10, 'LineWidth',2.5);
title("n = 8 = 4 + 4, nDAC = no = nADC = 6");
leg = legend('$\widehat{c_{8}} - \widetilde{c_{8}^s}$', ...
    '$2^{-8}$', '$2^{-6}$', '$2^{-5}$',...
    '$-2^{-8}$', '$-2^{-6}$', '$-2^{-5}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',20);
set(leg, 'Location','northwest');
ylim([0,200]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;

subplot(1,2,2);
histogram(y2);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-6, '-y', 'LineWidth', 2.5);
xline(2^-5, '-g', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-6, '-y', 'LineWidth', 2.5);
xline(-2^-5, '-g', 'LineWidth', 2.5);
% yline(10, 'LineWidth',2.5);
title("n = 8 = 3 + 5, nDAC = no = nADC = 6");
ylim([0,200]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
% exportgraphics(gcf, '8=4+4_vs_8=5+3_nDAC=no=nADC=6_transfer.pdf','ContentType', 'vector');