function Fillcircle(x,y,r)


% 定义圆半径和中心坐标
radius = r;
center = [x, y];

% 计算圆的左下角和右上角坐标
x_left = center(1) - radius;
y_bottom = center(2) - radius;
width = 2 * radius;
height = 2 * radius;

% 绘制填充的圆形
rectangle('Position', [x_left, y_bottom, width, height], 'Curvature', [1, 1], 'FaceColor', 'blue');