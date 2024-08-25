%绘制障碍物
figure();

relationmatrix=[	0 3 5 4 2.5 0;
    3 0 4 5 2.5 0;
    5 4 0 3 2.5 0;
    4 5 3 0 2.5 0;
    2.5 2.5 2.5 2.5 0 0;
    0 0 0 0 0 0];

agentnum=6;%绘制全部代理
colourmap={[1 0 0],[0 1 0],[0.5 0 0],[0.5 0 0.5],[0,0.55,0.93],[0 0 1]};
markermoment=[1,1000,2400];
xlabelname={'时间 s','时间 s','时间 s','时间 s'};
ylabelname={'x m','y m','vx m/s','vy m/s'};
titlename={'x全局坐标','y全局坐标','vx速度曲线','vy速度曲线'};
legendname={'agent1','agent2','agent3','agent4','agent5','Target'};
datacell=cell(agentnum);
TimeTrigger=cell(agentnum);
for j = 1:agentnum
    filename=string('C:\matlabws\draw\targetdir\mymatlabtools\plotETM\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
    M_j=xlsread(filename);%读取所有状态量
    datacell{1,j}=M_j;
    
    
end

%求解平均error
coord=cell(agentnum,1);
for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,agentnum*4+1);
    y=M_j(:,agentnum*4+2);
    vx=M_j(:,agentnum*4+3);
    vy=M_j(:,agentnum*4+4);
    
    cor_j=[x,y,vx,vy];
    coord{j}=cor_j;
    
    
end
error=zeros(size(x,1),1);
counter=0;
%最后终点再添加一下
time=0.03:0.03:(size(error,1)*0.03);

target_pos=coord{agentnum};
leader_pos=coord{agentnum-1};
Tx=target_pos(:,1);
Ty=target_pos(:,2);
Lx=leader_pos(:,1);
Ly=leader_pos(:,2);

error=vecnorm([Lx-Tx,Ly-Ty],2,2);
plot(time,error);
xlabel("time /s");
ylabel("tracking error /m");
legend("tracking error");
