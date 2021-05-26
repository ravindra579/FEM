%Plotting graphs for displacement
function Uplots(X,Y,UR,n1,n2,a)
z=(n1+1)*(n2+1);
%poltting UR and UZ graphs
fh1=figure;
if(a==1)
set(fh1,'name','UR','numbertitle','off');
else
    set(fh1,'name','UZ','numbertitle','off');
end
i=1;
iii=1;
while i<z-n1-1
x1=[];
y1=[];
ur1=[];
ii=1;
x1(ii)=X(i);
y1(ii)=Y(i);
ur1(ii)=UR(i);
ii=ii+1;
x1(ii)=X(i+1);
y1(ii)=Y(i+1);
ur1(ii)=UR(i+1);
ii=ii+1;
x1(ii)=X(i+n1+1);
y1(ii)=Y(i+n1+1);
ur1(ii)=UR(i+n1+1);
ii=ii+1;
x1(ii)=X(i);
y1(ii)=Y(i);
ur1(ii)=UR(i);
fill(x1,y1,ur1);
hold on;
if(iii==n1)
    i=i+2;
    iii=1;
else
    i=i+1;
    iii=iii+1;
end
end
iii=1;
i=2;
while i<z-n1
x1=[];
y1=[];
ur1=[];
ii=1;
x1(ii)=X(i);
y1(ii)=Y(i);
ur1(ii)=UR(i);
ii=ii+1;
x1(ii)=X(i+n1);
y1(ii)=Y(i+n1);
ur1(ii)=UR(i+n1);
ii=ii+1;
x1(ii)=X(i+n1+1);
y1(ii)=Y(i+n1+1);
ur1(ii)=UR(i+n1+1);
ii=ii+1;
x1(ii)=X(i);
y1(ii)=Y(i);
ur1(ii)=UR(i);
fill(x1,y1,ur1);
if(iii==n1)
    i=i+2;
    iii=1;
else
    i=i+1;
    iii=iii+1;
end
end
axis off;
%Displaying the colourbar for the variation
colorbar
if(a==1)
title("DISPLACEMENT IN R DIRECTION");
else
title("DISPLACEMENT IN Z DIRECTION");    
end