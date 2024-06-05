%绘制障碍物
figure();

adjmat=[0 1 0 0 0 1;
    1 0 1 0 0 0;
    0 1 0 1 0 0;
    0 0 1 0 1 0;
    0 0 0 1 0 1;
    1 0 0 0 1 0];    
%读取所有agent的轨迹：
agentnum=6;%绘制全部代理
time=0:0.03:12;
decnum=12/0.03+1;
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

%绘制agent轨迹
coord=cell(agentnum);
for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,agentnum*4+1);
    y=M_j(:,agentnum*4+2);
    cor_j=[x,y];
    coord{j}=cor_j;
    plot(x,y,'color', colourmap{j},'LineWidth',1.01);
    hold on;
    for i=1:1:size(markermoment,2)
            plot(x(markermoment(i)),y(markermoment(i)),'b--o','color', colourmap{j});
            

            
    end
    
    
end

markermoment=[2400];
%最后终点再添加一下
    for i=1:1:size(markermoment,2)            
            for j_0 = 1:agentnum
                for i_0=1:1:agentnum
                if adjmat(j_0,i_0)==1
                    cor_j=coord{j_0};
                    cor_next=coord{i_0};
                    plot([cor_j(markermoment(i),1) cor_next(markermoment(i),1)],[cor_j(markermoment(i),2) cor_next(markermoment(i),2)],':','color', [0.1,0,0.6]);
                    hold on;
                end
            %     plot([cor_j(end,1) x],[cor_j(end,2) y], 'color', 'black');
            %     hold on;
                end
            end

            
    end


% 找到所有线条对象
lines = findobj(gca, 'Type', 'line');
linetodraw=[];
% 设置红色线条的DisplayName属性
for i = 1:length(lines)
    for j=1:1:agentnum
    if isequal(lines(i).Color, colourmap{j}) && isequal(lines(i).LineWidth, 1.01)  % 判断是否为红色线条
%         lines(j).DisplayName = legendname{j};
        linetodraw(j)=lines(i);
    end
    end
end


% 显示只包含红色线条的图例
legend(linetodraw,legendname);
xlabel('X /m');
ylabel('Y /m');
