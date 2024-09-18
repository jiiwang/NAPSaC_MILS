addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
% Essentially we need to set a random repeatable seed so that 
% we can reinitialize and run with the same random values for refining our code
rng(1,"twister");

ntrial = 200;
n = 500;
y4 = zeros(n,ntrial);
y5 = zeros(n,ntrial);
y6 = zeros(n,ntrial);
y7 = zeros(n,ntrial);
y8 = zeros(n,ntrial);

nbit = 4;
% T1 = numerictype(1,2*nbit+1, 2*nbit);
% T2 = numerictype(1,nbit+1,nbit);

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    for j = 1:ntrial

        c_2n_no = noisy_mul(a, b, 2*nbit, 2*nbit-2, 1);

        c_bs_2n_no4 = bs_mul(a, b, nbit, nbit, nbit, nbit-2, 1);

        y4(i,j) = c_2n_no.double - c_bs_2n_no4.double;

        c_bs_2n_no5 = bs_mul(a, b, nbit, nbit, nbit+1, nbit-2, 1);

        y5(i,j) = c_2n_no.double - c_bs_2n_no5.double;

        c_bs_2n_no6 = bs_mul(a, b, nbit, nbit, nbit+2, nbit-2, 1);

        y6(i,j) = c_2n_no.double - c_bs_2n_no6.double;

        c_bs_2n_no7 = bs_mul(a, b, nbit, nbit, nbit+3, nbit-2, 1);

        y7(i,j) = c_2n_no.double - c_bs_2n_no7.double;

        c_bs_2n_no8 = bs_mul(a, b, nbit, nbit, 2*nbit, nbit-2, 1);

        y8(i,j) = c_2n_no.double - c_bs_2n_no8.double;
    end
    
end

y4 = mean(y4,2);
y5 = mean(y5,2);
y6 = mean(y6,2);
y7 = mean(y7,2);
y8 = mean(y8,2);

nADC = 8;
figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y8);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-y', 'LineWidth', 2.5);
xline(2^-6, '-g', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-y', 'LineWidth', 2.5);
xline(-2^-6, '-g', 'LineWidth', 2.5);
yline(10, 'LineWidth',2.5);
title("n = 8 = 4 + 4, nDAC = 4, no = 2, nADC = " + nADC);
leg = legend('$c_{8}-\widehat{c_{8}^s}$', ...
    '$2^{-8}$', '$2^{-7}$', '$2^{-6}$', ...
    '$-2^{-8}$', '$-2^{-7}$', '$-2^{-6}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',40);
set(leg, 'Location','northwest');
ylim([0,150]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
filename = sprintf('8no_vs_8bs_4+4_nDAC=4_no=2_nADC=%d_mul_err_count.pdf', nADC);
exportgraphics(gcf, filename,'ContentType', 'vector');