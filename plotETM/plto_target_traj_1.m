



steptime=0.03;
totaltime=60;
decnum=totaltime/steptime;
figure();
x=0;
y=0;
alpha=0;
odefun = @(t, y) center_steering_ode_function(t, y); % Define your ODE function here

vel=0;
omega=0;
initial_conditions = [x; y; alpha; vel; omega]; % Example initial conditions
%
% for i=1:1:5
%     x=x+1;
%     y=y+1;
%
%     drawbeacon(x,y,alpha,'g');
%     alpha=alpha+pi/20;
%     hold on;
% end
all_t = cell(decnum, 1);
all_y = zeros(5, decnum);

vel=0.3;
omega=0;

for i = 1:decnum
    y0 = initial_conditions; % Set initial condition for current iteration
    y0(4)=vel;
    y0(5)=omega;
    % Solve ODE using ode45
    [t, y] = ode45(odefun, [0,steptime], y0); % Define tspan as needed
    
    % Store results
    
    
    all_y(:,i) = y(end,:)';
    all_t{i} = t(end);
    initial_conditions(1:3)= y(end,1:3)';
    
end

% Plot the solution for current iteration
plot(all_y(1,:), all_y(2,:));
markertime=[1,500,1000,1500,2000];
hold on;
for j=1:1:size(markertime,2)
    index=markertime(j);
    drawbeacon(all_y(1,index),all_y(2,index),all_y(3,index),'g');
    hold on;
end
xlabel('X /m');
ylabel('Y /m');

% title(['ODE Solution for Initial Condition: ', num2str(y0)]);