
agentnum=3;%绘制4个追踪者的所有状态

decnum=700;
timeserires=0:0.03:decnum*0.03-0.03;
colourmap={'red','green','blue','yellow'};
xlabelname={'time /s','time /s','time /s','time /s','time /s'};
ylabelname={'x /m','y /m','vx m/s','vy m/s' ,'Omega rad/s'};
titlename={'x ','y','vx ','vy ','phi','Omega'};
legendname={'agent1','agent2','agent3','agent4'};
datacell=cell(4);
TimeTrigger=cell(4);
for j = 1:agentnum
    filename=string('C:\qtworkspace\newsim\my_simulation_dir\build\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
    M_j=xlsread(filename);%读取所有状态量
    datacell{1,j}=M_j;
    
    
end

%在一张图上绘制所有agent的同一状态

for j = 1:4%这里只包含了x y vx vy状态
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
        
        h=stem(timeserires,M_j(1:decnum,j),'LineStyle','-', 'MarkerFaceColor',colourmap{agent});
        xlim ([timeserires(1) timeserires(end)]);
        xlabel(xlabelname{j});
        ylabel(ylabelname{j});
        title(titlename{j});
        
        
        hold on
    end
    legend(legendname{1},legendname{2},legendname{3});
end
%绘制phi的变化
j=(2+agentnum)*4+1;
figure();
for agent=1:1:agentnum
    M_j= datacell{1,agent};
    %
    for si=1:1:decnum
        if(M_j(si,j)==0)
            M_j(si,j)=nan;
        end
    end
    
    h=stem(timeserires,M_j(1:decnum,j),'LineStyle','-', 'MarkerFaceColor',colourmap{agent});
    xlim ([timeserires(1) timeserires(end)]);
    xlabel('time /s');
    ylabel('phi /rad');
    title('phi');
    
    
    hold on
end
legend(legendname{1},legendname{2},legendname{3});
%绘制omega的变化
j=(2+agentnum)*4+2;
figure();
for agent=1:1:agentnum
    M_j= datacell{1,agent};
    %
    for si=1:1:decnum
        if(M_j(si,j)==0)
            M_j(si,j)=nan;
        end
    end
    
    h=stem(timeserires,M_j(1:decnum,j),'LineStyle','-', 'MarkerFaceColor',colourmap{agent});
    xlim ([timeserires(1) timeserires(end)]);
    xlabel('time /s');
    ylabel('Omega rad/s');
    title('Omega');
    
    
    hold on
end
legend(legendname{1},legendname{2},legendname{3});
