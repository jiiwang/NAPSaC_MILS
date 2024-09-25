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

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    for j = 1:ntrial

        c_2n_no = noisy_mul(a, b, 8, 6, 1);

        c_bs_2n_ADC6 = bs_mul(a, b, 8, 4, 4, 5, 5, 5, 1);
        y1(i,j) = c_2n_no.double - c_bs_2n_ADC6.double;

        c_bs_n1_n2_ADC8 = bs_mul(a, b, 8, 3, 5, 5, 5, 5, 1);
        y2(i,j) = c_2n_no.double - c_bs_n1_n2_ADC8.double;
    end
    
end

y1 = mean(y1,2);
y2 = mean(y2,2);

figure;
set(gcf,'position',[300,300,2000,800]);

subplot(1,2,1);
histogram(y1,10);
xline(2^-9, '-g', 'LineWidth', 2.5);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-y', 'LineWidth', 2.5);
xline(-2^-9, '-g', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-y', 'LineWidth', 2.5);
yline(10, 'LineWidth',2.5);
title("n = 8 = 4 + 4, nDAC = no = nADC = 5");
leg = legend('$\widehat{c_{8}}-\widehat{c_{8}^s}$', ...
    '$2^{-9}$', '$2^{-8}$', '$2^{-7}$',...
    '$-2^{-9}$', '$-2^{-8}$', '$-2^{-7}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',20);
set(leg, 'Location','northwest');
ylim([0,150]);
xlim([-10^-2,10^-2]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;

subplot(1,2,2);
histogram(y2,10);
xline(2^-9, '-g', 'LineWidth', 2.5);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-y', 'LineWidth', 2.5);
xline(-2^-9, '-g', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-y', 'LineWidth', 2.5);
yline(10, 'LineWidth',2.5);
title("n = 8 = 3 + 5, nDAC = no = nADC = 5");
% leg = legend('$\widehat{c_{8}}-\widehat{c_{8}^s}$', ...
%     '$2^{-9}$', '$2^{-8}$',...
%     '$-2^{-9}$', '$-2^{-8}$');
% set(leg,'Interpreter','latex');
% set(leg,'FontSize',40);
% set(leg, 'Location','northwest');
ylim([0,150]);
xlim([-10^-2,10^-2]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
exportgraphics(gcf, '8=4+4_vs_8=5+3_nADC=nDAC=no=5.pdf','ContentType', 'vector');