function[pcs,cprs_data,cprs_c]=pca_compress(data,rerr)
x=data;
[N,n]=size(x); % the number of row & column
ex=mean(x); % avearage of x
varx=var(x); % variance of x

%normalization 
for i=1:n
    x(:,i)=(x(:,i)-ex(:,i))/sqrt(varx(:,i));
end

%eigenvalue
x=x';
[Q,l]=eig(x*x');
r=abs(sum(l));

%getting maximum eigen value, optimal one 
t=1;
k=0;
ls=sum(r);
maxr=find(r==max(r));
while (k/ls<1-rerr)&&(t<=n)
    k=k+r(maxr);
    Qm(:,t)=Q(:,maxr);
    t=t+1;
    Q(:,maxr)=[];
    r(maxr)=[];
    maxr=find(r==max(r));
end

if t==(n+1)
    sprinrf("There isn't linear correlation in the matrix, it couldn't be compressed.")
else
    pcs=Qm;
    cprs_data=Qm'*x;
    cprs_c=[ex' varx'];
end
end