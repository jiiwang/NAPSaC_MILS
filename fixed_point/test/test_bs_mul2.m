addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
% Essentially we need to set a random repeatable seed so that 
% we can reinitialize and run with the same random values for refining our code
rng(1,"twister");

ntrial = 200;
n = 500;
y = zeros(n,ntrial);

nbit = 2;
T1 = numerictype(1,4*nbit+1, 4*nbit);
T2 = numerictype(1,2*nbit+1, 2*nbit);
T3 = numerictype(1,nbit+1,nbit);

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    for j = 1:ntrial

        c_2n_no = noisy_mul(a, b, 4*nbit, 4*nbit-2, 1);

        c_bs_2n_no = bs_mul2(a, b, nbit, nbit, 1);
         
        err = c_2n_no.double - c_bs_2n_no.double;
        y(i,j) = err;
    end
    
end

y2 = mean(y,2);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y2);
% xline(2^-16, '-r', 'LineWidth', 2.5);
% xline(2^-12, '-y', 'LineWidth', 2.5);
% xline(2^-11, '-g', 'LineWidth', 2.5);
% xline(-2^-16, '-r', 'LineWidth', 2.5);
% xline(-2^-12, '-y', 'LineWidth', 2.5);
% xline(-2^-11, '-g', 'LineWidth', 2.5);
% leg = legend('$\widehat{c_{16}}-\widehat{c_{16}^s}$', ...
%      '$2^{-16}$', '$2^{-12}$','$2^{-11}$', ...
%      '$-2^{-16}$', '$-2^{-12}$','$-2^{-11}$');
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-y', 'LineWidth', 2.5);
xline(2^-6, '-g', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-7, '-y', 'LineWidth', 2.5);
xline(-2^-6, '-g', 'LineWidth', 2.5);
leg = legend('$c_{8}-\widehat{c_{8}^s}$', ...
    '$2^{-8}$', '$2^{-7}$', '$2^{-6}$',...
    '$-2^{-8}$', '$-2^{-7}$', '$-2^{-6}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',40);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,150]);
% xlim([-10*10^-4, 10*10^-4]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
exportgraphics(gcf, '8no_vs_8bs_mul_2+2+2+2_optical_noise_err_count.pdf', 'ContentType', 'vector');
% exportgraphics(gcf, '16no_vs_16bs_mul_err_count.pdf', 'ContentType', 'vector');