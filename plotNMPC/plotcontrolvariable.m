agentnum=3;%绘制4个追踪者的所有状态
decnum=1000;
time=0:0.03:decnum*0.03-0.03;
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

figure()
for j = 1:agentnum
    M_j=datacell{1,j};%读取所有状态量
    omeaga=M_j(1:decnum,agentnum*4+4+6);
    plot(time,omeaga);
    xlim ([time(1) time(end)]);
    hold on;
end
xlabel('time /s');
ylabel('omega rad/s');
legend({'agent1','agent2','agent3'});

figure()
for j = 1:agentnum
    M_j=datacell{1,j};%读取所有状态量
    vx=M_j(1:decnum,agentnum*4+4+3);
    vy=M_j(1:decnum,agentnum*4+4+4);
    vel=sqrt(vx.^2+vy.^2);
    plot(time,vel);
    xlim ([time(1) time(end)]);
    hold on;
end
xlabel('time /s');
ylabel('vel m/s');
legend({'agent1','agent2','agent3'});
legend({'agent1','agent2','agent3'});