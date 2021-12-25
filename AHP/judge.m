function [max_lumda_A, w] = judge(A)
[~,dms]=size(A);
[x,lumda]=eig(A) ;
r=abs(sum(lumda));
n=find(r==max(r)); 
max_lumda_A=lumda(n,n) % eigen value 
max_x_A=x(:,n); 	   % eigen vector
sum_x=sum(max_x_A);    % vector w
w = max_x_A/sum_x

% C.R. calculation
RI=[0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.25];
CR=(max_lumda_A-dms)/(dms-1)
CR=CR/RI(dms)
% consitency judgement
if(CR < 0.1)
    fprintf("C.R.<0.1, Consistent...    \n");
else
    fprintf("C.R.>0.1, Not Consistent...   \n");
end