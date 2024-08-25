drawallobs_fir3;
hold on;

adjmat=[0 1 1;
    1 0 1 ;
    1 1 0;];
%读取所有agent的轨迹：
agentnum=3;%绘制全部代理
time=0:0.03:12;
decnum=12/0.03+1;
colourmap={[1 0 0],[0 1 0],[0.5 0 0],[0.5 0 0.5],[0,0.55,0.93],[0 0 1]};

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

markermoment=[];
moment=1;
index=1;
%最后添加虚拟代理
for i_0=1:1:agentnum
    M_j=datacell{1,i_0};%读取所有状态量
    while moment<size(M_j,1)
        if(isnan(M_j(moment,5)))
            moment=moment+1;
        else
            markermoment(index)=moment;
            moment=moment+200;
            index=index+1;
            break
        end
        
    end
    moment=1;
end
markermoment(index)=size(M_j,1);
markermoment=sort(markermoment);
markermoment=[1,500,1000,1500];
%绘制agent轨迹
coord=cell(agentnum);
for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,(agentnum)*4+1);
    y=M_j(:,(agentnum)*4+2);
    vx=M_j(:,(agentnum)*4+3);
    vy=M_j(:,(agentnum)*4+4);
    
    cor_j=[x,y,vx,vy];
    coord{j}=cor_j;
    plot(x,y,'color', colourmap{j},'LineWidth',1.01);
    hold on;
    for i=1:1:size(markermoment,2)
        %   plot(x(markermoment(i)),y(markermoment(i)),'b--o','color', colourmap{j});
        drawbeacon(x(markermoment(i)),y(markermoment(i)),atan2(vy(markermoment(i)),vx(markermoment(i))),colourmap{j},0.8)
        hold on;
        drawbeacon(M_j(markermoment(i),5),M_j(markermoment(i),6),atan2(M_j(markermoment(i),8),M_j(markermoment(i),7)),[0.8,0.7,0],0.8);

        
    end
    
    
end

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
axis equal
