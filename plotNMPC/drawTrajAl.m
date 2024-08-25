

xmlconfigname='C:\qtworkspace\newsim\my_simulation_dir\build\config\DistributedMPC\swarm.xml';

obs_num=XMLread(xmlconfigname,'obs_num');

%xmlconfigname_OBS='C:\matlabws\draw\mymatlabtools-master\plotNMPC\swarm.xml';
xmlconfigname_OBS='C:\matlabws\draw\targetdir\mymatlabtools\plotNMPC\swarm.xml';


figure();
hold on;
%首先绘制障碍物
for i=1:1:obs_num
    OBS=XMLread(xmlconfigname_OBS,string("OBS_")+string(i)+string("_vertexparams"));
    plotOBS(OBS);
    hold on;
end
% 
agentnum=XMLread(xmlconfigname,'agent_num')-1;

colourmap={'red','green','cyan','magenta'};
linemap={'-.',':','--','-'};

xlabelname={'时间 s','时间 s','时间 s','时间 s'};
ylabelname={'x m','y m','vx m/s','vy m/s'};
titlename={'x全局坐标','y全局坐标','v速度曲线','omega速度曲线'};
legendname={'无人车1','无人车2','无人车3','无人车4'};
datacell=cell(4);
TimeTrigger=cell(4);
for j = 1:agentnum
    filename=string('C:\qtworkspace\newsim\my_simulation_dir\build\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
    M_j=xlsread(filename);%读取所有状态量
    datacell{1,j}=M_j;
    
    
end
% 
% 
for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,agentnum*4+4+1);
    y=M_j(:,agentnum*4+4+2);
    vx=M_j(:,agentnum*4+4+3);
    vy=M_j(:,agentnum*4+4+4);
    cor_j=[x,y,vx,vy];
    coord{j}=cor_j;
    plot(x,y,'color', colourmap{j},'LineStyle',linemap{j},'LineWidth', 1.5);
    hold on;
    
    
end
% 
filename=string('C:\qtworkspace\newsim\my_simulation_dir\build\log\ETM_Target.xls');%这里会包含所有的数据类型
M_j=xlsread(filename);%读取所有状态量
x=M_j(:,agentnum*4+4+1);
y=M_j(:,agentnum*4+4+2);

    vx=M_j(:,agentnum*4+4+3);
    vy=M_j(:,agentnum*4+4+4);
    
plot(x,y);
hold on;
x=x(end);
y=y(end);
vx=vx(end);
vy=vy(end);
drawbeacon(x ,y,atan2(vy ,vx),'r',1);
hold on;
%最后终点再添加一下
for j = 1:agentnum
    
  
    cor_j=coord{j};
    if mod(j+1,3)==0
        cor_next=coord{3};
    else
        cor_next=coord{mod(j+1,3)};
    end
    
    plot([cor_j(end,1) cor_next(end,1)],[cor_j(end,2) cor_next(end,2)],'color', 'black');
    hold on;
    plot([cor_j(end,1) x],[cor_j(end,2) y], 'color', 'black');
    hold on;
    
end
%添加一下beacon
for j = 1:agentnum
    
  
    cor_j=coord{j};
    
    drawbeacon(cor_j(end,1) ,cor_j(end,2),atan2(cor_j(end,4) ,cor_j(end,3)),'r',1);
    hold on;
    
end
% 
lineHandles = findobj('Type', 'line');
xlabel('X 坐标(m)');
ylabel('Y 坐标(m)');
legend([lineHandles(14),lineHandles(13),lineHandles(12),lineHandles(11)],{'无人车1','无人车2','无人车3','领导车'});hold on;
