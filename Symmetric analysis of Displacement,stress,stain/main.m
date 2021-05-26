clc
clear all
close all
tic
%Material Library 
display('Material properties')
display('1.Cast Iron')
display('2.Cast steel')
display('3.Stainless Steel')
%a=input('enter 1 or 2 or 3');
a=1;
r1=100;
r2=50;
h=50;
p1=150;
p2=50;
n1=9;
n2=7;
if a==1
    E=169000;
    v=0.29;
else if a==2
       E=190000;
       v=0.29;
else
    E=207000;
    v=0.3;
end
end
%Define geometric inputs 
%Define outer radius of cylinder
%r1=input("enter outer radius in mm ");
%Define inner radius of cylinder
%r2=input("enter inner radius in mm ");
%Define height of cylinder
%h=input("enter height in mm ");
%%
% stage 1
%syms v E
%Define variables to calculate shape functions
syms R z 
%Define the external pressure and internal pressure
%p1=input("Enter external pressure in MPa ");
%p2=input("Enter internal pressure in MPa ");
%Define mesh size 
%n1=input("'number of elements need in radial direction");
%n2=input("'number of elements need in axial direction");
%width of each element
l=(r1-r2)/n1;
%height of each element
w=h/n2;
%Retriving the coordinates of each nodes of corrosponding elements
%r - nodal Coordinate matrix
figure(1);
rectangle('Position',[r2 0 r1-r2 h],"LineWidth",2)
axis([0 r1 0 h])
xlabel("Diameter (mm)");
ylabel("Height (mm)");
hold on
grid on
set(gca,'XTick',r2:l:r1)
set(gca,'YTick',0:w:h)
rectangle('Position',[r2 0 r1-r2 h],"LineWidth",2)
y=r2;
yy=0;
for i=1:min(n1,n2)
    plot([y+l r2],[0 yy+w],"Color","g")
    y=y+l;
    yy=yy+w;
end
y=r1;
yy=h;
for i=1:min(n1,n2)
    plot([r1 y-l],[yy-w h],"Color","g")
    y=y-l;
    yy=yy-w;
end
if n1>n2
y=r2+(n2)*l;
yy=r2;
for i=1:n1-n2
    plot([y+l yy+l],[0 h],"Color","g")
    y=y+l;
    yy=yy+l;
end
else
y=(n1)*w;
yy=0;
for i=1:n2-n1
    plot([r2 r1],[y+w yy+w],"Color","g")
    y=y+w;
    yy=yy+w;
end
end   
bc=2;
display('Boundary conditions')
display('1.Roller')
display('2.Fixed')
a=input('enter 1 or 2');
[U,K,B,d,UR,UZ]=globalstiffness(n1,n2,p1,p2,r1,r2,h,E,v,bc);
%Displaying the elements
[stress,strain]=strainstress(U,n1,n2,UR,UZ,B,d,r1,r2,h,p1,p2);
toc