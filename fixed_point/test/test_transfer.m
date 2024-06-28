addpath('../src/')

phi = linspace(-pi,pi,500);
r = .9;
% r = .8;
% r = .7;
y1 = transfer(phi, r);

figure;
set(gcf,'position',[100,100,800,400]);
plot(phi, y1, LineWidth=2);
leg1 = legend('$f(\phi, r) (r = 0.9)$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',25);
set(leg1, 'Location','southeast');
xlabel('$\phi$', 'Interpreter','latex', 'FontSize',25);
ylabel('$y$', 'Interpreter','latex', 'FontSize',25);
ax = gca; 
ax.FontSize = 20; 
box on;

% figure;
% set(gcf,'position',[100,100,1000,1000]);
% 
% subplot(2,1,1);
% plot(phi, y1, LineWidth=2);
% hold on;
% % x = linspace(0.1,0.25,250);
% % x = linspace(0.1, 0.45, 250);
% x = linspace(0.1, 0.3, 250);
% y = transfer(x, r);
% p = polyfit(x, y, 1);
% 
% x2 = linspace(0, 1, 250);
% y2 = polyval(p, x2);
% plot(x2, y2, LineWidth=2);
% ylim([-0.2, 1.5])
% leg1 = legend('Tpass (r = 0.7)', 'linear approximation');
% set(leg1,'Interpreter','latex');
% set(leg1,'FontSize',25);
% set(leg1, 'Location','southeast');
% xlabel('$\phi$', 'Interpreter','latex', 'FontSize',25);
% ax = gca; 
% ax.FontSize = 20; 
% 
% subplot(2,1,2);
% y3 = transfer(x2, r);
% plot(x2, abs(y3-y2), LineWidth = 2);
% xlabel('$\phi$', 'Interpreter','latex', 'FontSize',25);
% ylabel('error');
% ylim([0, 0.5]);
% ax = gca; 
% ax.FontSize = 20; 

exportgraphics(gcf, 'transfer_fun_r=0.9.pdf', 'ContentType', 'vector');