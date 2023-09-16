%绘制障碍物
size=0;
figure();
OBS1=[9.5 0;
    9 -1;
    8 -1.5;
    7 -1;
    6.5 0;
    7 1;
    8 1.5;
    9 1];
OBS2=[8 9;
    8 13;
    6 12];
plotOBS(OBS1);
plotOBS(OBS2);


%读取所有agent的轨迹：
agentnum=4;%绘制4个追踪者的所有状态
time=0:0.03:12;
decnum=12/0.03+1;
colourmap={'red','green','cyan','magenta'};
xlabelname={'时间 s','时间 s','时间 s','时间 s'};
ylabelname={'x m','y m','vx m/s','vy m/s'};
titlename={'x全局坐标','y全局坐标','vx速度曲线','vy速度曲线'};
legendname={'agent1','agent2','agent3','agent4'};
datacell=cell(4);
TimeTrigger=cell(4);
for j = 1:agentnum
    filename=string('D:\QT\prjdir\OSGIMODULE\my_simulation_dir\build\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
    M_j=xlsread(filename);%读取所有状态量
    datacell{1,j}=M_j;
    
    
end

%绘制agent轨迹
coord=cell(4);
for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,agentnum*4+4+1);
    y=M_j(:,agentnum*4+4+2);
    cor_j=[x,y];
    coord{j}=cor_j;
    plot(x,y,'color', colourmap{j});
    hold on;
    
    
end

filename=string('D:\QT\prjdir\OSGIMODULE\my_simulation_dir\build\log\ETM_Target.xls');%这里会包含所有的数据类型
M_j=xlsread(filename);%读取所有状态量
x=M_j(:,agentnum*4+4+1);
y=M_j(:,agentnum*4+4+2);
plot(x,y);
hold on;
x=x(end);
y=y(end);
%最后终点再添加一下
for j = 1:agentnum
    
  
    cor_j=coord{j};
    if mod(j+1,4)==0
        cor_next=coord{4};
    else
        cor_next=coord{mod(j+1,4)};
    end
    
    plot([cor_j(end,1) cor_next(end,1)],[cor_j(end,2) cor_next(end,2)],'color', 'black');
    hold on;
    plot([cor_j(end,1) x],[cor_j(end,2) y], 'color', 'black');
    hold on;
    
end
lineHandles = findobj('Type', 'line');
xlabel('X /m');
ylabel('Y /m');
legend([lineHandles(13),lineHandles(12),lineHandles(11),lineHandles(10),lineHandles(9)],{'agent1','agent2','agent3','agent4','Target'});hold on;
