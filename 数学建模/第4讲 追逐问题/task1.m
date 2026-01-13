clear all
v=1;  
dt=0.05;
x=[0 0 10 10];
y=[0 10 10 0];
for i=1:4
    plot(x(i),y(i),'.');hold on
end
d=20;
t = 0;
while(d>0.1)
    t = 1+t;
    x(5)=x(1);
    y(5)=y(1);
    c = ["b.","g.","r.","k."];
    for i=1:4
        d=sqrt((x(i+1)-x(i))^2+(y(i+1)-y(i))^2);
        x(i)=x(i)+v*dt*(x(i+1)-x(i))/d;
        y(i)=y(i)+v*dt*(y(i+1)-y(i))/d;
        plot(x(i),y(i),c(i));
        hold on
        frame = getframe(gca);  %getframe函数的作用是捕获坐标区或图窗作为影片帧。
        im{t} = frame2im(frame);  %从单个影片帧返回图像
    end
end