
figure()
x = linspace(0.01, 3, 100);

y = energyfunc(x);

plot(x, y);
xlabel('X-axis');
ylabel('Y-axis');
hold on;


syms z;
h=0.5;
 y=0.5*(1+cos(pi*(z-h)/(1-h)));
 
 
 df = diff(y, z);
 
 x_values =x;  % Specify the array of x values

df_values = subs(df, z, x_values);  % Calculate the values of df at x_values
 
 plot(x_values, df_values);
xlabel('X-axis');
ylabel('Y-axis');
hold on;

Ddf=diff(df, z);
df_values = subs(Ddf, z, x_values);  % Calculate the values of df at x_values
 
 plot(x_values, df_values);
xlabel('X-axis');
ylabel('Y-axis');
hold on;