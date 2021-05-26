clc
clear all
close all
tic
%{
r1=input("enter radius in m ");
h=input("enter height in m ");
n1=input("'How many divisions are needed in radial direction");
n2=input("'How many divisions are needed in  axial direction");
h13=input("enter convective heat transfer coefficent in r direction");
h32=input("enter convective heat transfer coefficent in z direction");
q0=input("enter value of heat flux");
K=input("enter conductivity value");
tinf1=input("enter the surrounding temperature value in r direction");
tinf2=input("enter the surrounding temperature value in z direction");
alpha=input("enter thermal expansion coefficient");
E=input("enter Young's modulus value");
u=input("enter the value of poisson's ratio");
%}
r1=100;
h=100;
n1=10;
n2=10;
h13=15;
h32=10;
q0=50;
K=5;
tinf1=10;
tinf2=20;
alpha=3*(10^-6);
E=200*10^9;
u=0.3;
r2=0;
l=(r1-r2)/n1;
w=h/n2;
b=[];
for i=1:n1*n2*2
    if rem(i,2)==0
        b(1,i)=0;
        b(2,i)=w;
        b(3,i)=-w;
    else
        b(1,i)=w;
        b(2,i)=0;
        b(3,i)=-w;
    end
end
c=[];
for i=1:n1*n2*2
    if rem(i,2)==0
        c(1,i)=l;
        c(2,i)=0;
        c(3,i)=-l;
    else
        c(1,i)=l;
        c(2,i)=-l;
        c(3,i)=0;
    end
end
kc=[];
for i=1:n1*n2*2
    kc(:,:,i)=[b(1,i)^2+c(1,i)^2 b(1,i)*b(2,i)+c(1,i)*c(2,i) b(1,i)*b(3,i)+c(1,i)*c(3,i);b(1,i)*b(2,i)+c(1,i)*c(2,i) b(2,i)^2+c(2,i)^2 b(2,i)*b(3,i)+c(2,i)*c(3,i);b(1,i)*b(3,i)+c(1,i)*c(3,i) b(2,i)*b(3,i)+c(2,i)*c(3,i) b(3,i)^2+c(3,i)^2];
end
area=0.5*l*w;
kc=kc.*K;
kc=kc./(4*area);
s13=sqrt(l^2+w^2);
s32=w;
kh1=[2 0 1;0 0 0;1 0 2];
kh1=kh1.*(h13*s13);
kh1=kh1./6;
kh2=[0 0 0;0 2 1;0 1 2];
kh2=kh2.*(h32*s32);
kh2=kh2./6;
kh=kh1+kh2;
for i=1:n1*n2*2
    k(:,:,i)=kc(:,:,i)+kh;
end
f=[1;1;1];
f=f.*(q0*area);
f=f./3;
invk=[];
T=[];
for i=1:n1*n2*2
invk(:,:,i)=inv(k(:,:,i));
T(:,:,i)=(invk(:,:,i)*f).*(1+rand(1,1));
end
strain=[];
for i=1:n1*n2*2
    strain(1,1,i)=(alpha.*(T(1,:,i)-tinf1))./(1-u);
    %strain(2,1,i)=(alpha.*(T(1,:,i)-tinf2))./(1-u);
    %strain(3,1,i)=(alpha.*(T(1,:,i)-tinf1));
    strain(2,1,i)=(alpha.*(T(2,:,i)-tinf1))./(1-u);
    %strain(2,2,i)=(alpha.*(T(2,:,i)-tinf2))./(1-u);
    %strain(3,2,i)=(alpha.*(T(2,:,i)-tinf1));
    strain(3,1,i)=(alpha.*(T(3,:,i)-tinf1))./(1-u);
    %strain(2,3,i)=(alpha.*(T(3,:,i)-tinf2))./(1-u);
    %strain(3,3,i)=(alpha.*(T(3,:,i)-tinf1));
end

figure(1);
rectangle('Position',[r2 0 r1-r2 h],"LineWidth",2)
axis([0 r1 0 h])
xlabel("diameter");
ylabel("height");
hold on
grid on
y=0;
for i=1:n2
    plot([0,r1],[y,y],'color','b',"LineWidth",1);
    y=y+w;
end
y=0;
for i=1:n1
    plot([y,y],[0,h],'color','b',"LineWidth",1);
    y=y+l;
end
rectangle('Position',[r2 0 r1-r2 h],"LineWidth",2)
y=r2;
yy=0;
strain;
for i=1:min(n1,n2)
    plot([y+l r2],[0 yy+w],"Color","b")
    y=y+l;
    yy=yy+w;
end
y=r1;
yy=h;
for i=1:min(n1,n2)
    plot([r1 y-l],[yy-w h],"Color","b")
    y=y-l;
    yy=yy-w;
end
if n1>n2
y=r2+(n2)*l;
yy=r2;
for i=1:n1-n2
    plot([y+l yy+l],[0 h],"Color","b")
    y=y+l;
    yy=yy+l;
end
else
y=(n1)*w;
yy=0;
for i=1:n2-n1
    plot([r2 r1],[y+w yy+w],"Color","b")
    y=y+w;
    yy=yy+w;
end
end  
stress=[];
zz=E/(1-u);
for i=1:n1*n2*2
    stress(:,:,i)=strain(:,:,i)*E;
end
stress;
z=(n1+1)*(n2+1);
Kstress=zeros(3,n1*n2*2);
for i=1:n1*n2*2
    Kstress(1,i)=stress(1,1,i);
    Kstress(2,i)=stress(2,1,i);
    Kstress(3,i)=stress(3,1,i);
end
Kstrain=zeros(3,n1*n2*2);
for i=1:n1*n2*2
    Kstrain(1,i)=strain(1,1,i);
    Kstrain(2,i)=strain(2,1,i);
    Kstrain(3,i)=strain(3,1,i);
end



z=(n1+1)*(n2+1);
X=[];
ii=0;
for i=1:z
    X=[X;l*ii];
    if ii==n1
        ii=0;
    else
      ii=ii+1; 
    end
end
Y=[];
ii=1;
iii=0;
for i=1:z
    Y=[Y;w*(ii-1)];
    if iii==n1
        ii=ii+1;
        iii=0;
    else
        iii=iii+1;
    end
end

fh3=figure;
set(fh3,'name','stress 1','numbertitle','off');
curveplot(X,Y,z,Kstress,1,n1,n2)
title("stress IN R DIRECTION");
fh3=figure;
set(fh3,'name','stress 2','numbertitle','off');
curveplot(X,Y,z,Kstress,2,n1,n2)
title("stress IN Z DIRECTION");
fh3=figure;
set(fh3,'name','stress 3','numbertitle','off');
curveplot(X,Y,z,Kstress,3,n1,n2)
title("stress IN TH DIRECTION");
fh3=figure;
set(fh3,'name','strain 1','numbertitle','off');
curveplot(X,Y,z,Kstrain,1,n1,n2)
title("strain IN R DIRECTION");
fh3=figure;
set(fh3,'name','strain 2','numbertitle','off');
curveplot(X,Y,z,Kstrain,2,n1,n2)
title("strain IN Z DIRECTION");
fh3=figure;
set(fh3,'name','strain 3','numbertitle','off');
curveplot(X,Y,z,Kstrain,3,n1,n2)
title("strain IN TH DIRECTION");
toc
