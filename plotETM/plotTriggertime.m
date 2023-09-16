
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

%在一张图上绘制所有agent的同一状态


for j = 1:4%状态数目
    figure();
    
    
    %     selfstates_ETM=M_j(:,1:4);
    for agent=1:1:4
        M_j= datacell{1,agent};
%         
        for si=1:1:decnum
            if(M_j(si,j)==0)
                M_j(si,j)=nan;
            end
        end
        
        h=stem(time,M_j(1:decnum,j),'LineStyle','-', 'MarkerFaceColor',colourmap{agent});
        xlabel(xlabelname{j});
        ylabel(ylabelname{j});
        title(titlename{j});
       
        
        hold on
    end
     legend(legendname{1},legendname{2},legendname{3},legendname{4});
end
