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
    
    T = numerictype(1,9,8);
    c = fi_mul(a, b, T);

    for j = 1:ntrial


        c_bs_2n_ADC6 = bs_mul(a, b, 8, 4, 4, 6, 6, 6, 0);
        y1(i,j) = c.double - c_bs_2n_ADC6.double;

        c_bs_n1_n2_ADC8 = bs_mul(a, b, 8, 3, 5, 6, 6, 6, 0);
        y2(i,j) = c.double - c_bs_n1_n2_ADC8.double;
    end
    
end

y1 = mean(y1,2);
y2 = mean(y2,2);

figure;
set(gcf,'position',[300,300,2000,800]);

subplot(1,2,1);
histogram(y1);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-y', 'LineWidth', 2.5);
xline(2^-6, '-g', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-y', 'LineWidth', 2.5);
xline(-2^-6, '-g', 'LineWidth', 2.5);
% yline(10, 'LineWidth',2.5);
title("n = 8 = 4 + 4, nADC = 6");
leg = legend('$c_{8}-c_{8}^s$', ...
    '$2^{-8}$', '$2^{-7}$', '$2^{-6}$',...
    '$-2^{-8}$', '$-2^{-7}$', '$-2^{-6}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',20);
set(leg, 'Location','north');
ylim([0,500]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;

subplot(1,2,2);
histogram(y2);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-y', 'LineWidth', 2.5);
xline(2^-6, '-g', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-y', 'LineWidth', 2.5);
xline(-2^-6, '-g', 'LineWidth', 2.5);
% yline(10, 'LineWidth',2.5);
title("n = 8 = 3 + 5, nADC = 6");
ylim([0,500]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
exportgraphics(gcf, '8=4+4_vs_8=5+3_nADC=6_no_noise.pdf','ContentType', 'vector');