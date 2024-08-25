clc
clear all;

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
titlename={'(a)','(b)','(c)','(d)','(e)','(f)','(g)'};
legendname={'agent1','agent2','agent3','agent4','agent5','agent6'};
datacell=cell(agentnum);
TimeTrigger=cell(agentnum);
for j = 1:agentnum
    filename=string('C:\matlabws\draw\targetdir\mymatlabtools\plotETM\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
    M_j=xlsread(filename);%读取所有状态量
    datacell{1,j}=M_j;
    
    
end

%绘制agent轨迹
coord=cell(agentnum);
M_j=datacell{1,1};
decnum=size(M_j(:,agentnum*4+1),1);



start=800;
cutc=2000;

for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,agentnum*4+1);
    y=M_j(:,agentnum*4+2);
    cor_j=[x,y];
    coord{j}=cor_j;
    time=0.03*start:0.03:(cutc*0.03);    
    
end

j=1;
%figure('Position',[100,10,500,800]);
figure();
%     selfstates_ETM=M_j(:,1:4);
for agent=1:1:agentnum-1
    M_j= datacell{1,agent};
    %
    
    for si=1:1:decnum
        if(M_j(si,j)==0)
            M_j(si,j)=nan;
        else
            M_j(si,j)=0;
        end
    end
    subplot(5,1,agent);
    h=stem(time,M_j(start:(cutc),j),'LineStyle','-', 'MarkerFaceColor',colourmap{agent},'DisplayName', legendname{agent}+"-triggered");
    xlabel(xlabelname{j});
    title(titlename{agent});
    
    hold on;
    
    
    
    
    % 显示只包含红色线条的图例
    legend;
    
end

