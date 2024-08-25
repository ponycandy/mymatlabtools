agentnum=3;%绘制4个追踪者的所有状态
decnum=1000;
time=0:0.03:decnum*0.03-0.03;
linemap_spec={'-.',':','--','-','-.',':'};
linewidth={2,2,2,2,1,1};
k_oop=1;

colourmap={'red','green','blue','yellow'};
xlabelname={'时间 s','时间 s','时间 s','时间 s'};
ylabelname={'x m','y m','vx m/s','vy m/s'};
titlename={'x全局坐标','y全局坐标','vx速度曲线','vy速度曲线'};
legendname={'agent1','agent2','agent3','agent4'};
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


%绘制全部的y值
%获取数据
filename=string('C:\qtworkspace\newsim\my_simulation_dir\build\log\ETM_Target.xls');%这里会包含所有的数据类型
M_j=xlsread(filename);%读取所有状态量
x=M_j(:,agentnum*4+4+1);
y=M_j(:,agentnum*4+4+2);


avgerror=cell(agentnum);

distance_Tag={2,2,2};
error=zeros(decnum,1);
figure()
%这里是到leader的距离
for j = 1:agentnum
    
    avergeerror_i=zeros(decnum,1);
    cor_j=coord{j};
    for k=1:1:decnum
        cor_next=[x(k) y(k)];
        distance= norm(cor_next-cor_j(k,:));
        error(k,1)=distance;
        
        avergeerror_i(k,1)=distance-2;
    end
    
    plot(time,error,'LineStyle', linemap_spec{j},'LineWidth', linewidth{k_oop});
    k_oop=k_oop+1;
    xlim ([time(1) time(end)]);
    
    hold on;
    avgerror{j}=avergeerror_i;
    
end


xlabel('time /s');


hold on 

for j = 1:agentnum
    
    avergeerror_j=avgerror{j};
    
    j_1=j+1;
    if(j_1>agentnum)
        j_1=1;
    end
    cor_j=coord{j};
    cor_next=coord{j_1};
    for k=1:1:decnum
        
        distance= norm(cor_next(k,:)-cor_j(k,:));
        error(k,1)=distance;
        avergeerror_j(k,1)=avergeerror_j(k,1)+distance-3.46;
    end
    
    plot(time,error,'LineStyle', linemap_spec{j+3},'LineWidth', linewidth{k_oop});
    k_oop=k_oop+1;
    xlim ([time(1) time(end)]);
    avgerror{j}=avergeerror_j;
    hold on;
    
    
end
ylabel('距离(m)')
xlabel('时间(s)');
legend({'领导车 - 无人车1','领导车 - 无人车2','领导车 - 无人车3','无人车1 - 无人车2','无人车2 - 无人车3','无人车3 - 无人车1'})

figure();

for j = 1:agentnum
    
    avergeerror_j=avgerror{j};
    plot(time,avergeerror_j);
    xlim ([time(1) time(end)]);
    avgerror{j}=avergeerror_j;
    hold on;
    
    
end
xlabel('time /s');

legend({'e1','e2','e3'})