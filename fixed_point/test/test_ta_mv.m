addpath("src/nbit_fi/")
addpath("src/util/")
addpath("src/bs/")
addpath("src/ta/")

% random seed, for reproducible results
rng("twister");

nbit = 8;
T = numerictype(1,nbit+1,nbit);

n = 100;
for dim = 5:5:n
    dim
    k = .9;
    nterm = 2;
    A = hilbert(dim,T);

    ntrial = 50;
    y = zeros(ntrial,1);

    for i = 1:ntrial
        % i
        x = 0.5*rand(dim,1);
        
        xfi = trun(x,T);
    
        c_fi = fi_mul(A,xfi,T);
    
        c_ta = ta_mv(A,xfi,T,k,nterm);
    
        err = norm(c_fi.double-c_ta.double, Inf);
            
        y(i) = err;    
    end

    err = mean(y)
end

% figure;
% set(gcf,'position',[300,300,1600,800]);
% histogram(y, 15);
% % xline(2^-16, '-r', 'LineWidth', 1.5);
% xline(2^-8, 'LineWidth', 2.5);
% xline(2^-7, '-r', 'LineWidth', 2.5);
% 
% leg = legend('$c_{8}-{c_{8}^a}$', '$2^{-8}$', '$2^{-7}$');
% set(leg,'Interpreter','latex');
% set(leg,'FontSize',50);
% set(leg, 'Location','northwest');
% % 'Orientation','horizontal');
% ylim([0,600]);
% % xlim([-10*10^-4, 10*10^-4]);
% xlabel('error')
% ylabel('count')
% ax = gca; 
% ax.FontSize = 30; 
% box on;
% exportgraphics(gcf, '8_vs_8ta_mul_err_count.pdf', 'ContentType', 'vector');