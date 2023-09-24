data=xlsread('D:\QT\prjdir\OSGIMODULE\my_simulation_dir\build\log\PATHPLAING\test.xls');
M=data;
xmlconfigname='D:\QT\prjdir\OSGIMODULE\my_simulation_dir\build\config\swarmmpc\swarm.xml';
Targetconfigfile='D:\QT\prjdir\OSGIMODULE\my_simulation_dir\build\config\swarmmpc\Target.xml';
colorpair={'red','green','blue','yellow','black'};
obs_num=XMLread(xmlconfigname,'obs_num');
communicationrange=XMLread(xmlconfigname,'communication_range');
collir=XMLread(xmlconfigname,'collision_r');
TargetTraj=XMLread(Targetconfigfile,'trajmat');
figure();
hold on;
%首先绘制障碍物
for i=1:1:obs_num
    OBS=XMLread(xmlconfigname,string("OBS_")+string(i)+string("_vertexparams"));
    Fillcircle(OBS(1,1),OBS(1,2),OBS(1,3));
    hold on;
end


sizemat=size(M);
dec_num=sizemat(1);
agentnum=sizemat(2)/3;
%绘制目标的轨迹
M_j=zeros(dec_num,2);
for i = 1:dec_num
    x_i=TargetTraj(i,1);
    y_i=TargetTraj(i,2);
    M_j(i,1)=x_i;
    M_j(i,2)=y_i;
end
plot(M_j(:,1),M_j(:,2),'blue');
hold on;
%绘制轨迹
for j = 1:agentnum
    
    M_j=zeros(dec_num,2);
    for i = 1:dec_num
        x_i=M(i,3*(j-1)+1);
        y_i=M(i,3*(j-1)+2);
        phi_i=M(i,3*(j-1)+2);
        M_j(i,1)=x_i;
        M_j(i,2)=y_i;
        
%         drawCircle(x_i,y_i,collir,colorpair{j});
%         hold on;
        
    end
    plot(M_j(:,1),M_j(:,2));
    hold on;
    
%     x_i=M_j(end,1);
%     y_i=M_j(end,2);
    %     drawCircle(x_i,y_i,communicationrange,colorpair{j});
    %     hold on;
    
    
end

axis equal;


% Add labels and title

hold on;