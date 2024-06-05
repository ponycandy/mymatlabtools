clc
clear all;
figure();

adjmat=[0 1 0 0 0 1;
    1 0 1 0 0 0;
    0 1 0 1 0 0;
    0 0 1 0 1 0;
    0 0 0 1 0 1;
    1 0 0 0 1 0];
%读取所有agent的轨迹：
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

%绘制agent轨迹
coord=cell(agentnum);
for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,agentnum*4+1);
    y=M_j(:,agentnum*4+2);
    cor_j=[x,y];
    coord{j}=cor_j;
    time=0.03:0.03:(size(x,1)*0.03);
    decnum=size(x,1);
    
    
end

for j = 1:4%状态数目:xyvxvy
    figure();
    
    %     selfstates_ETM=M_j(:,1:4);
    for agent=1:1:agentnum
        M_j= datacell{1,agent};
        %
        for si=1:1:decnum
            if(M_j(si,j)==0)
                M_j(si,j)=nan;
            end
        end
        
        h=stem(time,M_j(1:decnum,j),'LineStyle','-', 'MarkerFaceColor',colourmap{agent},'DisplayName', legendname{agent}+"-triggered");
        xlabel(xlabelname{j});
        ylabel(ylabelname{j});
        title(titlename{j});
        
        hold on;
        
        plot(time,M_j(:,agentnum*4+j),'LineStyle','--','color', colourmap{agent},'DisplayName', legendname{agent}+"-realtime");
        hold on;
        
        
    end
    
    
    % 显示只包含红色线条的图例
    legend;
    
end

