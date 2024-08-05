addpath('src/util/')

figure;
set(gcf,'position',[100,100,1200,600]);

phi = linspace(-pi,pi,1000);
r1 = .9;
r2 = .8;
alpha = .98;
y = transfer(phi, r1, r2, alpha);

plot(phi, y, LineWidth=2);
hold on;

point3 = [0, transfer(0,r1, r2, alpha)];
text(point3(1), point3(2), sprintf('(%d,%.3f)',point3), 'FontSize', 20, 'Horiz','right', 'Vert','bottom');
point4 = [1, transfer(1,r1, r2, alpha)];
text(point4(1), point4(2), sprintf('(%d,%.3f)',point4), 'FontSize', 20, 'Horiz','right', 'Vert','bottom');
plot(point3(1), point3(2), 'or', 'MarkerFaceColor','r');
hold on;
plot(point4(1), point4(2), 'or', 'MarkerFaceColor','r');

leg = legend('$f(\phi, r_1, r_2, \alpha) (r_1 = 0.9, r_2 = 0.8, \alpha = 0.98)$');
set(leg,'Interpreter','latex');
set(leg,'FontSize',20);
set(leg, 'Location','southeast');
xlabel('$\phi$', 'Interpreter','latex', 'FontSize',25);
ylabel('$y$', 'Interpreter','latex', 'FontSize',25);
ylim([0,1]);
ax = gca; 
ax.FontSize = 20; 
% title('Transfer function');
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

exportgraphics(gcf, 'transferfun_4.pdf', 'ContentType', 'vector');