
agentnum=4;%绘制4个追踪者的所有状态
decnum=200;
time=0:0.03:decnum*0.03-0.03;
colourmap={'red','green','blue','yellow'};
xlabelname={'时间 /s','时间 /s','时间 /s','时间 /s'};
ylabelname={'x /m','y /m','vx m/s','vy m/s'};
titlename={'x全局坐标','y全局坐标','vx速度曲线','vy速度曲线'};
legendname={'agent1','agent2','agent3','agent4'};
datacell=cell(4);
TimeTrigger=cell(4);
for j = 1:agentnum
    filename=string('D:\QT\prjdir\OSGIMODULE\my_simulation_dir\build\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
    M_j=xlsread(filename);%读取所有状态量
    datacell{1,j}=M_j;
    
    
end

%灰色状态预测的平均值
agent1grey=datacell{1,2};
agent1grey=agent1grey(:,5:9);

for j = 1:4%状态数目
    figure();
    M_j= datacell{1,1};
    nameCell=cell(1);
    counter=1;
    
    agent=1;
    singlestate=agent1grey(1:decnum,j);
    plot(time,singlestate,'LineStyle','-.', 'MarkerFaceColor',colourmap{agent});
    
    nameCell{1,counter}=legendname{agent}+string('Grey');
    legend(nameCell);
    counter=counter+1;
    
    singlestate=M_j(1:decnum,4+4*agentnum+j);
    hold on ;
    plot(time,singlestate,'LineStyle','-', 'MarkerFaceColor',colourmap{agent});
    
    nameCell{1,counter}=legendname{agent};
    legend(nameCell);
    counter=counter+1;
    hold on
    
    for agent = 2:(agentnum)%绘制除自己以外的agennt的这个状态
        singlestate=M_j(1:decnum,4*agent+j);
        plot(time,singlestate,'LineStyle','-.', 'MarkerFaceColor',colourmap{agent});
        
        nameCell{1,counter}=legendname{agent}+string('Grey');
        legend(nameCell);
        counter=counter+1;
        
        M_S_j=datacell{1,agent};
        singlestate=M_S_j(1:decnum,4+4*agentnum+j);
        hold on ;
        plot(time,singlestate,'LineStyle','-', 'MarkerFaceColor',colourmap{agent});
        
        nameCell{1,counter}=legendname{agent};
        legend(nameCell);
        counter=counter+1;
        hold on
        
    end
    xlabel(xlabelname{j});
    ylabel(ylabelname{j});
    title(titlename{j});
    
end
