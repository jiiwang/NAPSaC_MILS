addpath("src/fi/")
addpath("src/util/")

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
T = numerictype(1,nbit+1,nbit);

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    c_fi = fi_op(a,b,T,'*');

    for j = 1:ntrial

        c_fi_no = noisy_op(a, b, '*', nbit, nbit, nbit, nbit-1, 1);
        
        err = c_fi.double-c_fi_no.double;
                
        y(i, j) = err;
    end
    
end

y = mean(y,2);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y, 15);
xline(2^-8, '-r', 'LineWidth', 2.5);
xline(-2^-8, '-r', 'LineWidth', 2.5);
xline(2^-7, '-g', 'LineWidth', 2.5);
xline(-2^-7, '-g', 'LineWidth', 2.5);
leg = legend('$c_{8}-\widehat{c_{8}}$', ...
    '$2^{-8}$', '$-2^{-8}$',...
    '$2^{-7}$', '$-2^{-7}$');

set(leg,'Interpreter','latex');
set(leg,'FontSize',30);
set(leg, 'Location','northeast');
% 'Orientation','horizontal');
ylim([0,150]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;

% exportgraphics(gcf, '16_vs_16no_mul_err_count.pdf', 'ContentType', 'vector');