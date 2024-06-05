
figure();
x=0;
y=0;
alpha=0;
for i=1:1:5
    x=x+1;
    y=y+1;
    
    drawbeacon(x,y,alpha);
    alpha=alpha+pi/20;
    hold on;
end