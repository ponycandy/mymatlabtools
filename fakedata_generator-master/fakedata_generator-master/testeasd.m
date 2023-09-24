
%% ginputzp
% ginput function with online zoom and pan capability.
% 
% Same as ginput, but you can now zoom in and pan to different part of the data, while ginput is running.
% To zoom in, press "z" button on keyboard and then use left mouse or mouse wheel to zoom in and also zoom out, and to reset zoom use double left click.
% To pan, while ginputzp is running, press x on the keyboard and use left click and drag to pan and do the selection with middle or right mouse button.


%% 获取点坐标.注意必须预设最大值,注意用鼠标右键选择值
figure();
axis([0 3.4 -0.8  5])
grid on
zoom on % enable zoom mode
[X,Y,Z] = ginputzp();

f = fit(X,Y,'smoothingspline');
h1 = plot(f); % save the handle of the fitted line
hold on
% h2 = plot(X,Y,'o'); % save the handle of the data points
legend([h1],{'生成轨迹'}); % show only the handles you want in the legend

%% 更改坐标和标题名称

xlabel('位置 /m')
ylabel('时间 /s')

% title("生成轨迹")