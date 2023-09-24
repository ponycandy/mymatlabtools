
%% ginputzp
% ginput function with online zoom and pan capability.
% 
% Same as ginput, but you can now zoom in and pan to different part of the data, while ginput is running.
% To zoom in, press "z" button on keyboard and then use left mouse or mouse wheel to zoom in and also zoom out, and to reset zoom use double left click.
% To pan, while ginputzp is running, press x on the keyboard and use left click and drag to pan and do the selection with middle or right mouse button.


%% 获取点坐标.注意必须预设最大值,注意用鼠标右键选择值
figure();
axis([2000 6000 320  600])
grid on
zoom on % enable zoom mode
[X,Y,Z] = ginputzp();
f = fit(X,Y,'smoothingspline');
plot(f);

%% 更改坐标和标题名称

xlabel('转速r/min')
ylabel('排气管出口温度 /C')

