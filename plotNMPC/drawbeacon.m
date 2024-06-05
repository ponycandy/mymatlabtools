function drawbeacon(x,y,alpha)
alpha=-alpha;
pixl=0.8;

pix_x=x;%不做任何缩放
pix_y=y;

OBS=[       pixl, 0;
    -pixl, -pixl;
    0, 0;
    -pixl, pixl;
    pixl, 0];

for i=1:1:5
    
    x_c1=cos(alpha)*OBS(i,1)+sin(alpha)*OBS(i,2)+pix_x;
    y_c1=-sin(alpha)*OBS(i,1)+cos(alpha)*OBS(i,2)+pix_y;
    OBS(i,:)=[x_c1,y_c1];
end


x=OBS(:,1);
y=OBS(:,2);
plot([x; x(1)], [y ;y(1)], 'k');
fill(x, y, 'r');
grid on;
axis equal;
hold on;

end