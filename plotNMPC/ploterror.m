agentnum=3;%绘制4个追踪者的所有状态
decnum=1000;
time=0:0.03:decnum*0.03-0.03;
linemap={'-.',':','--','-'};
colourmap={'red','green','blue','yellow'};
xlabelname={'时间 s','时间 s','时间 s','时间 s'};
ylabelname={'x m','y m','vx m/s','vy m/s'};
titlename={'x全局坐标','y全局坐标','vx速度曲线','vy速度曲线'};
legendname={'无人车1','无人车2','无人车3','领导车'};
datacell=cell(4);
TimeTrigger=cell(4);
for j = 1:agentnum
    filename=string('C:\qtworkspace\newsim\my_simulation_dir\build\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
    M_j=xlsread(filename);%读取所有状态量
    datacell{1,j}=M_j;
    
    
end

coord=cell(4);
for j = 1:agentnum
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(1:decnum,agentnum*4+4+1);
    y=M_j(1:decnum,agentnum*4+4+2);
    cor_j=[x,y];
    coord{j}=cor_j;
end
%绘制全部的x值
figure()
for j = 1:agentnum
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(1:decnum,agentnum*4+4+1);
    plot(time,x,'LineStyle',linemap{j}, 'LineWidth', 2);
    xlim ([time(1) time(end)]);
    hold on;
end
xlabel('时间(s)');
ylabel('X 坐标(m)');
legend({'无人车1','无人车2','无人车3'});


figure()
for j = 1:agentnum
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(1:decnum,agentnum*4+4+7);
    plot(time,x,'LineStyle',linemap{j}, 'LineWidth', 2);
    xlim ([time(1) time(end)]);
    hold on;
end
xlabel('时间(s)');
ylabel('无人车朝向角(rad)');
legend({'无人车1','无人车2','无人车3'});


figure()
for j = 1:agentnum
    M_j=datacell{1,j};%读取所有状态量
    y=M_j(1:decnum,agentnum*4+4+2);
    plot(time,y,'LineStyle',linemap{j}, 'LineWidth', 2);
    xlim ([time(1) time(end)]);
    hold on;
end
xlabel('时间(s)');
ylabel('Y 坐标(m)');
legend({'无人车1','无人车2','无人车3'});
%绘制全部的y值
%获取数据
filename=string('C:\qtworkspace\newsim\my_simulation_dir\build\log\ETM_Target.xls');%这里会包含所有的数据类型
M_j=xlsread(filename);%读取所有状态量
x=M_j(:,agentnum*4+4+1);
y=M_j(:,agentnum*4+4+2);


distance_Tag={2,2,2};
error=zeros(decnum,1);
figure()
for j = 1:agentnum
    
    
    cor_j=coord{j};
    for k=1:1:decnum
        cor_next=[x(k) y(k)];
        distance= norm(cor_next-cor_j(k,:));
        error(k,1)=distance-distance_Tag{j};
    end
    
    plot(time,error,'LineStyle', linemap{j},'LineWidth', 2);
    xlim ([time(1) time(end)]);
    
    hold on;
    
    
end
ylabel('误差(m)');
xlabel('时间(s)');

legend({'e1','e2','e3'})
