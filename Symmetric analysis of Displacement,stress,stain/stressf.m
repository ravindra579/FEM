function stressf(n1,n2,X,Y,stress,a,b)
%Plotting the stress and strain diagrams in 3 directions
fh3=figure;
z=(n1+1)*(n2+1);
if(a==1)
    if(b==1)
set(fh3,'name','stress 1','numbertitle','off');
    else
        set(fh3,'name','strain 1','numbertitle','off');
    end
elseif(a==2)
   if(b==1)
set(fh3,'name','stress 2','numbertitle','off');
    else
        set(fh3,'name','strain 2','numbertitle','off');
   end
elseif(a==3)
    if(b==1)
set(fh3,'name','stress 3','numbertitle','off');
    else
        set(fh3,'name','strain 3','numbertitle','off');
    end
else
   if(b==1)
set(fh3,'name','stress 4','numbertitle','off');
    else
        set(fh3,'name','strain 4','numbertitle','off');
   end
end
i=1;
iii=1;
iiii=1;
while i<z-n1-1
x1=[];
y1=[];
ur1=[];
ii=1;
x1(ii)=X(i);
y1(ii)=Y(i);
ur1(ii)=stress(a,iiii);
ii=ii+1;
x1(ii)=X(i+1);
y1(ii)=Y(i+1);
ur1(ii)=stress(a,iiii);
ii=ii+1;
x1(ii)=X(i+n1+1);
y1(ii)=Y(i+n1+1);
ur1(ii)=stress(a,iiii);
ii=ii+1;
x1(ii)=X(i);
y1(ii)=Y(i);
ur1(ii)=stress(a,iiii);
fill(x1,y1,ur1);
hold on;
if(iii==n1)
    i=i+2;
    iii=1;
else
    i=i+1;
    iii=iii+1;
end
iiii=iiii+2;
end
iii=1;
i=2;
iiii=2;
while i<z-n1
x1=[];
y1=[];
ur1=[];
ii=1;
x1(ii)=X(i);
y1(ii)=Y(i);
ur1(ii)=stress(a,iiii);
ii=ii+1;
x1(ii)=X(i+n1);
y1(ii)=Y(i+n1);
ur1(ii)=stress(a,iiii);
ii=ii+1;
x1(ii)=X(i+n1+1);
y1(ii)=Y(i+n1+1);
ur1(ii)=stress(a,iiii);
ii=ii+1;
x1(ii)=X(i);
y1(ii)=Y(i);
ur1(ii)=stress(a,iiii);
fill(x1,y1,ur1);
if(iii==n1)
    i=i+2;
    iii=1;
else
    i=i+1;
    iii=iii+1;
end
iiii=iiii+2;
end
axis off;
colorbar
if(a==1)
    if(b==1)
title("STRESS IN R DIRECTION");
    else
        title("STRAIN IN R DIRECTION");
    end
elseif(a==2)
    if(b==1)
title("STRESS IN Z DIRECTION");
    else
        title("STRAIN IN Z DIRECTION");
    end
elseif(a==3)
    if(b==1)
title("STRESS IN TH DIRECTION");
    else
        title("STRAIN IN TH DIRECTION");
    end
else
    if(b==1)
title("STRESS IN RZ DIRECTION");
    else
        title("STRAIN IN RZ DIRECTION");
    end
end
end