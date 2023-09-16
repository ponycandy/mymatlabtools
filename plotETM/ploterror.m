agentnum=4;%绘制4个追踪者的所有状态
decnum=1200;
time=0:0.03:decnum*0.03-0.03;
colourmap={'red','green','blue','yellow'};
xlabelname={'时间 s','时间 s','时间 s','时间 s'};
ylabelname={'x m','y m','vx m/s','vy m/s'};
titlename={'x全局坐标','y全局坐标','vx速度曲线','vy速度曲线'};
legendname={'agent1','agent2','agent3','agent4'};
datacell=cell(4);
TimeTrigger=cell(4);
for j = 1:agentnum
    filename=string('D:\QT\prjdir\OSGIMODULE\my_simulation_dir\build\log\')+string('ETM_Agent_')+string(j)+string('.xls');%这里会包含所有的数据类型
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

%获取数据
distance_Tag={7.07,7.07,7.07,7.07};
error=zeros(decnum,1);
for j = 1:agentnum
    
  
    cor_j=coord{j};
    if mod(j+1,4)==0
        cor_next=coord{4};
    else
        cor_next=coord{mod(j+1,4)};
    end
   for k=1:1:decnum
        distance= norm(cor_next(k,:)-cor_j(k,:));
        error(k,1)=distance-distance_Tag{j};
   end
  
   plot(time,error);
   hold on;

    
end
xlabel('time /s');

legend({'e1','e2','e3','e4'})
