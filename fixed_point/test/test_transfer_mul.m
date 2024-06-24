addpath('../src')

% # of trials per run
ntrial = 100;
% # of runs
n = 500;
x = zeros(n,2);
y = zeros(n,1);
y1 = zeros(n,ntrial);
y2 = zeros(n,ntrial);

nbit = 8;
T = numerictype(1,nbit+1,nbit);

round4 = @(x) round(x.*10.^4)./10.^4;
r = 0.8;

for i = 1:n
    i
    a = round4(rand(1));
    b = round4(rand(1));

    c_8 = fi_mul(a,b,T);
    y(i) = c_8;

    for j = 1:ntrial

        c_8_no = noisy_mul(a, b, nbit, nbit);
    
        c_8_tran_no = transfer_mul(a, b, nbit, nbit, r);
    
        err1 = abs(c_8.double-c_8_no.double);
        
        err2 = abs(c_8.double-c_8_tran_no.double);
        
        y1(i, j) = err1;
        y2(i, j) = err2;
    end
    
end

y1 = mean(y1,2);
y2 = mean(y2,2);

[v1, e1] = histcounts(y1,'BinWidth',10^-3);
[v2, e2] = histcounts(y2,'BinWidth',10^-3);

v1 = [v1, zeros(1, size(e2,2) - size(e1,2))];

figure;
set(gcf,'position',[300,300,1200,800]);
bar(e2(1:end-1),[v1; v2]');
xline(2^-8, '-r');
xline(2^-7);
leg1 = legend('$|c_{8}-\widehat{c_{8}}|$', ...
     '$|c_{8}-\widetilde{c_{8}}|$', '$2^{-8}$', '$2^{-7}$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',30);
set(leg1, 'Location','northwest');
ylim([0,n]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
exportgraphics(gcf, 'transfer_mul_err_count.pdf', 'ContentType', 'vector');