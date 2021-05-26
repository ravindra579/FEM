function [stress,strain]=strainstress(U,n1,n2,UR,UZ,B,d,r1,r2,h,p1,p2)
%eps - strain matrix of each element
eps=[];
%width of each element
l=(r1-r2)/n1;
%height of each element
w=h/n2;
z=(n1+1)*(n2+1);
i=1;
ii=1;
iii=1;
while ii<2*n1*n2
    eps(:,ii)=[U(i),U(i+1),U(i+2),U(i+3),U(i+2*n1+2),U(i+2*n1+3)];
       if rem(iii,n1)==0
        i=i+2;
       end
     i=i+2;
     ii=ii+2;
     iii=iii+1;
end
i=3;
ii=2;
iii=1;
while ii<=2*n1*n2  
    eps(:,ii)=[U(i),U(i+1),U(i+2*n1),U(i+2*n1+1),U(i+2*n1-2),U(i+2*n1-1)];
       if rem(iii,n1)==0
        i=i+2;
       end
     i=i+2;
     ii=ii+2;
     iii=iii+1;
end
strain=[];
for i=1:n1*n2*2
    strain(:,i)=B(:,:,i)*eps(:,i);
end
%stress - stress matrix of each element
stress=[];
for i=1:n1*n2*2
    stress(:,i)=d*strain(:,i);
end
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

uplots(X,Y,UR,n1,n2,1);
uplots(X,Y,UZ,n1,n2,2);
stressf(n1,n2,X,Y,stress,1,1);
stressf(n1,n2,X,Y,stress,2,1);
stressf(n1,n2,X,Y,stress,3,1);
stressf(n1,n2,X,Y,stress,4,1);
stressf(n1,n2,X,Y,strain,1,2);
stressf(n1,n2,X,Y,strain,2,2);
stressf(n1,n2,X,Y,strain,3,2);
stressf(n1,n2,X,Y,strain,4,2);
end