%绘制障碍物
figure();

adjmat=[0 1 0 0 0 1;
    1 0 1 0 0 0;
    0 1 0 1 0 0;
    0 0 1 0 1 0;
    0 0 0 1 0 1;
    1 0 0 0 1 0];
Hmat={[1 1.732],[2 0],[1 -1.732],[-1 -1.732],[-2 0],[-1 1.732]};%读取所有agent的轨迹：
agentnum=6;%绘制全部代理
colourmap={[1 0 0],[0 1 0],[0.5 0 0],[0.5 0 0.5],[0,0.55,0.93],[0 0 1]};
markermoment=[1,1000,2400];
xlabelname={'时间 s','时间 s','时间 s','时间 s'};
ylabelname={'x m','y m','vx m/s','vy m/s'};
titlename={'x全局坐标','y全局坐标','vx速度曲线','vy速度曲线'};
legendname={'agent1','agent2','agent3','agent4','agent5','agent6'};
datacell=cell(agentnum);
TimeTrigger=cell(agentnum);
for j = 1:agentnum
    filename=string('C:\matlabws\draw\mymatlabtools-master\plotETM\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
    M_j=xlsread(filename);%读取所有状态量
    datacell{1,j}=M_j;
    
    
end

%求解平均error
coord=cell(agentnum);
for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,agentnum*4+1);
    y=M_j(:,agentnum*4+2);
    cor_j=[x,y];
    coord{j}=cor_j;
    
    
end
error=zeros(size(x,1),1);
time=0.03:0.03:(size(error,1)*0.03);
counter=0;
%最后终点再添加一下
for j_0 = 1:agentnum
    for i_0=1:1:agentnum
        if adjmat(j_0,i_0)==1
            cor_j=coord{j_0};
            cor_next=coord{i_0};
            
            error=error+vecnorm(((cor_j-cor_next)-(Hmat{j_0}-Hmat{i_0})), 2, 2);
            counter=counter+1;
        end
        %     plot([cor_j(end,1) x],[cor_j(end,2) y], 'color', 'black');
        %     hold on;
        
    end
    plot(time,error,'color', colourmap{j_0});
    hold on;
    error=zeros(size(x,1),1);

    
end



lines = findobj(gca, 'Type', 'line');
linetodraw=[];
% 设置红色线条的DisplayName属性
for i = 1:length(lines)
    for j=1:1:agentnum
    if isequal(lines(i).Color, colourmap{j})  % 判断是否为红色线条
%         lines(j).DisplayName = legendname{j};
        linetodraw(j)=lines(i);
    end
    end
end


% 显示只包含红色线条的图例
legend(linetodraw,legendname);


xlabel('Time /s');
ylabel('error /m');
