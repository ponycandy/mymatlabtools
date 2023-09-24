function drawCircle(x,y,r,color)

center = [x, y];
radius = r;

% Calculate the coordinates of the circle
theta = linspace(0, 2*pi, 100);
x = radius * cos(theta) + center(1);
y = radius * sin(theta) + center(2);

% Plot the circle
hold on;
plot(x, y,color); % Draw red lines
axis equal; % Set equal scaling for x and y axes
