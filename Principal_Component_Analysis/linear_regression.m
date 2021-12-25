function linear_regression(y,x,alpha)
% relevant data of x,y
[N,n]=size(x);
ex=mean(x);
ey=mean(y);
var_x=var(x);
var_y=var(y);

%regression
for i=1:n
    x(:,i)=(x(:,i)-ex(:,i))/sqrt(var_x(:,i));
end

y=(y-ey)/sqrt(var_y);

x=x';
% new relevants 
Ye=mean(y);
Xe=mean(x);

[Q,lamda]=eig(x*x');
lamda=abs(sum(lamda));
lamda_max=max(lamda);

t=1;
maxr=find(lamda==lamda_max);
while (lamda(maxr(1))>=lamda_max/10)&&(t<=n)
    Qm(:,t)=Q(:,maxr(1));
    t=t+1;
    Q(:,maxr(1))=[];
    lamda(maxr(1))=[];
    maxr=find(lamda==max(lamda));
    if t==n+1
        maxr=1;
        lamda=0;
    end
end

if t==n+1
    fprintf("It is normal regression (non ill-conditioned).\n");
    c_=inv(x*x')*x*y;
    c0_=Ye-mean(x')*c_;
    for i=1:n
      c(i)=sqrt(var_y/var_x(i))*c_(i);
    end
    c0=ey-ex*c';
else
   fprintf("It is ill-conditioned regression.\n");
    z=Qm'*x;
    lumda=inv(z*z');
    d=lumda*Qm'*x*y;
    c_=Qm*d;
    c0_=Ye-mean(x')*c_;
    
    for i=1:n
         c(i)=sqrt(var_y/var_x(i))*c_(i);
    end
    c0=ey-c*ex';
end

for i=1:n
    x_(i)=sym(['x',num2str(i)]);
end

y_=0;

for i=1:n
    y_=y_+round(c(i),3)*x_(i);
end

fprintf('Linear-Regression equation:')
y_=vpa(y_+ round(c0,3))

% TSS = ESS + RSS
TSS=0;
for i=1:N
    TSS=TSS+(y(i)-Ye)^2;
end
ESS=sum((x'*c_+c0_-mean(y)).^2);
RSS=TSS-ESS;

% F-test, df=(n, N-n-1)
F=(N-n-1)*ESS/(n*RSS);
Fa=finv(1-alpha,n,N-n-1);
fprintf('F=%f\nFa=%f\nLinear relationship exists\n',F,Fa);
% if F > Fa
% null hypothesis is not true, there be linear relationship
if F>Fa
    S=sqrt(var_y)*sqrt(RSS/(N-n-1));
    Z=norminv(1-alpha/2,0,1);
    fprintf('CI :(y0-%4.2f£¬y0+%4.2f)',S*Z, S*Z);
else
    fprintf("can't do linear regression");
end
end