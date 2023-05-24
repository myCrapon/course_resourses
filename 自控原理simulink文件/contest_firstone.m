function createSandWorld(long, width, height,ratio)
close;
space = zeros(3*width,2*long,4*height);
space(:,1:end,1) = 2;
d=10;
space = createThreePyramid(space,long,width,height,.5,d,ratio);
G=getSandNum(space,height);
Gi=getSandNum(space,height);
time=0; draw(space,time,Gi)
while Gi>=(G/2)
time=time+1; space = createWave(space,time,width,height);
draw(space,time,Gi)
space = moveWater(space);
space = permeate(space,time,width,height);
draw(space,time,Gi)
space = moveSand(space);
draw(space,time,Gi)
Gi=getSandNum(space,height);
end 
function sixPyramid=createSixPyramid(B,L,H,s,d,p)
dim=size(B);
pos=sym('posn',[9,3]);
pos(1,:)=[dim(1)-1-d,round(dim(2)/2-L/4),2];
pos(2,:)=[pos(1,1),round(dim(2)/2+L/4),2];
pos(3,:)=[round(pos(1,1)-sqrt(3)*L/4),round(pos(2,2)+L/4),2];
pos(4,:)=[round(pos(1,1)-sqrt(3)*L/2),pos(2,2),2];
pos(5,:)=[pos(4,1),pos(1,2),2];
pos(6,:)=[pos(3,1),round(pos(1,2)-L/4),2];
pos(7,:)=[pos(6,1),round(dim(2)/2-L*s/2),H+pos(1,3)-1]; pos(8,:)=[round(pos(7,1)+sqrt(3)*s*L/4),
round(pos(7,2)+3*s*L/4),H+pos(1,3)-1];
pos(9,:)=[pos(7,1),round(dim(2)/2+L*s/2),H+pos(1,3)-1];
plane=sym('plane',[1,6]);
plane(1)=getPlane(pos(1,:),pos(2,:),pos(8,:));
plane(2)=getPlane(pos(2,:),pos(8,:),pos(3,:));
plane(3)=getPlane(pos(4,:),pos(9,:),pos(3,:));
syms x
plane(4)=subs(plane(1),x,2*pos(3,1)-x);
plane(5)=getPlane(pos(5,:),pos(6,:),pos(7,:));
plane(6)=getPlane(pos(1,:),pos(6,:),pos(7,:));
z1=double(pos(8,3));z2=double(pos(1,3));
x1=double(pos(4,1));x2=double(pos(1,1));
y1=double(pos(6,2));y2=double(pos(3,2));
for z=z1:-1:z2
for x=x1:x2
for y=y1:y2
if eval(plane(1))>=z && eval(plane(2))>=z && eval(plane(3))>=z&& eval(plane(4))>=z && eval(plane(5))>=z && eval(plane(6))>=z
B(x,y,z)=1;
end
end
end
end
B=insertWater(B,p);
sixPyramid=B;
end
function circular=createCircular(B,L,W,H,d,p)
dim=size(B);
a=W/2;b=L/2;c=dim(3)-1;
pos=sym('pos',[4,3]);
pos(1,:)=[dim(1)-1-d,ceil(dim(2)/2),2];
pos(2,:)=[ceil(pos(1,1)-a),ceil(pos(1,2)+b),2];
pos(3,:)=[ceil(pos(1,1)-2*a),pos(1,2),2];
pos(4,:)=[pos(2,1),ceil(pos(1,2)-b),2];
x1=double(pos(3,1));x2=double(pos(1,1));
y1=double(pos(4,2));y2=double(pos(2,2));
for z=H+1:-1:2
for x=x1:x2
for y=y1:y2
if z <= c+1-sqrt(c^2*((x-pos(2,1))^2/a^2+(y-pos(1,2))^2/b^2))
B(x,y,z)=1;
end
end
end
end
B=insertWater(B,p);
circular=B;
end
