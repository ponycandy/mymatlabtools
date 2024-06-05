%绘制障碍物
figure();


adjmat_1=[0 1 0 0 1 0;
    1 0 1 0 0 0;
    0 1 0 1 0 0;
    0 0 1 0 0 1;
    1 0 0 0 0 1;
    0 0 0 1 1 0];

adjmat_2=[0 1 0 1 0 0;
    1 0 0 0 0 1;
    0 0 0 0 1 1;
    1 0 0 0 1 1;
    0 0 1 1 0 0;
    0 1 1 1 0 0];

adjmat_3=[0 1 1 1 1 1;
    1 0 1 1 1 1;
    1 1 0 1 1 1;
    1 1 1 0 1 1;
    1 1 1 1 0 1;
    1 1 1 1 1 0];


adjmat_4=[0 1 0 0 0 0;
    1 0 0 0 0 1;
    0 0 0 0 1 0;
    0 0 0 0 1 1;
    0 0 1 1 0 0;
    0 1 0 1 0 0];
Mattrix={adjmat_1,adjmat_2,adjmat_3,adjmat_4};



Hmat_1={[1 1.732],[2 0],[1 -1.732],[-1 -1.732],[-1 1.732],[-2 0]};
Hmat_2={[1 2],[-1 2],[-1 -2],[1 0],[1 -2],[-1 0]};
Hmat_3={[1 0],[0 1.5],[-1 0.75],[-1 -0.75],[0 -1.5],[0 0]};
Hmat_4={[-2 2],[-1 1],[-2 -3],[0 -1],[-1 -2],[0 0]};

Hmatrix={Hmat_1,Hmat_2,Hmat_3,Hmat_4};

agentnum=6;%绘制全部代理

%需要从Hmatrix生成Hmat
markermoment=[1,1200,1800,2500];
counterrep=[550,666,666,2601-550-666-666];


H_mat=cell(1,4);
for j=1:1:agentnum
    H_mat=[];
    for int=1:1:4
        tempdict=Hmatrix{int};
        tempmat=repmat(tempdict{j},counterrep(1,int),1);
        H_mat=[H_mat;tempmat];
    end
    Hmat{j}=H_mat;
end
colourmap={[1 0 0],[0 1 0],[0.5 0 0],[0.5 0 0.5],[0,0.55,0.93],[0 0 1]};
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

%求解平均error
coord=cell(agentnum);
for j = 1:agentnum
    
    M_j=datacell{1,j};%读取所有状态量
    x=M_j(:,agentnum*4+1);
    y=M_j(:,agentnum*4+2);
    cor_j=[x,y];
    coord{j}=cor_j;
    
    
end
error=zeros(size(x,1),1);
counter=0;
adjmat=adjmat_4;
%最后终点再添加一下
for j_0 = 1:agentnum
    for i_0=1:1:agentnum
        if adjmat(j_0,i_0)==1
            cor_j=coord{j_0};
            cor_next=coord{i_0};
            
            error=error+vecnorm(((cor_j-cor_next)-(Hmat{j_0}-Hmat{i_0})), 2, 2);
            counter=counter+1;
        end
        %     plot([cor_j(end,1) x],[cor_j(end,2) y], 'color', 'black');
        %     hold on;
        
    end
    
    
end
error=error/counter;
time=0.03:0.03:(size(error,1)*0.03);

plot(time,error)
hold on;
vertical=zeros(1,3);
vertical(1,1)=counterrep(1,1);
plot([vertical(1,1)*0.03,0.03*vertical(1,1)],[0,3.5], 'color', 'red','LineWidth',3.5);
text(1+0.03*vertical(1,1),3,"Shift 1");
hold on;
for opo=2:1:3
    vertical(1,opo)=vertical(1,opo-1)+counterrep(1,opo);
    plot([vertical(1,opo)*0.03,0.03*vertical(1,opo)],[0,3.5], 'color', 'red','LineWidth',3.5);
    text(0.03*vertical(1,opo)+1,3,"Shift "+num2str(opo));

hold on;
end



% 显示只包含红色线条的图例
legend("formation error");
xlabel('Time /s');
ylabel('error /m');
