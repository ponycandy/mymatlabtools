
figure();
x=0;
y=0;
alpha=0;
for i=1:1:100
    x=x+1;
    y=y+1;
    
    drawbeacon(x,y,alpha);
    alpha=alpha+1;
    hold on;
end