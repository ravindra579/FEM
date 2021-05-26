function [U,K,B,d,UR,UZ]=globalstiffness(n1,n2,p1,p2,r1,r2,h,E,v,bc)
r=[];
%width of each element
l=(r1-r2)/n1;
%height of each element
w=h/n2;
syms R z 
for i=1:n1*n2*2
    if rem(i,2)==0
        r(:,1,i)=[0 0];
        r(:,2,i)=[0 w];
        r(:,3,i)=[-l w];
    else
        r(:,1,i)=[0 0];
        r(:,2,i)=[l 0];
        r(:,3,i)=[0 w];
    end
end
%Centroid of each element
cen=[];
for i=1:n1*n2*2
    cen(:,i)=[sum(r(1,:,i))/3 sum(r(2,:,i))/3];
end
%Area of each element
area=0.5*l*w;
%Coeficient of shape functions 
f=[];
b=[];
c=[];
%N - Shape functions of each element
N=[];
for i=1:n1*n2*2
    f(:,i)=[r(1,2,i)*r(2,3,i)-r(1,3,i)*r(2,2,i) r(1,3,i)*r(2,1,i)-r(1,1,i)*r(2,3,i) r(1,2,i)*r(2,2,i)-r(1,3,i)*r(2,1,i)];
    b(:,i)=[r(2,2,i)-r(2,3,i) r(2,3,1)-r(2,1,1) r(2,1,1)-r(2,2,1)];
    c(:,i)=[r(1,3,i)-r(1,2,i) r(1,1,1)-r(1,3,1) r(1,2,1)-r(1,1,1)];
end
%Calculating the Shape functions of each element
for i=1:n1*n2*2
 N=[N;f(1,i)+R*b(1,i)+z*c(1,i) f(2,i)+R*b(2,i)+z*c(2,i) f(3,i)+R*b(3,i)+z*c(3,i)];
end
%Calculating shape functions at centroid of each element
Ncen=[];
for i=1:n1*n2*2
    Ncen(:,i)=[(f(1,i)+cen(1,i)*b(1,i)+cen(2,i)*c(1,i))/cen(1,i),(f(2,i)+cen(1,i)*b(2,i)+cen(1,i)*c(2,i))/cen(1,i),(f(3,i)+cen(2,i)*b(3,i)+cen(2,i)*c(3,i))/cen(1,i)];
end
%Strain displacment matrix
B=[];
for i= 1:n1*n2*2
    B(:,:,i)=(1/(2*area)).*[b(1,i) 0 b(2,i) 0 b(3,i) 0;0 c(1,i) 0 c(2,i) 0 c(3,i);Ncen(1,i) 0 Ncen(2,i) 0 Ncen(3,i) 0;c(1,i) b(1,i) c(2,i) b(2,i) c(3,i) b(3,i)];
end
%% 
% stage 2
% d - Stress strain  matrix
d=[];
d=[1-v v v 0 ; v 1-v v 0; v v 1-v 0; 0 0 0 0.5*(1-2*v)];
d=d.*(E/((1+v)*(1-2*v)));
%k - Stifness matrix of each element
k=[];
for i=1:n1*n2*2
   k(:,:,i)=B(:,:,i)'*d*B(:,:,i); 
   k(:,:,i)=k(:,:,i).*(2*(22/7)*area*cen(1,i));
end
% F - Assembled force vector
i=1;
F=[];
while i<(n1+1)*(n2+1)*2
    F(i)=(2*(22/7)*r2*w*p2);
    i=i+2*(n1+1);
end
i=2*(n1)+1;
while i<=(n1+1)*(n2+1)*2
    F(i)=(2*(22/7)*r1*w*p1);
    i=i+2*(n1+1);
end
F((n1+1)*(n2+1)*2)=0;
z=(n1+1)*(n2+1);
%K - Global Stifness matrix
K=zeros(z*2,z*2);
ii=1;
i=1;
iii=1;
while ii<n1*n2*2
    K=Assemble(K,k(:,:,ii),i,i+1,i+n1+1);
     if rem(iii,n1)==0
        i=i+1;
     end
     ii=ii+2;
     i=i+1;
     iii=iii+1;
end
ii=2;
i=2;
iii=1;
while ii<=n1*n2*2
    K=Assemble(K,k(:,:,ii),i,i+n1+1,i+n1);
     if rem(iii,n1)==0
             i=i+1;
     end
     ii=ii+2;
     i=i+1;
     iii=iii+1;
end
K;
%U - Displacemet Vector
U=zeros(n1*n2*2,1);
U=inv(K)*F';
if bc==1
i=2;
while i<=2*(n1+1)
    U(i,1)=0;
   U(2*z-i+2,1)=0;
   i=i+2;
   i
end
end
if bc==2
    for i=1:2*(n1+1)
        U(i,1)=0;
        U(2*z-i+1,1)=0;
        i
    end
end
UR=[];
j=1;
for i=1:z
    UR=[UR U(j)];
    j=j+2;
end
UZ=[];
j=2;
for i=1:z
    UZ=[UZ U(j)];
    j=j+2;
end
nodes=[1:z];
figure(2)
subplot(2,1,1)
plot(UR,nodes,'DisplayName','UR',"Color",'r');
xlabel("Displacement (mm)")
legend
ylabel("Nodes");
subplot(2,1,2)
plot(UZ,nodes,"DisplayName",'UZ')
ylabel("nodes");
xlabel("Displacement (mm)")
legend
end