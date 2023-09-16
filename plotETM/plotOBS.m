function plotOBS(OBS)

x=OBS(:,1);
y=OBS(:,2);
plot([x; x(1)], [y ;y(1)], 'k');
fill(x, y, 'b');
grid on;
axis equal;
hold on;

end