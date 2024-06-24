addpath('../src')

ntrial = 100;
n = 500;
x = zeros(n,2);
y1 = zeros(n,ntrial);
y2 = zeros(n,ntrial);

nbit = 8;
T1 = numerictype(1,2*nbit+1, 2*nbit);
T2 = numerictype(1,nbit+1,nbit);


round5 = @(x) round(x.*10.^5)./10.^5;

for i = 1:n
    i
    a = round5(rand(1));
    b = round5(rand(1));

    x(i,:) = [a b];

    c_8 = fi_mul(a,b,T2);
    c_16 = fi_mul(a,b,T1);

    for j = 1:ntrial

        c_8_no = noisy_mul(a, b, nbit, nbit);

        c_bs_16_no = bs_mul(a, b, nbit, nbit);
    
        err1 = abs(c_8.double-c_8_no.double);

        err2 = abs(c_16.double-c_bs_16_no.double);
        
        y1(i, j) = err1;
        y2(i, j) = err2;
    end
    
end

y1 = mean(y1,2);
y2 = mean(y2,2);

[v1, e1] = histcounts(y1,'BinWidth',10^-4);
[v2, e2] = histcounts(y2,'BinWidth',10^-4);

v2 = [v2, zeros(1, size(e1,2) - size(e2,2))];

figure;
set(gcf,'position',[300,300,1600,800]);
bar(e1(1:end-1),[v1; v2]');
xline(2^-12);
xline(2^-10, '-g');
xline(2^-8, '-r');
leg1 = legend('$|c_{8}-\widehat{c_{8}}|$', ...
    '$|c_{16}-\widehat{c_{16}}|$', '$2^{-12}$', '$2^{-10}$', '$2^{-8}$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',30);
set(leg1, 'Location','north','Orientation','horizontal');
ylim([0,n/5]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;
exportgraphics(gcf, 'bs_mul_err_count.pdf', 'ContentType', 'vector');