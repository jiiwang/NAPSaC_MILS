addpath("src/fi/")
addpath("src/util/")
addpath("src/bs/")

% random seed, for reproducible results
rng("twister");

n = 500;
x = zeros(n,2);
y = zeros(n,1);

nbit = 8;
T1 = numerictype(1,2*nbit+1, 2*nbit);
T2 = numerictype(1,nbit+1,nbit);

for i = 1:n
    i
    a = rand(1);
    b = rand(1);
    
    afi = quan(a,T1);
    bfi = quan(b,T1);
    x(i,:) = [afi bfi];

    % [a1, a2] = split(a,T1,T2);
    % 
    % abs = a1 + 2^-nbit*a2;
    % err = abs - trun(a,T1);

    c_2n = fi_mul(afi,bfi,T1);

    c_bs_2n = bs_orig_mul(a, b, nbit);

    err = c_2n.double-c_bs_2n.double;
        
    y(i) = err;    
end

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y, 15);
% xline(2^-16, '-r', 'LineWidth', 1.5);
xline(2^-12, 'LineWidth', 1.5);
xline(2^-10, '-y','LineWidth', 1.5);
xline(2^-9, '-r', 'LineWidth', 1.5);
% xline(2^-6, '-r', 'LineWidth', 1.5);

leg = legend('$c_{16}-{c_{16}^s}$', '$2^{-12}$', '$2^{-10}$', '$2^{-9}$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',30);
set(leg, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,100]);
% xlim([-10*10^-4, 10*10^-4]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
exportgraphics(gcf, '16_vs_16bs_trun_mul_err_count.pdf', 'ContentType', 'vector');