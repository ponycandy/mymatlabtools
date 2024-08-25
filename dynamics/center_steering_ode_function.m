function dydt=center_steering_ode_function(t,y)
% Parameters for the harmonic oscillator
    k = 1; % Spring constant
    m = 1; % Mass
    
    % ODE: m*y''(t) + k*y(t) = 0
    dydt = zeros(5, 1);
    xpos=y(1);
    ypos=y(2);
    alpha=y(3);
    vel=y(4);
    omega=y(5);
    dydt(1) = vel*cos(alpha); % y'(t) = v(t)
    dydt(2) = vel*sin(alpha); % v'(t) = -k/m * y(t)
    dydt(3) = omega;
end