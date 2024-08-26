addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
% Essentially we need to set a random repeatable seed so that 
% we can reinitialize and run with the same random values for refining our code
rng(1,"twister");

ntrial = 100;
n = 500;
y = zeros(n,ntrial);

nbit = 5;
T1 = numerictype(1,2*nbit+1, 2*nbit);
T2 = numerictype(1,nbit+1,nbit);

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    for j = 1:ntrial

        c_2n_no = noisy_mul(a, b, 2*nbit, 2*nbit-2, 1);

        c_bs_2n_no = bs_mul(a, b, nbit, nbit-2, 1);
         
        err = c_2n_no.double - c_bs_2n_no.double;
        y(i,j) = err;
    end
    
end

y = mean(y,1);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y,10);
% xline(2^-16, '-r', 'LineWidth', 2.5);
% xline(2^-12, '-y', 'LineWidth', 2.5);
% xline(2^-11, '-g', 'LineWidth', 2.5);
% xline(-2^-16, '-r', 'LineWidth', 2.5);
% xline(-2^-12, '-y', 'LineWidth', 2.5);
% xline(-2^-11, '-g', 'LineWidth', 2.5);
% leg = legend('$\widehat{c_{16}}-\widehat{c_{16}^s}$', ...
%      '$2^{-16}$', '$2^{-12}$','$2^{-11}$', ...
%      '$-2^{-16}$', '$-2^{-12}$','$-2^{-11}$');
xline(2^-10, '-r', 'LineWidth', 2.5);
xline(2^-9, '-y', 'LineWidth', 2.5);
xline(2^-8, '-g', 'LineWidth', 2.5);
xline(-2^-10, '-r', 'LineWidth', 2.5);
xline(-2^-9, '-y', 'LineWidth', 2.5);
xline(-2^-8, '-g', 'LineWidth', 2.5);
leg = legend('$c_{10}-\widehat{c_{10}^s}$', ...
    '$2^{-10}$', '$2^{-9}$', '$2^{-8}$', ...
    '$-2^{-10}$', '$-2^{-9}$', '$-2^{-8}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',40);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,50]);
% xlim([-10*10^-4, 10*10^-4]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
% exportgraphics(gcf, '16no_vs_16bs_mul_err_count.pdf', 'ContentType', 'vector');