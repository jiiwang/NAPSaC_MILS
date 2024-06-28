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

for i = 1:n
    i
    a = round4(rand(1));
    b = round4(rand(1));

    c_8 = fi_mul(a,b,T);
    y(i) = c_8;

    for j = 1:ntrial

        c_8_no = noisy_mul(a, b, nbit, nbit, 1);
        
        err1 = c_8.double-c_8_no.double;
                
        y1(i, j) = err1;
    end
    
end

y1 = mean(y1,2);

figure;
set(gcf,'position',[300,300,1600,800]);
histogram(y1);
xline(2^-8, '-r', 'LineWidth', 1.5);
xline(2^-7, 'LineWidth', 1.5);
leg1 = legend('$c_{8}-\widehat{c_{8}}$','$2^{-8}$', '$2^{-7}$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',30);
set(leg1, 'Location','northwest');
% 'Orientation','horizontal');
ylim([0,n/5]);
xlabel('error')
ylabel('count')
ax = gca; 
ax.FontSize = 30; 
box on;