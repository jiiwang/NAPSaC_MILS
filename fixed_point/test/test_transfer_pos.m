addpath('src/util/')

figure;
set(gcf,'position',[100,100,700,500]);

phi = linspace(0,1,500);
r1 = .9;
alpha = .98;
r2 = r1/alpha;
y = transfer(phi, r1, r2, alpha);

plot(phi, y, LineWidth=2);
hold on;

nbit = 3;
T = numerictype(1,nbit+1,nbit);
a = 6.5e-01;
aphi = recover(a,r1,r2,alpha);
aphifi = quan(aphi, T);
a_new = transfer(aphifi.double, r1, r2, alpha);

point1 = [0, a];
text(point1(1), point1(2), sprintf('  %.3f  ',point1(2)), 'FontSize', 12, 'Horiz','right', 'Vert','bottom');


point2 = [aphi, 0];

text(point2(1), point2(2), sprintf('  %.3f',point2(1)), 'FontSize', 12, 'Horiz','left', 'Vert','bottom');

point3 = [aphifi.double, 0];
text(point3(1), point3(2), sprintf('%.3f  ',point3(1)), 'FontSize', 12, 'Horiz','right', 'Vert','bottom');

point4 = [0, a_new];
text(point4(1), point4(2), sprintf('  %.3f  ',point4(2)), 'FontSize', 12, 'Horiz','right', 'Vert','top');

plot(point1(1), point1(2), 'or', 'MarkerFaceColor','r');
hold on;
plot(point2(1), point2(2), 'or', 'MarkerFaceColor','r');
hold on;
plot(point3(1), point3(2), 'or', 'MarkerFaceColor','r');
hold on;
plot(point4(1), point4(2), 'or', 'MarkerFaceColor','r');

plot([0; aphi], [a; a], 'r');
plot([aphi; aphi], [0; a], 'r');
plot([aphifi.double; aphifi.double], [0; a_new], 'g--');
plot([0; aphifi.double], [a_new; a_new], 'g--');

leg1 = legend('$f(\phi; r_1, r_2, \alpha) (r_1 = 0.9, \alpha = 0.98, r_2 = r_1/\alpha)$');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',15);
set(leg1, 'Location','northwest');
xlabel('$\phi$', 'Interpreter','latex', 'FontSize',25);
ylabel('$y$', 'Interpreter','latex', 'FontSize',25);
ylim([0,1]);
ax = gca; 
ax.FontSize = 20; 
box on;

exportgraphics(gcf, 'test/result/transfer_function_error.pdf', 'ContentType', 'vector');