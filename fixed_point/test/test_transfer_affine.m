addpath('src/util/')

figure;
set(gcf,'position',[100,100,1500,500]);

subplot(1,2,1);
x = linspace(0,1,500);
beta = .9;
gamma = .03;
y1 = affmap(x,beta,gamma);
yyaxis right;
plot(x, y1);

hold on;
point1 = [0, affmap(0,beta,gamma)];
text(point1(1), point1(2), sprintf('(%d,%.3f)',point1), 'FontSize', 15, 'Horiz','right', 'Vert','bottom');
point2 = [1, affmap(1,beta,gamma)];
text(point2(1), point2(2), sprintf('(%d,%.3f)',point2), 'FontSize', 15, 'Horiz','left', 'Vert','bottom');
plot(point1(1), point1(2), 'or', 'MarkerFaceColor','r');
hold on;
plot(point2(1), point2(2), 'or', 'MarkerFaceColor','r');


leg1 = legend('$g(x; \beta, \gamma) (\beta = 0.9, \gamma = 0.03)$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',20);
set(leg1, 'Location','southeast');
xlabel('$x$', 'Interpreter','latex', 'FontSize',25);
ylabel('$y$', 'Interpreter','latex', 'FontSize',25);
ylim([0,1]);
ax = gca; 
ax.FontSize = 20; 
title('Affine map');
box on;

subplot(1,2,2);

phi = linspace(0,1,500);
r1 = .9;
alpha = .98;
r2 = r1*alpha;
y = transfer(phi, r1, r2, alpha);

plot(phi, y, LineWidth=2);
hold on;

point3 = [0, transfer(0,r1, r2, alpha)];
text(point3(1), point3(2), sprintf('(%d,%.3f)',point3), 'FontSize', 15, 'Horiz','right', 'Vert','bottom');
point4 = [1, transfer(1,r1, r2, alpha)];
text(point4(1), point4(2), sprintf('(%d,%.3f)',point4), 'FontSize', 15, 'Horiz','right', 'Vert','bottom');
plot(point3(1), point3(2), 'or', 'MarkerFaceColor','r');
hold on;
plot(point4(1), point4(2), 'or', 'MarkerFaceColor','r');

leg1 = legend('$f(\phi; r_1, r_2, \alpha) (r_1 = 0.9, \alpha = 0.98, r_2 = \alpha r_1)$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',20);
set(leg1, 'Location','southeast');
xlabel('$\phi$', 'Interpreter','latex', 'FontSize',25);
ylabel('$y$', 'Interpreter','latex', 'FontSize',25);
ylim([0,1]);
ax = gca; 
ax.FontSize = 20; 
title('Transfer function Tpass');
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

exportgraphics(gcf, 'affinemap_transferfun1.pdf', 'ContentType', 'vector');