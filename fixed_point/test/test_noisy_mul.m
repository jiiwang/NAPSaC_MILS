addpath("src/nbit_fi/")
addpath("src/util/")

% random seed, for reproducible results
rng("twister");

% # of trials per run
ntrial = 200;
% # of runs
n = 500;
y = zeros(n,ntrial);

nbit = 16;
T = numerictype(1,nbit+1,nbit);

for i = 1:n
    i
    a = rand(1);
    b = rand(1);

    c_fi = fi_mul(a,b,T);

    for j = 1:ntrial

        c_fi_no = noisy_mul(a, b, nbit, nbit, 1);
        
        err = c_fi.double-c_fi_no.double;
                
        y(i, j) = err;
    end
    
end

y = mean(y,2);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y, 15);
xline(2^-16, '-r', 'LineWidth', 1.5);
% xline(2^-7, 'LineWidth', 1.5);
leg = legend('$c_{16}-\widehat{c_{16}}$','$2^{-16}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',30);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,120]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;

exportgraphics(gcf, '16_vs_16no_mul_err_count.pdf', 'ContentType', 'vector');